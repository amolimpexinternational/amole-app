import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'franchise_seller_profile_screen.dart';
import 'franchise_add_seller_screen.dart';

class FranchiseSellerListScreen extends StatefulWidget {
  const FranchiseSellerListScreen({super.key});

  @override
  State<FranchiseSellerListScreen> createState() =>
      _FranchiseSellerListScreenState();
}

class _FranchiseSellerListScreenState extends State<FranchiseSellerListScreen> {
  // TODO (Stage 3 - Backend): replace with Firestore query of sellers
  // linked to this Franchise's pincode.
  // 'active' = profile ON/OFF toggle
  // 'expiry' = subscription expiry date
  final List<Map<String, dynamic>> _sellers = [
    {
      "name": "राजेश किराणा स्टोअर",
      "mobile": "9876543210",
      "pincode": "411001",
      "joined": "12 Jul 2026",
      "expiry": "31 Mar 2027",
      "active": true,
    },
    {
      "name": "श्री मेडिकल्स",
      "mobile": "9823456712",
      "pincode": "411001",
      "joined": "18 Jul 2026",
      "expiry": "15 Jan 2027",
      "active": true,
    },
    {
      "name": "अनिता फॅशन हाऊस",
      "mobile": "9765432109",
      "pincode": "411002",
      "joined": "02 Aug 2026",
      "expiry": "20 Dec 2026",
      "active": false,
    },
    {
      "name": "पाटील हार्डवेअर",
      "mobile": "9911223344",
      "pincode": "411001",
      "joined": "10 Aug 2026",
      "expiry": "10 Jun 2027",
      "active": true,
    },
  ];

  void _toggleSeller(int index, bool value) {
    setState(() {
      _sellers[index]["active"] = value;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value
              ? '${_sellers[index]["name"]} — Profile ON केलं ✅'
              : '${_sellers[index]["name"]} — Profile OFF केलं',
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
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: Text(
          "Total Sellers (${_sellers.length})",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryBlue,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("नवीन सेलर जोडा", style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FranchiseAddSellerScreen()),
          );
        },
      ),
      body: _sellers.isEmpty
          ? const Center(child: Text("अजून कोणीही सेलर लिंक नाही"))
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
              itemCount: _sellers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final s = _sellers[index];
                final isActive = s["active"] as bool;

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isActive
                          ? Colors.green.shade200
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Column(
                    children: [
                      // === Main row — tap → profile ===
                      InkWell(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FranchiseSellerProfileScreen(
                                seller: {
                                  "name": s["name"].toString(),
                                  "mobile": s["mobile"].toString(),
                                  "pincode": s["pincode"].toString(),
                                  "joined": s["joined"].toString(),
                                },
                              ),
                            ),
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
                                            s["name"].toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        // Status badge
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: isActive
                                                ? Colors.green.shade50
                                                : Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(6),
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
                                      "📱 ${s["mobile"]}   📍 ${s["pincode"]}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textLight,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "सामील: ${s["joined"]}",
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textLight,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.event_outlined,
                                          size: 12,
                                          color: Colors.orange,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Expiry: ${s["expiry"]}",
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
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.chevron_right,
                                color: AppColors.textLight,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // === Divider + Toggle row ===
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.power_settings_new,
                                  size: 14,
                                  color: isActive
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isActive
                                      ? 'Profile ON'
                                      : 'Profile OFF',
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
                              onChanged: (v) => _toggleSeller(index, v),
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