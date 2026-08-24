import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminRevenueScreen extends StatelessWidget {
  const AdminRevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revenue Overview'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(child: _summaryCard('आजची कमाई', '₹0', Colors.green)),
              const SizedBox(width: 12),
              Expanded(child: _summaryCard('महिन्याची कमाई', '₹0', Colors.blue)),
            ],
          ),
          const SizedBox(height: 20),
          const Text('कमिशन वाटप (प्रकरण ७ नुसार)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 10),
          _splitRow('Franchise (1%)', '₹0'),
          _splitRow('Channel Partner (0.25%)', '₹0'),
          _splitRow('Buyer Reward Wallet (2%)', '₹0'),
          _splitRow('Referrer Reward (0.25%)', '₹0'),
          _splitRow('कंपनी निव्वळ उत्पन्न (6.5%)', '₹0', highlight: true),
          const SizedBox(height: 20),
          const Text('जाहिरात महसूल', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 10),
          _splitRow('एकूण Ad Spend', '₹0'),
          _splitRow('कंपनी वाटा (30%)', '₹0', highlight: true),
        ],
      ),
    );
  }

  Widget _summaryCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _splitRow(String label, String value, {bool highlight = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: highlight ? AppColors.primaryBlue.withValues(alpha: 0.06) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: highlight ? AppColors.primaryBlue.withValues(alpha: 0.2) : Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, fontWeight: highlight ? FontWeight.bold : FontWeight.normal, color: AppColors.textDark)),
          Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: highlight ? AppColors.primaryBlue : AppColors.textDark)),
        ],
      ),
    );
  }
}
