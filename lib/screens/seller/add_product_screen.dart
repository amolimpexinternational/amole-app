import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/product_database.dart';
import '../../models/product_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _mrpController = TextEditingController();
  final _discountController = TextEditingController(text: '0');
  final _stockController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _keywordsController = TextEditingController();
  String _selectedCategory = 'किराणा';
  bool _homeDelivery = true;
  bool _returnable = true;

  final List<String> _categories = [
    'किराणा', 'इलेक्ट्रॉनिक्स', 'मेडिकल', 'कपडे',
    'खाद्यपदार्थ', 'घर', 'वाहन', 'शिक्षण', 'सौंदर्य', 'इतर'
  ];

  double get mrp => double.tryParse(_mrpController.text) ?? 0;
  double get discountPct => double.tryParse(_discountController.text) ?? 0;
  double get sellingPrice => mrp - (mrp * discountPct / 100);
  double get companyFee => sellingPrice * 0.10;
  double get netPayout => sellingPrice - companyFee;

  @override
  void dispose() {
    _nameController.dispose();
    _mrpController.dispose();
    _discountController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    _keywordsController.dispose();
    super.dispose();
  }

  Widget _buildField(String label, TextEditingController ctrl,
      {TextInputType keyboard = TextInputType.text, int maxLines = 1, String? hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: ctrl,
        keyboardType: keyboard,
        maxLines: maxLines,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 6),
      child: Text(title,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
    );
  }

  void _saveProduct() {
    if (_nameController.text.trim().isEmpty || mrp <= 0 || _stockController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product Name, MRP आणि Stock आवश्यक आहे')),
      );
      return;
    }

    ProductDatabase.products.add(ProductModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      price: sellingPrice,
      stock: int.tryParse(_stockController.text) ?? 0,
      category: _selectedCategory,
      image: '',
    ));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Product Save झाला! Franchise Approval नंतर Live होईल.'),
          backgroundColor: Colors.green),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Product जोडा'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo Upload
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Photo Upload येत आहे...'))),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3), width: 2),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo_outlined, size: 50, color: AppColors.primaryBlue),
                    SizedBox(height: 8),
                    Text('Product Photo Upload करा',
                        style: TextStyle(color: AppColors.textLight, fontSize: 13)),
                    Text('(Free Plan: 1 photo per product)',
                        style: TextStyle(color: AppColors.textLight, fontSize: 11)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Basic Info
            _buildSectionTitle('मूलभूत माहिती'),
            _buildField('Product Name *', _nameController, hint: 'उदा. तांदूळ 5kg'),
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _selectedCategory = v!),
              ),
            ),
            _buildField('Keywords / Tags', _keywordsController,
                hint: 'उदा. rice, तांदूळ, basmati (comma ने वेगळे करा)'),
            _buildField('Description', _descriptionController,
                maxLines: 3, hint: 'Product बद्दल सांगा...'),
            _buildField('Stock Quantity *', _stockController,
                keyboard: TextInputType.number, hint: 'उदा. 50'),

            // Pricing Section — Blueprint 5.4
            _buildSectionTitle('किंमत (Blueprint ५.४ नुसार)'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.lightGrey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // MRP
                  TextField(
                    controller: _mrpController,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: 'MRP (मूळ किंमत) *',
                      prefixText: '₹ ',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      filled: true, fillColor: AppColors.lightGrey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Discount
                  TextField(
                    controller: _discountController,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: 'Discount % (तुम्ही देणार)',
                      suffixText: '%',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      filled: true, fillColor: AppColors.lightGrey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 10),

                  // Auto-calculated — Seller ला दिसणारे
                  _buildPriceRow('Selling Price (ग्राहकाला दिसणारी किंमत)',
                      '₹${sellingPrice.toStringAsFixed(2)}', AppColors.primaryBlue, bold: true),
                  const SizedBox(height: 8),
                  _buildPriceRow('Company Fee (10%)',
                      '- ₹${companyFee.toStringAsFixed(2)}', AppColors.errorRed),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.successGreen.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.successGreen.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('तुम्हाला मिळेल (Net Payout)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColors.textDark)),
                        Text('₹${netPayout.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.successGreen)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '⚠️ ग्राहकाला फक्त MRP, Discount% आणि Final Price दिसेल. Company Fee आणि Net Payout ग्राहकाला दिसणार नाही.',
                    style: TextStyle(fontSize: 11, color: AppColors.textLight),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Delivery Settings — Blueprint 5.7
            _buildSectionTitle('डिलिव्हरी सेटिंग्ज (Blueprint ५.७)'),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Home Delivery उपलब्ध',
                          style: TextStyle(fontSize: 14, color: AppColors.textDark)),
                      Switch(
                          value: _homeDelivery,
                          onChanged: (v) => setState(() => _homeDelivery = v),
                          activeColor: AppColors.primaryBlue),
                    ],
                  ),
                  const Divider(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Return Allowed',
                          style: TextStyle(fontSize: 14, color: AppColors.textDark)),
                      Switch(
                          value: _returnable,
                          onChanged: (v) => setState(() => _returnable = v),
                          activeColor: AppColors.successGreen),
                    ],
                  ),
                  if (!_returnable)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('⚠️ Non-Returnable — ग्राहकाला खरेदी करताना हे दिसेल',
                          style: TextStyle(fontSize: 11, color: Colors.orange)),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: mrp > 0 ? _saveProduct : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Product Save करा',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text('Save केल्यावर Franchise Approval नंतर Product Live होईल',
                  style: TextStyle(fontSize: 11, color: AppColors.textLight),
                  textAlign: TextAlign.center),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, Color color, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(label,
            style: TextStyle(
                fontSize: 13,
                color: AppColors.textDark,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal))),
        Text(value,
            style: TextStyle(
                fontSize: bold ? 16 : 14,
                fontWeight: bold ? FontWeight.bold : FontWeight.w600,
                color: color)),
      ],
    );
  }
}
