import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/buyer_shopping_data.dart';
import '../../data/product_database.dart';
import '../../models/product_model.dart';
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
    {'label': 'सर्व', 'icon': Icons.grid_view_rounded},
    {'label': 'फळे व भाजीपाला', 'icon': Icons.eco_outlined},
    {'label': 'किराणा', 'icon': Icons.shopping_basket_outlined},
    {'label': 'दैनंदिन गरजा', 'icon': Icons.home_outlined},
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

    if (_selectedCategory == 'फळे व भाजीपाला') {
      list = list.where((product) => product.category == 'FV').toList();
    } else if (_selectedCategory == 'किराणा') {
      list = list.where((product) => product.category == 'GR').toList();
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
      height: 82,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final selected = _selectedCategory == category['label'];

          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              setState(() {
                _selectedCategory = category['label'] as String;
              });
            },
            child: Container(
              width: 90,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primaryBlue
                    : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category['icon'] as IconData,
                    size: 24,
                    color: selected
                        ? Colors.white
                        : AppColors.primaryBlue,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    category['label'] as String,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: selected
                          ? Colors.white
                          : AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOfferBanner() {
    final offerProducts = ProductDatabase.products
        .where(
          (product) =>
              product.isActive &&
              product.stock > 0 &&
              product.discount > 0,
        )
        .toList();

    if (offerProducts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primaryBlue,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_offer_outlined,
            size: 36,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'आजचे ऑफर्स',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${offerProducts.length} उत्पादनांवर विशेष बचत उपलब्ध',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
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
                  height: 145,
                  width: double.infinity,
                  color: AppColors.lightGrey,
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 58,
                    color: AppColors.primaryBlue,
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        favourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: favourite
                            ? Colors.red
                            : AppColors.textLight,
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
                          'deliveryAvailable':
                              product.deliveryAvailable,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 4,
                      ),
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
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
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
                          fontSize: 17,
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
                          onPressed: () =>
                              _changeQuantity(product, -1),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
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
                    tooltip: 'मुख्य स्क्रीन',
                    icon: const Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BuyerHomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                  const Text(
                    'AMOLE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade600,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.stars,
                              color: Colors.white,
                              size: 16,
                            ),
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
                          MaterialPageRoute(
                            builder: (_) => const OrderTrackingScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cyan,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: AppColors.royalBlue,
                              size: 16,
                            ),
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
                      tooltip: 'Search',
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BuyerSearchScreen(
                              initialFilter: 'products',
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      tooltip: 'Cart',
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CartScreen(),
                          ),
                        ).then((_) {
                          if (mounted) setState(() {});
                        });
                      },
                    ),
                    IconButton(
                      tooltip: 'My Favourite',
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BuyerFavouriteScreen(),
                          ),
                        ).then((_) {
                          if (mounted) setState(() {});
                        });
                      },
                    ),
                    IconButton(
                      tooltip: 'Notification',
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BuyerNotificationScreen(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      tooltip: 'Profile',
                      icon: const Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BuyerProfileScreen(),
                          ),
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

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopHeader(),
              const SizedBox(height: 8),
              _buildCategoryBar(),
              _buildOfferBanner(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: products.isEmpty
                    ? const SizedBox(
                        height: 250,
                        child: Center(
                          child: Text(
                            'या शोधासाठी कोणतेही उत्पादन सापडले नाही.',
                            style: TextStyle(
                              color: AppColors.textLight,
                            ),
                          ),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.64,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return _buildProductCard(products[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
