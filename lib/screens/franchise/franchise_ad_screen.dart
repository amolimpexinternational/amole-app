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

  void _editAd(int index) {
    final ad = _ads[index];
    final titleCtrl = TextEditingController(text: ad['title']);
    final budgetCtrl = TextEditingController(text: ad['budget']);
    final daysCtrl = TextEditingController(text: ad['days']);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text('जाहिरात Edit करा'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'शीर्षक')),
            const SizedBox(height: 10),
            TextField(controller: budgetCtrl, decoration: const InputDecoration(labelText: 'Budget')),
            const SizedBox(height: 10),
            TextField(controller: daysCtrl, decoration: const InputDecoration(labelText: 'कालावधी')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('रद्द करा')),
          ElevatedButton(
            onPressed: () {
              // TODO (Stage 3 - Backend): persist edited ad to Firestore.
              setState(() {
                _ads[index]['title'] = titleCtrl.text;
                _ads[index]['budget'] = budgetCtrl.text;
                _ads[index]['days'] = daysCtrl.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✅ जाहिरात अद्ययावत झाली')),
              );
            },
            child: const Text('जतन करा'),
          ),
        ],
      ),
    );
  }

  void _deleteAd(int index) {
    setState(() => _ads.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Ad Approvals', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: _ads.isEmpty
          ? const Center(child: Text('कोणतीही जाहिरात नाही'))
          : ListView.builder(
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
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: _statusColor(ad['status']).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                                child: Text(ad['status'], style: TextStyle(color: _statusColor(ad['status']), fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, size: 18, color: AppColors.textLight),
                                tooltip: 'Edit',
                                onPressed: () => _editAd(index),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                                tooltip: 'Delete',
                                onPressed: () => _deleteAd(index),
                              ),
                            ],
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
