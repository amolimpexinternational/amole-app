import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../buyer/promoter_dashboard_screen.dart';

class PromoterListScreen extends StatefulWidget {
  const PromoterListScreen({super.key});

  @override
  State<PromoterListScreen> createState() => _PromoterListScreenState();
}

class _PromoterListScreenState extends State<PromoterListScreen> {
  final List<Map<String, dynamic>> _promoters = [
    {
      'name': 'अनिल जोशी',
      'phone': '9876543210',
      'area': 'हडपसर',
      'status': 'Verified',
      'earnings': '₹1,250',
      'active': true,
    },
    {
      'name': 'संगीता राणे',
      'phone': '9876543211',
      'area': 'कोथरूड',
      'status': 'Verified',
      'earnings': '₹3,500',
      'active': true,
    },
    {
      'name': 'रमेश पाटील',
      'phone': '9876543212',
      'area': 'वडगाव',
      'status': 'Pending',
      'earnings': '₹0',
      'active': false,
    },
  ];

  void _togglePromoter(int index, bool value) {
    setState(() {
      _promoters[index]['active'] = value;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value
              ? '${_promoters[index]["name"]} — Profile ON केलं ✅'
              : '${_promoters[index]["name"]} — Profile OFF केलं',
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
          'प्रमोटर यादी (${_promoters.length})',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _promoters.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final p = _promoters[index];
          final isVerified = p['status'] == 'Verified';
          final isActive = p['active'] as bool;

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isActive ? Colors.green.shade200 : Colors.grey.shade300,
              ),
            ),
            child: Column(
              children: [
                // === Main row — tap → promoter dashboard ===
                InkWell(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PromoterDashboardScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: isActive
                              ? AppColors.primaryBlue.withValues(alpha: 0.1)
                              : Colors.grey.shade200,
                          child: Text(
                            (p['name'] as String)[0],
                            style: TextStyle(
                              color: isActive
                                  ? AppColors.primaryBlue
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
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
                                      p['name'] as String,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? Colors.green.shade50
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      isActive ? 'Active' : 'Inactive',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: isActive
                                            ? Colors.green.shade700
                                            : Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${p['phone']} • ${p['area']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textLight,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: isVerified
                                          ? AppColors.successGreen
                                              .withValues(alpha: 0.1)
                                          : Colors.orange
                                              .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      p['status'] as String,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: isVerified
                                            ? AppColors.successGreen
                                            : Colors.orange,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'कमाई: ${p['earnings']}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right,
                            color: AppColors.textLight),
                      ],
                    ),
                  ),
                ),
                // === Divider + Toggle row ===
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
                        onChanged: (v) => _togglePromoter(index, v),
                        activeThumbColor: Colors.green.shade600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}