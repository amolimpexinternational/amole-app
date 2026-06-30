import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerLoyaltySetupScreen extends StatefulWidget {
  const SellerLoyaltySetupScreen({super.key});
  @override
  State<SellerLoyaltySetupScreen> createState() => _SellerLoyaltySetupScreenState();
}

class _SellerLoyaltySetupScreenState extends State<SellerLoyaltySetupScreen> {
  bool _isEnabled = true;
  double _pointsPerRupee = 1;
  final TextEditingController _minPurchaseController = TextEditingController(text: '100');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Loyalty Points Setup', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.lightGrey)),
              child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Loyalty Program सुरू करा', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 4),
                  const Text('ग्राहकांना खरेदीवर Points मिळतील', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                ])),
                Switch(value: _isEnabled, activeColor: AppColors.primaryBlue, onChanged: (v) => setState(() => _isEnabled = v)),
              ]),
            ),
            const SizedBox(height: 20),
            if (_isEnabled) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.lightGrey)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Points Rate', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    const SizedBox(height: 4),
                    Text('प्रत्येक ₹१०० खरेदीवर किती Points?', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                    const SizedBox(height: 16),
                    Row(children: [
                      Expanded(
                        child: Slider(
                          value: _pointsPerRupee,
                          min: 1,
                          max: 10,
                          divisions: 9,
                          activeColor: AppColors.primaryBlue,
                          label: '${_pointsPerRupee.toInt()} Points',
                          onChanged: (v) => setState(() => _pointsPerRupee = v),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: Text('${_pointsPerRupee.toInt()} pts', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                      ),
                    ]),
                    Text('उदा: ₹100 खरेदीवर ${_pointsPerRupee.toInt()} Points मिळतील', style: const TextStyle(fontSize: 12, color: AppColors.successGreen, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.lightGrey)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('किमान खरेदी रक्कम', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    const SizedBox(height: 4),
                    const Text('Points मिळण्यासाठी किमान किती खरेदी हवी?', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _minPurchaseController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: '₹ ',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: AppColors.primaryOrange.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
                child: Row(children: const [
                  Icon(Icons.info_outline, color: AppColors.primaryOrange),
                  SizedBox(width: 10),
                  Expanded(child: Text('Loyalty Program फक्त Premium Plan मध्ये उपलब्ध आहे', style: TextStyle(fontSize: 12, color: AppColors.textDark))),
                ]),
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('✅ Loyalty Settings Save झाल्या!'), backgroundColor: AppColors.successGreen),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('Save करा', style: TextStyle(color: AppColors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
