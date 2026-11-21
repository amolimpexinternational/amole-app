
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'cp_franchise_kyc_screen.dart';

class CpFranchiseScreen extends StatefulWidget {
  const CpFranchiseScreen({super.key});

  @override
  State<CpFranchiseScreen> createState() => _CpFranchiseScreenState();
}

class _CpFranchiseScreenState extends State<CpFranchiseScreen> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _franchises = [
    {
      'name': 'हडपसर फ्रँचाइजी',
      'area': 'पुणे — हडपसर',
      'owner': 'राजेश शर्मा',
      'phone': '9876543210',
      'sellers': 24,
      'buyers': 520,
      'status': 'Active',
      'revenue': '₹12,400',
      'expiry': '31 Mar 2027',
      'active': true,
    },
    {
      'name': 'कोथरूड फ्रँचाइजी',
      'area': 'पुणे — कोथरूड',
      'owner': 'सुनीता पाटील',
      'phone': '9765432109',
      'sellers': 18,
      'buyers': 480,
      'status': 'Active',
      'revenue': '₹9,800',
      'expiry': '15 Jan 2027',
      'active': true,
    },
    {
      'name': 'वडगाव फ्रँचाइजी',
      'area': 'पुणे — वडगाव',
      'owner': 'अमित देशमुख',
      'phone': '9654321098',
      'sellers': 11,
      'buyers': 430,
      'status': 'KYC Pending',
      'revenue': '₹5,200',
      'expiry': '—',
      'active': true,
    },
    {
      'name': 'भोसरी फ्रँचाइजी',
      'area': 'पुणे — भोसरी',
      'owner': 'प्रिया जोशी',
      'phone': '9543210987',
      'sellers': 8,
      'buyers': 420,
      'status': 'Active',
      'revenue': '₹4,600',
      'expiry': '10 Jun 2027',
      'active': true,
    },
    {
      'name': 'खडकी फ्रँचाइजी',
      'area': 'पुणे — खडकी',
      'owner': 'विकास कुलकर्णी',
      'phone': '9432109876',
      'sellers': 5,
      'buyers': 300,
      'status': 'Inactive',
      'revenue': '₹0',
      'expiry': '20 Dec 2026',
      'active': false,
    },
  ];

  // === Filter tabs ===
  List<Map<String, dynamic>> get _filtered {
    switch (_selectedTab) {
      case 0:
        return _franchises;
      case 1:
        return _franchises.where((f) => f['active'] == true).toList();
      case 2:
        return _franchises.where((f) => f['active'] == false).toList();
      case 3:
        return _franchises
            .where((f) => f['status'] == 'KYC Pending')
            .toList();
      default:
        return _franchises;
    }
  }

  void _toggleFranchise(int originalIndex, bool value) {
    setState(() {
      _franchises[originalIndex]['active'] = value;

      if (!value) {
        _franchises[originalIndex]['status'] = 'Inactive';
      } else if (_franchises[originalIndex]['status'] == 'Inactive') {
        _franchises[originalIndex]['status'] = 'Active';
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value
              ? '${_franchises[originalIndex]["name"]} — Profile ON ✅'
              : '${_franchises[originalIndex]["name"]} — Profile OFF',
        ),
        backgroundColor: value ? Colors.green : Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showAddFranchiseDialog() {
    final nameController = TextEditingController();
    final areaController = TextEditingController();
    final ownerController = TextEditingController();
    final phoneController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'नवीन Franchise जोडा',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildField(
              nameController,
              'Franchise नाव',
              Icons.business_outlined,
            ),
            const SizedBox(height: 12),
            _buildField(
              areaController,
              'क्षेत्र / तालुका',
              Icons.location_on_outlined,
            ),
            const SizedBox(height: 12),
            _buildField(
              ownerController,
              'मालकाचं नाव',
              Icons.person_outlined,
            ),
            const SizedBox(height: 12),
            _buildField(
              phoneController,
              'मोबाईल नंबर',
              Icons.phone_outlined,
              isPhone: true,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.trim().isNotEmpty &&
                      areaController.text.trim().isNotEmpty) {
                    setState(() {
                      _franchises.insert(0, {
                        'name': nameController.text.trim(),
                        'area': areaController.text.trim(),
                        'owner': ownerController.text.trim(),
                        'phone': phoneController.text.trim(),
                        'sellers': 0,
                        'buyers': 0,
                        'status': 'KYC Pending',
                        'revenue': '₹0',
                        'expiry': '—',
                        'active': true,
                      });
                    });

                    Navigator.pop(ctx);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('✅ नवीन Franchise जोडली!'),
                        backgroundColor: AppColors.successGreen,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Franchise जोडा',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController c,
    String hint,
    IconData icon, {
    bool isPhone = false,
  }) {
    return TextField(
      controller: c,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primaryBlue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    if (status == 'Active') return AppColors.successGreen;
    if (status == 'KYC Pending') return AppColors.primaryOrange;
    return AppColors.textLight;
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text(
          'Franchise Management',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton.icon(
              onPressed: _showAddFranchiseDialog,
              icon: const Icon(Icons.add, color: AppColors.white),
              label: const Text(
                'Add',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(46),
          child: Container(
            color: AppColors.primaryBlue,
            child: Row(
              children: [
                _buildTab(0, 'सर्व', _franchises.length),
                _buildTab(
                  1,
                  'Active',
                  _franchises.where((f) => f['active'] == true).length,
                ),
                _buildTab(
                  2,
                  'Inactive',
                  _franchises.where((f) => f['active'] == false).length,
                ),
                _buildTab(
                  3,
                  'KYC Pending',
                  _franchises
                      .where((f) => f['status'] == 'KYC Pending')
                      .length,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // === Stats row ===
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.white,
            child: Row(
              children: [
                _buildStat(
                  'एकूण',
                  '${_franchises.length}',
                  AppColors.primaryBlue,
                ),
                _buildStat(
                  'Active',
                  '${_franchises.where((f) => f['active'] == true).length}',
                  AppColors.successGreen,
                ),
                _buildStat(
                  'Inactive',
                  '${_franchises.where((f) => f['active'] == false).length}',
                  AppColors.textLight,
                ),
                _buildStat(
                  'KYC Pending',
                  '${_franchises.where((f) => f['status'] == 'KYC Pending').length}',
                  AppColors.primaryOrange,
                ),
              ],
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text(
                      'कोणतीही Franchise नाही',
                      style: TextStyle(color: AppColors.textLight),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (ctx, i) {
                      final f = items[i];
                      final originalIndex = _franchises.indexOf(f);
                      return _buildFranchiseCard(f, originalIndex);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddFranchiseDialog,
        backgroundColor: AppColors.primaryBlue,
        icon: const Icon(Icons.add, color: AppColors.white),
        label: const Text(
          'Add Franchise',
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }

  Widget _buildTab(int index, String label, int count) {
    final selected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 2,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? AppColors.cyan : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            '$label ($count)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.white : Colors.white60,
              fontWeight:
                  selected ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFranchiseCard(
    Map<String, dynamic> f,
    int originalIndex,
  ) {
    final isActive = f['active'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isActive ? Colors.green.shade200 : Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // === Main content (tap → KYC screen) ===
          InkWell(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(14),
            ),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CpFranchiseKycScreen(franchise: f),
                ),
              );

              if (result == true) setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: isActive
                            ? AppColors.primaryBlue.withOpacity(0.1)
                            : Colors.grey.shade200,
                        child: Icon(
                          Icons.store_outlined,
                          color: isActive
                              ? AppColors.primaryBlue
                              : Colors.grey,
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
                                    f['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _statusColor(f['status'])
                                        .withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    f['status'],
                                    style: TextStyle(
                                      color: _statusColor(f['status']),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              f['area'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textLight,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.event_outlined,
                                  size: 12,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Expiry: ${f['expiry']}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 14,
                        color: AppColors.textLight,
                      ),
                      Text(
                        f['owner'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textDark,
                        ),
                      ),
                      const Icon(
                        Icons.phone_outlined,
                        size: 14,
                        color: AppColors.textLight,
                      ),
                      Text(
                        f['phone'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildChip(
                        Icons.storefront_outlined,
                        '${f['sellers']} Sellers',
                        AppColors.primaryBlue,
                      ),
                      _buildChip(
                        Icons.people_outline,
                        '${f['buyers'] ?? 0} Buyers',
                        Colors.deepPurple,
                      ),
                      _buildChip(
                        Icons.currency_rupee,
                        'Monthly Income: ${f['revenue']}',
                        AppColors.successGreen,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // === Divider + Toggle row ===
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
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
                  onChanged: (v) => _toggleFranchise(originalIndex, v),
                  activeThumbColor: Colors.green.shade600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
