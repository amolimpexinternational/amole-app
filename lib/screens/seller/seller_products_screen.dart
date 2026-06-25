import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerProductsScreen extends StatefulWidget {
  const SellerProductsScreen({super.key});

  @override
  State<SellerProductsScreen> createState() => _SellerProductsScreenState();
}

class _SellerProductsScreenState extends State<SellerProductsScreen> {
  final List<Map<String, dynamic>> _products = [
    {'name': 'तांदूळ 5kg', 'price': '₹250', 'stock': '45 kg', 'status': 'active'},
    {'name': 'गहू 5kg', 'price': '₹180', 'stock': '30 kg', 'status': 'active'},
    {'name': 'तेल 1L', 'price': '₹140', 'stock': '20 bottles', 'status': 'active'},
    {'name': 'साखर 1kg', 'price': '₹45', 'stock': '0', 'status': 'outofstock'},
    {'name': 'डाळ 1kg', 'price': '₹120', 'stock': '15 kg', 'status': 'active'},
  ];

  void _showAddProductDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(context).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('नवीन Product टाका', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 16),
            Container(
              height: 100,
              decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3))),
              child: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.add_photo_alternate_outlined, color: AppColors.primaryBlue, size: 32),
                SizedBox(height: 6),
                Text('फोटो जोडा', style: TextStyle(color: AppColors.primaryBlue, fontSize: 13)),
              ])),
            ),
            const SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Product नाव', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'किंमत (₹)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))))),
              const SizedBox(width: 10),
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'Stock', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))))),
            ]),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Product जोडा'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('माझे Products', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddProductDialog,
        backgroundColor: AppColors.primaryBlue,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Product टाका', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final p = _products[index];
          final isOutOfStock = p['status'] == 'outofstock';
          return Container(
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
                  width: 56, height: 56,
                  decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.inventory_2_outlined, color: AppColors.primaryBlue, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                      const SizedBox(height: 3),
                      Text('Stock: ${p['stock']}', style: TextStyle(fontSize: 13, color: isOutOfStock ? Colors.red : AppColors.textLight)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(p['price'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.primaryBlue)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isOutOfStock ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(isOutOfStock ? 'संपले' : 'उपलब्ध', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isOutOfStock ? Colors.red : Colors.green)),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                IconButton(icon: const Icon(Icons.edit_outlined, color: AppColors.textLight), onPressed: () {}),
              ],
            ),
          );
        },
      ),
    );
  }
}
