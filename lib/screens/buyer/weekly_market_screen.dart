import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../widgets/offers_slider_widget.dart';
class WeeklyMarketScreen extends StatelessWidget {
  const WeeklyMarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {'name': 'हातमाग साडी', 'price': 1200, 'seller': 'सुनीता जाधव', 'color': Colors.pink.shade100},
      {'name': 'मातीची भांडी', 'price': 350, 'seller': 'रमेश कुंभार', 'color': Colors.brown.shade100},
      {'name': 'घरगुती पापड', 'price': 150, 'seller': 'संगीता राणे', 'color': Colors.orange.shade100},
      {'name': 'हस्तकला खेळणी', 'price': 500, 'seller': 'विकास पाटील', 'color': Colors.teal.shade100},
      {'name': 'सेंद्रिय मध', 'price': 450, 'seller': 'शेतकरी गट', 'color': Colors.yellow.shade100},
      {'name': 'भरतकामाची पिशवी', 'price': 800, 'seller': 'प्रिया देशमुख', 'color': Colors.purple.shade100},
    ];

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
                mainAxisExtent: 220,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: p['color'],
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        child: const Icon(Icons.shopping_bag, size: 50, color: Colors.white70),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            const SizedBox(height: 2),
                            Text(p['seller'], style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('₹${p['price']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 16)),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(6)),
                                  child: const Text('Buy', style: TextStyle(color: Colors.white, fontSize: 10)),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
