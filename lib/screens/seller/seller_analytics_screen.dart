import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerAnalyticsScreen extends StatelessWidget {
  const SellerAnalyticsScreen({super.key});

  Widget _buildBar(String label, double percent, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
            Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color)),
          ]),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 10,
              backgroundColor: AppColors.lightGrey,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String sub, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
          Text(sub, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Analytics', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildStatCard('या महिन्याचा महसूल', '₹18,450', '↑ 12% वाढ', Icons.currency_rupee_outlined, Colors.green),
                _buildStatCard('एकूण ऑर्डर्स', '37', '↑ 5 नवीन', Icons.shopping_bag_outlined, AppColors.primaryBlue),
                _buildStatCard('Profile Views', '1,248', 'आज: 42', Icons.visibility_outlined, Colors.purple),
                _buildStatCard('Avg. Order Value', '₹498', 'प्रति ऑर्डर', Icons.analytics_outlined, Colors.orange),
              ],
            ),
            const SizedBox(height: 20),
            // Top Products
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Top Products — या महिन्यात', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 16),
                  _buildBar('तांदूळ 5kg', 0.85, '₹6,250', Colors.green),
                  _buildBar('गहू 5kg', 0.65, '₹4,140', AppColors.primaryBlue),
                  _buildBar('तेल 1L', 0.50, '₹3,080', Colors.orange),
                  _buildBar('डाळ 1kg', 0.35, '₹2,160', Colors.purple),
                  _buildBar('साखर 1kg', 0.20, '₹1,350', Colors.teal),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Weekly Revenue
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('साप्ताहिक महसूल', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ['सोम', 0.4, '₹2.1k'],
                      ['मंगळ', 0.6, '₹3.2k'],
                      ['बुध', 0.5, '₹2.8k'],
                      ['गुरु', 0.8, '₹4.5k'],
                      ['शुक्र', 0.7, '₹3.9k'],
                      ['शनि', 0.9, '₹5.1k'],
                      ['रवि', 0.3, '₹1.8k'],
                    ].map((d) => Column(
                      children: [
                        Text(d[2] as String, style: const TextStyle(fontSize: 10, color: AppColors.textLight)),
                        const SizedBox(height: 4),
                        Container(
                          width: 32,
                          height: 120 * (d[1] as double),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withOpacity(0.7 + (d[1] as double) * 0.3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(d[0] as String, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                      ],
                    )).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
