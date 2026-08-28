import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CpSellerRevenueScreen extends StatelessWidget {
  const CpSellerRevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: replace with real data from Firestore (aggregate orders by sellerId, filtered by district, this month)
    final List<Map<String, String>> sellers = [
      {'name': 'पाटील किराणा स्टोअर', 'franchise': 'हडपसर फ्रँचाइजी', 'orders': '86', 'revenue': '₹11,200'},
      {'name': 'श्री साई मेडिकल', 'franchise': 'कोथरूड फ्रँचाइजी', 'orders': '54', 'revenue': '₹8,600'},
      {'name': 'न्यू फॅशन पॉइंट', 'franchise': 'वडगाव फ्रँचाइजी', 'orders': '31', 'revenue': '₹6,100'},
      {'name': 'भोसरी जनरल स्टोअर्स', 'franchise': 'भोसरी फ्रँचाइजी', 'orders': '22', 'revenue': '₹4,300'},
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Seller-wise Revenue', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: AppColors.white,
            child: Column(children: const [
              Text('₹38,400', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.successGreen)),
              SizedBox(height: 4),
              Text('या महिन्याचं एकूण Revenue Share', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
            ]),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: sellers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (ctx, i) {
                final s = sellers[i];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.lightGrey),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 22, backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1), child: const Icon(Icons.storefront_outlined, color: AppColors.primaryBlue)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(s['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                          Text('${s['franchise']} — ${s['orders']} ऑर्डर्स', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                        ]),
                      ),
                      Text(s['revenue']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.successGreen)),
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
