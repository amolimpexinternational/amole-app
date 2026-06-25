import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FranchiseAdScreen extends StatefulWidget {
  const FranchiseAdScreen({super.key});

  @override
  State<FranchiseAdScreen> createState() => _FranchiseAdScreenState();
}

class _FranchiseAdScreenState extends State<FranchiseAdScreen> {
  final List<Map<String, dynamic>> _ads = [
    {'seller': 'गणेश किराणा मार्ट', 'title': 'दिवाळी Sale — 20% सूट', 'budget': '₹500', 'days': '7 दिवस', 'status': 'प्रतीक्षेत'},
    {'seller': 'राज इलेक्ट्रॉनिक्स', 'title': 'नवीन Mobile Accessories', 'budget': '₹300', 'days': '5 दिवस', 'status': 'प्रतीक्षेत'},
    {'seller': 'श्री मेडिकल', 'title': 'Generic Medicines उपलब्ध', 'budget': '₹200', 'days': '3 दिवस', 'status': 'मंजूर'},
    {'seller': 'प्रिया फॅशन', 'title': 'नवीन Collection आले', 'budget': '₹400', 'days': '10 दिवस', 'status': 'नाकारले'},
  ];

  Color _statusColor(String s) {
    switch (s) {
      case 'प्रतीक्षेत': return Colors.orange;
      case 'मंजूर': return Colors.green;
      case 'नाकारले': return Colors.red;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Ad Approval', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _ads.length,
        itemBuilder: (context, index) {
          final ad = _ads[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(ad['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: _statusColor(ad['status']).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text(ad['status'], style: TextStyle(color: _statusColor(ad['status']), fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('🏪 ${ad['seller']}', style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
                const SizedBox(height: 4),
                Row(children: [
                  Text('💰 Budget: ${ad['budget']}', style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                  const SizedBox(width: 16),
                  Text('📅 ${ad['days']}', style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                ]),
                if (ad['status'] == 'प्रतीक्षेत') ...[
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 8)),
                        onPressed: () => setState(() => ad['status'] = 'मंजूर'),
                        child: const Text('✅ मंजूर'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red), padding: const EdgeInsets.symmetric(vertical: 8)),
                        onPressed: () => setState(() => ad['status'] = 'नाकारले'),
                        child: const Text('❌ नाकारा'),
                      ),
                    ),
                  ]),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
