import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/transactions_data.dart';
import '../../models/transaction_model.dart';

class FranchiseWalletScreen extends StatelessWidget {
  final String franchiseName;
  const FranchiseWalletScreen({super.key, required this.franchiseName});

  @override
  Widget build(BuildContext context) {
    final todaysPoints = TransactionsData.todaysRewardPoints(franchiseName);
    final txns = TransactionsData.forEntity(franchiseName);
    final totalSettled = txns.where((t) => t.category == 'settlement').fold(0.0, (s, t) => s + t.amount);

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, title: const Text('Franchise Wallet')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.royalBlue, AppColors.primaryBlue], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('आज दिवसभरात आलेले Reward Points', style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 6),
                Text('₹${todaysPoints.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('हे आज रात्री Admin कडून Auto-Settlement होऊन बँक खात्यावर जमा होतील', style: TextStyle(color: Colors.white70, fontSize: 11)),
                const SizedBox(height: 14),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  _headerStat('आजपर्यंत एकूण Settled', '₹${totalSettled.toStringAsFixed(0)}'),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('अलीकडील व्यवहार', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 10),
          if (txns.isEmpty)
            const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Center(child: Text('अजून कोणताही व्यवहार नाही', style: TextStyle(color: AppColors.textLight))))
          else
            ...txns.map((t) {
              final isCredit = t.type == TxnType.credit;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                child: Row(children: [
                  Icon(isCredit ? Icons.arrow_downward : Icons.arrow_upward, color: isCredit ? AppColors.successGreen : AppColors.errorRed, size: 18),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(t.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                    Text(t.dateLabel, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                  ])),
                  Text('${isCredit ? '+' : '-'}₹${t.amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isCredit ? AppColors.successGreen : AppColors.errorRed)),
                ]),
              );
            }),
        ],
      ),
    );
  }

  Widget _headerStat(String label, String value) {
    return Column(children: [
      Text(value, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
      const SizedBox(height: 2),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
    ]);
  }
}
