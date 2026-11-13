import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'order_tracking_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final String productName;
  final double unitPrice;
  final int quantity;
  final String sellerName;
  final String productId;

  const CheckoutScreen({
    super.key,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.sellerName,
    required this.productId,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // === Reward Points (डमी — 245 pts) ===
  int _rewardPoints = 245;
  bool _useRewardPoints = false;
  int _usedPoints = 0;

  // === पेमेंट पद्धत ===
  String _paymentMethod = 'UPI';

  // === डिलिव्हरी फी (डमी — वजन/पिनकोडनुसार) ===
  double get _deliveryCharge {
    // डमी: ₹45 (नंतर Stage 3 मध्ये Shiprocket API)
    return 45.0;
  }

  double get _itemTotal => widget.unitPrice * widget.quantity;

  double get _rewardDiscount => _useRewardPoints ? _usedPoints.toDouble() : 0.0;

  double get _grandTotal => _itemTotal + _deliveryCharge - _rewardDiscount;

  void _toggleRewardPoints(bool value) {
    setState(() {
      _useRewardPoints = value;
      if (value) {
        _usedPoints = _rewardPoints < _itemTotal
            ? _rewardPoints
            : _itemTotal.toInt();
      } else {
        _usedPoints = 0;
      }
    });
  }

  void _placeOrder() {
    if (_grandTotal < 0) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('ऑर्डर यशस्वी ✅'),
        content: Text(
          'तुमची ऑर्डर ${widget.productName} (${widget.quantity} नग) '
          'यशस्वीरित्या प्लेस झाली.\n\n'
          'एकूण रक्कम: ₹${_grandTotal.toStringAsFixed(0)}\n'
          'पेमेंट: $_paymentMethod\n\n'
          'ऑर्डर ट्रॅकिंगसाठी पुढे जा.',
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

  Widget _infoRow(String label, String value, {bool bold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: bold ? 15 : 14, color: AppColors.textDark)),
          Text(
            value,
            style: TextStyle(
              fontSize: bold ? 16 : 14,
              fontWeight: bold ? FontWeight.bold : FontWeight.w600,
              color: color ?? AppColors.textDark,
            ),
          ),
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
            // === वस्तूची माहिती ===
            Container(
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
            ),
            const SizedBox(height: 12),

            // === डिलिव्हरी फी ===
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

            // === Reward Points ===
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
                          Text('Reward Points ($_rewardPoints pts)',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Switch(
                        value: _useRewardPoints,
                        activeThumbColor: Colors.amber,
                        onChanged: _toggleRewardPoints,
                      ),
                    ],
                  ),
                  if (_useRewardPoints)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'वापरले: $_usedPoints pts (₹$_usedPoints)',
                        style: const TextStyle(fontSize: 12, color: AppColors.textLight),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // === पेमेंट पद्धत ===
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('पेमेंट पद्धत', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  RadioListTile<String>(
                    title: const Text('UPI'),
                    value: 'UPI',
                    groupValue: _paymentMethod,
                    activeColor: AppColors.primaryBlue,
                    onChanged: (v) => setState(() => _paymentMethod = v!),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  RadioListTile<String>(
                    title: const Text('Card'),
                    value: 'Card',
                    groupValue: _paymentMethod,
                    activeColor: AppColors.primaryBlue,
                    onChanged: (v) => setState(() => _paymentMethod = v!),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  RadioListTile<String>(
                    title: const Text('NetBanking'),
                    value: 'NetBanking',
                    groupValue: _paymentMethod,
                    activeColor: AppColors.primaryBlue,
                    onChanged: (v) => setState(() => _paymentMethod = v!),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // === एकूण रक्कम ===
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

            // === ऑर्डर करा ===
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.successGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'ऑर्डर करा',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
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