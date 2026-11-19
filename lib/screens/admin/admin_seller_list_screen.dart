import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'admin_edit_profile_screen.dart';
import '../seller/seller_home_screen.dart';

class AdminSellerListScreen extends StatefulWidget {
  const AdminSellerListScreen({super.key});

  @override
  State<AdminSellerListScreen> createState() => _AdminSellerListScreenState();
}

class _AdminSellerListScreenState extends State<AdminSellerListScreen> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _sellers = [
    {
      'shop': 'पाटील किराणा स्टोअर',
      'franchise': 'हडपसर फ्रँचाइजी',
      'status': 'Verified',
      'orders': '37',
      'revenue': '₹18,450',
      'customers': '124',
      'expiry': '31 Mar 2027',
      'active': true,
    },
    {
      'shop': 'श्री साई मेडिकल',
      'franchise': 'कोथरूड फ्रँचाइजी',
      'status': 'Verified',
      'orders': '52',
      'revenue': '₹26,900',
      'customers': '190',
      'expiry': '15 Jan 2027',
      'active': true,
    },
    {
      'shop': 'न्यू फॅशन पॉइंट',
      'franchise': 'वडगाव फ्रँचाइजी',
      'status': 'KYC Pending',
      'orders': '9',
      'revenue': '₹4,100',
      'customers': '22',
      'expiry': '—',
      'active': true,
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    switch (_selectedTab) {
      case 0:
        return _sellers;
      case 1:
        return _sellers.where((s) => s['active'] == true).toList();
      case 2:
        return _sellers.where((s) => s['active'] == false).toList();
      case 3:
        return _sellers.where((s) => s['status'] == 'KYC Pending').toList();
      default:
        return _sellers;
    }
  }

  void _toggleSeller(int originalIndex, bool value) {
    setState(() {
      _sellers[originalIndex]['active'] = value;
      if (!value) {
        _sellers[originalIndex]['status'] = 'Inactive';
      } else if (_sellers[originalIndex]['status'] == 'Inactive') {
        _sellers[originalIndex]['status'] = 'Verified';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value
              ? '${_sellers[originalIndex]["shop"]} — Profile ON ✅'
              : '${_sellers[originalIndex]["shop"]} — Profile OFF',
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
          'सर्व Sellers (${_sellers.length})',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(46),
          child: Container(
            color: AppColors.primaryBlue,
            child: Row(
              children: [
                _buildTab(0, 'सर्व', _sellers.length),
                _buildTab(1, 'Active',
                    _sellers.where((s) => s['active'] == true).length),
                _buildTab(2, 'Inactive',
                    _sellers.where((s) => s['active'] == false).length),
                _buildTab(
                    3,
                    'KYC Pending',
                    _sellers
                        .where((s) => s['status'] == 'KYC Pending')
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
                _buildStat('एकूण', '${_sellers.length}', AppColors.primaryBlue),
                _buildStat(
                    'Active',
                    '${_sellers.where((s) => s['active'] == true).length}',
                    AppColors.successGreen),
                _buildStat(
                    'Inactive',
                    '${_sellers.where((s) => s['active'] == false).length}',
                    AppColors.textLight),
                _buildStat(
                    'KYC Pending',
                    '${_sellers.where((s) => s['status'] == 'KYC Pending').length}',
                    AppColors.primaryOrange),
              ],
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text(
                      'कोणताही Seller नाही',
                      style: TextStyle(color: AppColors.textLight),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (ctx, i) {
                      final s = items[i];
                      final originalIndex = _sellers.indexOf(s);
                      return _buildSellerCard(s, originalIndex);
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

  Widget _buildSellerCard(Map<String, dynamic> s, int originalIndex) {
    final isVerified = s['status'] == 'Verified';
    final isActive = s['active'] as bool;

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
              ctx,
              MaterialPageRoute(
                builder: (_) => AdminEditProfileScreen(
                  name: s['shop'] as String? ?? '',
                  roleLabel: 'Seller',
                  idCode: s['franchise'] as String? ?? '',
                  avatarIcon: Icons.store_outlined,
                  avatarColor: AppColors.primaryBlue,
                  fields: [
                    ProfileField(
                        label: 'दुकानाचे नाव',
                        icon: Icons.store_outlined,
                        value: s['shop'] as String? ?? ''),
                    ProfileField(
                        label: 'Franchise',
                        icon: Icons.storefront_outlined,
                        value: s['franchise'] as String? ?? ''),
                    ProfileField(
                        label: 'स्थिती',
                        icon: Icons.verified_outlined,
                        value: s['status'] as String? ?? ''),
                    ProfileField(
                        label: 'Expiry',
                        icon: Icons.event_outlined,
                        value: s['expiry'] as String? ?? '—'),
                  ],
                  dashboardScreen: const SellerHomeScreen(),
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
                          ? AppColors.primaryBlue.withValues(alpha: 0.1)
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
                                  s['shop'] as String? ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: AppColors.textDark),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: (isVerified
                                          ? AppColors.successGreen
                                          : AppColors.primaryOrange)
                                      .withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  s['status'] as String? ?? '',
                                  style: TextStyle(
                                    color: isVerified
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
                          Row(
                            children: [
                              const Icon(Icons.storefront_outlined,
                                  size: 12, color: AppColors.textLight),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  s['franchise'] as String? ?? '',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textLight),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.event_outlined,
                                  size: 12, color: Colors.orange),
                              const SizedBox(width: 4),
                              Text(
                                'Expiry: ${s['expiry']}',
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
                    const Icon(Icons.shopping_bag_outlined,
                        size: 14, color: AppColors.textLight),
                    const SizedBox(width: 4),
                    Text(
                      '${s['orders']} ऑर्डर्स',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textDark),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.people_outline,
                        size: 14, color: AppColors.textLight),
                    const SizedBox(width: 4),
                    Text(
                      '${s['customers']}',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textDark),
                    ),
                    const Spacer(),
                    Text(
                      s['revenue'] as String? ?? '',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.successGreen,
                      ),
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
                  onChanged: (v) => _toggleSeller(originalIndex, v),
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