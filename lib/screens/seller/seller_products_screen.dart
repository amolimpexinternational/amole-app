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
  String _filter = 'सर्व';

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

  void _togglePromoterAdd(ProductModel p) {
    setState(() => p.isPromoterAdd = !p.isPromoterAdd);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(p.isPromoterAdd 
          ? '${p.name} - प्रमोटर जोड सुरू (५% कमिशन)' 
          : '${p.name} - प्रमोटर जोड बंद'),
        backgroundColor: p.isPromoterAdd ? Colors.purple : Colors.grey,
      ),
    );
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
                    
                    // किंमत गणित
                    final double sellPrice = p.sellingPrice;
                    final double companyComm = sellPrice * 0.10;
                    final double promoterComm = p.isPromoterAdd ? (sellPrice * 0.05) : 0.0;
                    final double netIncome = sellPrice - companyComm - promoterComm;

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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Row: Image & Details & Actions
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Image Icon
                              Container(
                                width: 50, height: 50,
                                decoration: BoxDecoration(
                                  color: p.isActive ? AppColors.primaryBlue.withValues(alpha: 0.1) : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.inventory_2_outlined, color: p.isActive ? AppColors.primaryBlue : Colors.grey, size: 24),
                              ),
                              const SizedBox(width: 12),

                              // Name & Stock
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(p.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: p.isActive ? AppColors.textDark : Colors.grey)),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text('Stock: ${p.stock}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isOutOfStock ? Colors.red : AppColors.textDark)),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(4)),
                                          child: Text(p.category, style: const TextStyle(fontSize: 10, color: AppColors.textLight)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Actions (Switch, Edit, Delete)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // Active/Inactive टॉगल
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Active', style: TextStyle(fontSize: 10, color: AppColors.textLight)),
                                      Switch(
                                        value: p.isActive,
                                        onChanged: (_) => _toggleActive(p),
                                        activeThumbColor: AppColors.primaryBlue,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ],
                                  ),
                                  // प्रमोटर जोड टॉगल (नवीन)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('प्रमोटर', style: TextStyle(fontSize: 10, color: Colors.purple)),
                                      Switch(
                                        value: p.isPromoterAdd,
                                        onChanged: (_) => _togglePromoterAdd(p),
                                        activeThumbColor: Colors.purple,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          const Divider(height: 20),

                          // Bottom Section: Pricing & Math
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Customer Price
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('ग्राहक किंमत', style: TextStyle(fontSize: 10, color: AppColors.textLight)),
                                  Text('₹${sellPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                                ],
                              ),
                              
                              // Promoter Commission
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('प्रमोटर कमिशन', style: TextStyle(fontSize: 10, color: AppColors.textLight)),
                                  Text(
                                    p.isPromoterAdd ? '₹${promoterComm.toStringAsFixed(0)} (५%)' : 'बंद आहे',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: p.isPromoterAdd ? Colors.purple : AppColors.textLight),
                                  ),
                                ],
                              ),

                              // Net Income
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text('तुम्हाला मिळणारे', style: TextStyle(fontSize: 10, color: AppColors.textLight)),
                                  Text('₹${netIncome.toStringAsFixed(0)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.successGreen)),
                                ],
                              ),
                            ],
                          ),
                          
                          // Edit & Delete Buttons
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton.icon(
                                onPressed: () async {
                                  await Navigator.push(context, MaterialPageRoute(builder: (_) => EditProductScreen(product: p)));
                                  setState(() {});
                                },
                                icon: const Icon(Icons.edit_outlined, size: 16),
                                label: const Text('Edit', style: TextStyle(fontSize: 12)),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                  side: const BorderSide(color: Colors.blue),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  minimumSize: Size.zero,
                                ),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton.icon(
                                onPressed: () => _deleteProduct(p),
                                icon: const Icon(Icons.delete_outline, size: 16),
                                label: const Text('Delete', style: TextStyle(fontSize: 12)),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  side: const BorderSide(color: Colors.red),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  minimumSize: Size.zero,
                                ),
                              ),
                            ],
                          ),
                          
                          // Promoter ON tag
                          if (p.isPromoterAdd)
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.purple.shade200)),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.campaign, color: Colors.purple, size: 14),
                                  SizedBox(width: 4),
                                  Text('प्रमोटर जोड सुरू आहे (Promoter ON)', style: TextStyle(fontSize: 10, color: Colors.purple, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                        ],
                      ),
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
