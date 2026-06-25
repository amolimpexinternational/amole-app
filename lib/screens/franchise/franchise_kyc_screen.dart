import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FranchiseKycScreen extends StatefulWidget {
  const FranchiseKycScreen({super.key});

  @override
  State<FranchiseKycScreen> createState() => _FranchiseKycScreenState();
}

class _FranchiseKycScreenState extends State<FranchiseKycScreen> {
  String _selectedTab = 'प्रतीक्षेत';

  final List<Map<String, dynamic>> _sellers = [
    {'name': 'रमेश किराणा मार्ट', 'owner': 'रमेश पाटील', 'category': 'किराणा', 'phone': '9876543210', 'days': '2 दिवसांपूर्वी', 'status': 'प्रतीक्षेत'},
    {'name': 'सुनील मेडिकल', 'owner': 'सुनील कदम', 'category': 'मेडिकल', 'phone': '9765432109', 'days': '4 दिवसांपूर्वी', 'status': 'प्रतीक्षेत'},
    {'name': 'प्रिया फॅशन', 'owner': 'प्रिया देशमुख', 'category': 'कपडे', 'phone': '9654321098', 'days': '6 दिवसांपूर्वी', 'status': 'प्रतीक्षेत'},
    {'name': 'गणेश इलेक्ट्रॉनिक्स', 'owner': 'गणेश शिंदे', 'category': 'इलेक्ट्रॉनिक्स', 'phone': '9543210987', 'days': '3 दिवसांपूर्वी', 'status': 'मंजूर'},
    {'name': 'साई बेकरी', 'owner': 'साई जोशी', 'category': 'खाद्यपदार्थ', 'phone': '9432109876', 'days': '5 दिवसांपूर्वी', 'status': 'नाकारले'},
  ];

  List<Map<String, dynamic>> get _filtered =>
      _sellers.where((s) => s['status'] == _selectedTab).toList();

  Color _statusColor(String status) {
    switch (status) {
      case 'प्रतीक्षेत': return Colors.orange;
      case 'मंजूर': return Colors.green;
      case 'नाकारले': return Colors.red;
      default: return Colors.grey;
    }
  }

  void _showKycDetail(Map<String, dynamic> seller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(seller['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 16),
            _infoRow(Icons.person_outlined, 'मालक: ${seller['owner']}'),
            _infoRow(Icons.category_outlined, 'श्रेणी: ${seller['category']}'),
            _infoRow(Icons.phone_outlined, 'फोन: ${seller['phone']}'),
            _infoRow(Icons.access_time_outlined, 'अर्ज: ${seller['days']}'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(10)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [Icon(Icons.badge_outlined, color: AppColors.primaryBlue), SizedBox(height: 4), Text('Aadhar', style: TextStyle(fontSize: 12))]),
                  Column(children: [Icon(Icons.store_outlined, color: AppColors.primaryBlue), SizedBox(height: 4), Text('Shop Photo', style: TextStyle(fontSize: 12))]),
                  Column(children: [Icon(Icons.description_outlined, color: AppColors.primaryBlue), SizedBox(height: 4), Text('GST', style: TextStyle(fontSize: 12))]),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (seller['status'] == 'प्रतीक्षेत') Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      setState(() => seller['status'] = 'मंजूर');
                      Navigator.pop(context);
                    },
                    child: const Text('✅ मंजूर करा'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
                    onPressed: () {
                      setState(() => seller['status'] = 'नाकारले');
                      Navigator.pop(context);
                    },
                    child: const Text('❌ नाकारा'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Icon(icon, size: 18, color: AppColors.textLight),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontSize: 14, color: AppColors.textDark)),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['प्रतीक्षेत', 'मंजूर', 'नाकारले'];
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Seller KYC', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: tabs.map((tab) {
                final isSelected = _selectedTab == tab;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = tab),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? _statusColor(tab).withOpacity(0.1) : Colors.transparent,
                        border: Border.all(color: isSelected ? _statusColor(tab) : AppColors.lightGrey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(tab, textAlign: TextAlign.center, style: TextStyle(color: isSelected ? _statusColor(tab) : AppColors.textLight, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(child: Text('कोणतेही अर्ज नाहीत', style: TextStyle(color: AppColors.textLight)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      final s = _filtered[index];
                      return GestureDetector(
                        onTap: () => _showKycDetail(s),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48, height: 48,
                                decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                                child: const Icon(Icons.storefront_outlined, color: AppColors.primaryBlue),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(s['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                                    Text('${s['category']} • ${s['days']}', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(color: _statusColor(s['status']).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                child: Text(s['status'], style: TextStyle(color: _statusColor(s['status']), fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
