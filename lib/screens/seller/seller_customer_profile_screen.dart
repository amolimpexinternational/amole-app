import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerCustomerProfileScreen extends StatelessWidget {
  final String customerName;
  final String totalPurchase;
  final String visits;

  const SellerCustomerProfileScreen({
    super.key,
    required this.customerName,
    required this.totalPurchase,
    required this.visits,
  });

  // TODO (Stage 3 - Backend): replace with real purchase history from
  // Firestore (collection: orders, filtered by sellerId + buyerId)
  static const List<Map<String, String>> _recentPurchases = [
    {'items': 'तांदूळ 5kg, तेल 1L', 'amount': '₹390', 'date': '2 दिवसांपूर्वी'},
    {'items': 'साखर 2kg, गहू 5kg', 'amount': '₹270', 'date': '1 आठवड्यापूर्वी'},
    {'items': 'डाळ 1kg', 'amount': '₹120', 'date': '2 आठवड्यांपूर्वी'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('ग्राहक प्रोफाइल'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                  child: Text(
                    customerName.isNotEmpty ? customerName[0] : '?',
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                  ),
                ),
                const SizedBox(height: 12),
                Text(customerName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    children: [
                      const Icon(Icons.currency_rupee, color: Colors.green, size: 22),
                      const SizedBox(height: 6),
                      Text(totalPurchase, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      const Text('एकूण खरेदी', style: TextStyle(fontSize: 11, color: AppColors.textLight)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    children: [
                      const Icon(Icons.storefront_outlined, color: AppColors.primaryBlue, size: 22),
                      const SizedBox(height: 6),
                      Text(visits, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      const Text('भेटी', style: TextStyle(fontSize: 11, color: AppColors.textLight)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('अलीकडील खरेदी', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 10),
          ..._recentPurchases.map((p) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['items']!, style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                          const SizedBox(height: 3),
                          Text(p['date']!, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                        ],
                      ),
                    ),
                    Text(p['amount']!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.successGreen)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
