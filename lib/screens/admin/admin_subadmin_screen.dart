import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminSubAdminScreen extends StatelessWidget {
  const AdminSubAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: replace with real data from Firestore (collection: sub_admins)
    final List<Map<String, String>> subAdmins = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sub-Admins'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: subAdmins.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.admin_panel_settings_outlined, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text('अजून कोणताही Sub-Admin नाही', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 6),
                  const Text('"+" बटण दाबून नवीन Sub-Admin नियुक्त करा', style: TextStyle(fontSize: 13, color: AppColors.textLight)),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: subAdmins.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final admin = subAdmins[index];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1), child: const Icon(Icons.admin_panel_settings_outlined, color: AppColors.primaryBlue)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(admin['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(admin['role'] ?? '', style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryBlue,
        onPressed: () => _showAddSubAdminDialog(context),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('नवीन Sub-Admin', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _showAddSubAdminDialog(BuildContext context) {
    final nameController = TextEditingController();
    final mobileController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('नवीन Sub-Admin नियुक्त करा'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'नाव')),
            TextField(controller: mobileController, decoration: const InputDecoration(labelText: 'मोबाईल नंबर'), keyboardType: TextInputType.phone),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('रद्द करा')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
            onPressed: () {
              // TODO: save new sub-admin to Firestore (collection: sub_admins)
              Navigator.pop(context);
            },
            child: const Text('नियुक्त करा', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
