import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/product_database.dart';
import '../../models/product_model.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';
import 'stock_management_screen.dart';

class SellerProductsScreen extends StatefulWidget {
  const SellerProductsScreen({super.key});
  @override
  State<SellerProductsScreen> createState() => _SellerProductsScreenState();
}

class _SellerProductsScreenState extends State<SellerProductsScreen> {
  String _search = '';
  String _filter = 'सर्व'; // सर्व / Active / Inactive / संपले

  List<ProductModel> get _filtered {
    return ProductDatabase.products.where((p) {
      final matchSearch = _search.isEmpty ||
          p.name.toLowerCase().contains(_search.toLowerCase()) ||
          p.keywords.toLowerCase().contains(_search.toLowerCase());
      final matchFilter = _filter == 'सर्व' ||
          (_filter == 'Active' && p.isActive) ||
          (_filter == 'Inactive' && !p.isActive) ||
          (_filter == 'संपले' && p.stock <= 0);
      return matchSearch && matchFilter;
    }).toList();
  }

  void _toggleActive(ProductModel p) {
    setState(() => p.isActive = !p.isActive);
  }

  void _deleteProduct(ProductModel p) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Product Delete करायचा?'),
        content: Text('${p.name} delete होईल.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              setState(() => ProductDatabase.deleteProduct(p.id));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${p.name} delete झाला'), backgroundColor: Colors.red),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = _filtered;
    final activeCount = ProductDatabase.products.where((p) => p.isActive).length;
    final totalCount = ProductDatabase.products.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('माझे Products', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.inventory_outlined, color: Colors.white),
            tooltip: 'Stock Management',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StockManagementScreen())),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddProductScreen()));
          setState(() {});
        },
        backgroundColor: AppColors.primaryBlue,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Product टाका', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // Stats bar
          Container(
            color: AppColors.primaryBlue,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(children: [
              _statChip(Icons.inventory_2_outlined, '$totalCount एकूण', Colors.white70),
              const SizedBox(width: 12),
              _statChip(Icons.check_circle_outline, '$activeCount Active', Colors.greenAccent),
              const SizedBox(width: 12),
              _statChip(Icons.warning_amber_outlined, '${ProductDatabase.products.where((p) => p.stock <= 0).length} संपले', Colors.orangeAccent),
            ]),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (v) => setState(() => _search = v),
              decoration: InputDecoration(
                hintText: 'Product शोधा...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primaryBlue),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),

          // Filter chips
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: ['सर्व', 'Active', 'Inactive', 'संपले'].map((f) {
                final sel = _filter == f;
                return GestureDetector(
                  onTap: () => setState(() => _filter = f),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: sel ? AppColors.primaryBlue : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: sel ? AppColors.primaryBlue : Colors.grey.shade300),
                    ),
                    child: Text(f, style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600,
                      color: sel ? Colors.white : AppColors.textDark,
                    )),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),

          // Product list
          Expanded(
            child: products.isEmpty
              ? Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey.shade300),
                    const SizedBox(height: 12),
                    Text('कोणतेही Product नाही', style: TextStyle(color: Colors.grey.shade500, fontSize: 15)),
                  ]),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 80),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final p = products[index];
                    final isOutOfStock = p.stock <= 0;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: p.isActive ? Colors.white : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: p.isActive ? Colors.transparent : Colors.grey.shade300),
                        boxShadow: p.isActive
                          ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 2))]
                          : [],
                      ),
                      child: Row(children: [
                        // Product icon/image
                        Container(
                          width: 54, height: 54,
                          decoration: BoxDecoration(
                            color: p.isActive
                              ? AppColors.primaryBlue.withValues(alpha: 0.1)
                              : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.inventory_2_outlined,
                            color: p.isActive ? AppColors.primaryBlue : Colors.grey,
                            size: 26),
                        ),
                        const SizedBox(width: 12),

                        // Name, category, stock
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(children: [
                              Expanded(
                                child: Text(p.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14,
                                    color: p.isActive ? AppColors.textDark : Colors.grey,
                                  )),
                              ),
                              if (!p.isActive)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4)),
                                  child: const Text('Inactive', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                ),
                            ]),
                            const SizedBox(height: 3),
                            Text('Stock: ${p.stock}  |  Category: ${p.category}',
                              style: TextStyle(fontSize: 12,
                                color: isOutOfStock ? Colors.red.shade400 : AppColors.textLight)),
                            const SizedBox(height: 4),
                            Row(children: [
                              Text('₹${p.sellingPrice.toStringAsFixed(0)}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primaryBlue)),
                              if (p.discount > 0) ...[
                                const SizedBox(width: 6),
                                Text('₹${p.mrp.toStringAsFixed(0)}',
                                  style: const TextStyle(fontSize: 11, decoration: TextDecoration.lineThrough, color: AppColors.textLight)),
                                const SizedBox(width: 4),
                                Text('${p.discount.toInt()}% OFF',
                                  style: const TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold)),
                              ],
                            ]),
                          ]),
                        ),

                        // Actions column
                        Column(children: [
                          // Active/Inactive toggle
                          Switch(
                            value: p.isActive,
                            onChanged: (_) => _toggleActive(p),
                            activeThumbColor: AppColors.primaryBlue,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          Row(children: [
                            // Edit
                            GestureDetector(
                              onTap: () async {
                                await Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => EditProductScreen(product: p)));
                                setState(() {});
                              },
                              child: const Icon(Icons.edit_outlined, color: AppColors.textLight, size: 20),
                            ),
                            const SizedBox(width: 10),
                            // Delete
                            GestureDetector(
                              onTap: () => _deleteProduct(p),
                              child: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                            ),
                          ]),
                        ]),
                      ]),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }

  Widget _statChip(IconData icon, String label, Color color) => Row(children: [
    Icon(icon, size: 14, color: color),
    const SizedBox(width: 4),
    Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500)),
  ]);
}
