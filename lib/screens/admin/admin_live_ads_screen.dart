import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'admin_create_ad_screen.dart';
import 'admin_view_dashboard_screen.dart';
import '../channel_partner/channel_partner_home_screen.dart';
import '../franchise/franchise_home_screen.dart';
import '../seller/seller_home_screen.dart';

class AdminLiveAdsScreen extends StatefulWidget {
  final String? locationKeyword;
  final String title;
  const AdminLiveAdsScreen({
    super.key,
    this.locationKeyword,
    this.title = 'जाहिरात विभाग',
  });

  @override
  State<AdminLiveAdsScreen> createState() => _AdminLiveAdsScreenState();
}

class _AdminLiveAdsScreenState extends State<AdminLiveAdsScreen> {
  int _selectedTab = 0;

  // === Live Ads ===
  final List<Map<String, dynamic>> _liveAds = [
    {
      'title': 'दिवाळी Sale — 20% सूट',
      'seller': 'गणेश किराणा मार्ट',
      'role': 'Seller',
      'underFranchise': 'हडपसर फ्रँचाइजी',
      'underCP': 'राजेश कुलकर्णी (पुणे CP)',
      'location': 'पुणे',
      'budget': 500,
      'expiry': '15 Dec 2026',
      'income': 450,
      'avatar': 'ग',
      'avatarColor': Colors.teal,
    },
    {
      'title': 'हडपसर स्पेशल ऑफर',
      'seller': 'हडपसर फ्रँचाइजी',
      'role': 'Franchise',
      'underFranchise': 'हडपसर फ्रँचाइजी',
      'underCP': 'राजेश कुलकर्णी (पुणे CP)',
      'location': 'हडपसर',
      'budget': 1000,
      'expiry': '20 Dec 2026',
      'income': 1200,
      'avatar': 'ह',
      'avatarColor': Colors.blue,
    },
    {
      'title': 'AMOLE Premium Launch',
      'seller': 'राजेश कुलकर्णी',
      'role': 'Channel Partner',
      'underFranchise': '—',
      'underCP': 'राजेश कुलकर्णी (पुणे CP)',
      'location': 'पुणे जिल्हा',
      'budget': 2000,
      'expiry': '31 Dec 2026',
      'income': 2800,
      'avatar': 'रा',
      'avatarColor': Colors.indigo,
    },
  ];

  // === Pending Ads ===
  final List<Map<String, dynamic>> _pendingAds = [
    {
      'title': 'नवीन Mobile Accessories',
      'seller': 'राज इलेक्ट्रॉनिक्स',
      'role': 'Seller',
      'underFranchise': 'कोथरूड फ्रँचाइजी',
      'underCP': 'राजेश कुलकर्णी (पुणे CP)',
      'location': 'कोथरूड',
      'budget': 300,
      'expiry': '—',
      'avatar': 'रा',
      'avatarColor': Colors.orange,
    },
    {
      'title': 'प्रमोटर खास ऑफर',
      'seller': 'प्रिया देशमुख',
      'role': 'Promoter',
      'underFranchise': 'वडगाव फ्रँचाइजी',
      'underCP': 'राजेश कुलकर्णी (पुणे CP)',
      'location': 'वडगाव',
      'budget': 250,
      'expiry': '—',
      'avatar': 'प्र',
      'avatarColor': Colors.pink,
    },
  ];

  // === Pending Offers ===
  final List<Map<String, dynamic>> _pendingOffers = [
    {
      'title': 'दिवाळी धमाका 30% सूट',
      'seller': 'गणेश किराणा मार्ट',
      'role': 'Seller',
      'underFranchise': 'हडपसर फ्रँचाइजी',
      'underCP': 'राजेश कुलकर्णी (पुणे CP)',
      'location': 'हडपसर',
      'budget': 500,
      'expiry': '—',
      'avatar': 'ग',
      'avatarColor': Colors.teal,
    },
  ];

  // === Rejected Ads ===
  final List<Map<String, dynamic>> _rejectedAds = [
    {
      'title': 'Weekend Special',
      'seller': 'श्री मेडिकल',
      'role': 'Seller',
      'underFranchise': 'वडगाव फ्रँचाइजी',
      'underCP': 'राजेश कुलकर्णी (पुणे CP)',
      'location': 'वडगाव',
      'budget': 400,
      'expiry': '—',
      'reason': 'फोटो अस्पष्ट / जाहिरात नियम उल्लंघन',
      'avatar': 'श्',
      'avatarColor': Colors.grey,
    },
  ];

  List<Map<String, dynamic>> get _currentList {
    switch (_selectedTab) {
      case 0:
        return _liveAds;
      case 1:
        return _pendingAds;
      case 2:
        return _pendingOffers;
      case 3:
        return _rejectedAds;
      default:
        return _liveAds;
    }
  }

  // === Person → Dashboard navigate ===
  void _openPersonDashboard(String role, String name) {
    Widget? dashboardScreen;
    if (role == 'Seller') {
      dashboardScreen = const SellerHomeScreen();
    } else if (role == 'Franchise') {
      dashboardScreen = const FranchiseHomeScreen();
    } else if (role == 'Channel Partner') {
      dashboardScreen = const ChannelPartnerHomeScreen();
    } else {
      // Promoter — फक्त माहिती
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$name ($role) — प्रमोटर डॅशबोर्ड Stage 3 मध्ये'),
          backgroundColor: AppColors.primaryBlue,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminViewDashboardScreen(
          name: name,
          roleLabel: role,
          headerSubtitle: 'Admin View',
          revenueLabel: 'या महिन्यातील महसूल',
          revenueValue: '₹0',
          viewerLabel: 'Admin',
          kpis: const [],
          dashboardScreen: dashboardScreen,
        ),
      ),
    );
  }

  // === Approve / Reject ===
  void _approveItem(Map<String, dynamic> ad, bool isOffer) {
    setState(() {
      if (isOffer) {
        _pendingOffers.remove(ad);
      } else {
        _pendingAds.remove(ad);
      }
      ad['expiry'] = '7 दिवस';
      ad['income'] = 0;
      _liveAds.insert(0, ad);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✅ "${ad['title']}" Live झाली'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _rejectItem(Map<String, dynamic> ad, bool isOffer) {
    setState(() {
      if (isOffer) {
        _pendingOffers.remove(ad);
      } else {
        _pendingAds.remove(ad);
      }
      ad['reason'] = 'Admin ने नाकारले';
      _rejectedAds.insert(0, ad);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('❌ "${ad['title']}" नाकारली'),
        backgroundColor: Colors.red,
      ),
    );
  }

  // === Preview Dialog ===
  void _previewAd(Map<String, dynamic> ad, {String status = 'Live'}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (ctx, ctrl) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.visibility, color: AppColors.primaryBlue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('जाहिरात Preview — $status',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx)),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: ctrl,
                padding: const EdgeInsets.all(16),
                children: [
                  // Ad card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primaryBlue, AppColors.royalBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.25),
                              child: Text(ad['avatar'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(ad['seller'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  Text('${ad['role']} • ${ad['location']}',
                                      style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(ad['title'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Hierarchy
                  _section('🏢 कोणाच्या अंडर?', [
                    _hierarchyRow(
                      'Channel Partner',
                      ad['underCP'] ?? '—',
                      'Channel Partner',
                      Icons.hub_outlined,
                      Colors.indigo,
                    ),
                    _hierarchyRow(
                      'Franchise',
                      ad['underFranchise'] ?? '—',
                      'Franchise',
                      Icons.storefront_outlined,
                      AppColors.primaryBlue,
                    ),
                    _hierarchyRow(
                      ad['role'] ?? 'Seller',
                      ad['seller'] ?? '—',
                      ad['role'] ?? 'Seller',
                      Icons.store_outlined,
                      Colors.teal,
                    ),
                  ]),

                  _section('📋 जाहिरात तपशील', [
                    _infoRow('Budget', '₹${ad['budget']}'),
                    _infoRow('Expiry', ad['expiry'] ?? '—'),
                    if (status == 'Live')
                      _infoRow('Income Generated', '₹${ad['income'] ?? 0}'),
                    if (status == 'Rejected' && ad['reason'] != null)
                      _infoRow('Reject Reason', ad['reason']),
                  ]),

                  if (status == 'Pending')
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.pending_actions,
                              color: Colors.orange, size: 20),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'ही जाहिरात Approval साठी प्रतीक्षेत आहे.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            // Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: status == 'Pending'
                  ? Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(ctx);
                              _rejectItem(ad, false);
                            },
                            icon: const Icon(Icons.close, color: Colors.red),
                            label: const Text('नाकारा',
                                style: TextStyle(color: Colors.red)),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              minimumSize: const Size(0, 44),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(ctx);
                              _approveItem(ad, false);
                            },
                            icon: const Icon(Icons.check, color: Colors.white),
                            label: const Text('मंजूर करा — Live',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.successGreen,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              minimumSize: const Size(0, 44),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Edit — Stage 3 मध्ये Firestore जोडल्यावर पूर्ण होईल'),
                              backgroundColor: AppColors.primaryBlue,
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit, color: Colors.white),
                        label: const Text('संपूर्ण Edit करा',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          minimumSize: const Size(0, 44),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hierarchyRow(String label, String name, String role, IconData icon,
      Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          if (name == '—') return;
          _openPersonDashboard(role, name);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.25)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(icon, color: color, size: 14),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: const TextStyle(
                            fontSize: 10, color: AppColors.textLight)),
                    Text(name,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              if (name != '—')
                Icon(Icons.chevron_right, size: 16, color: color),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text('$label: ',
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textLight)),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  // === Card ===
  Widget _buildCard(Map<String, dynamic> ad, String status) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor:
                    (ad['avatarColor'] as Color).withValues(alpha: 0.15),
                child: Text(ad['avatar'],
                    style: TextStyle(
                        color: ad['avatarColor'],
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ad['title'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.textDark)),
                    const SizedBox(height: 2),
                    Text('${ad['seller']} (${ad['role']})',
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textLight)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.hub_outlined,
                            size: 11, color: AppColors.textLight),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            '${ad['underCP']} › ${ad['underFranchise']}',
                            style: const TextStyle(
                                fontSize: 10, color: AppColors.textLight),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _statusBadge(status),
            ],
          ),
          const SizedBox(height: 10),
          // Budget + expiry row
          Row(
            children: [
              const Icon(Icons.currency_rupee,
                  size: 13, color: AppColors.textLight),
              const SizedBox(width: 3),
              Text('₹${ad['budget']}',
                  style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 14),
              const Icon(Icons.event_outlined, size: 13, color: Colors.orange),
              const SizedBox(width: 3),
              Text(ad['expiry'] ?? '—',
                  style: const TextStyle(fontSize: 12, color: Colors.orange)),
              const Spacer(),
              if (status == 'Live')
                Text('₹${ad['income'] ?? 0}',
                    style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.successGreen,
                        fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          // Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _previewAd(ad, status: status),
                  icon: const Icon(Icons.visibility,
                      size: 16, color: Colors.white),
                  label: const Text('Preview',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    minimumSize: const Size(0, 36),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              if (status == 'Pending') ...[
                IconButton(
                  icon: const Icon(Icons.check_circle_outline,
                      size: 22, color: Colors.green),
                  onPressed: () => _approveItem(ad, _selectedTab == 2),
                  tooltip: 'Approve',
                ),
                IconButton(
                  icon: const Icon(Icons.cancel_outlined,
                      size: 22, color: Colors.red),
                  onPressed: () => _rejectItem(ad, _selectedTab == 2),
                  tooltip: 'Reject',
                ),
              ] else ...[
                IconButton(
                  icon: const Icon(Icons.edit_outlined,
                      size: 20, color: AppColors.primaryBlue),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Edit — Stage 3'),
                        backgroundColor: AppColors.primaryBlue,
                      ),
                    );
                  },
                  tooltip: 'Edit',
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline,
                      size: 20, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      if (_selectedTab == 0) {
                        _liveAds.remove(ad);
                      } else if (_selectedTab == 3) {
                        _rejectedAds.remove(ad);
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🗑️ जाहिरात हटवली'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  tooltip: 'Delete',
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color c = Colors.grey;
    if (status == 'Live') c = Colors.green;
    if (status == 'Pending') c = Colors.orange;
    if (status == 'Rejected') c = Colors.red;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(status,
          style: TextStyle(
              color: c, fontSize: 11, fontWeight: FontWeight.w600)),
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
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalIncome =
        _liveAds.fold<int>(0, (sum, a) => sum + (a['income'] as int));

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('जाहिरात विभाग',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const AdminCreateAdScreen()),
              );
              if (mounted) setState(() {});
            },
            child: const Text(
              'Create New Ad',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(46),
          child: Container(
            color: AppColors.primaryBlue,
            child: Row(
              children: [
                _buildTab(0, 'Live', _liveAds.length),
                _buildTab(1, 'Pending Ads', _pendingAds.length),
                _buildTab(2, 'Pending Offers', _pendingOffers.length),
                _buildTab(3, 'Rejected', _rejectedAds.length),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Summary
          if (_selectedTab == 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Column(children: [
                      Text('${_liveAds.length}',
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBlue)),
                      const Text('Live जाहिराती',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.textLight)),
                    ]),
                  ),
                  Expanded(
                    child: Column(children: [
                      Text('₹$totalIncome',
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.successGreen)),
                      const Text('एकूण Income',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.textLight)),
                    ]),
                  ),
                ],
              ),
            ),
          Expanded(
            child: _currentList.isEmpty
                ? const Center(
                    child: Text('या विभागात सध्या काहीही नाही',
                        style: TextStyle(color: AppColors.textLight)))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _currentList.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (ctx, i) {
                      final statuses = ['Live', 'Pending', 'Pending', 'Rejected'];
                      return _buildCard(
                          _currentList[i], statuses[_selectedTab]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}