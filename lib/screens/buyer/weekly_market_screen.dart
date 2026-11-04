import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class WeeklyMarketScreen extends StatelessWidget {
  const WeeklyMarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
    // डेमो डेटा - आठवडी बाजारातील वस्तू
>>>>>>> 92e1e33d29a69597c866b1e6a78c41c48a9980fd
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
<<<<<<< HEAD
=======
          // माहिती बॅनर
>>>>>>> 92e1e33d29a69597c866b1e6a78c41c48a9980fd
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.teal, Colors.tealAccent]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('दर शनिवारी दुपारी ३ ते रात्री १२', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 4),
                Text('स्थानिक विक्रेत्यांकडून खास वस्तू खरेदी करा', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
<<<<<<< HEAD
=======
          
          // वस्तूंची यादी
>>>>>>> 92e1e33d29a69597c866b1e6a78c41c48a9980fd
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
<<<<<<< HEAD
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6)],
=======
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
>>>>>>> 92e1e33d29a69597c866b1e6a78c41c48a9980fd
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