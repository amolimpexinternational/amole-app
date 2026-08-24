import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminChannelPartnersScreen extends StatelessWidget {
  const AdminChannelPartnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: replace with real data from Firestore (collection: channel_partners)
    final List<Map<String, String>> channelPartners = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Channel Partners'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: channelPartners.isEmpty
          ? _emptyState(
              icon: Icons.hub_outlined,
              title: 'अजून कोणताही Channel Partner नाही',
              subtitle: '"+" बटण दाबून पहिला Channel Partner जोडा',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: channelPartners.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final cp = channelPartners[index];
                return _cpCard(cp);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryBlue,
        onPressed: () => _showAddCpDialog(context),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('नवीन CP', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _cpCard(Map<String, String> cp) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: Colors.indigo.shade50, child: const Icon(Icons.hub_outlined, color: Colors.indigo)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cp['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(cp['district'] ?? '', style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  Widget _emptyState({required IconData icon, required String title, required String subtitle}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
        ],
      ),
    );
  }

  void _showAddCpDialog(BuildContext context) {
    final nameController = TextEditingController();
    final districtController = TextEditingController();
    final mobileController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('नवीन Channel Partner जोडा'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'नाव')),
            TextField(controller: districtController, decoration: const InputDecoration(labelText: 'जिल्हा')),
            TextField(controller: mobileController, decoration: const InputDecoration(labelText: 'मोबाईल नंबर'), keyboardType: TextInputType.phone),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('रद्द करा')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
            onPressed: () {
              // TODO: save new channel partner to Firestore (collection: channel_partners)
              Navigator.pop(context);
            },
            child: const Text('जोडा', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
