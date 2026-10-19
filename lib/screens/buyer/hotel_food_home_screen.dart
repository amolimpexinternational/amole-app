import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/buyer_shopping_data.dart';
import '../../data/delivery_rates.dart';
import 'cart_screen.dart';

// Demo डेटा. km = buyer पासूनचे अंतर. खरा डेटा Stage 3 मध्ये येईल.
class HotelFoodData {
  static const List<Map<String, dynamic>> hotels = [
    {
      'name': 'स्वाद हॉटेल',
      'cuisine': 'मराठी, नाश्ता',
      'km': 0.8,
      'rating': '4.7',
      'items': [
        {'name': 'मिसळ पाव', 'price': 80.0, 'veg': true, 'desc': 'झणझणीत मिसळ, 2 पाव'},
        {'name': 'वडापाव (2)', 'price': 30.0, 'veg': true, 'desc': 'चटणी सह'},
        {'name': 'साबुदाणा खिचडी', 'price': 60.0, 'veg': true, 'desc': 'दाणे आणि बटाटा'},
        {'name': 'चिकन थाळी', 'price': 180.0, 'veg': false, 'desc': 'भाकरी, रस्सा, भात'},
      ],
    },
    {
      'name': 'सह्याद्री भोजनालय',
      'cuisine': 'थाळी, महाराष्ट्रीयन',
      'km': 2.6,
      'rating': '4.5',
      'items': [
        {'name': 'व्हेज थाळी', 'price': 140.0, 'veg': true, 'desc': 'पोळी, 2 भाज्या, आमटी, भात'},
        {'name': 'पिठलं भाकरी', 'price': 90.0, 'veg': true, 'desc': 'ठेचा सह'},
        {'name': 'मटण थाळी', 'price': 260.0, 'veg': false, 'desc': 'सुके मटण, रस्सा, भाकरी'},
      ],
    },
    {
      'name': 'पंजाबी तडका',
      'cuisine': 'पंजाबी, चायनीज',
      'km': 4.4,
      'rating': '4.3',
      'items': [
        {'name': 'पनीर बटर मसाला', 'price': 190.0, 'veg': true, 'desc': 'रोटी सह'},
        {'name': 'दाल तडका', 'price': 130.0, 'veg': true, 'desc': 'जीरा राइस सह'},
        {'name': 'व्हेज हक्का नूडल्स', 'price': 120.0, 'veg': true, 'desc': 'फुल प्लेट'},
        {'name': 'बटर चिकन', 'price': 240.0, 'veg': false, 'desc': 'नान सह'},
      ],
    },
    {
      'name': 'गावरान हॉटेल, मुळशी',
      'cuisine': 'गावरान',
      'km': 8.9,
      'rating': '4.6',
      'items': [
        {'name': 'झुणका भाकर', 'price': 70.0, 'veg': true, 'desc': 'कांदा आणि ठेचा'},
        {'name': 'गावरान चिकन', 'price': 220.0, 'veg': false, 'desc': 'भाकरी सह'},
      ],
    },
    {
      'name': 'दूरचे हॉटेल, बारामती',
      'cuisine': 'मराठी',
      'km': 35.0,
      'rating': '4.4',
      'items': [
        {'name': 'व्हेज थाळी', 'price': 150.0, 'veg': true, 'desc': 'पूर्ण थाळी'},
      ],
    },
  ];
}

String _idOf(String hotel, String dish) => '$hotel|$dish';

int _qtyOf(String id) {
  final i = BuyerShoppingData.cartItems.indexWhere((e) => e['id'] == id);
  if (i < 0) return 0;
  return BuyerShoppingData.cartItems[i]['qty'] as int;
}

void _addItem(String hotel, Map<String, dynamic> item) {
  final price = item['price'] as double;
  BuyerShoppingData.addToCart(
    id: _idOf(hotel, item['name'] as String),
    name: item['name'] as String,
    price: price,
    qty: 1,
    seller: hotel,
    description: (item['desc'] ?? '') as String,
    mrp: price,
    discount: 0,
    stock: 50,
    deliveryAvailable: true,
    isReturnable: false,
  );
}

void _changeItem(String id, int delta) {
  if (delta < 0 && _qtyOf(id) == 1) {
    BuyerShoppingData.removeFromCart(id);
  } else {
    BuyerShoppingData.changeCartQuantity(id, delta);
  }
}

// Cart मधल्या हॉटेलांपैकी सर्वात दूरच्या हॉटेलवरून डिलिव्हरी चार्ज (Demo नियम)
int _hotelDeliveryCharge() {
  double? maxKm;
  for (final c in BuyerShoppingData.cartItems) {
    for (final h in HotelFoodData.hotels) {
      if (h['name'] == c['seller']) {
        final km = h['km'] as double;
        if (maxKm == null || km > maxKm) maxKm = km;
      }
    }
  }
  if (maxKm == null) return 0;
  return DeliveryRates.chargeForKm(maxKm);
}

class _QtyControl extends StatelessWidget {
  final String id;
  final VoidCallback onAdd;
  final void Function(int) onChange;
  const _QtyControl(
      {required this.id, required this.onAdd, required this.onChange});

  @override
  Widget build(BuildContext context) {
    final q = _qtyOf(id);
    if (q == 0) {
      return SizedBox(
        height: 32,
        width: 84,
        child: OutlinedButton(
          onPressed: onAdd,
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: AppColors.primaryBlue,
            side: const BorderSide(color: AppColors.primaryBlue),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('ADD',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ),
      );
    }
    return Container(
      height: 32,
      width: 84,
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => onChange(-1),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.remove, color: Colors.white, size: 18),
            ),
          ),
          Text('$q',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          InkWell(
            onTap: () => onChange(1),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.add, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartBar extends StatelessWidget {
  final VoidCallback onBack;
  const _CartBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    final count = BuyerShoppingData.cartCount;
    if (count == 0) return const SizedBox.shrink();
    final subtotal = BuyerShoppingData.cartSubtotal;
    final delivery = _hotelDeliveryCharge();
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
                  Text('$count वस्तू · ₹${subtotal.toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark)),
                  if (delivery > 0)
                    Text('+ डिलिव्हरी ₹$delivery · Online पेमेंट',
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textLight)),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              ).then((_) => onBack()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Cart बघा',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class HotelFoodHomeScreen extends StatefulWidget {
  const HotelFoodHomeScreen({super.key});

  @override
  State<HotelFoodHomeScreen> createState() => _HotelFoodHomeScreenState();
}

class _HotelFoodHomeScreenState extends State<HotelFoodHomeScreen> {
  static const double _maxKm = 10;
  String _query = '';

  // पदार्थाचे किंवा हॉटेलचे नाव जुळणारी हॉटेले, 10 km मधली, जवळची आधी
  List<Map<String, dynamic>> get _visible {
    final q = _query.trim();
    final list = HotelFoodData.hotels.where((h) {
      if ((h['km'] as double) > _maxKm) return false;
      if (q.isEmpty) return true;
      if ((h['name'] as String).contains(q)) return true;
      final items = h['items'] as List;
      return items.any((it) => ((it as Map)['name'] as String).contains(q));
    }).toList();
    list.sort((a, b) => (a['km'] as double).compareTo(b['km'] as double));
    return list;
  }

  List<String> _matchingDishes(Map<String, dynamic> h) {
    final q = _query.trim();
    if (q.isEmpty) return [];
    final items = h['items'] as List;
    return items
        .map((it) => (it as Map)['name'] as String)
        .where((n) => n.contains(q))
        .toList();
  }

  Widget _hotelCard(Map<String, dynamic> h) {
    final km = h['km'] as double;
    final dishes = _matchingDishes(h);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => HotelMenuScreen(hotel: h)),
      ).then((_) => setState(() {})),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFEF6C00).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.restaurant_outlined,
                  color: Color(0xFFEF6C00), size: 30),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(h['name'] as String,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.textDark)),
                  const SizedBox(height: 2),
                  Text(h['cuisine'] as String,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textLight)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 3),
                      Text(h['rating'] as String,
                          style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 10),
                      Text('$km km',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textLight)),
                      const SizedBox(width: 10),
                      Text('डिलिव्हरी ₹${DeliveryRates.chargeForKm(km)}',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textLight)),
                    ],
                  ),
                  if (dishes.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text('मिळते: ${dishes.join(', ')}',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryBlue)),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textLight),
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
            Text('🍽️ Hotel Food',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text('तुमच्या 10 km मधली हॉटेले',
                style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
      bottomNavigationBar: _CartBar(onBack: () => setState(() {})),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'पदार्थ किंवा हॉटेल शोधा...',
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.primaryBlue),
                filled: true,
                fillColor: const Color(0xFFF1F3F6),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text('या शोधासाठी हॉटेल सापडले नाही',
                        style: TextStyle(color: AppColors.textLight)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (context, i) => _hotelCard(items[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class HotelMenuScreen extends StatefulWidget {
  final Map<String, dynamic> hotel;
  const HotelMenuScreen({super.key, required this.hotel});

  @override
  State<HotelMenuScreen> createState() => _HotelMenuScreenState();
}

class _HotelMenuScreenState extends State<HotelMenuScreen> {
  @override
  Widget build(BuildContext context) {
    final name = widget.hotel['name'] as String;
    final items = widget.hotel['items'] as List;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold)),
            Text('${widget.hotel['cuisine']} · ${widget.hotel['km']} km',
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
      bottomNavigationBar: _CartBar(onBack: () => setState(() {})),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, i) {
          final it = items[i] as Map<String, dynamic>;
          final id = _idOf(name, it['name'] as String);
          final veg = it['veg'] == true;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.lightGrey),
            ),
            child: Row(
              children: [
                Icon(Icons.circle,
                    size: 14, color: veg ? Colors.green : Colors.red),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(it['name'] as String,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: AppColors.textDark)),
                      const SizedBox(height: 2),
                      Text(it['desc'] as String,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textLight)),
                      const SizedBox(height: 4),
                      Text('₹${(it['price'] as double).toStringAsFixed(0)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark)),
                    ],
                  ),
                ),
                _QtyControl(
                  id: id,
                  onAdd: () => setState(() => _addItem(name, it)),
                  onChange: (d) => setState(() => _changeItem(id, d)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}