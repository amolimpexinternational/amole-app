import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerRevenueDetailScreen extends StatelessWidget {
  const SellerRevenueDetailScreen({super.key});

  Widget revenueTile(String month, String amount) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.currency_rupee),
        title: Text(month),
        trailing: Text(
          amount,
          style: const TextStyle(
            color: AppColors.successGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Revenue Details'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          revenueTile('April 2026', '₹24,500'),
          revenueTile('May 2026', '₹31,800'),
          revenueTile('June 2026', '₹38,400'),
        ],
      ),
    );
  }
}
