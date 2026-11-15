import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/buyer_order_history_data.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  Widget buildStep(String title, String subtitle, bool completed) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: completed ? AppColors.successGreen : AppColors.lightGrey,
        child: Icon(completed ? Icons.check : Icons.access_time, color: completed ? AppColors.white : AppColors.textLight),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildModuleOrderCard({required String module, required String orderId, required String status, required IconData icon, required Color color, required List<String> items, required double total}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 8),
                Expanded(child: Text(module, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: color))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
                  child: Text(status, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text('ऑर्डर ID: $orderId', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
            const SizedBox(height: 8),
            ...items.map((i) => Text('• $i', style: const TextStyle(fontSize: 12))),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('एकूण:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('₹${total.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmCancel(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('ऑर्डर रद्द करायची आहे का?'),
        content: const Text('रद्द केल्यास कदाचित काही दंड लागू शकतो.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('नको')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.errorRed),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ऑर्डर रद्द करण्याची विनंती पाठवली'), backgroundColor: Colors.red));
            },
            child: const Text('हो, रद्द करा', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('ऑर्डर ट्रॅकिंग'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('एकूण ऑर्डर्स', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('3 (Demo)'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  // === 3 separate orders (demo — cart split नंतर) ===
                  _buildModuleOrderCard(
                    module: '📦 Global Shopping',
                    orderId: '#GS-001',
                    status: 'पाठवली (Shipped)',
                    icon: Icons.shopping_bag,
                    color: Colors.blue,
                    items: ['Samsung Galaxy A55 × 1'],
                    total: 32999,
                  ),
                  _buildModuleOrderCard(
                    module: '⚡ ZatPat',
                    orderId: '#ZP-002',
                    status: 'Delivery Boy निघाला',
                    icon: Icons.bolt,
                    color: Colors.orange,
                    items: ['तांदूळ 5kg × 2', 'साखर 1kg × 1'],
                    total: 545,
                  ),
                  _buildModuleOrderCard(
                    module: '🍽️ Hotel Food',
                    orderId: '#HF-003',
                    status: 'पोहोचलं ✓',
                    icon: Icons.restaurant,
                    color: Colors.deepOrange,
                    items: ['मिसळ पाव × 2'],
                    total: 160,
                  ),
                  const SizedBox(height: 20),
                  const Text('मागील ऑर्डर्स', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  ...BuyerOrderHistoryData.orders.map(
                    (order) => Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('#${order['id']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text(order['status'], style: TextStyle(fontWeight: FontWeight.bold, color: order['status'] == 'पूर्ण' ? AppColors.successGreen : AppColors.errorRed)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text('दिनांक: ${order['date']}'),
                            Text('Seller: ${order['seller']}'),
                            Text('Products: ${order['items']}'),
                            Text('एकूण: ${order['total']}'),
                            Text('Payment: ${order['payment']}'),
                            Text('Delivery: ${order['delivery']}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _confirmCancel(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.errorRed),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('ऑर्डर रद्द करा', style: TextStyle(color: AppColors.errorRed)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}