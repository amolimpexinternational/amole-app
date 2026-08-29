import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/transactions_data.dart';
import '../../models/transaction_model.dart';

class AdminEntityTransactionsScreen extends StatelessWidget {
  final String entityName;
  final String roleLabel;

  const AdminEntityTransactionsScreen({super.key, required this.entityName, required this.roleLabel});

  @override
  Widget build(BuildContext context) {
    final txns = TransactionsData.forEntity(entityName);
    final totalCredit = txns.where((t) => t.type == TxnType.credit).fold(0.0, (s, t) => s + t.amount);
    final totalDebit = txns.where((t) => t.type == TxnType.debit).fold(0.0, (s, t) => s + t.amount);

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, title: Text('$entityName — व्यवहार')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(children: [
              Expanded(child: Column(children: [
                Text('₹${totalCredit.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.successGreen)),
                const Text('एकूण जमा', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
              ])),
              Expanded(child: Column(children: [
                Text('₹${totalDebit.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.errorRed)),
                const Text('एकूण वजा/Settlement', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
              ])),
            ]),
          ),
          Expanded(
            child: txns.isEmpty
                ? const Center(child: Text('अजून कोणताही व्यवहार नाही', style: TextStyle(color: AppColors.textLight)))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: txns.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (ctx, i) {
                      final t = txns[i];
                      final isCredit = t.type == TxnType.credit;
                      return Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
                        child: Row(children: [
                          Icon(isCredit ? Icons.arrow_downward : Icons.arrow_upward, color: isCredit ? AppColors.successGreen : AppColors.errorRed, size: 18),
                          const SizedBox(width: 10),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(t.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                            Text(t.dateLabel, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                          ])),
                          Text('${isCredit ? '+' : '-'}₹${t.amount.toStringAsFixed(0)}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isCredit ? AppColors.successGreen : AppColors.errorRed)),
                        ]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
