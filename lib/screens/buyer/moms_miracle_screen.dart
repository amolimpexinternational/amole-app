import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/buyer_shopping_data.dart';
import '../../data/kids_demo_products.dart';
import '../../data/product_database.dart';
import '../../models/product_model.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';

class MomsMiracleScreen extends StatefulWidget {
  const MomsMiracleScreen({super.key});

  @override
  State<MomsMiracleScreen> createState() => _MomsMiracleScreenState();
}

class _MomsMiracleScreenState extends State<MomsMiracleScreen> {
  String _query = '';
  String _selected = 'सर्व';

  final List<String> _chips = const ['सर्व', 'कपडे', 'खेळणी', 'आहार', 'काळजी'];

  // लहान मुलांशी संबंधित शब्द (keywords मध्ये यापैकी काही असेल तर प्रॉडक्ट दिसतो)
  static const List<String> _kidTerms = [
    'baby', 'kids', 'kid', 'child', 'children', 'infant', 'toy', 'diaper',
    'लहान मुल', 'मुले', 'मुलां', 'बाळ', 'खेळणी',
  ];

  static const Map<String, List<String>> _subTerms = {
    'कपडे': ['कपडे', 'clothes', 'dress', 'frock', 'shirt'],
    'खेळणी': ['खेळणी', 'toy', 'teddy', 'game'],
    'आहार': ['आहार', 'food', 'cereal', 'milk', 'दूध'],
    'काळजी': ['डायपर', 'diaper', 'lotion', 'soap', 'care', 'काळजी'],
  };

  String _text(ProductModel p) =>
      '${p.name} ${p.keywords} ${p.description} ${p.category}'.toLowerCase();

  bool _isKids(ProductModel p) {
    if (p.category == 'KD') return true;
    final t = _text(p);
    return _kidTerms.any((k) => t.contains(k));
  }

  List<ProductModel> get _products {
    final all = [...ProductDatabase.products, ...KidsDemoProducts.items];
    var list =
        all.where((p) => p.isActive && p.stock > 0 && _isKids(p)).toList();

    if (_selected != 'सर्व') {
      final terms = _subTerms[_selected] ?? const <String>[];
      list = list.where((p) {
        final t = _text(p);
        return terms.any((k) => t.contains(k));
      }).toList();
    }

    final q = _query.trim().toLowerCase();
    if (q.isNotEmpty) {
      list = list
          .where((p) => _text(p).contains(q) || p.brand.toLowerCase().contains(q))
          .toList();
    }
    return list;
  }

  int _cartQuantity(ProductModel product) {
    final index = BuyerShoppingData.cartItems
        .indexWhere((item) => item['id'] == product.id);
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
    final next = _cartQuantity(product) + change;
    if (next <= 0) {
      BuyerShoppingData.removeFromCart(product.id);
      setState(() {});
      return;
    }
    if (next > product.stock) return;
    final index = BuyerShoppingData.cartItems
        .indexWhere((item) => item['id'] == product.id);
    if (index == -1) {
      _addToCart(product);
      return;
    }
    BuyerShoppingData.cartItems[index]['qty'] = next;
    setState(() {});
  }

  Widget _chipBar() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final c = _chips[i];
          final selected = c == _selected;
          return GestureDetector(
            onTap: () => setState(() => _selected = c),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppColors.primaryBlue : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: AppColors.primaryBlue.withValues(alpha: 0.3)),
              ),
              child: Text(
                c,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : AppColors.primaryBlue,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _productCard(ProductModel product) {
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
                  child: const Icon(Icons.child_care,
                      size: 54, color: AppColors.primaryBlue),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 4),
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
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.brand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textLight),
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
                        Text('$quantity',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
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

  Widget _bottomBar() {
    final count = BuyerShoppingData.cartCount;
    if (count == 0) return const SizedBox.shrink();
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '$count वस्तू · ₹${BuyerShoppingData.cartSubtotal.toStringAsFixed(0)}',
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              ).then((_) => setState(() {})),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              ),
              child: const Text('Cart बघा',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _products;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🧸 Mom's Miracle",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text('लहान मुलांसाठी सर्व काही',
                style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
      bottomNavigationBar: _bottomBar(),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'लहान मुलांचे प्रॉडक्ट शोधा...',
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.primaryBlue),
                filled: true,
                fillColor: const Color(0xFFF1F3F6),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          _chipBar(),
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text('सध्या कोणतेही प्रॉडक्ट सापडले नाही',
                        style: TextStyle(color: AppColors.textLight)))
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 290,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, i) => _productCard(items[i]),
                  ),
          ),
        ],
      ),
    );
  }
}