import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/buyer_shopping_data.dart';
import '../../data/product_database.dart';
import '../../models/product_model.dart';
import '../../widgets/offers_slider_widget.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';
import 'buyer_favourite_screen.dart';
import 'buyer_notification_screen.dart';
import 'buyer_profile_screen.dart';
import 'buyer_search_screen.dart';
import 'buyer_home_screen.dart';
import 'order_tracking_screen.dart';
import 'reward_wallet_screen.dart';

class GlobalShoppingHomeScreen extends StatefulWidget {
  const GlobalShoppingHomeScreen({super.key});

  @override
  State<GlobalShoppingHomeScreen> createState() =>
      _GlobalShoppingHomeScreenState();
}

class _GlobalShoppingHomeScreenState
    extends State<GlobalShoppingHomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  String _selectedCategory = 'सर्व';

  final List<Map<String, dynamic>> _categories = [
    {'label': 'सर्व', 'icon': Icons.grid_view_rounded, 'key': 'ALL'},
    {'label': 'फळे व भाजीपाला', 'icon': Icons.eco_outlined, 'key': 'FV'},
    {'label': 'किराणा', 'icon': Icons.shopping_basket_outlined, 'key': 'GR'},
    {'label': 'दैनंदिन गरजा', 'icon': Icons.home_outlined, 'key': 'DA'},
    {'label': 'कपडे', 'icon': Icons.checkroom_outlined, 'key': 'CF'},
    {'label': 'इलेक्ट्रॉनिक', 'icon': Icons.devices_outlined, 'key': 'EL'},
    {'label': 'आयुर्वेद', 'icon': Icons.spa_outlined, 'key': 'AY'},
    {'label': 'Kids', 'icon': Icons.child_care_outlined, 'key': 'KD'},
    {'label': 'Women', 'icon': Icons.woman_outlined, 'key': 'WM'},
    {'label': 'Men', 'icon': Icons.man_outlined, 'key': 'MN'},
    {'label': 'Stationery', 'icon': Icons.edit_outlined, 'key': 'ST'},
    {'label': 'Top Seller', 'icon': Icons.star_outline, 'key': 'TS'},
    {'label': 'Sports', 'icon': Icons.sports_soccer_outlined, 'key': 'SP'},
    {'label': 'Beauty', 'icon': Icons.face_retouching_natural_outlined, 'key': 'BT'},
    {'label': 'Home', 'icon': Icons.chair_outlined, 'key': 'HM'},
    {'label': 'Toys', 'icon': Icons.toys_outlined, 'key': 'TY'},
    {'label': 'Footwear', 'icon': Icons.directions_walk_outlined, 'key': 'FW'},
    {'label': 'Bags', 'icon': Icons.work_outline, 'key': 'BG'},
    {'label': 'Kitchen', 'icon': Icons.kitchen_outlined, 'key': 'KT'},
    {'label': 'Health', 'icon': Icons.local_hospital_outlined, 'key': 'HL'},
    {'label': 'Pet', 'icon': Icons.pets_outlined, 'key': 'PT'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ProductModel> get _products {
    var list = ProductDatabase.products
        .where((product) => product.isActive && product.stock > 0)
        .toList();

    if (_selectedCategory != 'सर्व') {
      final catKey = _categories.firstWhere(
        (c) => c['label'] == _selectedCategory,
        orElse: () => {'key': 'ALL'},
      )['key'];
      if (catKey != 'ALL') {
        list = list.where((product) => product.category == catKey).toList();
      }
    }

    final query = _searchQuery.trim().toLowerCase();
    if (query.isNotEmpty) {
      list = list.where((product) {
        return product.name.toLowerCase().contains(query) ||
            product.keywords.toLowerCase().contains(query) ||
            product.category.toLowerCase().contains(query) ||
            product.brand.toLowerCase().contains(query);
      }).toList();
    }

    return list;
  }

  int _cartQuantity(ProductModel product) {
    final index = BuyerShoppingData.cartItems.indexWhere(
      (item) => item['id'] == product.id,
    );
    if (index == -1) return 0;
    return (BuyerShoppingData.cartItems[index]['qty'] as int?) ?? 0;
  }

  void _addToCart(ProductModel product) {
    if (product.stock <= 0) return;
    BuyerShoppingData.addToCart(
      id: product.id,
      name: product.name,
      price: product.sellingPrice,
      qty: 1,
      seller: product.sellerName,
      description: product.description,
      image: product.image,
      mrp: product.mrp,
      discount: product.discount,
      stock: product.stock,
      deliveryAvailable: product.deliveryAvailable,
      isReturnable: product.isReturnable,
    );
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} Cart मध्ये जोडले'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _changeQuantity(ProductModel product, int change) {
    final current = _cartQuantity(product);
    final next = current + change;
    if (next <= 0) {
      BuyerShoppingData.removeFromCart(product.id);
      setState(() {});
      return;
    }
    if (next > product.stock) return;
    final index = BuyerShoppingData.cartItems.indexWhere(
      (item) => item['id'] == product.id,
    );
    if (index == -1) {
      _addToCart(product);
      return;
    }
    BuyerShoppingData.cartItems[index]['qty'] = next;
    setState(() {});
  }

  Widget _buildCategoryBar() {
    return SizedBox(
      height: 95,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final selected = _selectedCategory == category['label'];
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category['label'] as String;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primaryBlue.withValues(alpha: 0.15)
                        : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected ? AppColors.primaryBlue : Colors.grey.shade300,
                      width: selected ? 2 : 1,
                    ),
                  ),
                  child: Icon(
                    category['icon'] as IconData,
                    size: 26,
                    color: selected ? AppColors.primaryBlue : AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  category['label'] as String,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                    color: selected ? AppColors.primaryBlue : AppColors.textDark,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(ProductModel product) {
    final quantity = _cartQuantity(product);
    final favourite = BuyerShoppingData.isFavourite(product.id);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product),
            ),
          ).then((_) {
            if (mounted) setState(() {});
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 110,
                  width: double.infinity,
                  color: AppColors.lightGrey,
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 54,
                    color: AppColors.primaryBlue,
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        favourite ? Icons.favorite : Icons.favorite_border,
                        color: favourite ? Colors.red : AppColors.textLight,
                      ),
                      onPressed: () {
                        BuyerShoppingData.toggleFavourite({
                          'id': product.id,
                          'name': product.name,
                          'price': product.sellingPrice,
                          'seller': product.sellerName,
                          'description': product.description,
                          'image': product.image,
                          'mrp': product.mrp,
                          'discount': product.discount,
                          'stock': product.stock,
                          'deliveryAvailable': product.deliveryAvailable,
                          'isReturnable': product.isReturnable,
                        });
                        setState(() {});
                      },
                    ),
                  ),
                ),
                if (product.discount > 0)
                  Positioned(
                    left: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.successGreen,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${product.discount.toStringAsFixed(0)}% OFF',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.brand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '₹${product.sellingPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.successGreen,
                        ),
                      ),
                      if (product.discount > 0) ...[
                        const SizedBox(width: 6),
                        Text(
                          '₹${product.mrp.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 11,
                            decoration: TextDecoration.lineThrough,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (quantity == 0)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _addToCart(product),
                        child: const Text('Cart मध्ये टाका'),
                      ),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: () => _changeQuantity(product, -1),
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text(
                          '$quantity',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: quantity < product.stock
                              ? () => _changeQuantity(product, 1)
                              : null,
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    final cartCount = BuyerShoppingData.cartCount;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(8, 10, 4, 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryBlue, AppColors.royalBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 30, minHeight: 32),
                    visualDensity: VisualDensity.compact,
                    iconSize: 20,
                    tooltip: 'मुख्य स्क्रीन',
                    icon: const Icon(Icons.home_outlined, color: Colors.white),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const BuyerHomeScreen()),
                        (route) => false,
                      );
                    },
                  ),
                  const Text(
                    'AMOLE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RewardWalletScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade600,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.stars, color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text(
                              '245 pts',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.cyan,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.shopping_bag_outlined, color: AppColors.royalBlue, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'ऑर्डर',
                              style: TextStyle(
                                color: AppColors.royalBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 30, minHeight: 32),
                      visualDensity: VisualDensity.compact,
                      iconSize: 20,
                      tooltip: 'Search',
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BuyerSearchScreen(initialFilter: 'products'),
                          ),
                        );
                      },
                    ),
                    // === Cart icon + Badge (हिरवा) ===
                    Badge(
                      isLabelVisible: cartCount > 0,
                      label: Text(
                        cartCount > 99 ? '99+' : '$cartCount',
                        style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: AppColors.successGreen,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 30, minHeight: 32),
                        visualDensity: VisualDensity.compact,
                        iconSize: 20,
                        tooltip: 'Cart',
                        icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CartScreen()),
                          ).then((_) {
                            if (mounted) setState(() {});
                          });
                        },
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 30, minHeight: 32),
                      visualDensity: VisualDensity.compact,
                      iconSize: 20,
                      tooltip: 'My Favourite',
                      icon: const Icon(Icons.favorite_border, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const BuyerFavouriteScreen()),
                        ).then((_) {
                          if (mounted) setState(() {});
                        });
                      },
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 30, minHeight: 32),
                      visualDensity: VisualDensity.compact,
                      iconSize: 20,
                      tooltip: 'Notification',
                      icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const BuyerNotificationScreen()),
                        );
                      },
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 30, minHeight: 32),
                      visualDensity: VisualDensity.compact,
                      iconSize: 20,
                      tooltip: 'Profile',
                      icon: const Icon(Icons.account_circle_outlined, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const BuyerProfileScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = _products;
    final media = MediaQuery.of(context);
    final screenH = media.size.height - media.padding.top - media.padding.bottom;
    final cardW = (media.size.width - 32 - 12) / 2;
    final cardH = (screenH - 24 - 8 - 64) / 3;
    final ratio = (cardW / cardH).clamp(0.5, 1.0).toDouble();

    return Scaffold(
      // === bottomNavigationBar काढून टाकलं ===
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildTopHeader(),
                  const SizedBox(height: 8),
                  _buildCategoryBar(),
                  const SizedBox(height: 8),
                  const OffersSliderWidget(),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            if (products.isEmpty)
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 250,
                  child: Center(
                    child: Text(
                      'या शोधासाठी कोणतेही उत्पादन सापडले नाही.',
                      style: TextStyle(color: AppColors.textLight),
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: ratio,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _buildProductCard(
                        products[index % products.length],
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
