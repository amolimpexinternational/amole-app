import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CpApprovalsScreen extends StatelessWidget {
  const CpApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: AppBar(
          backgroundColor: AppColors.primaryBlue,
          title: const Text('Pending Approvals', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
          iconTheme: const IconThemeData(color: AppColors.white),
          bottom: const TabBar(
            indicatorColor: AppColors.white,
            labelColor: AppColors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'जाहिराती'),
              Tab(text: 'New On-boarding'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _AdsApprovalTab(),
            _OnboardingApprovalTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------- टॅब १ — जाहिराती ----------------
class _AdsApprovalTab extends StatelessWidget {
  const _AdsApprovalTab();

  @override
  Widget build(BuildContext context) {
    // === फ्रँचायझीनुसार ग्रुप केलेले ॲड्स ===
    final List<Map<String, dynamic>> franchiseGroups = [
      {
        'franchise': 'हडपसर फ्रँचाइजी',
        'phone': '+91 9876543210',
        'pendingCount': 2,
        'ads': [
          {'title': 'पाटील किराणा स्टोअर — Photo Ad', 'sender': 'पाटील किराणा स्टोअर', 'senderType': 'Seller', 'days': '3 दिवसांपूर्वी', 'budget': '₹300'},
          {'title': 'जोशी किराणा — Text Ad', 'sender': 'जोशी किराणा', 'senderType': 'Seller', 'days': '2 दिवसांपूर्वी', 'budget': '₹200'},
        ],
      },
      {
        'franchise': 'कोथरूड फ्रँचाइजी',
        'phone': '+91 9876543211',
        'pendingCount': 1,
        'ads': [
          {'title': 'श्री साई मेडिकल — Text Ad', 'sender': 'श्री साई मेडिकल', 'senderType': 'Seller', 'days': '1 दिवसापूर्वी', 'budget': '₹150'},
        ],
      },
      {
        'franchise': 'वडगाव फ्रँचाइजी',
        'phone': '+91 9876543212',
        'pendingCount': 0,
        'ads': [],
      },
    ];

    final totalPending = franchiseGroups.fold<int>(0, (sum, g) => sum + (g['pendingCount'] as int));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // === एकूण सारांश ===
        Container(
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.pending_actions, color: Colors.orange.shade700, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('एकूण $totalPending जाहिराती अप्रूव्हलसाठी प्रतीक्षेत', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange.shade900)),
                    Text('${franchiseGroups.where((g) => (g['pendingCount'] as int) > 0).length} फ्रँचायझींकडून', style: TextStyle(fontSize: 12, color: Colors.orange.shade700)),
                  ],
                ),
              ),
            ],
          ),
        ),

        // === प्रत्येक फ्रँचायझीचा ग्रुप ===
        ...franchiseGroups.map((group) {
          final count = group['pendingCount'] as int;
          final ads = group['ads'] as List;
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: count > 0 ? Colors.orange.shade200 : Colors.grey.shade200),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // फ्रँचायझी हेडर
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: count > 0 ? Colors.orange.shade50 : Colors.grey.shade50,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.business, color: count > 0 ? Colors.orange.shade700 : Colors.grey, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(group['franchise'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                            Text('📞 ${group['phone']}', style: const TextStyle(fontSize: 12, color: AppColors.primaryBlue)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: count > 0 ? Colors.orange : Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('$count पेंडिंग', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                // ॲड्स यादी
                if (ads.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(14),
                    child: Text('कोणतेही पेंडिंग नाही', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                  )
                else
                  ...ads.map<Widget>((ad) => _adRow(context, ad as Map<String, String>)),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _adRow(BuildContext context, Map<String, String> ad) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.campaign_outlined, color: AppColors.primaryBlue, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ad['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textDark)),
                    Text('पाठवणारा: ${ad['sender']} (${ad['senderType']}) • ${ad['days']} • बजेट ${ad['budget']}', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
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
}

// ---------------- टॅब २ — New On-boarding ----------------
class _OnboardingApprovalTab extends StatelessWidget {
  const _OnboardingApprovalTab();

  @override
  Widget build(BuildContext context) {
    // === फ्रँचायझीनुसार ग्रुप ===
    final List<Map<String, dynamic>> franchiseGroups = [
      {
        'franchise': 'हडपसर फ्रँचाइजी',
        'phone': '+91 9876543210',
        'pendingCount': 2,
        'requests': [
          {'title': 'न्यू फॅशन पॉईंट', 'type': 'Seller', 'days': '1 दिवसापूर्वी'},
          {'title': 'जोशी किराणा', 'type': 'Seller', 'days': '2 दिवसांपूर्वी'},
        ],
      },
      {
        'franchise': 'कोथरूड फ्रँचाइजी',
        'phone': '+91 9876543211',
        'pendingCount': 1,
        'requests': [
          {'title': 'श्री साई मेडिकल', 'type': 'Seller', 'days': '4 दिवसांपूर्वी'},
        ],
      },
    ];

    final totalPending = franchiseGroups.fold<int>(0, (sum, g) => sum + (g['pendingCount'] as int));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.person_add_alt_1, color: Colors.blue.shade700, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('एकूण $totalPending On-boarding विनंत्या प्रतीक्षेत', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
                    Text('${franchiseGroups.where((g) => (g['pendingCount'] as int) > 0).length} फ्रँचायझींकडून', style: TextStyle(fontSize: 12, color: Colors.blue.shade700)),
                  ],
                ),
              ),
            ],
          ),
        ),
        ...franchiseGroups.map((group) {
          final count = group['pendingCount'] as int;
          final requests = group['requests'] as List;
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: count > 0 ? Colors.blue.shade200 : Colors.grey.shade200),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: count > 0 ? Colors.blue.shade50 : Colors.grey.shade50,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.business, color: count > 0 ? Colors.blue.shade700 : Colors.grey, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(group['franchise'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                            Text('📞 ${group['phone']}', style: const TextStyle(fontSize: 12, color: AppColors.primaryBlue)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: count > 0 ? Colors.blue : Colors.green, borderRadius: BorderRadius.circular(12)),
                        child: Text('$count पेंडिंग', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                if (requests.isEmpty)
                  const Padding(padding: EdgeInsets.all(14), child: Text('कोणतेही पेंडिंग नाही', style: TextStyle(fontSize: 12, color: AppColors.textLight)))
                else
                  ...requests.map<Widget>((req) => _requestRow(context, req as Map<String, String>)),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _requestRow(BuildContext context, Map<String, String> req) {
    final isSeller = req['type'] == 'Seller';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(isSeller ? Icons.storefront_outlined : Icons.business_outlined, color: isSeller ? Colors.teal : AppColors.primaryBlue, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(req['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textDark)),
                    Text('${req['type']} • ${req['days']}', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
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
}
