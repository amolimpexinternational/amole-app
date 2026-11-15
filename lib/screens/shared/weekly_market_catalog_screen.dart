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
  final List<Map<String, dynamic>> _catalogItems = [];
  bool _isCatalogOn = false;

  Future<void> _addProduct() async {
    if (_catalogItems.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कमाल ५ प्रॉडक्ट्सच जोडू शकता!'), backgroundColor: Colors.red),
      );
      return;
    }

    // === Controllers ===
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final colorCtrl = TextEditingController();
    final weightCtrl = TextEditingController();
    final sizeCtrl = TextEditingController();
    final materialCtrl = TextEditingController();
    final brandCtrl = TextEditingController();
    final quantityCtrl = TextEditingController();
    String selectedCategory = 'किराणा';
    String selectedUnit = 'kg';
    File? pickedImage;

    const List<String> categories = [
      'किराणा', 'भाजीपाला', 'मेडिकल', 'खाद्यपदार्थ',
      'कपडे', 'इलेक्ट्रॉनिक', 'घर', 'सौंदर्य',
      'खेळणी', 'हस्तकला', 'दागिने', 'इतर',
    ];
    const List<String> units = ['kg', 'g', 'L', 'ml', 'नग', 'डझन', 'मीटर'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            top: 20, left: 20, right: 20,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.85),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === Header ===
                  Row(
                    children: [
                      const Expanded(
                        child: Text('आठवडी बाजारात प्रॉडक्ट जोडा',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // === फोटो ===
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
                        if (img != null) setSheetState(() => pickedImage = File(img.path));
                      },
                      child: Container(
                        height: 110, width: 110,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: pickedImage != null ? AppColors.successGreen : Colors.grey.shade400, width: 2),
                        ),
                        child: pickedImage != null
                            ? ClipRRect(borderRadius: BorderRadius.circular(9), child: Image.file(pickedImage!, fit: BoxFit.cover))
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_a_photo, color: AppColors.primaryBlue, size: 28),
                                  SizedBox(height: 4),
                                  Text('फोटो जोडा', style: TextStyle(fontSize: 11, color: AppColors.textLight)),
                                ],
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // === मूलभूत ===
                  _sectionLabel('मूलभूत माहिती'),
                  _inputField(nameCtrl, 'प्रॉडक्टचे नाव *'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedCategory,
                          decoration: const InputDecoration(
                            labelText: 'श्रेणी *',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                            isDense: true,
                          ),
                          items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 13)))).toList(),
                          onChanged: (v) => setSheetState(() => selectedCategory = v!),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _inputField(brandCtrl, 'ब्रँड (ऐच्छिक)'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // === किंमत + संख्या ===
                  _sectionLabel('किंमत आणि संख्या'),
                  Row(
                    children: [
                      Expanded(
                        child: _inputField(priceCtrl, 'किंमत (₹) *', keyboardType: TextInputType.number),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _inputField(quantityCtrl, 'उपलब्ध संख्या', keyboardType: TextInputType.number),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // === वजन + युनिट ===
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _inputField(weightCtrl, 'वजन / प्रमाण', keyboardType: TextInputType.number),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedUnit,
                          decoration: const InputDecoration(
                            labelText: 'युनिट',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                            isDense: true,
                          ),
                          items: units.map((u) => DropdownMenuItem(value: u, child: Text(u, style: const TextStyle(fontSize: 13)))).toList(),
                          onChanged: (v) => setSheetState(() => selectedUnit = v!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // === रंग + साईज + मटेरियल ===
                  _sectionLabel('रंग, साईज आणि मटेरियल'),
                  _inputField(colorCtrl, 'रंग (उदा. लाल, निळा)'),
                  const SizedBox(height: 10),
                  _inputField(sizeCtrl, 'साईज (उदा. M, L, XL, 5 inch)'),
                  const SizedBox(height: 10),
                  _inputField(materialCtrl, 'मटेरियल (उदा. कॉटन, स्टील)'),
                  const SizedBox(height: 10),

                  // === सखोल वर्णन ===
                  _sectionLabel('सखोल वर्णन'),
                  TextField(
                    controller: descCtrl,
                    maxLines: 4,
                    maxLength: 500,
                    decoration: const InputDecoration(
                      hintText: 'उत्पादनाची संपूर्ण माहिती — वापर, फायदे, खासियत, इत्यादी...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // === जोडा बटन ===
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (nameCtrl.text.trim().isEmpty || priceCtrl.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('नाव आणि किंमत आवश्यक!'), backgroundColor: Colors.red),
                          );
                          return;
                        }
                        Navigator.pop(ctx);
                        setState(() {
                          _catalogItems.add({
                            'id': DateTime.now().millisecondsSinceEpoch.toString(),
                            'name': nameCtrl.text.trim(),
                            'price': double.tryParse(priceCtrl.text) ?? 0,
                            'image': pickedImage,
                            'isActive': true,
                            'category': selectedCategory,
                            'brand': brandCtrl.text.trim(),
                            'description': descCtrl.text.trim(),
                            'color': colorCtrl.text.trim(),
                            'weight': weightCtrl.text.trim(),
                            'unit': selectedUnit,
                            'size': sizeCtrl.text.trim(),
                            'material': materialCtrl.text.trim(),
                            'quantity': quantityCtrl.text.trim(),
                          });
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('प्रॉडक्ट जोडले!'), backgroundColor: AppColors.successGreen),
                        );
                      },
                      icon: const Icon(Icons.check, color: Colors.white),
                      label: const Text('प्रॉडक्ट जोडा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // === Helper — Section label ===
  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
      ),
    );
  }

  // === Helper — Input field ===
  Widget _inputField(TextEditingController ctrl, String label, {TextInputType? keyboardType}) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        isDense: true,
        labelStyle: const TextStyle(fontSize: 12),
      ),
      style: const TextStyle(fontSize: 13),
    );
  }

  // === प्रॉडक्ट detail dialog ===
  void _showProductDetail(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (ctx, scrollCtrl) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.teal),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('प्रॉडक्ट माहिती', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: scrollCtrl,
                padding: const EdgeInsets.all(16),
                children: [
                  if (item['image'] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(item['image'], height: 180, width: double.infinity, fit: BoxFit.cover),
                    ),
                  const SizedBox(height: 12),
                  Text(item['name'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('₹${(item['price'] as double).toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 22, color: Colors.teal, fontWeight: FontWeight.bold)),
                  const Divider(height: 24),
                  _detailRow(Icons.category_outlined, 'श्रेणी', item['category'] ?? '—'),
                  if ((item['brand'] ?? '').toString().isNotEmpty)
                    _detailRow(Icons.branding_watermark_outlined, 'ब्रँड', item['brand']),
                  if ((item['color'] ?? '').toString().isNotEmpty)
                    _detailRow(Icons.palette_outlined, 'रंग', item['color']),
                  if ((item['weight'] ?? '').toString().isNotEmpty)
                    _detailRow(Icons.scale_outlined, 'वजन / प्रमाण', '${item['weight']} ${item['unit'] ?? ''}'),
                  if ((item['size'] ?? '').toString().isNotEmpty)
                    _detailRow(Icons.straighten_outlined, 'साईज', item['size']),
                  if ((item['material'] ?? '').toString().isNotEmpty)
                    _detailRow(Icons.texture_outlined, 'मटेरियल', item['material']),
                  if ((item['quantity'] ?? '').toString().isNotEmpty)
                    _detailRow(Icons.inventory_2_outlined, 'उपलब्ध संख्या', item['quantity']),
                  if ((item['description'] ?? '').toString().isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Text('सखोल वर्णन', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                    const SizedBox(height: 4),
                    Text(item['description'], style: const TextStyle(fontSize: 13, height: 1.5)),
                  ],
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.textLight),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
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
        title: const Text('आठवडी बाजार कॅटलॉग'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                Text(
                  _isCatalogOn ? 'सहभागी: ON' : 'सहभागी: OFF',
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
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
                        ? 'आठवडी बाजारात सहभागी — आठवडी बाजार भरल्यावर हा कॅटलॉग सार्वजनिक होईल.'
                        : 'आठवडी बाजारात सहभागी नाही — सहभागी होण्यासाठी ON करा.',
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
                      return GestureDetector(
                        onTap: () => _showProductDetail(item),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.teal.shade200),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4)],
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
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Text('₹${(item['price'] as double).toStringAsFixed(0)}',
                                            style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                                        if ((item['category'] ?? '').toString().isNotEmpty) ...[
                                          const SizedBox(width: 8),
                                          Text('• ${item['category']}',
                                              style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                                        ],
                                      ],
                                    ),
                                    if ((item['weight'] ?? '').toString().isNotEmpty)
                                      Text('वजन: ${item['weight']} ${item['unit'] ?? ''}',
                                          style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                                onPressed: () {
                                  setState(() => _catalogItems.removeAt(index));
                                },
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