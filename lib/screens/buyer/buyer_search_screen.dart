import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/buyer_shopping_data.dart';
import '../../data/buyer_social_data.dart';
import '../../data/product_database.dart';
import '../../models/product_model.dart';
import 'buyer_public_social_profile_screen.dart';
import 'seller_profile_screen.dart';
import 'product_detail_screen.dart';

class BuyerSearchScreen extends StatefulWidget {
  final String initialFilter;
  const BuyerSearchScreen({super.key, this.initialFilter = 'all'});

  @override
  State<BuyerSearchScreen> createState() => _BuyerSearchScreenState();
}

class _BuyerSearchScreenState extends State<BuyerSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter;
  }

  final List<Map<String, String>> _sellers = [
    {
      'name': 'श्री गणेश किराणा स्टोअर',
      'category': 'किराणा',
      'distance': '0.5 km',
      'rating': '4.5',
    },
    {
      'name': 'राज इलेक्ट्रॉनिक्स',
      'category': 'इलेक्ट्रॉनिक्स',
      'distance': '1.2 km',
      'rating': '4.2',
    },
    {
      'name': 'स्वाद हॉटेल',
      'category': 'खाद्यपदार्थ',
      'distance': '0.8 km',
      'rating': '4.7',
    },
    {
      'name': 'फॅशन पॉईंट',
      'category': 'कपडे',
      'distance': '1.5 km',
      'rating': '4.0',
    },
    {
      'name': 'मेडिकल स्टोअर',
      'category': 'मेडिकल',
      'distance': '0.3 km',
      'rating': '4.8',
    },
    {
      'name': 'होम डेकोर शॉप',
      'category': 'घर',
      'distance': '2.0 km',
      'rating': '4.1',
    },
  ];

  final String _currentBuyerPincode = '411028';

  List<Map<String, String>> get _filteredSellers {
    List<Map<String, String>> list = _sellers;
    if (_selectedFilter == 'shops') {
      list = _sellers
          .where((s) => ['किराणा', 'कपडे', 'घर'].contains(s['category']))
          .toList();
    } else if (_selectedFilter == 'products') {
      list = _sellers
          .where((s) => ['इलेक्ट्रॉनिक्स', 'मेडिकल'].contains(s['category']))
          .toList();
    } else if (_selectedFilter == 'services') {
      list = _sellers
          .where((s) => ['खाद्यपदार्थ'].contains(s['category']))
          .toList();
    }
    if (_searchQuery.isNotEmpty) {
      list = list
          .where(
            (s) =>
                s['name']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                s['category']!.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }
    return list;
  }

  List<ProductModel> get _filteredProducts {
    var list = ProductDatabase.products
        .where((product) => product.isActive && product.stock > 0)
        .toList();

    if (_searchQuery.trim().isNotEmpty) {
      final query = _searchQuery.trim().toLowerCase();

      list = list.where((product) {
        return product.name.toLowerCase().contains(query) ||
            product.keywords.toLowerCase().contains(query) ||
            product.category.toLowerCase().contains(query) ||
            product.brand.toLowerCase().contains(query) ||
            product.sellerName.toLowerCase().contains(query);
      }).toList();
    }

    return list;
  }

  int _productCartQuantity(ProductModel product) {
    for (final item in BuyerShoppingData.cartItems) {
      if (item['id'] == product.id) {
        return (item['qty'] as int?) ?? 0;
      }
    }
    return 0;
  }

  void _addProductToCart(ProductModel product, {int quantity = 1}) {
    if (product.stock <= 0) return;

    final safeQuantity =
        quantity.clamp(1, product.stock);

    BuyerShoppingData.addToCart(
      id: product.id,
      name: product.name,
      price: product.sellingPrice,
      qty: safeQuantity,
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

  void _changeProductQuantity(ProductModel product, int change) {
    final current = _productCartQuantity(product);
    final next = current + change;

    if (next <= 0) {
      BuyerShoppingData.removeFromCart(product.id);
      setState(() {});
      return;
    }

    if (current == 0) {
      _addProductToCart(product, quantity: next);
      return;
    }

    final index = BuyerShoppingData.cartItems.indexWhere(
      (item) => item['id'] == product.id,
    );

    if (index == -1) return;

    BuyerShoppingData.cartItems[index]['qty'] =
        next.clamp(1, product.stock);

    setState(() {});
  }

  Widget _buildProductCard(ProductModel product) {
    final price = product.sellingPrice;
    final cartQuantity = _productCartQuantity(product);
    final isFavourite = BuyerShoppingData.isFavourite(product.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 42,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.sellerName.isEmpty
                          ? 'AMOLE Seller'
                          : product.sellerName,
                      style: const TextStyle(
                        color: AppColors.textLight,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          '₹${price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.successGreen,
                          ),
                        ),
                        if (product.discount > 0) ...[
                          const SizedBox(width: 8),
                          Text(
                            '₹${product.mrp.toStringAsFixed(0)}',
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.textLight,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${product.discount.toStringAsFixed(0)}% OFF',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryOrange,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'स्टॉक: ${product.stock}  •  ${product.category}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primaryBlue,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: cartQuantity > 0
                                    ? () => _changeProductQuantity(
                                          product,
                                          -1,
                                        )
                                    : null,
                                icon: const Icon(
                                  Icons.remove,
                                  size: 18,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 34,
                                  minHeight: 38,
                                ),
                              ),
                              Text(
                                '$cartQuantity',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed:
                                    cartQuantity < product.stock
                                        ? () => _changeProductQuantity(
                                              product,
                                              1,
                                            )
                                        : null,
                                icon: const Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 34,
                                  minHeight: 38,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: OutlinedButton(
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
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.redAccent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 10,
                              ),
                            ),
                            child: Icon(
                              isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: product.stock > 0
                                ? () => _addProductToCart(product)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.primaryOrange,
                              foregroundColor: AppColors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 10,
                              ),
                            ),
                            child: const Text(
                              'Add to Cart',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textLight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> get _filteredBuyers {
    List<Map<String, dynamic>> list = BuyerSocialData.buyers
        .where((buyer) => buyer['pincode'] == _currentBuyerPincode)
        .toList();

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      list = BuyerSocialData.buyers.where((buyer) {
        final name = '${buyer['name']}'.toLowerCase();
        final area = '${buyer['area']}'.toLowerCase();
        return name.contains(query) || area.contains(query);
      }).toList();
    }

    return list;
  }

  Widget _buildFilterChip(String code, String label, IconData icon) {
    final bool isSelected = _selectedFilter == code;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _selectedFilter = code),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryBlue : AppColors.lightGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 14,
                color: isSelected ? Colors.white : AppColors.textLight,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textDark,
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSellerCard(Map<String, String> item) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SellerProfileScreen(
            sellerName: item['name']!,
            category: item['category']!,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.lightGrey),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.store_outlined,
                color: AppColors.primaryBlue,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['category']!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.primaryOrange,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item['rating']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.textLight,
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        item['distance']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }

  Widget _buildBuyerCard(Map<String, dynamic> item) {
    final requestStatus = '${item['friendRequestStatus']}';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BuyerPublicSocialProfileScreen(buyer: item),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.lightGrey),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
              child: Text(
                '${item['name']}'.isNotEmpty ? '${item['name']}'[0] : '?',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item['name']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.textLight,
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          '${item['area']}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item['mutual']} mutual friends',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: requestStatus == 'pending'
                  ? null
                  : () {
                      setState(() {
                        BuyerSocialData.sendFriendRequest('${item['id']}');
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${item['name']} यांना Friend Request पाठवली.',
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                disabledBackgroundColor: AppColors.lightGrey,
                disabledForegroundColor: AppColors.textLight,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size.zero,
              ),
              child: Text(
                requestStatus == 'pending' ? 'Request पाठवली' : 'मित्र जोडा',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isFriendSearch = _selectedFilter == 'friends';
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
        title: const Text(
          'शोधा',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() => _searchQuery = v),
                      decoration: InputDecoration(
                        hintText: isFriendSearch
                            ? 'मित्राचं नाव किंवा परिसर शोधा...'
                            : 'दुकान, वस्तू, सेवा, keyword शोधा...',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.textLight,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('all', 'सर्व', Icons.apps),
                        _buildFilterChip(
                          'shops',
                          'दुकाने',
                          Icons.store_outlined,
                        ),
                        _buildFilterChip(
                          'products',
                          'वस्तू',
                          Icons.inventory_2_outlined,
                        ),
                        _buildFilterChip(
                          'services',
                          'सेवा',
                          Icons.handyman_outlined,
                        ),
                        _buildFilterChip(
                          'friends',
                          'मित्र शोध',
                          Icons.people_outline,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isFriendSearch
                  ? (_filteredBuyers.isEmpty
                        ? const Center(
                            child: Text(
                              'कोणी सापडले नाही',
                              style: TextStyle(color: AppColors.textLight),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: _filteredBuyers.length,
                            itemBuilder: (_, i) =>
                                _buildBuyerCard(_filteredBuyers[i]),
                          ))
                  : _selectedFilter == 'products'
                  ? (_filteredProducts.isEmpty
                        ? const Center(
                            child: Text(
                              'कोणतेही उत्पादन सापडले नाही',
                              style: TextStyle(color: AppColors.textLight),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: _filteredProducts.length,
                            itemBuilder: (_, i) =>
                                _buildProductCard(_filteredProducts[i]),
                          ))
                  : (_filteredSellers.isEmpty
                        ? const Center(
                            child: Text(
                              'काही सापडले नाही',
                              style: TextStyle(color: AppColors.textLight),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: _filteredSellers.length,
                            itemBuilder: (_, i) =>
                                _buildSellerCard(_filteredSellers[i]),
                          )),
            ),
          ],
        ),
      ),
    );
  }
}
