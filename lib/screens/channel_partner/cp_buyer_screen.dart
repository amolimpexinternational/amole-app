import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CpBuyerScreen extends StatelessWidget {
  const CpBuyerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: replace with real data from Firestore (collection: buyers, filtered by district)
    final List<Map<String, String>> buyers = [
      {'name': 'अजय कदम', 'area': 'हडपसर', 'orders': '18', 'spent': '₹4,200'},
      {'name': 'स्नेहा भोसले', 'area': 'कोथरूड', 'orders': '32', 'spent': '₹9,800'},
      {'name': 'विशाल पवार', 'area': 'वडगाव', 'orders': '7', 'spent': '₹1,450'},
      {'name': 'रेखा गायकवाड', 'area': 'भोसरी', 'orders': '24', 'spent': '₹6,300'},
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('एकूण Buyers', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.white,
            child: Row(children: [
              Expanded(child: Column(children: [
                Text('${buyers.length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                const Text('एकूण Buyers (जिल्ह्यात)', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
              ])),
            ]),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: buyers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (ctx, i) {
                final b = buyers[i];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.lightGrey),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 22, backgroundColor: AppColors.primaryOrange.withValues(alpha: 0.1), child: const Icon(Icons.person_outline, color: AppColors.primaryOrange)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(b['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                          Text('${b['area']} — ${b['orders']} ऑर्डर्स', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                        ]),
                      ),
                      Text(b['spent']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.successGreen)),
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
