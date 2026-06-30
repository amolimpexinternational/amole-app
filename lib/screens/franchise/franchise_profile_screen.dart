import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FranchiseProfileScreen extends StatelessWidget {
  const FranchiseProfileScreen({super.key});

  Widget _infoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primaryBlue),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('माझं प्रोफाइल', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.primaryBlue,
              child: Icon(Icons.business, color: Colors.white, size: 44),
            ),
            const SizedBox(height: 12),
            const Text('AMOLE Franchise — हडपसर', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const Text('AM-IN-MH-PN-F-000001', style: TextStyle(fontSize: 13, color: AppColors.textLight)),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoTile(Icons.person_outlined, 'मालकाचं नाव', 'विशाल जाधव'),
                  _infoTile(Icons.phone_outlined, 'मोबाईल नंबर', '+91 9999999999'),
                  _infoTile(Icons.location_on_outlined, 'क्षेत्र', 'पुणे — हडपसर तालुका'),
                  _infoTile(Icons.calendar_today_outlined, 'सामील झाले', '१५ जानेवारी २०२५'),
                  _infoTile(Icons.storefront_outlined, 'एकूण Sellers', '48'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined),
                label: const Text('प्रोफाइल Edit करा'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
                onPressed: () {},
                icon: const Icon(Icons.logout_outlined),
                label: const Text('Logout करा'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
