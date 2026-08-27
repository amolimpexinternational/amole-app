import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class QrPaymentScreen extends StatefulWidget {
  final String sellerName;
  const QrPaymentScreen({super.key, required this.sellerName});

  @override
  State<QrPaymentScreen> createState() => _QrPaymentScreenState();
}

class _QrPaymentScreenState extends State<QrPaymentScreen> {
  final TextEditingController _amountController = TextEditingController();
  bool _useLoyaltyPoints = false;
  int _loyaltyPoints = 245;
  bool _paymentDone = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _makePayment() {
    if (_amountController.text.isEmpty) return;
    setState(() => _paymentDone = true);
  }

  @override
  Widget build(BuildContext context) {
    final int discount = _useLoyaltyPoints ? (_loyaltyPoints > 50 ? 50 : _loyaltyPoints) : 0;
    final double amount = double.tryParse(_amountController.text) ?? 0;
    final double finalAmount = (amount - discount).clamp(0, double.infinity);

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('QR Pay'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: _paymentDone ? _buildSuccess() : _buildPaymentForm(discount, finalAmount),
    );
  }

  Widget _buildPaymentForm(int discount, double finalAmount) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primaryBlue, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.qr_code_2, size: 100, color: AppColors.primaryBlue),
                      const SizedBox(height: 8),
                      Text(widget.sellerName,
                          style: const TextStyle(fontSize: 12, color: AppColors.textLight),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(widget.sellerName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                const Text('Verified Seller ✓',
                    style: TextStyle(fontSize: 13, color: AppColors.successGreen)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('रक्कम टाका (₹)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const SizedBox(height: 10),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    prefixText: '₹ ',
                    prefixStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
                    hintText: '0',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primaryOrange.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: AppColors.primaryOrange, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text('Loyalty Points: $_loyaltyPoints pts (₹$_loyaltyPoints)',
                            style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                      ),
                      Switch(
                        value: _useLoyaltyPoints,
                        onChanged: (val) => setState(() => _useLoyaltyPoints = val),
                        activeColor: AppColors.primaryOrange,
                      ),
                    ],
                  ),
                ),
                if (_useLoyaltyPoints) ...[
                  const SizedBox(height: 8),
                  Text('Points सवलत: -₹$discount',
                      style: const TextStyle(fontSize: 13, color: AppColors.successGreen)),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('रक्कम:', style: TextStyle(color: AppColors.textLight)),
                    Text('₹${(double.tryParse(_amountController.text) ?? 0).toStringAsFixed(0)}',
                        style: const TextStyle(color: AppColors.textDark)),
                  ],
                ),
                if (_useLoyaltyPoints) ...[
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Points सवलत:', style: TextStyle(color: AppColors.textLight)),
                      Text('-₹$discount', style: const TextStyle(color: AppColors.successGreen)),
                    ],
                  ),
                ],
                const Divider(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('एकूण द्यायचे:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    Text('₹${finalAmount.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _amountController.text.isNotEmpty ? _makePayment : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cyan,
                foregroundColor: AppColors.textDark,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                'Pay ₹${finalAmount.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSuccess() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.successGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle, color: AppColors.successGreen, size: 80),
            ),
            const SizedBox(height: 24),
            const Text('Payment यशस्वी!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.successGreen)),
            const SizedBox(height: 8),
            Text(widget.sellerName,
                style: const TextStyle(fontSize: 16, color: AppColors.textLight)),
            const SizedBox(height: 8),
            Text('+${(double.tryParse(_amountController.text) ?? 0) * 0.02 < 1 ? ((double.tryParse(_amountController.text) ?? 0) * 0.02).toStringAsFixed(2) : ((double.tryParse(_amountController.text) ?? 0) * 0.02).toStringAsFixed(0)} Loyalty Points मिळाले! (2%)',
                style: const TextStyle(fontSize: 14, color: AppColors.primaryOrange, fontWeight: FontWeight.w600)),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text('Home वर जा'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
