import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'admin_edit_profile_screen.dart';
import 'admin_view_dashboard_screen.dart';

class AdminFranchiseListScreen extends StatelessWidget {
  const AdminFranchiseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> franchises = [
      {'name': 'हडपसर फ्रँचाइजी', 'area': 'पुणे — हडपसर', 'cp': 'राजेश कुलकर्णी (पुणे CP)', 'sellers': '24', 'buyers': '850', 'business': '₹85,000', 'status': 'Active'},
      {'name': 'कोथरूड फ्रँचाइजी', 'area': 'पुणे — कोथरूड', 'cp': 'राजेश कुलकर्णी (पुणे CP)', 'sellers': '18', 'buyers': '620', 'business': '₹62,000', 'status': 'Active'},
      {'name': 'वडगाव फ्रँचाइजी', 'area': 'पुणे — वडगाव', 'cp': 'राजेश कुलकर्णी (पुणे CP)', 'sellers': '11', 'buyers': '340', 'business': '₹38,000', 'status': 'KYC Pending'},
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, title: const Text('सर्व Franchise')),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(children: [
            Expanded(child: Column(children: [
              Text('${franchises.length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
              const Text('एकूण Franchise', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
            ])),
            Expanded(child: Column(children: [
              Text('${franchises.where((f) => f['status'] == 'Active').length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.successGreen)),
              const Text('Active', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
            ])),
          ]),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: franchises.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (ctx, i) {
              final f = franchises[i];
              final isActive = f['status'] == 'Active';
              return GestureDetector(
                onTap: () => Navigator.push(ctx, MaterialPageRoute(
                  builder: (_) => AdminEditProfileScreen(
                    name: f['name'] ?? '',
                    roleLabel: 'Franchise',
                    idCode: f['area'] ?? '',
                    avatarIcon: Icons.storefront_outlined,
                    avatarColor: AppColors.primaryBlue,
                    stats: [MapEntry('Sellers', f['sellers'] ?? '0')],
                    fields: [
                      ProfileField(label: 'परिसर', icon: Icons.location_on_outlined, value: f['area'] ?? ''),
                      ProfileField(label: 'Channel Partner', icon: Icons.hub_outlined, value: f['cp'] ?? ''),
                      ProfileField(label: 'स्थिती', icon: Icons.verified_outlined, value: f['status'] ?? ''),
                    ],
                    dashboardScreen: AdminViewDashboardScreen(
                      name: f['name'] ?? '',
                      roleLabel: 'Franchise',
                      headerSubtitle: f['area'] ?? '',
                      revenueLabel: "या महिन्याचा व्यवसाय",
                      revenueValue: f['business'] ?? '₹0',
                      kpis: [
                        DashboardKpi(title: 'Total Sellers', value: f['sellers'] ?? '0', subtitle: 'नोंदणीकृत', icon: Icons.storefront_outlined, color: AppColors.primaryBlue),
                        DashboardKpi(title: 'Total Buyers', value: f['buyers'] ?? '0', subtitle: 'नोंदणीकृत', icon: Icons.people_outline, color: AppColors.successGreen),
                      ],
                    ),
                  ),
                )),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      CircleAvatar(radius: 22, backgroundColor: AppColors.primaryBlue.withOpacity(0.1), child: const Icon(Icons.storefront_outlined, color: AppColors.primaryBlue)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(f['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                        Text(f['area']!, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                      ])),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: (isActive ? AppColors.successGreen : AppColors.primaryOrange).withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                        child: Text(f['status']!, style: TextStyle(color: isActive ? AppColors.successGreen : AppColors.primaryOrange, fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                    ]),
                    const Divider(height: 20),
                    Row(children: [
                      const Icon(Icons.hub_outlined, size: 14, color: AppColors.textLight),
                      const SizedBox(width: 4),
                      Expanded(child: Text(f['cp']!, style: const TextStyle(fontSize: 12, color: AppColors.textDark))),
                      const Icon(Icons.store_outlined, size: 14, color: AppColors.textLight),
                      const SizedBox(width: 4),
                      Text('${f['sellers']} Sellers', style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
                    ]),
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
