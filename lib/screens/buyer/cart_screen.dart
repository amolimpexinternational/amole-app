import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'order_tracking_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> _items = [
    {'name': 'तांदूळ 5kg', 'price': 250.0, 'qty': 2},
    {'name': 'ताज्या टोमॅटो', 'price': 30.0, 'qty': 5},
    {'name': 'नैसर्गिक मध', 'price': 450.0, 'qty': 1},
  ];

  bool _usePoints = false;
  final int _availablePoints = 245;

  double get _subtotal => _items.fold(0.0, (sum, item) => sum + (item['price'] as double) * (item['qty'] as int));
  int get _pointsToUse => _usePoints ? (_availablePoints > _subtotal ? _subtotal.round() : _availablePoints) : 0;
  double get _total => (_subtotal - _pointsToUse).clamp(0, double.infinity);

  void _removeItem(int index) {
    setState(() => _items.removeAt(index));
  }

  void _changeQty(int index, int delta) {
    setState(() {
      final newQty = (_items[index]['qty'] as int) + delta;
      if (newQty >= 1) _items[index]['qty'] = newQty;
    });
  }

  Widget _buildCartItem(int index) {
    final item = _items[index];
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 26,
          child: Icon(Icons.shopping_bag_outlined),
        ),
        title: Text(
          item['name'] as String,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 18,
              onPressed: () => _changeQty(index, -1),
              icon: const Icon(Icons.remove_circle_outline),
            ),
            const SizedBox(width: 6),
            Text('${item['qty']}'),
            const SizedBox(width: 6),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 18,
              onPressed: () => _changeQty(index, 1),
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '₹${((item['price'] as double) * (item['qty'] as int)).toStringAsFixed(0)}',
              style: const TextStyle(
                color: AppColors.successGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () => _removeItem(index),
              child: const Icon(Icons.delete_outline, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('माझी Cart'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: _items.isEmpty
                  ? const Center(child: Text('तुमची कार्ट रिकामी आहे', style: TextStyle(color: AppColors.textLight)))
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) => _buildCartItem(index),
                    ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: AppColors.primaryOrange.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: AppColors.primaryOrange, size: 20),
                        const SizedBox(width: 8),
                        Expanded(child: Text('Loyalty Points वापरा ($_availablePoints उपलब्ध)', style: const TextStyle(fontSize: 13, color: AppColors.textDark))),
                        Switch(
                          value: _usePoints,
                          onChanged: _items.isEmpty ? null : (val) => setState(() => _usePoints = val),
                          activeColor: AppColors.primaryOrange,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('एकूण रक्कम', style: TextStyle(fontSize: 14, color: AppColors.textLight)),
                      Text('₹${_subtotal.toStringAsFixed(0)}', style: const TextStyle(fontSize: 14, color: AppColors.textDark)),
                    ],
                  ),
                  if (_usePoints) ...[
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Points सवलत', style: TextStyle(fontSize: 14, color: AppColors.textLight)),
                        Text('-₹$_pointsToUse', style: const TextStyle(fontSize: 14, color: AppColors.successGreen)),
                      ],
                    ),
                  ],
                  const Divider(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'द्यायची रक्कम',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '₹${_total.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.successGreen),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _items.isEmpty ? null : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Checkout करा',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
