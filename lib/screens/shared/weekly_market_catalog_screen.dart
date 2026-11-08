import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/app_colors.dart';

class WeeklyMarketCatalogScreen extends StatefulWidget {
  const WeeklyMarketCatalogScreen({super.key});

  @override
  State<WeeklyMarketCatalogScreen> createState() => _WeeklyMarketCatalogScreenState();
}

class _WeeklyMarketCatalogScreenState extends State<WeeklyMarketCatalogScreen> {
  // === आठवडी बाजार कॅटलॉग — max 5 प्रॉडक्ट ===
  final List<Map<String, dynamic>> _catalogItems = [];
  bool _isCatalogOn = false;

  Future<void> _addProduct() async {
    if (_catalogItems.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कमाल ५ प्रॉडक्ट्सच जोडू शकता!'), backgroundColor: Colors.red),
      );
      return;
    }

    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    File? pickedImage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            top: 24, left: 24, right: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('आठवडी बाजारात प्रॉडक्ट जोडा', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (img != null) {
                      setSheetState(() => pickedImage = File(img.path));
                    }
                  },
                  child: Container(
                    height: 100, width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: pickedImage != null
                        ? ClipRRect(borderRadius: BorderRadius.circular(9), child: Image.file(pickedImage!, fit: BoxFit.cover))
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, color: AppColors.textLight),
                              Text('फोटो', style: TextStyle(fontSize: 10, color: AppColors.textLight)),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'प्रॉडक्टचे नाव', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(controller: priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'किंमत (₹)', border: OutlineInputBorder())),
              const SizedBox(height: 20),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameCtrl.text.isEmpty || priceCtrl.text.isEmpty) return;
                    Navigator.pop(ctx);
                    setState(() {
                      _catalogItems.add({
                        'id': DateTime.now().millisecondsSinceEpoch.toString(),
                        'name': nameCtrl.text,
                        'price': double.tryParse(priceCtrl.text) ?? 0,
                        'image': pickedImage,
                        'isActive': true,
                      });
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('प्रॉडक्ट जोडले!'), backgroundColor: Colors.green),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: const Text('जोडा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('आठवडी बाजार कॅटलॉग'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          // ON/OFF
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                Text(_isCatalogOn ? 'ON' : 'OFF', style: const TextStyle(color: Colors.white, fontSize: 12)),
                Switch(
                  value: _isCatalogOn,
                  onChanged: (v) => setState(() => _isCatalogOn = v),
                  activeThumbColor: Colors.greenAccent,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _catalogItems.length >= 5
          ? null
          : FloatingActionButton.extended(
              onPressed: _addProduct,
              backgroundColor: Colors.teal,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('प्रॉडक्ट जोडा', style: TextStyle(color: Colors.white)),
            ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.teal.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('एकूण प्रॉडक्ट्स', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${_catalogItems.length} / 5', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal.shade700)),
              ],
            ),
          ),
          // ON/OFF ची माहिती
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _isCatalogOn ? Colors.green.shade50 : Colors.orange.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _isCatalogOn ? Colors.green.shade300 : Colors.orange.shade300),
            ),
            child: Row(
              children: [
                Icon(
                  _isCatalogOn ? Icons.check_circle : Icons.info_outline,
                  color: _isCatalogOn ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _isCatalogOn
                        ? 'कॅटलॉग ON — आठवडी बाजार भरल्यावर हा कॅटलॉग सार्वजनिक होईल.'
                        : 'कॅटलॉग OFF — आठवडी बाजारात सहभागी होण्यासाठी ON करा.',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _catalogItems.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Text(
                        'कॅटलॉग रिकामा आहे.\n\n"प्रॉडक्ट जोडा" वर क्लिक करून आठवडी बाजारासाठी प्रॉडक्ट्स जोडा.',
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
                          border: Border.all(color: Colors.teal.shade200),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60, height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: item['image'] != null
                                  ? ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.file(item['image'], fit: BoxFit.cover))
                                  : const Icon(Icons.image_not_supported, color: AppColors.textLight),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                  Text('₹${(item['price'] as double).toStringAsFixed(0)}', style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                                ],
                              ),
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