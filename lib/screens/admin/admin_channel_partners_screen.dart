import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'admin_edit_profile_screen.dart';
import 'admin_view_dashboard_screen.dart';

class AdminChannelPartnersScreen extends StatelessWidget {
  const AdminChannelPartnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> channelPartners = [
      {
        'name': 'राजेश कुलकर्णी',
        'district': 'पुणे जिल्हा',
        'id': 'CP-PUN-2024-001',
        'mobile': '+91 98765 43210',
        'email': 'rajesh@amole.in',
        'joinDate': 'जानेवारी 2024',
        'kyc': 'Verified',
        'franchise': '8',
        'sellers': '142',
        'buyers': '3,250',
        'revenue': '₹38,400',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Channel Partners'), backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white),
      body: channelPartners.isEmpty
          ? _emptyState(icon: Icons.hub_outlined, title: 'अजून कोणताही Channel Partner नाही', subtitle: '"+" बटण दाबून पहिला Channel Partner जोडा')
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: channelPartners.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) => _cpCard(context, channelPartners[index]),
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryBlue,
        onPressed: () => _showAddCpDialog(context),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('नवीन CP', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _cpCard(BuildContext context, Map<String, String> cp) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (_) => AdminEditProfileScreen(
          name: cp['name'] ?? '',
          roleLabel: 'Channel Partner',
          idCode: cp['id'] ?? '',
          avatarIcon: Icons.hub_outlined,
          avatarColor: Colors.indigo,
          stats: [
            MapEntry('Franchise', cp['franchise'] ?? '0'),
            MapEntry('Sellers', cp['sellers'] ?? '0'),
            MapEntry('Buyers', cp['buyers'] ?? '0'),
          ],
          fields: [
            ProfileField(label: 'मोबाईल', icon: Icons.phone_outlined, value: cp['mobile'] ?? ''),
            ProfileField(label: 'Email', icon: Icons.email_outlined, value: cp['email'] ?? ''),
            ProfileField(label: 'जिल्हा', icon: Icons.location_on_outlined, value: cp['district'] ?? ''),
            ProfileField(label: 'Join Date', icon: Icons.calendar_today_outlined, value: cp['joinDate'] ?? ''),
            ProfileField(label: 'KYC Status', icon: Icons.verified_outlined, value: cp['kyc'] ?? ''),
          ],
          dashboardScreen: AdminViewDashboardScreen(
            name: cp['name'] ?? '',
            roleLabel: 'Channel Partner',
            headerSubtitle: '${cp['district']} — ${cp['id']}',
            revenueLabel: 'या महिन्याचं Revenue Share',
            revenueValue: cp['revenue'] ?? '₹0',
            kpis: [
              DashboardKpi(title: 'एकूण Franchise', value: cp['franchise'] ?? '0', subtitle: 'Active', icon: Icons.business_outlined, color: AppColors.primaryBlue),
              DashboardKpi(title: 'Active Sellers', value: cp['sellers'] ?? '0', subtitle: 'नोंदणीकृत', icon: Icons.storefront_outlined, color: AppColors.successGreen),
              DashboardKpi(title: 'एकूण Buyers', value: cp['buyers'] ?? '0', subtitle: 'नोंदणीकृत', icon: Icons.people_outline, color: AppColors.primaryOrange),
            ],
          ),
        ),
      )),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))]),
        child: Row(children: [
          CircleAvatar(backgroundColor: Colors.indigo.shade50, child: const Icon(Icons.hub_outlined, color: Colors.indigo)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(cp['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text(cp['district'] ?? '', style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
          ])),
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ]),
      ),
    );
  }

  Widget _emptyState({required IconData icon, required String title, required String subtitle}) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 64, color: Colors.grey.shade300),
        const SizedBox(height: 16),
        Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 6),
        Text(subtitle, style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
      ]),
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
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: nameController, decoration: const InputDecoration(labelText: 'नाव')),
          TextField(controller: districtController, decoration: const InputDecoration(labelText: 'जिल्हा')),
          TextField(controller: mobileController, decoration: const InputDecoration(labelText: 'मोबाईल नंबर'), keyboardType: TextInputType.phone),
        ]),
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
