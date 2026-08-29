import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'admin_edit_profile_screen.dart';
import '../buyer/buyer_home_screen.dart';

class AdminBuyerListScreen extends StatelessWidget {
  const AdminBuyerListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> buyers = [
      {'name': 'अजय कदम', 'area': 'पुणे — हडपसर', 'orders': '18', 'spent': '₹4,200'},
      {'name': 'स्नेहा भोसले', 'area': 'पुणे — कोथरूड', 'orders': '32', 'spent': '₹9,800'},
      {'name': 'विशाल पवार', 'area': 'पुणे — वडगाव', 'orders': '7', 'spent': '₹1,450'},
    ];
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, title: const Text('सर्व Buyers (संपूर्ण नेटवर्क)')),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(children: [
            Text('${buyers.length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
            const Text('एकूण नोंदणीकृत Buyers', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
          ]),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: buyers.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (ctx, i) {
              final b = buyers[i];
              return GestureDetector(
                onTap: () => Navigator.push(ctx, MaterialPageRoute(
                  builder: (_) => AdminEditProfileScreen(
                    name: b['name'] ?? '',
                    roleLabel: 'Buyer',
                    idCode: b['area'] ?? '',
                    avatarIcon: Icons.person_outline,
                    avatarColor: AppColors.primaryOrange,
                    stats: [
                      MapEntry('Orders', b['orders'] ?? '0'),
                      MapEntry('Spent', b['spent'] ?? '₹0'),
                    ],
                    fields: [
                      ProfileField(label: 'परिसर', icon: Icons.location_on_outlined, value: b['area'] ?? ''),
                    ],
                    dashboardScreen: const BuyerHomeScreen(),
                  ),
                )),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
                  child: Row(children: [
                    CircleAvatar(radius: 22, backgroundColor: AppColors.primaryOrange.withValues(alpha: 0.1), child: const Icon(Icons.person_outline, color: AppColors.primaryOrange)),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(b['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                      Text('${b['area']} — ${b['orders']} ऑर्डर्स', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                    ])),
                    Text(b['spent']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.successGreen)),
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
