import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminApprovalsScreen extends StatelessWidget {
  const AdminApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: replace with real data from Firestore (collection: approval_requests, status: pending)
    // Each request should store: type (franchise_kyc / ad / seller_kyc), requestedBy (franchise/CP id),
    // targetId (seller/ad id), submittedAt.
    final List<Map<String, String>> pendingApprovals = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Approvals'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: pendingApprovals.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.task_alt_outlined, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text('सध्या कोणतेही Approval प्रतीक्षेत नाही', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 6),
                  const Text('Franchise/CP कडून येणाऱ्या विनंत्या इथे दिसतील', style: TextStyle(fontSize: 13, color: AppColors.textLight)),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: pendingApprovals.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final req = pendingApprovals[index];
                return _approvalCard(context, req);
              },
            ),
    );
  }

  Widget _approvalCard(BuildContext context, Map<String, String> req) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.orange.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.pending_actions_outlined, color: Colors.orange.shade700),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(req['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
                  child: const Text('मंजूर करा', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
