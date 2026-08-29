import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class DashboardKpi {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  DashboardKpi({required this.title, required this.value, required this.subtitle, required this.icon, required this.color});
}

class AdminViewDashboardScreen extends StatelessWidget {
  final String name;
  final String roleLabel;
  final String headerSubtitle;
  final String revenueLabel;
  final String revenueValue;
  final List<DashboardKpi> kpis;

  const AdminViewDashboardScreen({
    super.key,
    required this.name,
    required this.roleLabel,
    required this.headerSubtitle,
    required this.revenueLabel,
    required this.revenueValue,
    required this.kpis,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
              decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.primaryBlue, AppColors.royalBlue], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
                    Expanded(child: Text('$roleLabel Dashboard (Admin View)', style: const TextStyle(color: Colors.white70, fontSize: 12))),
                  ]),
                  Text(name, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(headerSubtitle, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(14)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(revenueLabel, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(revenueValue, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      ]),
                      const Icon(Icons.account_balance_wallet_outlined, color: AppColors.cyan, size: 32),
                    ]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(10)),
                    child: const Row(children: [
                      Icon(Icons.visibility_outlined, color: AppColors.primaryBlue, size: 18),
                      SizedBox(width: 8),
                      Expanded(child: Text('हे Admin साठी फक्त बघण्यासाठी (Read-only) डॅशबोर्ड आहे.', style: TextStyle(fontSize: 12, color: AppColors.textDark))),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1.4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: kpis.map((k) => Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Expanded(child: Text(k.title, style: const TextStyle(fontSize: 12, color: AppColors.textLight))),
                            Icon(k.icon, color: k.color, size: 22),
                          ]),
                          Text(k.value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: k.color)),
                          Text(k.subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                        ],
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
