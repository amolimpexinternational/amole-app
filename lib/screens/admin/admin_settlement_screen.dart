import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/transactions_data.dart';
import '../../models/transaction_model.dart';

class AdminSettlementScreen extends StatelessWidget {
  const AdminSettlementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final byDate = TransactionsData.settlementsByDate;
    final dateKeys = byDate.keys.toList()..sort((a, b) => b.compareTo(a));
    final grandTotal = dateKeys.fold(0.0, (sum, k) => sum + TransactionsData.totalForDate(k));

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, title: const Text('Seller Daily Auto-Settlement')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.royalBlue, AppColors.primaryBlue], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('एकूण Settlement (सर्व दिवस)', style: TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 6),
              Text('₹${grandTotal.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            ]),
          ),
          Expanded(
            child: dateKeys.isEmpty
                ? const Center(child: Text('अजून कोणतंही Settlement झालेलं नाही', style: TextStyle(color: AppColors.textLight)))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: dateKeys.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (ctx, i) {
                      final key = dateKeys[i];
                      final txns = byDate[key]!;
                      final total = TransactionsData.totalForDate(key);
                      final label = txns.first.dateLabel;
                      return GestureDetector(
                        onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => _SettlementDayDetailScreen(dateLabel: label, transactions: txns))),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
                          child: Row(children: [
                            CircleAvatar(radius: 22, backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1), child: const Icon(Icons.event_outlined, color: AppColors.primaryBlue)),
                            const SizedBox(width: 12),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                              Text('${txns.length} Sellers ना Settlement झालं', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                            ])),
                            Text('₹${total.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.successGreen)),
                          ]),
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

class _SettlementDayDetailScreen extends StatelessWidget {
  final String dateLabel;
  final List<TransactionModel> transactions;
  const _SettlementDayDetailScreen({required this.dateLabel, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, title: Text('Settlement — $dateLabel')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (ctx, i) {
          final t = transactions[i];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
            child: Row(children: [
              const Icon(Icons.store_outlined, color: AppColors.primaryBlue),
              const SizedBox(width: 10),
              Expanded(child: Text(t.entityName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
              Text('₹${t.amount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.successGreen)),
            ]),
          );
        },
      ),
    );
  }
}
