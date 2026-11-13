import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/buyer_shopping_data.dart';
import '../../models/product_model.dart';
import '../../widgets/offers_slider_widget.dart';
import 'product_detail_screen.dart';

class WeeklyMarketScreen extends StatefulWidget {
  const WeeklyMarketScreen({super.key});

  @override
  State<WeeklyMarketScreen> createState() => _WeeklyMarketScreenState();
}

class _WeeklyMarketScreenState extends State<WeeklyMarketScreen> {
  // === आठवडी बाजार प्रॉडक्ट्स (डमी — ProductModel) ===
  final List<ProductModel> _weeklyProducts = [
    ProductModel(
      id: 'wm-1',
      name: 'हातमाग साडी',
      mrp: 1200,
      discount: 0,
      stock: 10,
      category: 'कपडे',
      description: 'हातमागावर विणलेली पारंपरिक साडी.',
      keywords: 'saree, साडी, handloom',
      sellerId: 'wm-seller-1',
      sellerName: 'सुनीता जाधव',
      image: '',
    ),
    ProductModel(
      id: 'wm-2',
      name: 'मातीची भांडी',
      mrp: 350,
      discount: 0,
      stock: 20,
      category: 'घर',
      description: 'मातीची हाताने बनवलेली भांडी.',
      keywords: 'pottery, भांडी, माती',
      sellerId: 'wm-seller-2',
      sellerName: 'रमेश कुंभार',
      image: '',
    ),
    ProductModel(
      id: 'wm-3',
      name: 'घरगुती पापड',
      mrp: 150,
      discount: 0,
      stock: 50,
      category: 'खाद्यपदार्थ',
      description: 'घरगुती पद्धतीने बनवलेले पापड.',
      keywords: 'papad, पापड, homemade',
      sellerId: 'wm-seller-3',
      sellerName: 'संगीता राणे',
      image: '',
    ),
    ProductModel(
      id: 'wm-4',
      name: 'हस्तकला खेळणी',
      mrp: 500,
      discount: 0,
      stock: 15,
      category: 'खेळणी',
      description: 'हाताने बनवलेली लाकडी खेळणी.',
      keywords: 'toys, खेळणी, handicraft',
      sellerId: 'wm-seller-4',
      sellerName: 'विकास पाटील',
      image: '',
    ),
    ProductModel(
      id: 'wm-5',
      name: 'सेंद्रिय मध',
      mrp: 450,
      discount: 0,
      stock: 25,
      category: 'खाद्यपदार्थ',
      description: 'शेतकऱ्यांकडून थेट सेंद्रिय मध.',
      keywords: 'honey, मध, organic',
      sellerId: 'wm-seller-5',
      sellerName: 'शेतकरी गट',
      image: '',
    ),
    ProductModel(
      id: 'wm-6',
      name: 'भरतकामाची पिशवी',
      mrp: 800,
      discount: 0,
      stock: 8,
      category: 'कपडे',
      description: 'हाताने भरतकाम केलेली पिशवी.',
      keywords: 'bag, पिशवी, embroidery',
      sellerId: 'wm-seller-6',
      sellerName: 'प्रिया देशमुख',
      image: '',
    ),
  ];

  int _cartQty(ProductModel p) {
    for (final item in BuyerShoppingData.cartItems) {
      if (item['id'] == p.id) return (item['qty'] as int?) ?? 0;
    }
    return 0;
  }

  void _addToCart(ProductModel p, {int qty = 1}) {
    BuyerShoppingData.addToCart(
      id: p.id,
      name: p.name,
      price: p.sellingPrice,
      qty: qty,
      seller: p.sellerName,
      description: p.description,
      image: p.image,
      mrp: p.mrp,
      discount: p.discount,
      stock: p.stock,
      deliveryAvailable: p.deliveryAvailable,
      isReturnable: p.isReturnable,
    );
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${p.name} Cart मध्ये जोडले'),
        duration: const Duration(seconds: 1),
      ),
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

    final index = BuyerShoppingData.cartItems.indexWhere(
      (item) => item['id'] == p.id,
    );
    if (index == -1) return;

    BuyerShoppingData.cartItems[index]['qty'] = next.clamp(1, p.stock);
    setState(() {});
  }

  Widget _productCard(ProductModel p) {
    final qty = _cartQty(p);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: p),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // फोटो (डमी)
            Container(
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: const Icon(
                Icons.shopping_bag,
                size: 45,
                color: Colors.teal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    p.sellerName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${p.sellingPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 14,
                        ),
                      ),
                      // Add / +−
                      if (qty == 0)
                        GestureDetector(
                          onTap: () => _addToCart(p),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'ADD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      else
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.teal),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () => _changeQty(p, -1),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 2,
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: 14,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                              Text(
                                '$qty',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _changeQty(p, 1),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 2,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 14,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
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
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text('🎪 आठवडी बाजार'),
      ),
      body: Column(
        children: [
          const OffersSliderWidget(),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 210,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _weeklyProducts.length,
              itemBuilder: (context, index) =>
                  _productCard(_weeklyProducts[index]),
            ),
          ),
        ],
      ),
    );
  }
}
