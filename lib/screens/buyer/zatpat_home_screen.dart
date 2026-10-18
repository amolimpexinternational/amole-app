import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/buyer_shopping_data.dart';
import 'cart_screen.dart';

class ZatPatHomeScreen extends StatefulWidget {
  const ZatPatHomeScreen({super.key});

  @override
  State<ZatPatHomeScreen> createState() => _ZatPatHomeScreenState();
}

class _ZatPatHomeScreenState extends State<ZatPatHomeScreen> {
  static const double _maxKm = 10;
  String _category = 'सर्व';
  String _query = '';

  final List<String> _categories = const [
    'सर्व',
    'किराणा',
    'भाजीपाला',
    'मेडिकल',
    'खाद्यपदार्थ',
  ];

  // Demo डेटा. 'zatpat': true म्हणजे दुकानदाराने लोकल डिलिव्हरी ON केली आहे.
  // km म्हणजे buyer पासूनचे अंतर. खरा डेटा Stage 3 मध्ये येईल.
  final List<Map<String, dynamic>> _products = const [
    {'seller': 'श्री गणेश किराणा', 'km': 0.3, 'zatpat': true, 'category': 'किराणा', 'name': 'तांदूळ 5kg', 'price': 250.0, 'mrp': 280.0},
    {'seller': 'श्री गणेश किराणा', 'km': 0.3, 'zatpat': true, 'category': 'किराणा', 'name': 'साखर 1kg', 'price': 45.0, 'mrp': 50.0},
    {'seller': 'राज मेडिकल', 'km': 0.5, 'zatpat': true, 'category': 'मेडिकल', 'name': 'हँड सॅनिटायझर 100ml', 'price': 55.0, 'mrp': 60.0},
    {'seller': 'राज मेडिकल', 'km': 0.5, 'zatpat': true, 'category': 'मेडिकल', 'name': 'ORS पावडर', 'price': 22.0, 'mrp': 25.0},
    {'seller': 'स्वाद हॉटेल', 'km': 0.8, 'zatpat': true, 'category': 'खाद्यपदार्थ', 'name': 'वडापाव (2)', 'price': 30.0, 'mrp': 30.0},
    {'seller': 'स्वाद हॉटेल', 'km': 0.8, 'zatpat': true, 'category': 'खाद्यपदार्थ', 'name': 'मिसळ पाव', 'price': 80.0, 'mrp': 90.0},
    {'seller': 'साई किराणा स्टोअर', 'km': 2.4, 'zatpat': true, 'category': 'भाजीपाला', 'name': 'ताज्या टोमॅटो', 'price': 30.0, 'mrp': 35.0},
    {'seller': 'साई किराणा स्टोअर', 'km': 2.4, 'zatpat': true, 'category': 'भाजीपाला', 'name': 'कांदा 1kg', 'price': 28.0, 'mrp': 32.0},
    {'seller': 'आरोग्य मेडिकल', 'km': 3.0, 'zatpat': false, 'category': 'मेडिकल', 'name': 'व्हिटॅमिन C', 'price': 90.0, 'mrp': 100.0},
    {'seller': 'महालक्ष्मी जनरल स्टोअर', 'km': 4.6, 'zatpat': true, 'category': 'किराणा', 'name': 'नैसर्गिक मध', 'price': 450.0, 'mrp': 500.0},
    {'seller': 'महालक्ष्मी जनरल स्टोअर', 'km': 4.6, 'zatpat': true, 'category': 'किराणा', 'name': 'डाळ 1kg', 'price': 120.0, 'mrp': 130.0},
    {'seller': 'मुळशी किराणा स्टोअर', 'km': 6.8, 'zatpat': true, 'category': 'किराणा', 'name': 'गव्हाचे पीठ 5kg', 'price': 210.0, 'mrp': 230.0},
    {'seller': 'शेतकरी भाजी केंद्र', 'km': 9.2, 'zatpat': true, 'category': 'भाजीपाला', 'name': 'पालक जुडी', 'price': 15.0, 'mrp': 20.0},
    {'seller': 'जुन्नर कपडे', 'km': 35.0, 'zatpat': false, 'category': 'कपडे', 'name': 'टी-शर्ट', 'price': 299.0, 'mrp': 399.0},
  ];

  String _idOf(Map<String, dynamic> p) => '${p['seller']}|${p['name']}';

  IconData _iconOf(String category) {
    switch (category) {
      case 'किराणा':
        return Icons.shopping_basket_outlined;
      case 'भाजीपाला':
        return Icons.eco_outlined;
      case 'मेडिकल':
        return Icons.local_hospital_outlined;
      case 'खाद्यपदार्थ':
        return Icons.restaurant_outlined;
      default:
        return Icons.storefront_outlined;
    }
  }

  // फक्त ZatPat ON असलेले आणि 10 km मधले, जवळचे आधी
  List<Map<String, dynamic>> get _visible {
    final q = _query.trim();
    final list = _products.where((p) {
      if (p['zatpat'] != true) return false;
      if ((p['km'] as double) > _maxKm) return false;
      if (_category != 'सर्व' && p['category'] != _category) return false;
      if (q.isNotEmpty &&
          !(p['name'] as String).contains(q) &&
          !(p['seller'] as String).contains(q)) {
        return false;
      }
      return true;
    }).toList();
    list.sort((a, b) => (a['km'] as double).compareTo(b['km'] as double));
    return list;
  }

  int _qtyOf(String id) {
    final i = BuyerShoppingData.cartItems.indexWhere((e) => e['id'] == id);
    if (i < 0) return 0;
    return BuyerShoppingData.cartItems[i]['qty'] as int;
  }

  void _add(Map<String, dynamic> p) {
    final price = p['price'] as double;
    final mrp = p['mrp'] as double;
    final discount = mrp > 0 ? ((mrp - price) / mrp * 100).roundToDouble() : 0.0;
    setState(() {
      BuyerShoppingData.addToCart(
        id: _idOf(p),
        name: p['name'] as String,
        price: price,
        qty: 1,
        seller: p['seller'] as String,
        mrp: mrp,
        discount: discount,
        stock: 50,
        deliveryAvailable: true,
      );
    });
  }

  void _change(String id, int delta) {
    setState(() {
      if (delta < 0 && _qtyOf(id) == 1) {
        BuyerShoppingData.removeFromCart(id);
      } else {
        BuyerShoppingData.changeCartQuantity(id, delta);
      }
    });
  }

  // डिलिव्हरी चार्ज: 3 km ₹30, 5 km ₹45, 7 km ₹60, 10 km ₹100
  int _chargeForKm(double km) {
    if (km <= 3) return 30;
    if (km <= 5) return 45;
    if (km <= 7) return 60;
    return 100;
  }

  // Cart मधल्या ZatPat दुकानांपैकी सर्वात दूरच्या दुकानावरून (Demo नियम)
  int _deliveryCharge() {
    double? maxKm;
    for (final item in BuyerShoppingData.cartItems) {
      for (final p in _products) {
        if (p['seller'] == item['seller'] && p['zatpat'] == true) {
          final km = p['km'] as double;
          if (maxKm == null || km > maxKm) maxKm = km;
          break;
        }
      }
    }
    if (maxKm == null) return 0;
    return _chargeForKm(maxKm);
  }

  Widget _qtyControl(Map<String, dynamic> p) {
    final id = _idOf(p);
    final q = _qtyOf(id);
    if (q == 0) {
      return SizedBox(
        height: 32,
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () => _add(p),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: AppColors.primaryBlue,
            side: const BorderSide(color: AppColors.primaryBlue),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('ADD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ),
      );
    }
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => _change(id, -1),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.remove, color: Colors.white, size: 18),
            ),
          ),
          Text('$q', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          InkWell(
            onTap: () => _change(id, 1),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.add, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productCard(Map<String, dynamic> p) {
    final price = p['price'] as double;
    final mrp = p['mrp'] as double;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(_iconOf(p['category'] as String), color: AppColors.primaryBlue, size: 34),
          ),
          const SizedBox(height: 6),
          Text(
            p['name'] as String,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),
          ),
          const SizedBox(height: 2),
          Text(
            '${p['seller']} · ${p['km']} km',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, color: AppColors.textLight),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('₹${price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              const SizedBox(width: 6),
              if (mrp > price)
                Text(
                  '₹${mrp.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 11, color: AppColors.textLight, decoration: TextDecoration.lineThrough),
                ),
            ],
          ),
          const SizedBox(height: 6),
          _qtyControl(p),
        ],
      ),
    );
  }

  Widget _bottomBar() {
    final count = BuyerShoppingData.cartCount;
    if (count == 0) return const SizedBox.shrink();
    final subtotal = BuyerShoppingData.cartSubtotal;
    final delivery = _deliveryCharge();
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$count वस्तू · ₹${subtotal.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  if (delivery > 0)
                    Text(
                      '+ डिलिव्हरी ₹$delivery',
                      style: const TextStyle(fontSize: 12, color: AppColors.textLight),
                    ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              ).then((_) => setState(() {})),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Cart बघा', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _visible;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('⚡ ZatPat', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            Text('तुमच्या 10 km मधली दुकाने', style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
      bottomNavigationBar: _bottomBar(),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
            child: Column(
              children: [
                TextField(
                  onChanged: (v) => setState(() => _query = v),
                  decoration: InputDecoration(
                    hintText: 'वस्तू किंवा दुकान शोधा...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.primaryBlue),
                    filled: true,
                    fillColor: const Color(0xFFF1F3F6),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'डिलिव्हरी: 3 km ₹30 · 5 km ₹45 · 7 km ₹60 · 10 km ₹100',
                  style: TextStyle(fontSize: 11, color: AppColors.textLight),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 52,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final c = _categories[i];
                final selected = c == _category;
                return GestureDetector(
                  onTap: () => setState(() => _category = c),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primaryBlue : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      c,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: selected ? Colors.white : AppColors.primaryBlue,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text(
                      'या परिसरात सध्या ZatPat वस्तू नाहीत',
                      style: TextStyle(color: AppColors.textLight),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 232,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, i) => _productCard(items[i]),
                  ),
          ),
        ],
      ),
    );
  }
}