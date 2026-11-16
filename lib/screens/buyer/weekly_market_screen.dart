import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/buyer_shopping_data.dart';
import '../../models/product_model.dart';
import '../../widgets/offers_slider_widget.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';
import 'buyer_favourite_screen.dart';

class WeeklyMarketScreen extends StatefulWidget {
  const WeeklyMarketScreen({super.key});

  @override
  State<WeeklyMarketScreen> createState() => _WeeklyMarketScreenState();
}

class _WeeklyMarketScreenState extends State<WeeklyMarketScreen> {
  final List<ProductModel> _weeklyProducts = [
    ProductModel(id: 'wm-1', name: 'हातमाग साडी', mrp: 1200, discount: 0, stock: 10, category: 'कपडे', description: 'हातमागावर विणलेली पारंपरिक साडी.', keywords: 'saree, साडी, handloom', sellerId: 'wm-seller-1', sellerName: 'सुनीता जाधव', image: ''),
    ProductModel(id: 'wm-2', name: 'मातीची भांडी', mrp: 350, discount: 0, stock: 20, category: 'घर', description: 'मातीची हाताने बनवलेली भांडी.', keywords: 'pottery, भांडी, माती', sellerId: 'wm-seller-2', sellerName: 'रमेश कुंभार', image: ''),
    ProductModel(id: 'wm-3', name: 'घरगुती पापड', mrp: 150, discount: 0, stock: 50, category: 'खाद्यपदार्थ', description: 'घरगुती पद्धतीने बनवलेले पापड.', keywords: 'papad, पापड, homemade', sellerId: 'wm-seller-3', sellerName: 'संगीता राणे', image: ''),
    ProductModel(id: 'wm-4', name: 'हस्तकला खेळणी', mrp: 500, discount: 0, stock: 15, category: 'खेळणी', description: 'हाताने बनवलेली लाकडी खेळणी.', keywords: 'toys, खेळणी, handicraft', sellerId: 'wm-seller-4', sellerName: 'विकास पाटील', image: ''),
    ProductModel(id: 'wm-5', name: 'सेंद्रिय मध', mrp: 450, discount: 0, stock: 25, category: 'खाद्यपदार्थ', description: 'शेतकऱ्यांकडून थेट सेंद्रिय मध.', keywords: 'honey, मध, organic', sellerId: 'wm-seller-5', sellerName: 'शेतकरी गट', image: ''),
    ProductModel(id: 'wm-6', name: 'भरतकामाची पिशवी', mrp: 800, discount: 0, stock: 8, category: 'कपडे', description: 'हाताने भरतकाम केलेली पिशवी.', keywords: 'bag, पिशवी, embroidery', sellerId: 'wm-seller-6', sellerName: 'प्रिया देशमुख', image: ''),
  ];

  int _cartQty(ProductModel p) {
    for (final item in BuyerShoppingData.cartItems) {
      if (item['id'] == p.id) return (item['qty'] as int?) ?? 0;
    }
    return 0;
  }

  void _addToCart(ProductModel p, {int qty = 1}) {
    BuyerShoppingData.addToCart(
      id: p.id, name: p.name, price: p.sellingPrice, qty: qty,
      seller: p.sellerName, description: p.description, image: p.image,
      mrp: p.mrp, discount: p.discount, stock: p.stock,
      deliveryAvailable: p.deliveryAvailable, isReturnable: p.isReturnable,
    );
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${p.name} Cart मध्ये जोडले'), duration: const Duration(seconds: 1)),
    );
  }

  void _changeQty(ProductModel p, int delta) {
    final current = _cartQty(p);
    final next = current + delta;
    if (next <= 0) {
      BuyerShoppingData.removeFromCart(p.id);
      setState(() {});
      return;
    }
    if (current == 0) {
      _addToCart(p, qty: next);
      return;
    }
    final index = BuyerShoppingData.cartItems.indexWhere((item) => item['id'] == p.id);
    if (index == -1) return;
    BuyerShoppingData.cartItems[index]['qty'] = next.clamp(1, p.stock);
    setState(() {});
  }

  // ✅ आकर्षक हेडर — Back button + Favourite + Cart
  Widget _buildHeader() {
    final cartCount = BuyerShoppingData.cartCount;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00695C), Color(0xFF00897B), Color(0xFF26C6DA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // === सजावट — shopping icons ===
          Positioned(
            right: -30,
            top: -20,
            child: Icon(Icons.shopping_bag_rounded,
                size: 140, color: Colors.white.withValues(alpha: 0.07)),
          ),
          Positioned(
            left: -25,
            bottom: -30,
            child: Icon(Icons.local_offer_rounded,
                size: 110, color: Colors.white.withValues(alpha: 0.06)),
          ),
          Positioned(
            right: 80,
            bottom: 20,
            child: Icon(Icons.stars_rounded,
                size: 40, color: Colors.white.withValues(alpha: 0.12)),
          ),
          Positioned(
            left: 70,
            top: 30,
            child: Icon(Icons.shopping_cart_rounded,
                size: 35, color: Colors.white.withValues(alpha: 0.1)),
          ),
          Positioned(
            right: 130,
            top: 15,
            child: Icon(Icons.celebration_rounded,
                size: 25, color: Colors.white.withValues(alpha: 0.15)),
          ),

          // === Back button (डाव्या कोपऱ्यात) ===
          Positioned(
            top: 8,
            left: 4,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                tooltip: 'मागे',
              ),
            ),
          ),

          // === मजकूर + Favourite + Cart ===
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 56, 8, 18),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.celebration,
                                color: Colors.amber, size: 18),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'आठवडी बाजार',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        '🎉 दर शनिवारी दुपारी ३ ते रात्री १२',
                        style: TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'स्थानिक विक्रेत्यांची खास ऑफर',
                        style: TextStyle(
                            color: Colors.white60,
                            fontSize: 11,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                // ✅ Favourite icon — BuyerFavouriteScreen उघडेल
                IconButton(
                  icon: const Icon(Icons.favorite_border,
                      color: Colors.white, size: 22),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const BuyerFavouriteScreen()),
                    ).then((_) {
                      if (mounted) setState(() {});
                    });
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                      minWidth: 40, minHeight: 40),
                  tooltip: 'आवडते',
                ),
                const SizedBox(width: 2),
                // ✅ Cart icon
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Badge(
                    isLabelVisible: cartCount > 0,
                    label: Text(
                      cartCount > 99 ? '99+' : '$cartCount',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: AppColors.successGreen,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                          minWidth: 40, minHeight: 40),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CartScreen()),
                        ).then((_) => setState(() {}));
                      },
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _productCard(ProductModel p) {
    final qty = _cartQty(p);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p))).then((_) {
          if (mounted) setState(() {});
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12))),
              child: const Icon(Icons.shopping_bag, size: 45, color: Colors.teal),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 2),
                  Text(p.sellerName, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10, color: AppColors.textLight)),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('₹${p.sellingPrice.toStringAsFixed(0)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 14)),
                      if (qty == 0)
                        GestureDetector(
                          onTap: () => _addToCart(p),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(6)),
                            child: const Text('ADD', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        )
                      else
                        Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.teal), borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(onTap: () => _changeQty(p, -1), child: const Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2), child: Icon(Icons.remove, size: 14, color: Colors.teal))),
                              Text('$qty', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.teal)),
                              GestureDetector(onTap: () => _changeQty(p, 1), child: const Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2), child: Icon(Icons.add, size: 14, color: Colors.teal))),
                            ],
                          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: OffersSliderWidget(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 210,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _productCard(_weeklyProducts[index]),
                childCount: _weeklyProducts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}