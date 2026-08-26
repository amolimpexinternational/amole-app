import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CpApprovalsScreen extends StatelessWidget {
  const CpApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: replace with real data from Firestore (collection: approval_requests,
    // filtered by district == currentCP.district, status: pending)
    final List<Map<String, String>> pendingApprovals = [
      {'title': 'हडपसर फ्रँचाइजी — नवीन जाहिरात', 'subtitle': 'Seller: पाटील किराणा स्टोअर — Photo Ad, बजेट ₹300', 'type': 'ad'},
      {'title': 'कोथरूड फ्रँचाइजी — Seller KYC', 'subtitle': 'श्री साई मेडिकल — 72 तासांत verification बाकी', 'type': 'seller_kyc'},
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Pending Approvals', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: pendingApprovals.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.task_alt_outlined, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text('सध्या कोणतेही Approval प्रतीक्षेत नाही', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: pendingApprovals.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) => _approvalCard(context, pendingApprovals[index]),
            ),
    );
  }

  Widget _approvalCard(BuildContext context, Map<String, String> req) {
    final isAd = req['type'] == 'ad';
    return Container(
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
          Row(
            children: [
              Icon(isAd ? Icons.campaign_outlined : Icons.how_to_reg_outlined, color: Colors.orange.shade700),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(req['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                    Text(req['subtitle'] ?? '', style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(foregroundColor: AppColors.errorRed, side: const BorderSide(color: AppColors.errorRed)),
                  onPressed: () {
                    // TODO: update Firestore approval_requests doc -> status: rejected
                  },
                  child: const Text('नाकारा'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen),
                  onPressed: () {
                    // TODO: update Firestore approval_requests doc -> status: approved
                  },
                  child: const Text('मंजूर करा', style: TextStyle(color: AppColors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
