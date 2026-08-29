import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'admin_edit_profile_screen.dart';
import 'admin_view_dashboard_screen.dart';

class AdminSellerListScreen extends StatelessWidget {
  const AdminSellerListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> sellers = [
      {'shop': 'पाटील किराणा स्टोअर', 'franchise': 'हडपसर फ्रँचाइजी', 'status': 'Verified', 'orders': '37', 'revenue': '₹18,450', 'customers': '124'},
      {'shop': 'श्री साई मेडिकल', 'franchise': 'कोथरूड फ्रँचाइजी', 'status': 'Verified', 'orders': '52', 'revenue': '₹26,900', 'customers': '190'},
      {'shop': 'न्यू फॅशन पॉइंट', 'franchise': 'वडगाव फ्रँचाइजी', 'status': 'KYC Pending', 'orders': '9', 'revenue': '₹4,100', 'customers': '22'},
    ];
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, title: const Text('सर्व Sellers (संपूर्ण नेटवर्क)')),
      body: Column(children: [
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
              return GestureDetector(
                onTap: () => Navigator.push(ctx, MaterialPageRoute(
                  builder: (_) => AdminEditProfileScreen(
                    name: s['shop'] ?? '',
                    roleLabel: 'Seller',
                    idCode: s['franchise'] ?? '',
                    avatarIcon: Icons.store_outlined,
                    avatarColor: AppColors.primaryBlue,
                    fields: [
                      ProfileField(label: 'दुकानाचे नाव', icon: Icons.store_outlined, value: s['shop'] ?? ''),
                      ProfileField(label: 'Franchise', icon: Icons.storefront_outlined, value: s['franchise'] ?? ''),
                      ProfileField(label: 'स्थिती', icon: Icons.verified_outlined, value: s['status'] ?? ''),
                    ],
                    dashboardScreen: AdminViewDashboardScreen(
                      name: s['shop'] ?? '',
                      roleLabel: 'Seller',
                      headerSubtitle: s['franchise'] ?? '',
                      revenueLabel: 'या महिन्यातील महसूल',
                      revenueValue: s['revenue'] ?? '₹0',
                      kpis: [
                        DashboardKpi(title: 'ऑर्डर्स', value: s['orders'] ?? '0', subtitle: 'या महिन्यात', icon: Icons.shopping_bag_outlined, color: Colors.orange),
                        DashboardKpi(title: 'ग्राहक', value: s['customers'] ?? '0', subtitle: 'या महिन्यात', icon: Icons.people_outlined, color: Colors.purple),
                      ],
                    ),
                  ),
                )),
                child: Container(
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
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
