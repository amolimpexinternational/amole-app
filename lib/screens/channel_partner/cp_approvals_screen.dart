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
    // TODO: replace with real data from Firestore (collection: advertisements, district-scoped).
    // Query order: status == 'pending' orderBy submittedAt ASC (oldest first) first,
    // then status == 'live' orderBy submittedAt ASC. Ads with status == 'ended' are
    // auto-deleted by a scheduled job and never queried here.
    final List<Map<String, String>> pendingAds = [
      {'title': 'पाटील किराणा स्टोअर — Photo Ad', 'subtitle': 'हडपसर फ्रँचाइजी • बजेट ₹300 • 3 दिवसांपूर्वी सबमिट', 'age': 'सर्वात जुनी'},
      {'title': 'श्री साई मेडिकल — Text Ad', 'subtitle': 'कोथरूड फ्रँचाइजी • बजेट ₹150 • 1 दिवसापूर्वी सबमिट', 'age': ''},
    ];
    final List<Map<String, String>> liveAds = [
      {'title': 'न्यू फॅशन पॉइंट — Video Ad', 'subtitle': 'वडगाव फ्रँचाइजी • बजेट ₹500 • 5 दिवसांपूर्वी मंजूर', 'age': ''},
      {'title': 'भोसरी जनरल स्टोअर्स — Photo Ad', 'subtitle': 'भोसरी फ्रँचाइजी • बजेट ₹200 • 6 दिवसांपूर्वी मंजूर', 'age': ''},
    ];

    if (pendingAds.isEmpty && liveAds.isEmpty) {
      return const _EmptyState(text: 'सध्या कोणतीही जाहिरात नाही');
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (pendingAds.isNotEmpty) ...[
          const _SectionLabel(text: '⏳ Approval प्रतीक्षेत (जुन्या आधी)'),
          ...pendingAds.map((ad) => _pendingAdCard(context, ad)),
          const SizedBox(height: 20),
        ],
        if (liveAds.isNotEmpty) ...[
          const _SectionLabel(text: '✅ मंजूर व Live'),
          ...liveAds.map((ad) => _liveAdCard(ad)),
        ],
      ],
    );
  }

  Widget _pendingAdCard(BuildContext context, Map<String, String> ad) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.orange.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.campaign_outlined, color: Colors.orange.shade700),
            const SizedBox(width: 10),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(ad['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                Text(ad['subtitle']!, style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
              ]),
            ),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(foregroundColor: AppColors.errorRed, side: const BorderSide(color: AppColors.errorRed)),
                onPressed: () {
                  // TODO: update advertisements doc -> status: rejected
                },
                child: const Text('नाकारा'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen),
                onPressed: () {
                  // TODO: update advertisements doc -> status: live
                },
                child: const Text('मंजूर करा', style: TextStyle(color: AppColors.white)),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _liveAdCard(Map<String, String> ad) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(children: [
        const Icon(Icons.check_circle_outline, color: AppColors.successGreen),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(ad['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
            Text(ad['subtitle']!, style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
          ]),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: AppColors.successGreen.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
          child: const Text('Live', style: TextStyle(color: AppColors.successGreen, fontSize: 11, fontWeight: FontWeight.w600)),
        ),
      ]),
    );
  }
}

// ---------------- टॅब २ — New On-boarding ----------------
class _OnboardingApprovalTab extends StatelessWidget {
  const _OnboardingApprovalTab();

  @override
  Widget build(BuildContext context) {
    // TODO: replace with real data from Firestore (collections: sellers + franchises,
    // district-scoped). Query order: status == 'pending' orderBy submittedAt ASC (oldest
    // first), then status == 'verified'/'active' orderBy submittedAt ASC.
    final List<Map<String, String>> pendingOnboarding = [
      {'title': 'कोथरूड फ्रँचाइजी — नवीन Seller', 'subtitle': 'श्री साई मेडिकल • 4 दिवसांपूर्वी विनंती • 72-तास मुदत जवळ', 'icon': 'seller'},
      {'title': 'नवीन Franchise विनंती', 'subtitle': 'खडकी पिनकोड • 2 दिवसांपूर्वी विनंती', 'icon': 'franchise'},
      {'title': 'हडपसर फ्रँचाइजी — नवीन Seller', 'subtitle': 'न्यू फॅशन पॉइंट • 1 दिवसापूर्वी विनंती', 'icon': 'seller'},
    ];
    final List<Map<String, String>> approvedOnboarding = [
      {'title': 'पाटील किराणा स्टोअर', 'subtitle': 'हडपसर फ्रँचाइजी • 6 दिवसांपूर्वी मंजूर', 'icon': 'seller'},
      {'title': 'वडगाव फ्रँचाइजी', 'subtitle': '10 दिवसांपूर्वी मंजूर', 'icon': 'franchise'},
    ];

    if (pendingOnboarding.isEmpty && approvedOnboarding.isEmpty) {
      return const _EmptyState(text: 'सध्या कोणतीही On-boarding विनंती नाही');
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (pendingOnboarding.isNotEmpty) ...[
          const _SectionLabel(text: '⏳ Approval प्रतीक्षेत (जुन्या आधी)'),
          ...pendingOnboarding.map((r) => _pendingOnboardingCard(context, r)),
          const SizedBox(height: 20),
        ],
        if (approvedOnboarding.isNotEmpty) ...[
          const _SectionLabel(text: '✅ मंजूर झालेले'),
          ...approvedOnboarding.map((r) => _approvedOnboardingCard(r)),
        ],
      ],
    );
  }

  Widget _pendingOnboardingCard(BuildContext context, Map<String, String> r) {
    final isSeller = r['icon'] == 'seller';
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.orange.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(isSeller ? Icons.storefront_outlined : Icons.business_outlined, color: Colors.orange.shade700),
            const SizedBox(width: 10),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(r['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                Text(r['subtitle']!, style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
              ]),
            ),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(foregroundColor: AppColors.errorRed, side: const BorderSide(color: AppColors.errorRed)),
                onPressed: () {
                  // TODO: update doc -> status: rejected
                },
                child: const Text('नाकारा'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen),
                onPressed: () {
                  // TODO: update doc -> status: verified/active
                },
                child: const Text('मंजूर करा', style: TextStyle(color: AppColors.white)),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _approvedOnboardingCard(Map<String, String> r) {
    final isSeller = r['icon'] == 'seller';
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(children: [
        Icon(isSeller ? Icons.storefront_outlined : Icons.business_outlined, color: AppColors.successGreen),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(r['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
            Text(r['subtitle']!, style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
          ]),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: AppColors.successGreen.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
          child: const Text('Verified', style: TextStyle(color: AppColors.successGreen, fontSize: 11, fontWeight: FontWeight.w600)),
        ),
      ]),
    );
  }
}

// ---------------- सामायिक विजेट्स ----------------
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textDark)),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String text;
  const _EmptyState({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.task_alt_outlined, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        ],
      ),
    );
  }
}
