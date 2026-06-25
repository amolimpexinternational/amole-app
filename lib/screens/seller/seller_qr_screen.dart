import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerQrScreen extends StatelessWidget {
  const SellerQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('माझा QR Code', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))],
              ),
              child: Column(
                children: [
                  const Text('गणेश किराणा मार्ट', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const Text('AM-IN-MH-PN-411001-S-000001', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                  const SizedBox(height: 20),
                  Container(
                    width: 200, height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryBlue, width: 3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
                          itemCount: 100,
                          itemBuilder: (_, i) => Container(
                            margin: const EdgeInsets.all(1),
                            color: (i % 3 == 0 || i % 7 == 0) ? AppColors.primaryBlue : Colors.transparent,
                          ),
                        ),
                        Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.storefront, color: AppColors.primaryBlue, size: 28),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('हा QR Code स्कॅन करून पैसे पाठवा', style: TextStyle(fontSize: 13, color: AppColors.textLight)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download_outlined),
                    label: const Text('Download करा'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share_outlined),
                    label: const Text('Share करा'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('आजचे QR Payments', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  SizedBox(height: 12),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('एकूण व्यवहार', style: TextStyle(color: AppColors.textLight)),
                    Text('8', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  ]),
                  SizedBox(height: 6),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('एकूण रक्कम', style: TextStyle(color: AppColors.textLight)),
                    Text('₹2,340', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
