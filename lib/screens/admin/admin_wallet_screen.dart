import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminWalletScreen extends StatelessWidget {
  const AdminWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: replace with real data from Firestore (aggregate company_ledger collection)
    final List<Map<String, String>> transactions = [
      {'title': 'Seller Commission जमा — पाटील किराणा स्टोअर', 'amount': '+₹10.00', 'time': 'आज, 11:42 AM', 'type': 'credit'},
      {'title': 'Franchise Settlement — हडपसर फ्रँचाइजी', 'amount': '-₹1,200.00', 'time': 'आज, 9:00 AM', 'type': 'debit'},
      {'title': 'Ad Revenue — CP जाहिरात', 'amount': '+₹0.15', 'time': 'काल, 6:20 PM', 'type': 'credit'},
      {'title': 'Seller Daily Auto-Settlement', 'amount': '-₹4,850.00', 'time': 'काल, 12:00 AM', 'type': 'debit'},
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('Company Wallet'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.royalBlue, AppColors.primaryBlue], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('सध्याची Wallet शिल्लक', style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 6),
                const Text('₹0.00', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _headerStat('आजचा जमा', '₹0'),
                    _headerStat('महिन्याचा जमा', '₹0'),
                    _headerStat('एकूण Settlement', '₹0'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('अलीकडील व्यवहार', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 10),
          ...transactions.map((t) {
            final isCredit = t['type'] == 'credit';
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
              child: Row(
                children: [
                  Icon(isCredit ? Icons.arrow_downward : Icons.arrow_upward, color: isCredit ? AppColors.successGreen : AppColors.errorRed, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t['title']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                        Text(t['time']!, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                      ],
                    ),
                  ),
                  Text(t['amount']!, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isCredit ? AppColors.successGreen : AppColors.errorRed)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _headerStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
      ],
    );
  }
}
