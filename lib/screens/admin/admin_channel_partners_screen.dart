import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'admin_edit_profile_screen.dart';
import '../channel_partner/channel_partner_home_screen.dart';

class AdminChannelPartnersScreen extends StatefulWidget {
  const AdminChannelPartnersScreen({super.key});

  @override
  State<AdminChannelPartnersScreen> createState() =>
      _AdminChannelPartnersScreenState();
}

class _AdminChannelPartnersScreenState
    extends State<AdminChannelPartnersScreen> {
  final List<Map<String, dynamic>> _channelPartners = [
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
      'active': true,
    },
  ];

  void _toggleCp(int index, bool value) {
    setState(() {
      _channelPartners[index]['active'] = value;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value
              ? '${_channelPartners[index]["name"]} — Profile ON ✅'
              : '${_channelPartners[index]["name"]} — Profile OFF',
        ),
        backgroundColor: value ? Colors.green : Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(
          'Channel Partners (${_channelPartners.length})',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: _channelPartners.isEmpty
          ? _emptyState(
              icon: Icons.hub_outlined,
              title: 'अजून कोणताही Channel Partner नाही',
              subtitle: '"+" बटण दाबून पहिला Channel Partner जोडा',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _channelPartners.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) =>
                  _cpCard(context, _channelPartners[index], index),
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryBlue,
        onPressed: () => _showAddCpDialog(context),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('नवीन CP', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _cpCard(BuildContext context, Map<String, dynamic> cp, int index) {
    final isActive = cp['active'] as bool;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isActive ? Colors.green.shade200 : Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // === Main row — tap → edit profile ===
          InkWell(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AdminEditProfileScreen(
                  name: cp['name'] as String? ?? '',
                  roleLabel: 'Channel Partner',
                  idCode: cp['id'] as String? ?? '',
                  avatarIcon: Icons.hub_outlined,
                  avatarColor: Colors.indigo,
                  stats: [
                    MapEntry('Franchise', cp['franchise'] as String? ?? '0'),
                    MapEntry('Sellers', cp['sellers'] as String? ?? '0'),
                    MapEntry('Buyers', cp['buyers'] as String? ?? '0'),
                  ],
                  fields: [
                    ProfileField(
                        label: 'मोबाईल',
                        icon: Icons.phone_outlined,
                        value: cp['mobile'] as String? ?? ''),
                    ProfileField(
                        label: 'Email',
                        icon: Icons.email_outlined,
                        value: cp['email'] as String? ?? ''),
                    ProfileField(
                        label: 'जिल्हा',
                        icon: Icons.location_on_outlined,
                        value: cp['district'] as String? ?? ''),
                    ProfileField(
                        label: 'Join Date',
                        icon: Icons.calendar_today_outlined,
                        value: cp['joinDate'] as String? ?? ''),
                    ProfileField(
                        label: 'KYC Status',
                        icon: Icons.verified_outlined,
                        value: cp['kyc'] as String? ?? ''),
                  ],
                  dashboardScreen: const ChannelPartnerHomeScreen(),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        isActive ? Colors.indigo.shade50 : Colors.grey.shade200,
                    child: Icon(
                      Icons.hub_outlined,
                      color: isActive ? Colors.indigo : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                cp['name'] as String? ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? Colors.green.shade50
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                isActive ? 'Active' : 'Inactive',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: isActive
                                      ? Colors.green.shade700
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          cp['district'] as String? ?? '',
                          style: const TextStyle(
                              color: AppColors.textLight, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey.shade400),
                ],
              ),
            ),
          ),
          // === Toggle row ===
          const Divider(height: 1),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.power_settings_new,
                      size: 14,
                      color: isActive ? Colors.green : Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isActive ? 'Profile ON' : 'Profile OFF',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isActive
                            ? Colors.green.shade700
                            : Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: isActive,
                  onChanged: (v) => _toggleCp(index, v),
                  activeThumbColor: Colors.green.shade600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 6),
          Text(subtitle,
              style:
                  const TextStyle(fontSize: 13, color: AppColors.textLight)),
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
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'नाव')),
            TextField(
                controller: districtController,
                decoration: const InputDecoration(labelText: 'जिल्हा')),
            TextField(
                controller: mobileController,
                decoration: const InputDecoration(labelText: 'मोबाईल नंबर'),
                keyboardType: TextInputType.phone),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('रद्द करा')),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  _channelPartners.insert(0, {
                    'name': nameController.text,
                    'district': districtController.text,
                    'id': 'CP-NEW-${DateTime.now().millisecondsSinceEpoch}',
                    'mobile': mobileController.text,
                    'email': '',
                    'joinDate': 'आज',
                    'kyc': 'Pending',
                    'franchise': '0',
                    'sellers': '0',
                    'buyers': '0',
                    'revenue': '₹0',
                    'active': true,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ नवीन Channel Partner जोडला!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('जोडा', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}