import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminSellerListScreen extends StatelessWidget {
  const AdminSellerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: replace with real data from Firestore (collection: sellers, all districts)
    final List<Map<String, String>> sellers = [
      {'shop': 'पाटील किराणा स्टोअर', 'franchise': 'हडपसर फ्रँचाइजी', 'status': 'Verified'},
      {'shop': 'श्री साई मेडिकल', 'franchise': 'कोथरूड फ्रँचाइजी', 'status': 'Verified'},
      {'shop': 'न्यू फॅशन पॉइंट', 'franchise': 'वडगाव फ्रँचाइजी', 'status': 'KYC Pending'},
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('सर्व Sellers (संपूर्ण नेटवर्क)'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(children: [
              Expanded(child: Column(children: [
                Text('${sellers.length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                const Text('एकूण Sellers', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
              ])),
              Expanded(child: Column(children: [
                Text('${sellers.where((s) => s['status'] == 'Verified').length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.successGreen)),
                const Text('Verified', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
              ])),
            ]),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: sellers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (ctx, i) {
                final s = sellers[i];
                final isVerified = s['status'] == 'Verified';
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
                  child: Row(children: [
                    CircleAvatar(radius: 22, backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1), child: const Icon(Icons.store_outlined, color: AppColors.primaryBlue)),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(s['shop']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                      Text(s['franchise']!, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                    ])),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: (isVerified ? AppColors.successGreen : AppColors.primaryOrange).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
                      child: Text(s['status']!, style: TextStyle(color: isVerified ? AppColors.successGreen : AppColors.primaryOrange, fontSize: 11, fontWeight: FontWeight.w600)),
                    ),
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
