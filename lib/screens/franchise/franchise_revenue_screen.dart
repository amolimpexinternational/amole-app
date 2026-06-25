import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FranchiseRevenueScreen extends StatelessWidget {
  const FranchiseRevenueScreen({super.key});

  Widget _buildBar(String label, double percent, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
            Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
          ]),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: percent, minHeight: 10,
              backgroundColor: AppColors.lightGrey,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
            ),
          ),
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
        title: const Text('Revenue Report', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            Row(children: [
              Expanded(child: _summaryCard('या महिन्याची कमाई', '₹4,250', Colors.green, Icons.currency_rupee_outlined)),
              const SizedBox(width: 12),
              Expanded(child: _summaryCard('एकूण Sellers', '48', AppColors.primaryBlue, Icons.storefront_outlined)),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _summaryCard('Active Sellers', '43', Colors.orange, Icons.check_circle_outline)),
              const SizedBox(width: 12),
              Expanded(child: _summaryCard('Commission Rate', '10%', Colors.purple, Icons.percent_outlined)),
            ]),
            const SizedBox(height: 20),
            // Top Earning Sellers
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Top Earning Sellers', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 16),
                  _buildBar('गणेश किराणा मार्ट', 0.90, '₹850'),
                  _buildBar('राज इलेक्ट्रॉनिक्स', 0.70, '₹650'),
                  _buildBar('श्री मेडिकल', 0.55, '₹520'),
                  _buildBar('प्रिया फॅशन', 0.40, '₹380'),
                  _buildBar('साई बेकरी', 0.25, '₹240'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Monthly Breakdown
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('मासिक Commission', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 16),
                  ...['जानेवारी', 'फेब्रुवारी', 'मार्च', 'एप्रिल', 'मे', 'जून'].asMap().entries.map((e) {
                    final amounts = ['₹2,100', '₹2,450', '₹3,200', '₹3,800', '₹4,100', '₹4,250'];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.value, style: const TextStyle(fontSize: 14, color: AppColors.textDark)),
                          Text(amounts[e.key], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          Text(title, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
        ],
      ),
    );
  }
}
