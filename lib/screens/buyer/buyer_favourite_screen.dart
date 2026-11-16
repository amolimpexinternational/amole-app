import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/buyer_shopping_data.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';

class BuyerFavouriteScreen extends StatefulWidget {
  const BuyerFavouriteScreen({super.key});

  @override
  State<BuyerFavouriteScreen> createState() => _BuyerFavouriteScreenState();
}

class _BuyerFavouriteScreenState extends State<BuyerFavouriteScreen> {
  void _removeFavourite(String id) {
    setState(() {
      BuyerShoppingData.removeFromFavourite(id);
    });
  }

  // ✅ Cart मध्ये qty शोधण्यासाठी helper
  int _cartQty(String id) {
    for (final item in BuyerShoppingData.cartItems) {
      if (item['id'] == id) return (item['qty'] as int?) ?? 0;
    }
    return 0;
  }

  void _addToCart(Map<String, dynamic> item) {
    BuyerShoppingData.addToCart(
      id: item['id'] as String,
      name: item['name'] as String,
      price: (item['price'] as num).toDouble(),
      qty: 1,
      seller: item['seller'] as String,
      description: item['description'] as String? ?? '',
      image: item['image'] as String? ?? '',
      mrp: (item['mrp'] as num?)?.toDouble() ??
          (item['price'] as num).toDouble(),
      discount: (item['discount'] as num?)?.toDouble() ?? 0,
      stock: item['stock'] as int? ?? 0,
      deliveryAvailable: item['deliveryAvailable'] as bool? ?? true,
      isReturnable: item['isReturnable'] as bool? ?? true,
    );
    // ✅ Snackbar काढलं — फक्त setState (button green + badge update)
    setState(() {});
  }

  void _openProduct(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          productName: item['name'] as String,
          price: '₹${(item['price'] as num).toStringAsFixed(0)}',
          sellerName: item['seller'] as String,
        ),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  Widget _buildFavouriteCard(Map<String, dynamic> item) {
    final name = item['name'] as String;
    final seller = item['seller'] as String;
    final description = item['description'] as String? ?? '';
    final price = (item['price'] as num).toDouble();
    final mrp = (item['mrp'] as num?)?.toDouble() ?? price;
    final discount = (item['discount'] as num?)?.toDouble() ?? 0;
    final stock = item['stock'] as int? ?? 0;
    final deliveryAvailable =
        item['deliveryAvailable'] as bool? ?? true;
    final isReturnable = item['isReturnable'] as bool? ?? true;
    final id = item['id'] as String;
    final cartQty = _cartQty(id);
    final inCart = cartQty > 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      child: InkWell(
        onTap: () => _openProduct(item),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.image_outlined,
                      size: 38,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textLight,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          seller,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              '₹${price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: AppColors.successGreen,
                              ),
                            ),
                            if (mrp > price) ...[
                              const SizedBox(width: 6),
                              Text(
                                '₹${mrp.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textLight,
                                  decoration:
                                      TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${discount.toStringAsFixed(0)}% OFF',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.successGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Remove Favourite',
                    onPressed: () => _removeFavourite(id),
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      stock > 0 ? 'Stock उपलब्ध' : 'Stock संपला',
                      style: TextStyle(
                        fontSize: 11,
                        color: stock > 0
                            ? AppColors.successGreen
                            : Colors.red,
                      ),
                    ),
                  ),
                  Text(
                    deliveryAvailable
                        ? 'Delivery उपलब्ध'
                        : 'Delivery नाही',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    isReturnable
                        ? 'Return उपलब्ध'
                        : 'Non-returnable',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // ✅ बटन — Cart मध्ये नसेल तर orange, असेल तर green + qty
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: stock > 0 && !inCart
                      ? () => _addToCart(item)
                      : (inCart
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CartScreen(),
                                ),
                              ).then((_) {
                                if (mounted) setState(() {});
                              });
                            }
                          : null),
                  icon: Icon(
                    inCart ? Icons.check_circle : Icons.shopping_cart_outlined,
                  ),
                  label: Text(
                    inCart
                        ? 'Cart मध्ये आहे ($cartQty) ✓'
                        : 'Cart मध्ये टाका',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: inCart
                        ? AppColors.successGreen
                        : AppColors.primaryOrange,
                    foregroundColor: AppColors.white,
                    disabledBackgroundColor: AppColors.lightGrey,
                    disabledForegroundColor: AppColors.textLight,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = BuyerShoppingData.favouriteItems;
    final cartCount = BuyerShoppingData.cartCount;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: Text(
          'My Favourite (${BuyerShoppingData.favouriteCount})',
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        actionsPadding: const EdgeInsets.only(right: 8),
        actions: [
          // Favourite icon (already on favourite screen — snackbar only)
          IconButton(
            tooltip: 'My Favourite',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            iconSize: 22,
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('तुम्ही आधीच Favourite screen वर आहात'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          const SizedBox(width: 2),
          // ✅ Cart — हिरवा badge सह
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Badge(
              isLabelVisible: cartCount > 0,
              label: Text(
                cartCount > 99 ? '99+' : '$cartCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: AppColors.successGreen,
              child: IconButton(
                tooltip: 'Cart',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                iconSize: 24,
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
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
            ),
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: AppColors.textLight,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'तुमची Favourite list रिकामी आहे',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textLight,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'आवडलेली उत्पादने येथे जतन करा',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildFavouriteCard(items[index]);
              },
            ),
    );
  }
}