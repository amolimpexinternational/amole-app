import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CpRevenueScreen extends StatelessWidget {
  const CpRevenueScreen({super.key});

  Widget _buildBar(String label, double percent, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textLight))),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: percent,
                minHeight: 18,
                backgroundColor: AppColors.lightGrey,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        ],
      ),
    );
  }

  Widget _buildFranchiseRow(String name, String area, String revenue, String percent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
            child: const Icon(Icons.store_outlined, color: AppColors.primaryBlue, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
              Text(area, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
            ]),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(revenue, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.successGreen)),
            Text(percent, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
          ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Revenue Report', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_outlined, color: AppColors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Report download होत आहे...'), backgroundColor: AppColors.primaryBlue),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              _buildSummaryCard('एकूण Revenue', '₹38,400', Icons.currency_rupee, AppColors.successGreen),
              const SizedBox(width: 12),
              _buildSummaryCard('Revenue Share', '₹3,840', Icons.account_balance_outlined, AppColors.primaryBlue),
            ]),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.lightGrey)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('महिनानिहाय Revenue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 16),
                  _buildBar('जाने', 0.5, '₹19,200'),
                  _buildBar('फेब्रु', 0.6, '₹23,000'),
                  _buildBar('मार्च', 0.7, '₹26,800'),
                  _buildBar('एप्रिल', 0.65, '₹24,960'),
                  _buildBar('मे', 0.8, '₹30,720'),
                  _buildBar('जून', 1.0, '₹38,400'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Franchise-wise Revenue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 12),
            _buildFranchiseRow('हडपसर फ्रँचाइजी', 'पुणे — हडपसर', '₹12,400', '32%'),
            _buildFranchiseRow('कोथरूड फ्रँचाइजी', 'पुणे — कोथरूड', '₹9,800', '26%'),
            _buildFranchiseRow('वडगाव फ्रँचाइजी', 'पुणे — वडगाव', '₹8,600', '22%'),
            _buildFranchiseRow('भोसरी फ्रँचाइजी', 'पुणे — भोसरी', '₹7,600', '20%'),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.lightGrey)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
        ]),
      ),
    );
  }
}
