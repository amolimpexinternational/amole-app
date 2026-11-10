import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class PromoterCatalogScreen extends StatefulWidget {
  const PromoterCatalogScreen({super.key});

  @override
  State<PromoterCatalogScreen> createState() => _PromoterCatalogScreenState();
}

class _PromoterCatalogScreenState extends State<PromoterCatalogScreen> {
  // === प्रमोटर कॅटलॉग — max 50 ===
  final List<Map<String, dynamic>> _catalogItems = [];

  // === उपलब्ध प्रॉडक्ट्स (डमी — फक्त "प्रमोशन ON") ===
  final List<Map<String, dynamic>> _availableProducts = [
    {'id': 'p1', 'name': 'हातमाग साडी', 'price': 1200, 'seller': 'श्री गणेश किराणा', 'image': null, 'isPromoterAdd': true},
    {'id': 'p2', 'name': 'बासमती तांदूळ (5 kg)', 'price': 450, 'seller': 'श्री गणेश किराणा', 'image': null, 'isPromoterAdd': true},
    {'id': 'p3', 'name': 'इलेक्ट्रिक केतली', 'price': 899, 'seller': 'राज इलेक्ट्रॉनिक्स', 'image': null, 'isPromoterAdd': true},
    {'id': 'p4', 'name': 'कॉटन कुर्ता', 'price': 599, 'seller': 'अमोल कपडे भांडार', 'image': null, 'isPromoterAdd': true},
    {'id': 'p5', 'name': 'स्टील थाळी सेट', 'price': 349, 'seller': 'स्वाद हॉटेल', 'image': null, 'isPromoterAdd': true},
  ];

  List<Map<String, dynamic>> get _filteredAvailable {
    final existingIds = _catalogItems.map((e) => e['id']).toSet();
    return _availableProducts.where((p) => !existingIds.contains(p['id'])).toList();
  }

  void _addProduct() {
    if (_catalogItems.length >= 50) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कमाल ५० प्रॉडक्ट्सच जोडू शकता!'), backgroundColor: Colors.red),
      );
      return;
    }

    final available = _filteredAvailable;
    if (available.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('जोडण्यासाठी नवीन प्रॉडक्ट्स उपलब्ध नाहीत.'), backgroundColor: Colors.orange),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (ctx, scrollController) => Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('उपलब्ध प्रॉडक्ट्स (प्रमोशन ON)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: available.length,
                itemBuilder: (context, index) {
                  final p = available[index];
                  return ListTile(
                    leading: Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.shopping_bag_outlined, color: AppColors.textLight),
                    ),
                    title: Text(p['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('${p['seller']} · ₹${p['price']}'),
                    trailing: const Icon(Icons.add_circle, color: Colors.purple),
                    onTap: () {
                      Navigator.pop(ctx);
                      setState(() {
                        _catalogItems.add(Map<String, dynamic>.from(p));
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${p['name']} कॅटलॉगमध्ये जोडलं!'), backgroundColor: Colors.green),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareProduct(Map<String, dynamic> item) {
    final link = 'https://amole.in/promoter/AMOLE-P123/${item['id']}';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('प्रॉडक्ट शेअर करा'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${item['name']} — ₹${item['price']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('ही लिंक WhatsApp, Instagram वर शेअर करा:', style: TextStyle(fontSize: 13)),
            const SizedBox(height: 8),
            SelectableText(link, style: const TextStyle(color: Colors.blue, fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('बंद करा')),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('लिंक कॉपी झाली! WhatsApp/Instagram वर शेअर करा.'), backgroundColor: Colors.green),
              );
            },
            icon: const Icon(Icons.share, size: 16),
            label: const Text('शेअर करा'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('माझा प्रमोटर कॅटलॉग'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: _catalogItems.length >= 50
          ? null
          : FloatingActionButton.extended(
              onPressed: _addProduct,
              backgroundColor: Colors.purple,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('प्रॉडक्ट जोडा', style: TextStyle(color: Colors.white)),
            ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.purple.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('एकूण प्रॉडक्ट्स', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${_catalogItems.length} / 50', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple.shade700)),
              ],
            ),
          ),
          Expanded(
            child: _catalogItems.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Text(
                        'कॅटलॉग रिकामा आहे.\n\n"प्रॉडक्ट जोडा" वर क्लिक करून सेलरची "प्रमोशन ON" प्रॉडक्ट्स जोडा.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.textLight),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _catalogItems.length,
                    itemBuilder: (context, index) {
                      final item = _catalogItems[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.purple.shade200),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60, height: 60,
                              decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(8)),
                              child: const Icon(Icons.shopping_bag_outlined, color: AppColors.textLight),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                  Text('₹${item['price']}', style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
                                  Text('सेलर: ${item['seller']}', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.share, color: Colors.purple),
                              onPressed: () => _shareProduct(item),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () {
                                setState(() => _catalogItems.removeAt(index));
                              },
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
}