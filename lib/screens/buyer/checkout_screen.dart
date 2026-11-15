import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'order_tracking_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final String productName;
  final double unitPrice;
  final int quantity;
  final String sellerName;
  final String productId;
  // ✅ नवीन: cart items (जर cart मधून checkout केलं तर)
  final List<Map<String, dynamic>>? cartItems;

  const CheckoutScreen({
    super.key,
    this.productName = '',
    this.unitPrice = 0,
    this.quantity = 1,
    this.sellerName = '',
    this.productId = '',
    this.cartItems,
  });

  bool get isCartMode => cartItems != null && cartItems!.isNotEmpty;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _rewardPoints = 245;
  bool _useRewardPoints = false;
  int _usedPoints = 0;
  String _paymentMethod = 'UPI';

  // === Module detection ===
  String _detectModule(Map<String, dynamic> item) {
    final seller = (item['seller'] ?? '').toString();
    final id = (item['id'] ?? '').toString();

    const hotelKeywords = ['हॉटेल', 'भोजनालय', 'तडका', 'Hotel', 'hotel', 'स्वाद'];
    for (final kw in hotelKeywords) {
      if (seller.contains(kw)) return 'Hotel Food';
    }
    if (id.contains('|')) return 'ZatPat';
    return 'Global Shopping';
  }

  String _moduleDelivery(String module) {
    switch (module) {
      case 'Global Shopping': return 'कुरिअर (Shiprocket) — 3-5 दिवस';
      case 'ZatPat': return 'स्थानिक delivery — 15-30 मिनिटं';
      case 'Hotel Food': return 'स्थानिक delivery — 15-30 मिनिटं';
      default: return '';
    }
  }

  IconData _moduleIcon(String module) {
    switch (module) {
      case 'Global Shopping': return Icons.shopping_bag;
      case 'ZatPat': return Icons.bolt;
      case 'Hotel Food': return Icons.restaurant;
      default: return Icons.local_shipping;
    }
  }

  Map<String, List<Map<String, dynamic>>> get _groupedByModule {
    if (!widget.isCartMode) return {};
    final groups = <String, List<Map<String, dynamic>>>{};
    for (final item in widget.cartItems!) {
      final module = _detectModule(item);
      groups.putIfAbsent(module, () => []).add(item);
    }
    return groups;
  }

  double _itemTotalForModule(List<Map<String, dynamic>> items) {
    double total = 0;
    for (final item in items) {
      total += ((item['price'] as num).toDouble()) * ((item['qty'] as num).toInt());
    }
    return total;
  }

  // === एकूण ===
  double get _itemTotal {
    if (widget.isCartMode) {
      return _itemTotalForModule(widget.cartItems!);
    }
    return widget.unitPrice * widget.quantity;
  }

  double get _deliveryCharge {
    if (widget.isCartMode) {
      // प्रत्येक module साठी डिलिव्हरी चार्ज (डमी)
      final groups = _groupedByModule;
      double total = 0;
      for (final module in groups.keys) {
        if (module == 'Global Shopping') {
          total += 45; // कुरिअर डमी
        } else {
          total += 30; // स्थानिक डमी
        }
      }
      return total;
    }
    return 45.0;
  }

  double get _rewardDiscount => _useRewardPoints ? _usedPoints.toDouble() : 0.0;
  double get _grandTotal => _itemTotal + _deliveryCharge - _rewardDiscount;

  void _toggleRewardPoints(bool value) {
    setState(() {
      _useRewardPoints = value;
      if (value) {
        _usedPoints = _rewardPoints < _itemTotal ? _rewardPoints : _itemTotal.toInt();
      } else {
        _usedPoints = 0;
      }
    });
  }

  void _placeOrder() {
    if (_grandTotal < 0) return;

    if (widget.isCartMode) {
      // === Cart mode: ३ वेगळ्या orders ===
      final groups = _groupedByModule;
      final modulesText = groups.keys.map((m) => '• $m (${_itemTotalForModule(groups[m]!).toStringAsFixed(0)}₹)').join('\n');

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('ऑर्डर यशस्वी ✅'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('तुमची ऑर्डर ${groups.length} भागांमध्ये विभागली गेली:\n'),
              Text(modulesText, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Text('एकूण रक्कम: ₹${_grandTotal.toStringAsFixed(0)}'),
              Text('पेमेंट: $_paymentMethod'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
              child: const Text('ऑर्डर ट्रॅक करा'),
            ),
          ],
        ),
      );
    } else {
      // === Single product mode (existing) ===
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('ऑर्डर यशस्वी ✅'),
          content: Text(
            'तुमची ऑर्डर ${widget.productName} (${widget.quantity} नग) यशस्वीरित्या प्लेस झाली.\n\n'
            'एकूण रक्कम: ₹${_grandTotal.toStringAsFixed(0)}\n'
            'पेमेंट: $_paymentMethod',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
              child: const Text('ऑर्डर ट्रॅक करा'),
            ),
          ],
        ),
      );
    }
  }

  Widget _infoRow(String label, String value, {bool bold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: bold ? 15 : 14, color: AppColors.textDark)),
          Text(value, style: TextStyle(fontSize: bold ? 16 : 14, fontWeight: bold ? FontWeight.bold : FontWeight.w600, color: color ?? AppColors.textDark)),
        ],
      ),
    );
  }

  Widget _buildCartSplitCard() {
    final groups = _groupedByModule;
    if (groups.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.orange.shade800, size: 20),
              const SizedBox(width: 8),
              Text('तुमची ऑर्डर ${groups.length} भागांमध्ये विभागली जाईल', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange.shade900, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          ...groups.entries.map((e) {
            final total = _itemTotalForModule(e.value);
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Icon(_moduleIcon(e.key), color: AppColors.primaryBlue, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        Text(_moduleDelivery(e.key), style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                      ],
                    ),
                  ),
                  Text('₹${total.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProductInfo() {
    if (widget.isCartMode) {
      final groups = _groupedByModule;
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('वस्तूंची माहिती', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...groups.entries.map((e) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.key, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue, fontSize: 13)),
                    ...e.value.map((item) => Text('• ${item['name']} × ${item['qty']} — ₹${((item['price'] as num).toDouble() * (item['qty'] as num).toInt()).toStringAsFixed(0)}', style: const TextStyle(fontSize: 12))),
                  ],
                ),
              );
            }),
          ],
        ),
      );
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('वस्तूची माहिती', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _infoRow('वस्तू', widget.productName),
          _infoRow('विक्रेता', widget.sellerName),
          _infoRow('संख्या', '${widget.quantity}'),
          _infoRow('किंमत', '₹${widget.unitPrice.toStringAsFixed(0)}'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('चेकआउट'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.isCartMode) ...[
              _buildCartSplitCard(),
              const SizedBox(height: 12),
            ],
            _buildProductInfo(),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('डिलिव्हरी', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _infoRow('डिलिव्हरी चार्ज', '₹${_deliveryCharge.toStringAsFixed(0)}'),
                  const Text('(वजन/पिनकोडनुसार — डमी)', style: TextStyle(fontSize: 11, color: AppColors.textLight)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.stars, color: Colors.amber, size: 20),
                          const SizedBox(width: 6),
                          Text('Reward Points ($_rewardPoints pts)', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Switch(value: _useRewardPoints, activeThumbColor: Colors.amber, onChanged: _toggleRewardPoints),
                    ],
                  ),
                  if (_useRewardPoints)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('वापरले: $_usedPoints pts (₹$_usedPoints)', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('पेमेंट पद्धत', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  RadioListTile<String>(title: const Text('UPI'), value: 'UPI', groupValue: _paymentMethod, activeColor: AppColors.primaryBlue, onChanged: (v) => setState(() => _paymentMethod = v!), contentPadding: EdgeInsets.zero, dense: true),
                  RadioListTile<String>(title: const Text('Card'), value: 'Card', groupValue: _paymentMethod, activeColor: AppColors.primaryBlue, onChanged: (v) => setState(() => _paymentMethod = v!), contentPadding: EdgeInsets.zero, dense: true),
                  RadioListTile<String>(title: const Text('NetBanking'), value: 'NetBanking', groupValue: _paymentMethod, activeColor: AppColors.primaryBlue, onChanged: (v) => setState(() => _paymentMethod = v!), contentPadding: EdgeInsets.zero, dense: true),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  _infoRow('वस्तूंची एकूण', '₹${_itemTotal.toStringAsFixed(0)}'),
                  _infoRow('डिलिव्हरी चार्ज', '₹${_deliveryCharge.toStringAsFixed(0)}'),
                  if (_useRewardPoints) _infoRow('Reward Discount', '-₹${_rewardDiscount.toStringAsFixed(0)}', color: Colors.green),
                  const Divider(),
                  _infoRow('एकूण रक्कम', '₹${_grandTotal.toStringAsFixed(0)}', bold: true, color: AppColors.primaryBlue),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.successGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('ऑर्डर करा', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '※ संपूर्ण रक्कम Amole कंपनीकडे जाईल. ऑर्डर return कालावधी (7 दिवस) संपल्यानंतर seller ला पेमेंट होईल.',
              style: TextStyle(fontSize: 11, color: AppColors.textLight),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}