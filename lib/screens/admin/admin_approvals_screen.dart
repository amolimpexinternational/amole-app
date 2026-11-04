import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminApprovalsScreen extends StatefulWidget {
  const AdminApprovalsScreen({super.key});

  @override
  State<AdminApprovalsScreen> createState() => _AdminApprovalsScreenState();
}

class _AdminApprovalsScreenState extends State<AdminApprovalsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // === CP नुसार ग्रुप केलेले ॲड्स ===
  final List<Map<String, dynamic>> _cpGroups = [
    {
      'cp': 'पुणे CP',
      'phone': '+91 9876543210',
      'franchises': [
        {
          'franchise': 'हडपसर फ्रँचाइजी',
          'phone': '+91 9876543211',
          'ads': [
            {'title': 'पाटील किराणा स्टोअर — Photo Ad', 'sender': 'पाटील किराणा स्टोअर', 'senderType': 'Seller', 'days': '3 दिवसांपूर्वी', 'budget': '₹300', 'status': 'pending'},
            {'title': 'जोशी किराणा — Text Ad', 'sender': 'जोशी किराणा', 'senderType': 'Seller', 'days': '2 दिवसांपूर्वी', 'budget': '₹200', 'status': 'pending'},
          ],
        },
        {
          'franchise': 'कोथरूड फ्रँचाइजी',
          'phone': '+91 9876543212',
          'ads': [
            {'title': 'श्री साई मेडिकल — Text Ad', 'sender': 'श्री साई मेडिकल', 'senderType': 'Seller', 'days': '1 दिवसापूर्वी', 'budget': '₹150', 'status': 'pending'},
            {'title': 'रेस्टॉरंट डील — Photo Ad', 'sender': 'स्वाद हॉटेल', 'senderType': 'Seller', 'days': '4 दिवसांपूर्वी', 'budget': '₹400', 'status': 'approved'},
          ],
        },
      ],
    },
    {
      'cp': 'नागपूर CP',
      'phone': '+91 9876543213',
      'franchises': [
        {
          'franchise': 'नागपूर फ्रँचाइजी',
          'phone': '+91 9876543214',
          'ads': [
            {'title': 'नागपूर किराणा — Video Ad', 'sender': 'नागपूर किराणा', 'senderType': 'Seller', 'days': '5 दिवसांपूर्वी', 'budget': '₹500', 'status': 'pending'},
          ],
        },
      ],
    },
  ];

  // === On-boarding (CP नुसार) ===
  final List<Map<String, dynamic>> _cpOnboardingGroups = [
    {
      'cp': 'पुणे CP',
      'phone': '+91 9876543210',
      'franchises': [
        {
          'franchise': 'हडपसर फ्रँचाइजी',
          'phone': '+91 9876543211',
          'requests': [
            {'title': 'न्यू फॅशन पॉईंट', 'type': 'Seller', 'days': '1 दिवसापूर्वी', 'status': 'pending'},
            {'title': 'जोशी किराणा', 'type': 'Seller', 'days': '2 दिवसांपूर्वी', 'status': 'pending'},
          ],
        },
        {
          'franchise': 'कोथरूड फ्रँचाइजी',
          'phone': '+91 9876543212',
          'requests': [
            {'title': 'श्री साई मेडिकल', 'type': 'Seller', 'days': '4 दिवसांपूर्वी', 'status': 'pending'},
            {'title': 'वडगाव फ्रँचाइजी', 'type': 'Franchise', 'days': '10 दिवसांपूर्वी', 'status': 'approved'},
          ],
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _countPendingAds() {
    int count = 0;
    for (final cp in _cpGroups) {
      for (final f in cp['franchises']) {
        for (final a in f['ads']) {
          if (a['status'] == 'pending') count++;
        }
      }
    }
    return count;
  }

  int _countPendingOnboarding() {
    int count = 0;
    for (final cp in _cpOnboardingGroups) {
      for (final f in cp['franchises']) {
        for (final r in f['requests']) {
          if (r['status'] == 'pending') count++;
        }
      }
    }
    return count;
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'Seller': return Colors.teal;
      case 'Franchise': return AppColors.primaryBlue;
      case 'Channel Partner': return Colors.purple;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('Pending Approvals (Admin)'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'जाहिराती (${_countPendingAds()})'),
            Tab(text: 'On-boarding (${_countPendingOnboarding()})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAdsTab(),
          _buildOnboardingTab(),
        ],
      ),
    );
  }

  // === जाहिराती टॅब ===
  Widget _buildAdsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // एकूण सारांश
        Container(
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange.shade200)),
          child: Row(
            children: [
              Icon(Icons.pending_actions, color: Colors.orange.shade700, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('एकूण ${_countPendingAds()} जाहिराती अप्रूव्हलसाठी प्रतीक्षेत', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange.shade900)),
                    Text('${_cpGroups.length} चॅनल पार्टनर अंतर्गत', style: TextStyle(fontSize: 12, color: Colors.orange.shade700)),
                  ],
                ),
              ),
            ],
          ),
        ),
        // प्रत्येक CP चा ग्रुप
        ..._cpGroups.map((cp) {
          final franchises = cp['franchises'] as List;
          int cpPending = 0;
          for (final f in franchises) {
            for (final a in f['ads']) {
              if (a['status'] == 'pending') cpPending++;
            }
          }
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: cpPending > 0 ? Colors.purple.shade200 : Colors.grey.shade200),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CP हेडर
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: cpPending > 0 ? Colors.purple.shade50 : Colors.grey.shade50,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.hub, color: cpPending > 0 ? Colors.purple.shade700 : Colors.grey, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cp['cp'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                            Text('📞 ${cp['phone']}', style: const TextStyle(fontSize: 12, color: AppColors.primaryBlue)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: cpPending > 0 ? Colors.purple : Colors.green, borderRadius: BorderRadius.circular(12)),
                        child: Text('$cpPending पेंडिंग', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                // प्रत्येक फ्रँचायझी
                ...franchises.map<Widget>((f) {
                  final ads = f['ads'] as List;
                  final pendingAds = ads.where((a) => a['status'] == 'pending').toList();
                  if (pendingAds.isEmpty) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // फ्रँचायझी हेडर
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        color: AppColors.lightGrey.withValues(alpha: 0.5),
                        child: Row(
                          children: [
                            const Icon(Icons.business, size: 16, color: AppColors.textLight),
                            const SizedBox(width: 6),
                            Expanded(child: Text(f['franchise'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark))),
                            Text('📞 ${f['phone']}', style: const TextStyle(fontSize: 11, color: AppColors.primaryBlue)),
                          ],
                        ),
                      ),
                      // ॲड्स
                      ...pendingAds.map<Widget>((ad) => _adRow(ad as Map<String, String>)),
                    ],
                  );
                }),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _adRow(Map<String, String> ad) {
    final typeColor = _typeColor(ad['senderType']!);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 14, backgroundColor: typeColor.withValues(alpha: 0.1), child: Icon(Icons.campaign_outlined, color: typeColor, size: 14)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ad['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textDark)),
                    Text('${ad['sender']} (${ad['senderType']}) • ${ad['days']} • बजेट ${ad['budget']}', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: OutlinedButton(
                style: OutlinedButton.styleFrom(foregroundColor: AppColors.errorRed, side: const BorderSide(color: AppColors.errorRed), padding: const EdgeInsets.symmetric(vertical: 6)),
                onPressed: () {},
                child: const Text('नाकारा', style: TextStyle(fontSize: 12)),
              )),
              const SizedBox(width: 8),
              Expanded(child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen, padding: const EdgeInsets.symmetric(vertical: 6)),
                onPressed: () {},
                child: const Text('मंजूर करा', style: TextStyle(color: Colors.white, fontSize: 12)),
              )),
            ],
          ),
        ],
      ),
    );
  }

  // === On-boarding टॅब ===
  Widget _buildOnboardingTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade200)),
          child: Row(
            children: [
              Icon(Icons.person_add_alt_1, color: Colors.blue.shade700, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('एकूण ${_countPendingOnboarding()} On-boarding विनंत्या प्रतीक्षेत', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
                    Text('${_cpOnboardingGroups.length} चॅनल पार्टनर अंतर्गत', style: TextStyle(fontSize: 12, color: Colors.blue.shade700)),
                  ],
                ),
              ),
            ],
          ),
        ),
        ..._cpOnboardingGroups.map((cp) {
          final franchises = cp['franchises'] as List;
          int cpPending = 0;
          for (final f in franchises) {
            for (final r in f['requests']) {
              if (r['status'] == 'pending') cpPending++;
            }
          }
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: cpPending > 0 ? Colors.purple.shade200 : Colors.grey.shade200),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: cpPending > 0 ? Colors.purple.shade50 : Colors.grey.shade50,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.hub, color: cpPending > 0 ? Colors.purple.shade700 : Colors.grey, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cp['cp'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                            Text('📞 ${cp['phone']}', style: const TextStyle(fontSize: 12, color: AppColors.primaryBlue)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: cpPending > 0 ? Colors.purple : Colors.green, borderRadius: BorderRadius.circular(12)),
                        child: Text('$cpPending पेंडिंग', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                ...franchises.map<Widget>((f) {
                  final requests = f['requests'] as List;
                  final pendingReqs = requests.where((r) => r['status'] == 'pending').toList();
                  if (pendingReqs.isEmpty) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        color: AppColors.lightGrey.withValues(alpha: 0.5),
                        child: Row(
                          children: [
                            const Icon(Icons.business, size: 16, color: AppColors.textLight),
                            const SizedBox(width: 6),
                            Expanded(child: Text(f['franchise'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark))),
                            Text('📞 ${f['phone']}', style: const TextStyle(fontSize: 11, color: AppColors.primaryBlue)),
                          ],
                        ),
                      ),
                      ...pendingReqs.map<Widget>((req) => _requestRow(req as Map<String, String>)),
                    ],
                  );
                }),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _requestRow(Map<String, String> req) {
    final isFranchise = req['type'] == 'Franchise';
    final typeColor = isFranchise ? AppColors.primaryBlue : Colors.teal;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(isFranchise ? Icons.storefront_outlined : Icons.store_outlined, color: typeColor, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(req['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color
