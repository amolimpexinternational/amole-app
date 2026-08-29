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

  final List<Map<String, String>> _adRequests = [
    {'title': 'किराणा दुकान जाहिरात', 'by': 'हडपसर फ्रँचाइजी', 'date': '2026-06-20', 'status': 'pending', 'days': '5 दिवसांपूर्वी'},
    {'title': 'मेडिकल स्टोअर ऑफर', 'by': 'कोथरूड फ्रँचाइजी', 'date': '2026-06-22', 'status': 'pending', 'days': '3 दिवसांपूर्वी'},
    {'title': 'रेस्टॉरंट डील', 'by': 'वडगाव फ्रँचाइजी', 'date': '2026-06-24', 'status': 'approved', 'days': '1 दिवसापूर्वी'},
  ];

  final List<Map<String, String>> _onboardingRequests = [
    {'title': 'राज इलेक्ट्रॉनिक्स', 'type': 'Seller', 'by': 'हडपसर फ्रँचाइजी', 'days': '7 दिवसांपूर्वी', 'status': 'pending'},
    {'title': 'स्वाद हॉटेल', 'type': 'Seller', 'by': 'कोथरूड फ्रँचाइजी', 'days': '4 दिवसांपूर्वी', 'status': 'pending'},
    {'title': 'नागपूर फ्रँचाइजी', 'type': 'Franchise', 'by': 'नागपूर CP', 'days': '2 दिवसांपूर्वी', 'status': 'pending'},
    {'title': 'पुणे उत्तर फ्रँचाइजी', 'type': 'Franchise', 'by': 'पुणे CP', 'days': '1 दिवसापूर्वी', 'status': 'approved'},
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

  Widget _buildAdCard(Map<String, String> req) {
    final isPending = req['status'] == 'pending';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isPending ? Colors.orange.shade200 : Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: isPending ? Colors.orange.shade50 : Colors.green.shade50,
              child: Icon(Icons.campaign_outlined, color: isPending ? Colors.orange : Colors.green, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(req['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
              Text('${req['by']} • ${req['days']}', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
            ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isPending ? Colors.orange.shade50 : Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(isPending ? 'प्रतीक्षेत' : 'मंजूर', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isPending ? Colors.orange : Colors.green)),
            ),
          ]),
          if (isPending) ...[
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: OutlinedButton(
                style: OutlinedButton.styleFrom(foregroundColor: AppColors.errorRed, side: const BorderSide(color: AppColors.errorRed)),
                onPressed: () {},
                child: const Text('नाकारा'),
              )),
              const SizedBox(width: 10),
              Expanded(child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen),
                onPressed: () {},
                child: const Text('मंजूर करा', style: TextStyle(color: Colors.white)),
              )),
            ]),
          ],
        ],
      ),
    );
  }

  Widget _buildOnboardingCard(Map<String, String> req) {
    final isPending = req['status'] == 'pending';
    final isFranchise = req['type'] == 'Franchise';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isPending ? Colors.blue.shade200 : Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: isFranchise ? AppColors.primaryBlue.withOpacity(0.1) : Colors.teal.shade50,
              child: Icon(isFranchise ? Icons.storefront_outlined : Icons.store_outlined, color: isFranchise ? AppColors.primaryBlue : Colors.teal, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(req['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
              Text('${req['type']} • ${req['by']} • ${req['days']}', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
            ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isPending ? Colors.blue.shade50 : Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(isPending ? 'प्रतीक्षेत' : 'मंजूर', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isPending ? AppColors.primaryBlue : Colors.green)),
            ),
          ]),
          if (isPending) ...[
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: OutlinedButton(
                style: OutlinedButton.styleFrom(foregroundColor: AppColors.errorRed, side: const BorderSide(color: AppColors.errorRed)),
                onPressed: () {},
                child: const Text('नाकारा'),
              )),
              const SizedBox(width: 10),
              Expanded(child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen),
                onPressed: () {},
                child: const Text('मंजूर करा', style: TextStyle(color: Colors.white)),
              )),
            ]),
          ],
        ],
      ),
    );
  }

  List<Map<String, String>> get _sortedAds {
    final pending = _adRequests.where((r) => r['status'] == 'pending').toList();
    final approved = _adRequests.where((r) => r['status'] == 'approved').toList();
    return [...pending, ...approved];
  }

  List<Map<String, String>> get _sortedOnboarding {
    final pending = _onboardingRequests.where((r) => r['status'] == 'pending').toList();
    final approved = _onboardingRequests.where((r) => r['status'] == 'approved').toList();
    return [...pending, ...approved];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('Pending Approvals'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'जाहिराती (${_sortedAds.where((r) => r['status'] == 'pending').length})'),
            Tab(text: 'New On-boarding (${_sortedOnboarding.where((r) => r['status'] == 'pending').length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _sortedAds.length,
            itemBuilder: (_, i) => _buildAdCard(_sortedAds[i]),
          ),
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _sortedOnboarding.length,
            itemBuilder: (_, i) => _buildOnboardingCard(_sortedOnboarding[i]),
          ),
        ],
      ),
    );
  }
}
