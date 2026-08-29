import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../admin/admin_edit_profile_screen.dart';
import '../admin/admin_view_dashboard_screen.dart';

class FranchiseBuyerListScreen extends StatelessWidget {
  const FranchiseBuyerListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> buyers = [
      {"name": "सचिन जाधव", "mobile": "9898989898", "pincode": "411001", "joined": "05 Jul 2026", "orders": "18", "spent": "₹4,200"},
      {"name": "प्रिया देशमुख", "mobile": "9797979797", "pincode": "411002", "joined": "20 Jul 2026", "orders": "32", "spent": "₹9,800"},
      {"name": "विकास मोरे", "mobile": "9696969696", "pincode": "411001", "joined": "03 Aug 2026", "orders": "7", "spent": "₹1,450"},
    ];
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text("Total Buyers"),
      ),
      body: buyers.isEmpty
          ? const Center(child: Text("अजून कोणीही बायर लिंक नाही", style: TextStyle(color: AppColors.textLight)))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: buyers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final b = buyers[index];
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (_) => AdminEditProfileScreen(
                      name: b['name'] ?? '',
                      roleLabel: 'Buyer',
                      idCode: 'पिनकोड: ${b['pincode']}',
                      avatarIcon: Icons.person_outline,
                      avatarColor: AppColors.primaryOrange,
                      stats: [
                        MapEntry('Orders', b['orders'] ?? '0'),
                        MapEntry('Spent', b['spent'] ?? '₹0'),
                      ],
                      fields: [
                        ProfileField(label: 'मोबाईल नंबर', icon: Icons.phone_outlined, value: b['mobile'] ?? ''),
                        ProfileField(label: 'पिनकोड', icon: Icons.location_on_outlined, value: b['pincode'] ?? ''),
                        ProfileField(label: 'सामील तारीख', icon: Icons.calendar_today_outlined, value: b['joined'] ?? ''),
                      ],
                      dashboardScreen: AdminViewDashboardScreen(
                        name: b['name'] ?? '',
                        roleLabel: 'Buyer',
                        headerSubtitle: 'पिनकोड: ${b['pincode']}',
                        revenueLabel: 'एकूण खर्च',
                        revenueValue: b['spent'] ?? '₹0',
                        viewerLabel: 'Franchise',
                        kpis: [
                          DashboardKpi(title: 'एकूण ऑर्डर्स', value: b['orders'] ?? '0', subtitle: 'आजपर्यंत', icon: Icons.shopping_bag_outlined, color: AppColors.primaryBlue),
                          DashboardKpi(title: 'सामील', value: b['joined'] ?? '-', subtitle: 'तारीख', icon: Icons.calendar_today_outlined, color: AppColors.successGreen),
                        ],
                      ),
                    ),
                  )),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
                    child: Row(children: [
                      CircleAvatar(radius: 22, backgroundColor: AppColors.primaryOrange.withValues(alpha: 0.1), child: const Icon(Icons.person_outline, color: AppColors.primaryOrange)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(b["name"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                        Text("📱 ${b["mobile"]}   📍 ${b["pincode"]}", style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                        Text("सामील: ${b["joined"]}", style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                      ])),
                      Icon(Icons.chevron_right, color: Colors.grey.shade400),
                    ]),
                  ),
                );
              },
            ),
    );
  }
}
