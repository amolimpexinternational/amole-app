import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerOrdersScreen extends StatefulWidget {
  const SellerOrdersScreen({super.key});

  @override
  State<SellerOrdersScreen> createState() => _SellerOrdersScreenState();
}

class _SellerOrdersScreenState extends State<SellerOrdersScreen> {
  String _selectedTab = 'नवीन';

  final List<Map<String, dynamic>> _orders = [
    {'id': 'AM-ORD-001', 'buyer': 'अनिल जोशी', 'items': 'तांदूळ 5kg, तेल 1L', 'amount': '₹390', 'time': '10 मिनिटांपूर्वी', 'status': 'नवीन'},
    {'id': 'AM-ORD-002', 'buyer': 'संगीता राणे', 'items': 'साखर 2kg, गहू 5kg', 'amount': '₹270', 'time': '25 मिनिटांपूर्वी', 'status': 'नवीन'},
    {'id': 'AM-ORD-003', 'buyer': 'रमेश पाटील', 'items': 'डाळ 1kg', 'amount': '₹120', 'time': '1 तासापूर्वी', 'status': 'स्वीकारले'},
    {'id': 'AM-ORD-004', 'buyer': 'प्रिया देशमुख', 'items': 'तांदूळ 10kg', 'amount': '₹500', 'time': '2 तासांपूर्वी', 'status': 'तयार'},
    {'id': 'AM-ORD-005', 'buyer': 'सुनील कदम', 'items': 'तेल 2L, साखर 1kg', 'amount': '₹325', 'time': 'काल', 'status': 'पूर्ण'},
    {'id': 'AM-ORD-006', 'buyer': 'मीना शिंदे', 'items': 'गहू 10kg', 'amount': '₹360', 'time': 'काल', 'status': 'रद्द'},
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'नवीन': return Colors.red;
      case 'स्वीकारले': return Colors.orange;
      case 'तयार': return Colors.blue;
      case 'पूर्ण': return Colors.green;
      case 'रद्द': return Colors.grey;
      default: return Colors.grey;
    }
  }

  List<Map<String, dynamic>> get _filteredOrders {
    if (_selectedTab == 'सर्व') return _orders;
    return _orders.where((o) => o['status'] == _selectedTab).toList();
  }

  void _showOrderDetail(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order['id'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: _statusColor(order['status']).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text(order['status'], style: TextStyle(color: _statusColor(order['status']), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('ग्राहक: ${order['buyer']}', style: const TextStyle(fontSize: 15, color: AppColors.textDark)),
            const SizedBox(height: 6),
            Text('वस्तू: ${order['items']}', style: const TextStyle(fontSize: 14, color: AppColors.textLight)),
            const SizedBox(height: 6),
            Text('रक्कम: ${order['amount']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
            const SizedBox(height: 20),
            if (order['status'] == 'नवीन') Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      setState(() => order['status'] = 'स्वीकारले');
                      Navigator.pop(context);
                    },
                    child: const Text('✅ स्वीकार करा'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
                    onPressed: () {
                      setState(() => order['status'] = 'रद्द');
                      Navigator.pop(context);
                    },
                    child: const Text('❌ नकार द्या'),
                  ),
                ),
              ],
            ),
            if (order['status'] == 'स्वीकारले') SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  setState(() => order['status'] = 'तयार');
                  Navigator.pop(context);
                },
                child: const Text('📦 तयार आहे'),
              ),
            ),
            if (order['status'] == 'तयार') SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  setState(() => order['status'] = 'पूर्ण');
                  Navigator.pop(context);
                },
                child: const Text('✅ पूर्ण झाले'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['सर्व', 'नवीन', 'स्वीकारले', 'तयार', 'पूर्ण', 'रद्द'];
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('ऑर्डर्स', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
            child: const Text('2 नवीन', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: tabs.map((tab) {
                  final isSelected = _selectedTab == tab;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTab = tab),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryBlue : Colors.transparent,
                        border: Border.all(color: isSelected ? AppColors.primaryBlue : AppColors.lightGrey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(tab, style: TextStyle(color: isSelected ? Colors.white : AppColors.textLight, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // Orders List
          Expanded(
            child: _filteredOrders.isEmpty
                ? const Center(child: Text('कोणत्याही ऑर्डर्स नाहीत', style: TextStyle(color: AppColors.textLight)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = _filteredOrders[index];
                      return GestureDetector(
                        onTap: () => _showOrderDetail(order),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
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
                                  Text(order['id'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(color: _statusColor(order['status']).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                                    child: Text(order['status'], style: TextStyle(color: _statusColor(order['status']), fontSize: 12, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text('👤 ${order['buyer']}', style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                              const SizedBox(height: 3),
                              Text('🛒 ${order['items']}', style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(order['amount'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                                  Text(order['time'], style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                                ],
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
