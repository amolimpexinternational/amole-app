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

  final TextEditingController purchaseController =
      TextEditingController(text: "100");

  final TextEditingController discountController =
      TextEditingController(text: "0");

  final double companyFee = 10.0;

  @override
  Widget build(BuildContext context) {

    double purchase =
        double.tryParse(purchaseController.text) ?? 0;

    double discount =
        double.tryParse(discountController.text) ?? 0;

    double customerPay =
        purchase - (purchase * discount / 100);

    double company =
        customerPay * companyFee / 100;

    double seller =
        customerPay - company;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text("Discount Offer"),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          TextField(
            controller: purchaseController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Purchase Amount",
            ),
            onChanged: (_) => setState(() {}),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: discountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Discount %",
            ),
            onChanged: (_) => setState(() {}),
          ),

          const SizedBox(height: 25),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("ग्राहक देईल:", style: TextStyle(fontSize: 15, color: AppColors.textLight)),
                      Text("₹\${customerPay.toStringAsFixed(0)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("तुम्हाला मिळेल:", style: TextStyle(fontSize: 15, color: AppColors.textLight)),
                      Text("₹\${seller.toStringAsFixed(0)}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.successGreen)),
                    ],
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Offer Save झाला!'), backgroundColor: Colors.green),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
            ),
            child: const Text(
              "Save Discount Offer",
              style: TextStyle(color: Colors.white),
            ),
          ),

        ],
      ),
    );
  }
}
