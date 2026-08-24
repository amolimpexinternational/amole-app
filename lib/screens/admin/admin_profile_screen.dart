import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Profile'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                const CircleAvatar(radius: 44, backgroundColor: AppColors.primaryBlue, child: Icon(Icons.person, size: 44, color: Colors.white)),
                const SizedBox(height: 12),
                const Text('Amole Admin', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                Text('AM-ADMIN-000001', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _menuTile(Icons.hub_outlined, 'Channel Partners व्यवस्थापन'),
          _menuTile(Icons.admin_panel_settings_outlined, 'Sub-Admin व्यवस्थापन'),
          _menuTile(Icons.bar_chart_outlined, 'Revenue Reports'),
          _menuTile(Icons.settings_outlined, 'ॲप सेटिंग्ज'),
          _menuTile(Icons.logout, 'लॉगआउट', color: AppColors.errorRed),
        ],
      ),
    );
  }

  Widget _menuTile(IconData icon, String title, {Color? color}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: ListTile(
        leading: Icon(icon, color: color ?? AppColors.primaryBlue),
        title: Text(title, style: TextStyle(color: color ?? AppColors.textDark, fontWeight: FontWeight.w600, fontSize: 14)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
