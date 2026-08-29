import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/product_database.dart';
import '../../models/product_model.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel product;
  const EditProductScreen({super.key, required this.product});
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _mrpCtrl;
  late final TextEditingController _discountCtrl;
  late final TextEditingController _stockCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _keywordsCtrl;
  late bool _isActive;
  late bool _isReturnable;
  late bool _deliveryAvailable;
  late String _category;

  final List<String> _categories = [
    'GR','FV','DA','BK','RS','MD','EL','CF','JW','BP','ED','AU','CH','AG','FS','HS','OT'
  ];
  final Map<String,String> _catNames = {
    'GR':'किराणा','FV':'फळे व भाजीपाला','DA':'दुग्धजन्य','BK':'बेकरी',
    'RS':'हॉटेल/रेस्तराँ','MD':'मेडिकल','EL':'इलेक्ट्रॉनिक्स','CF':'कपडे',
    'JW':'दागिने','BP':'ब्युटी','ED':'शिक्षण','AU':'वाहन','CH':'बांधकाम',
    'AG':'शेती','FS':'आर्थिक','HS':'गृहसेवा','OT':'इतर'
  };

  double get mrp => double.tryParse(_mrpCtrl.text) ?? 0;
  double get discount => double.tryParse(_discountCtrl.text) ?? 0;
  double get sellingPrice => mrp - (mrp * discount / 100);

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _nameCtrl = TextEditingController(text: p.name);
    _mrpCtrl = TextEditingController(text: p.mrp.toStringAsFixed(0));
    _discountCtrl = TextEditingController(text: p.discount.toStringAsFixed(0));
    _stockCtrl = TextEditingController(text: p.stock.toString());
    _descCtrl = TextEditingController(text: p.description);
    _keywordsCtrl = TextEditingController(text: p.keywords);
    _isActive = p.isActive;
    _isReturnable = p.isReturnable;
    _deliveryAvailable = p.deliveryAvailable;
    _category = _categories.contains(p.category) ? p.category : 'OT';
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); _mrpCtrl.dispose(); _discountCtrl.dispose();
    _stockCtrl.dispose(); _descCtrl.dispose(); _keywordsCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_nameCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product नाव आवश्यक आहे'), backgroundColor: Colors.red));
      return;
    }
    final updated = ProductModel(
      id: widget.product.id,
      name: _nameCtrl.text.trim(),
      mrp: mrp,
      discount: discount,
      stock: int.tryParse(_stockCtrl.text) ?? 0,
      category: _category,
      description: _descCtrl.text.trim(),
      keywords: _keywordsCtrl.text.trim(),
      isActive: _isActive,
      isReturnable: _isReturnable,
      deliveryAvailable: _deliveryAvailable,
      image: widget.product.image,
    );
    ProductDatabase.updateProduct(updated);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product Update झाला! ✅'), backgroundColor: Colors.green));
    Navigator.pop(context);
  }

  Widget _field(String label, TextEditingController ctrl,
      {TextInputType kb = TextInputType.text, int maxLines = 1, String? hint}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: ctrl,
        keyboardType: kb,
        maxLines: maxLines,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          labelText: label, hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2)),
          filled: true, fillColor: Colors.white,
        ),
      ),
    );

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 10),
    child: Row(children: [
      Container(width: 4, height: 18,
        decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(2))),
      const SizedBox(width: 8),
      Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
    ]),
  );

  Widget _toggle(String label, String subtitle, bool value, Function(bool) onChanged) =>
    Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200)),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
        ])),
        Switch(value: value, onChanged: onChanged, activeColor: AppColors.primaryBlue),
      ]),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Product Edit करा'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('Product माहिती'),
          _field('Product नाव', _nameCtrl, hint: 'उदा: Organic Mango'),
          _field('Description', _descCtrl, maxLines: 3, hint: 'Product बद्दल सांगा...'),
          _field('Search Keywords', _keywordsCtrl, hint: 'उदा: mango, आंबा, फळे'),

          _sectionTitle('Category'),
          Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300)),
            child: DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
              items: _categories.map((c) =>
                DropdownMenuItem(value: c, child: Text(_catNames[c] ?? c))).toList(),
              onChanged: (v) => setState(() => _category = v!),
            ),
          ),

          _sectionTitle('किंमत आणि Stock'),
          Row(children: [
            Expanded(child: _field('MRP (₹)', _mrpCtrl, kb: TextInputType.number)),
            const SizedBox(width: 12),
            Expanded(child: _field('Discount (%)', _discountCtrl, kb: TextInputType.number)),
          ]),
          if (mrp > 0)
            Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Selling Price:', style: TextStyle(fontSize: 13, color: AppColors.textLight)),
                Text('₹${sellingPrice.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
              ]),
            ),
          _field('Stock (किती शिल्लक)', _stockCtrl, kb: TextInputType.number),

          _sectionTitle('Settings'),
          _toggle('Active', 'Product Customer ला दिसेल', _isActive, (v) => setState(() => _isActive = v)),
          _toggle('Home Delivery', 'या Product वर Delivery उपलब्ध', _deliveryAvailable, (v) => setState(() => _deliveryAvailable = v)),
          _toggle('Returnable', 'Customer परत करू शकतो', _isReturnable, (v) => setState(() => _isReturnable = v)),

          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity, height: 52,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text('Product Save करा',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
