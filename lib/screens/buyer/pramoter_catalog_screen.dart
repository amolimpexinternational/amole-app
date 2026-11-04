import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/app_colors.dart';

class PromoterCatalogScreen extends StatefulWidget {
  const PromoterCatalogScreen({super.key});

  @override
  State<PromoterCatalogScreen> createState() => _PromoterCatalogScreenState();
}

class _PromoterCatalogScreenState extends State<PromoterCatalogScreen> {
  // डेमो प्रॉडक्ट्स
  final List<Map<String, dynamic>> _catalogItems = [
    {
      'id': '1',
      'name': 'हातमाग साडी',
      'price': 1200,
      'image': null,
      'isActive': true,
      'expiry': '30 दिवस शिल्लक',
    }
  ];

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
              const Text('नवीन प्रॉडक्ट जोडा (₹50 फी)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              
              // फोटो अपलोड
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
                        'expiry': '30 दिवस शिल्लक',
                      });
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('प्रॉडक्ट जोडले! ₹50 फी कापली गेली.'), backgroundColor: Colors.green),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: const Text('जोडा आणि ₹50 भरा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addProduct,
        backgroundColor: Colors.teal,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('प्रॉडक्ट जोडा', style: TextStyle(color: Colors.white)),
      ),
      body: _catalogItems.isEmpty
          ? const Center(child: Text('कॅटलॉग रिकामा आहे. नवीन प्रॉडक्ट जोडा.', style: TextStyle(color: AppColors.textLight)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _catalogItems.length,
              itemBuilder: (context, index) {
                final item = _catalogItems[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: item['isActive'] ? Colors.white : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: item['isActive'] ? Colors.teal.shade200 : Colors.grey.shade400),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60, height: 60,
                        decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(8)),
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
                            Text(item['expiry'], style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                          ],
                        ),
                      ),
                      Switch(
                        value: item['isActive'],
                        activeThumbColor: Colors.teal,
                        onChanged: (val) {
                          setState(() => item['isActive'] = val);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}