import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerDiscountOfferScreen extends StatefulWidget {
  const SellerDiscountOfferScreen({super.key});

  @override
  State<SellerDiscountOfferScreen> createState() =>
      _SellerDiscountOfferScreenState();
}

class _SellerDiscountOfferScreenState
    extends State<SellerDiscountOfferScreen> {
  final TextEditingController _myPriceController =
      TextEditingController(text: "90");
  final TextEditingController _mrpController =
      TextEditingController(text: "100");

  double get mrp => double.tryParse(_mrpController.text) ?? 100;
  double get myPrice => double.tryParse(_myPriceController.text) ?? 90;
  double get discount => mrp > 0 ? ((mrp - myPrice) / mrp * 100) : 0;

  @override
  void dispose() {
    _myPriceController.dispose();
    _mrpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text("Discount Offer"),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("MRP (वस्तूची मूळ किंमत)",
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textLight,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextField(
                  controller: _mrpController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    prefixText: "₹ ",
                    prefixStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColors.primaryBlue, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.primaryBlue, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("माझी किंमत (Seller ला मिळणारी रक्कम)",
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextField(
                  controller: _myPriceController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue),
                  decoration: InputDecoration(
                    prefixText: "₹ ",
                    prefixStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColors.primaryBlue, width: 2),
                    ),
                    helperText: "हे amount तुम्हाला मिळेल",
                    helperStyle:
                        const TextStyle(color: AppColors.successGreen),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (mrp > 0 && myPrice >= 0 && myPrice <= mrp)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.successGreen.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: AppColors.successGreen.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("ग्राहकाला Discount:",
                      style: TextStyle(
                          fontSize: 15, color: AppColors.textDark)),
                  Text(
                    "${discount.toStringAsFixed(1)}%",
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.successGreen),
                  ),
                ],
              ),
            ),
          if (myPrice > mrp)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.errorRed.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "⚠️ माझी किंमत MRP पेक्षा जास्त असू शकत नाही",
                style: TextStyle(color: AppColors.errorRed),
              ),
            ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: myPrice <= mrp && myPrice > 0
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Offer Save झाला! ${discount.toStringAsFixed(1)}% Discount'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              "Save Discount Offer",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
