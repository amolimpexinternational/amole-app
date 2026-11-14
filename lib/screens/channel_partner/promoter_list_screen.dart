import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../buyer/promoter_dashboard_screen.dart';

class PromoterListScreen extends StatelessWidget {
  const PromoterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> promoters = [
      {'name': 'अनिल जोशी', 'phone': '9876543210', 'area': 'हडपसर', 'status': 'Verified', 'earnings': '₹1,250'},
      {'name': 'संगीता राणे', 'phone': '9876543211', 'area': 'कोथरूड', 'status': 'Verified', 'earnings': '₹3,500'},
      {'name': 'रमेश पाटील', 'phone': '9876543212', 'area': 'वडगाव', 'status': 'Pending', 'earnings': '₹0'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('प्रमोटर यादी'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: promoters.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final p = promoters[index];
          final isVerified = p['status'] == 'Verified';
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                child: Text(p['name']![0], style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
              ),
              title: Text(p['name']!, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('${p['phone']} • ${p['area']}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isVerified ? AppColors.successGreen.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      p['status']!,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isVerified ? AppColors.successGreen : Colors.orange,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(p['earnings']!, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PromoterDashboardScreen()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
