import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'admin_edit_profile_screen.dart';
import '../franchise/franchise_home_screen.dart';

class AdminFranchiseListScreen extends StatefulWidget {
  const AdminFranchiseListScreen({super.key});

  @override
  State<AdminFranchiseListScreen> createState() =>
      _AdminFranchiseListScreenState();
}

class _AdminFranchiseListScreenState extends State<AdminFranchiseListScreen> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _franchises = [
    {
      'name': 'हडपसर फ्रँचाइजी',
      'area': 'पुणे — हडपसर',
      'cp': 'राजेश कुलकर्णी (पुणे CP)',
      'sellers': '24',
      'buyers': '850',
      'business': '₹85,000',
      'status': 'Active',
      'expiry': '31 Mar 2027',
      'active': true,
    },
    {
      'name': 'कोथरूड फ्रँचाइजी',
      'area': 'पुणे — कोथरूड',
      'cp': 'राजेश कुलकर्णी (पुणे CP)',
      'sellers': '18',
      'buyers': '620',
      'business': '₹62,000',
      'status': 'Active',
      'expiry': '15 Jan 2027',
      'active': true,
    },
    {
      'name': 'वडगाव फ्रँचाइजी',
      'area': 'पुणे — वडगाव',
      'cp': 'राजेश कुलकर्णी (पुणे CP)',
      'sellers': '11',
      'buyers': '340',
      'business': '₹38,000',
      'status': 'KYC Pending',
      'expiry': '—',
      'active': true,
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    switch (_selectedTab) {
      case 0:
        return _franchises;
      case 1:
        return _franchises.where((f) => f['active'] == true).toList();
      case 2:
        return _franchises.where((f) => f['active'] == false).toList();
      case 3:
        return _franchises.where((f) => f['status'] == 'KYC Pending').toList();
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

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: Text(
          'सर्व Franchise (${_franchises.length})',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(46),
          child: Container(
            color: AppColors.primaryBlue,
            child: Row(
              children: [
                _buildTab(0, 'सर्व', _franchises.length),
                _buildTab(1, 'Active',
                    _franchises.where((f) => f['active'] == true).length),
                _buildTab(2, 'Inactive',
                    _franchises.where((f) => f['active'] == false).length),
                _buildTab(
                    3,
                    'KYC Pending',
                    _franchises
                        .where((f) => f['status'] == 'KYC Pending')
                        .length),
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
            color: Colors.white,
            child: Row(
              children: [
                _buildStat('एकूण', '${_franchises.length}', AppColors.primaryBlue),
                _buildStat(
                    'Active',
                    '${_franchises.where((f) => f['active'] == true).length}',
                    AppColors.successGreen),
                _buildStat(
                    'Inactive',
                    '${_franchises.where((f) => f['active'] == false).length}',
                    AppColors.textLight),
                _buildStat(
                    'KYC Pending',
                    '${_franchises.where((f) => f['status'] == 'KYC Pending').length}',
                    AppColors.primaryOrange),
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
    );
  }

  Widget _buildTab(int index, String label, int count) {
    final selected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
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
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFranchiseCard(Map<String, dynamic> f, int originalIndex) {
    final isActive = f['active'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isActive ? Colors.green.shade200 : Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // === Main content — tap → edit profile ===
          InkWell(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(14)),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AdminEditProfileScreen(
                  name: f['name'] as String? ?? '',
                  roleLabel: 'Franchise',
                  idCode: f['area'] as String? ?? '',
                  avatarIcon: Icons.storefront_outlined,
                  avatarColor: AppColors.primaryBlue,
                  stats: [MapEntry('Sellers', f['sellers'] as String? ?? '0')],
                  fields: [
                    ProfileField(
                        label: 'परिसर',
                        icon: Icons.location_on_outlined,
                        value: f['area'] as String? ?? ''),
                    ProfileField(
                        label: 'Channel Partner',
                        icon: Icons.hub_outlined,
                        value: f['cp'] as String? ?? ''),
                    ProfileField(
                        label: 'स्थिती',
                        icon: Icons.verified_outlined,
                        value: f['status'] as String? ?? ''),
                    ProfileField(
                        label: 'Expiry',
                        icon: Icons.event_outlined,
                        value: f['expiry'] as String? ?? '—'),
                  ],
                  dashboardScreen: const FranchiseHomeScreen(),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: isActive
                          ? AppColors.primaryBlue.withOpacity(0.1)
                          : Colors.grey.shade200,
                      child: Icon(
                        Icons.storefront_outlined,
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
                                  f['name'] as String? ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: AppColors.textDark),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: (isActive
                                          ? AppColors.successGreen
                                          : AppColors.primaryOrange)
                                      .withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  f['status'] as String? ?? '',
                                  style: TextStyle(
                                    color: isActive
                                        ? AppColors.successGreen
                                        : AppColors.primaryOrange,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            f['area'] as String? ?? '',
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textLight),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.event_outlined,
                                  size: 12, color: Colors.orange),
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
                  ]),
                  const Divider(height: 20),
                  Row(children: [
                    const Icon(Icons.hub_outlined,
                        size: 14, color: AppColors.textLight),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        f['cp'] as String? ?? '',
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textDark),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.store_outlined,
                        size: 14, color: AppColors.textLight),
                    const SizedBox(width: 4),
                    Text(
                      '${f['sellers']} Sellers',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textDark),
                    ),
                  ]),
                ],
              ),
            ),
          ),
          // === Toggle row ===
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
          Text(value,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          Text(label,
              style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
        ],
      ),
    );
  }
}