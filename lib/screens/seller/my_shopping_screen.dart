import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class MyShoppingScreen extends StatefulWidget {
  const MyShoppingScreen({super.key});

  @override
  State<MyShoppingScreen> createState() => _MyShoppingScreenState();
}

class _MyShoppingScreenState extends State<MyShoppingScreen> {
  int _selectedTab = 0;
  String _selectedCategory = 'सर्व';
  final _searchController = TextEditingController();

  final List<String> _categories = [
    'सर्व', 'किराणा', 'इलेक्ट्रॉनिक्स', 'कपडे', 'खाद्यपदार्थ', 'घर', 'इतर'
  ];

  final List<Map<String, dynamic>> _products = [
    {'name': 'तांदूळ 50kg (Wholesale)', 'seller': 'महाराष्ट्र अॅग्रो', 'price': 2200, 'mrp': 2500, 'discount': 12, 'category': 'किराणा', 'rating': 4.5, 'inStock': true},
    {'name': 'साखर 100kg (Bulk)', 'seller': 'पुणे शुगर मिल', 'price': 3800, 'mrp': 4200, 'discount': 10, 'category': 'किराणा', 'rating': 4.2, 'inStock': true},
    {'name': 'तेल 15L (Wholesale)', 'seller': 'गोल्डन ऑईल', 'price': 1800, 'mrp': 2000, 'discount': 10, 'category': 'किराणा', 'rating': 4.7, 'inStock': true},
    {'name': 'LED TV 43 inch', 'seller': 'राज इलेक्ट्रॉनिक्स', 'price': 18999, 'mrp': 25000, 'discount': 24, 'category': 'इलेक्ट्रॉनिक्स', 'rating': 4.3, 'inStock': true},
    {'name': 'Cotton Fabric 50m', 'seller': 'पुणे टेक्सटाईल', 'price': 4500, 'mrp': 5500, 'discount': 18, 'category': 'कपडे', 'rating': 4.0, 'inStock': false},
    {'name': 'पापड 10kg (Wholesale)', 'seller': 'श्री फूड्स', 'price': 850, 'mrp': 1000, 'discount': 15, 'category': 'खाद्यपदार्थ', 'rating': 4.6, 'inStock': true},
  ];

  final List<Map<String, dynamic>> _myOrders = [
    {'id': 'B2B-001', 'product': 'तांदूळ 50kg', 'seller': 'महाराष्ट्र अॅग्रो', 'amount': 2200, 'status': 'Delivered', 'date': '20 Aug 2026'},
    {'id': 'B2B-002', 'product': 'साखर 100kg', 'seller': 'पुणे शुगर मिल', 'amount': 3800, 'status': 'Processing', 'date': '24 Aug 2026'},
    {'id': 'B2B-003', 'product': 'तेल 15L', 'seller': 'गोल्डन ऑईल', 'amount': 1800, 'status': 'Pending', 'date': '25 Aug 2026'},
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    return _products.where((p) {
      final matchCategory = _selectedCategory == 'सर्व' || p['category'] == _selectedCategory;
      final matchSearch = _searchController.text.isEmpty ||
          p['name'].toString().toLowerCase().contains(_searchController.text.toLowerCase()) ||
          p['seller'].toString().toLowerCase().contains(_searchController.text.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Delivered': return Colors.green;
      case 'Processing': return Colors.blue;
      case 'Pending': return Colors.orange;
      default: return Colors.grey;
    }
  }

  void _addToCart(Map<String, dynamic> product) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('विक्रेता: ${product['seller']}', style: const TextStyle(color: AppColors.textLight)),
            const SizedBox(height: 8),
            Row(children: [
              Text('₹${product['price']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
              const SizedBox(width: 8),
              Text('₹${product['mrp']}', style: const TextStyle(fontSize: 14, color: AppColors.textLight, decoration: TextDecoration.lineThrough)),
              const SizedBox(width: 8),
              Text('${product['discount']}% off', style: const TextStyle(fontSize: 13, color: AppColors.successGreen, fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
              child: const Text('✅ B2B खरेदी — तुम्हाला पण 2% Reward Points मिळतील!', style: TextStyle(fontSize: 12, color: AppColors.primaryBlue)),
            ),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('रद्द करा'),
              )),
              const SizedBox(width: 12),
              Expanded(child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product["name"]} Order केला!'), backgroundColor: Colors.green),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
                child: const Text('Order करा', style: TextStyle(color: Colors.white)),
              )),
            ]),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('My Shopping (B2B)'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(46),
          child: Container(
            color: AppColors.primaryBlue,
            child: Row(children: [
              Expanded(child: GestureDetector(
                onTap: () => setState(() => _selectedTab = 0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _selectedTab == 0 ? AppColors.cyan : Colors.transparent, width: 3))),
                  child: Text('Products', textAlign: TextAlign.center, style: TextStyle(color: _selectedTab == 0 ? Colors.white : Colors.white60, fontWeight: _selectedTab == 0 ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
                ),
              )),
              Expanded(child: GestureDetector(
                onTap: () => setState(() => _selectedTab = 1),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _selectedTab == 1 ? AppColors.cyan : Colors.transparent, width: 3))),
                  child: Text('माझे Orders', textAlign: TextAlign.center, style: TextStyle(color: _selectedTab == 1 ? Colors.white : Colors.white60, fontWeight: _selectedTab == 1 ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
                ),
              )),
            ]),
          ),
        ),
      ),
      body: _selectedTab == 0 ? _buildProducts() : _buildMyOrders(),
    );
  }

  Widget _buildProducts() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Product किंवा Seller शोधा...',
              prefixIcon: const Icon(Icons.search, color: AppColors.textLight),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final cat = _categories[index];
              final isSelected = _selectedCategory == cat;
              return GestureDetector(
                onTap: () => setState(() => _selectedCategory = cat),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryBlue : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isSelected ? AppColors.primaryBlue : AppColors.lightGrey),
                  ),
                  child: Text(cat, style: TextStyle(color: isSelected ? Colors.white : AppColors.textDark, fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _filteredProducts.length,
            itemBuilder: (context, index) {
              final p = _filteredProducts[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.inventory_2_outlined, color: AppColors.primaryBlue, size: 28),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textDark)),
                          Text(p['seller'], style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                          const SizedBox(height: 4),
                          Row(children: [
                            Text('₹${p['price']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primaryBlue)),
                            const SizedBox(width: 6),
                            Text('${p['discount']}% off', style: const TextStyle(fontSize: 11, color: AppColors.successGreen, fontWeight: FontWeight.w600)),
                          ]),
                          if (!p['inStock'])
                            const Text('Stock नाही', style: TextStyle(fontSize: 11, color: AppColors.errorRed)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: p['inStock'] ? () => _addToCart(p) : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        minimumSize: Size.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Order', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMyOrders() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _myOrders.length,
      itemBuilder: (context, index) {
        final o = _myOrders[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(o['id'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textDark)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: _statusColor(o['status']).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                    child: Text(o['status'], style: TextStyle(fontSize: 11, color: _statusColor(o['status']), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(o['product'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              Text('विक्रेता: ${o['seller']}', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('₹${o['amount']}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                  Text(o['date'], style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
