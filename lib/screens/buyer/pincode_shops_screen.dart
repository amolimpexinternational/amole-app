import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'seller_profile_screen.dart';

class PincodeShopsScreen extends StatelessWidget {
  const PincodeShopsScreen({super.key});

  final List<Map<String, String>> _shops = const [
    {'name': 'श्री गणेश किराणा', 'category': 'किराणा', 'pincode': '411028', 'rating': '4.5', 'distance': '0.3 km'},
    {'name': 'राज मेडिकल', 'category': 'मेडिकल', 'pincode': '411028', 'rating': '4.8', 'distance': '0.5 km'},
    {'name': 'स्वाद हॉटेल', 'category': 'खाद्यपदार्थ', 'pincode': '411028', 'rating': '4.7', 'distance': '0.8 km'},
    {'name': 'फॅशन पॉईंट', 'category': 'कपडे', 'pincode': '411028', 'rating': '4.0', 'distance': '1.0 km'},
    {'name': 'होम डेकोर', 'category': 'घर', 'pincode': '411028', 'rating': '4.2', 'distance': '1.2 km'},
    {'name': 'इलेक्ट्रो शॉप', 'category': 'इलेक्ट्रॉनिक्स', 'pincode': '411028', 'rating': '4.3', 'distance': '1.5 km'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('आपल्या गावातील दुकाने', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Pincode: 411028', style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.primaryBlue, size: 18),
                const SizedBox(width: 8),
                const Text('हडपसर, पुणे — 411028', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined, size: 14),
                  label: const Text('बदला', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _shops.length,
              itemBuilder: (context, index) {
                final shop = _shops[index];
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (_) => SellerProfileScreen(sellerName: shop['name']!, category: shop['category']!),
                  )),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.lightGrey),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 52, height: 52,
                          decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.store_outlined, color: AppColors.primaryBlue, size: 26),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(shop['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                              const SizedBox(height: 4),
                              Text(shop['category']!, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                              const SizedBox(height: 4),
                              Row(children: [
                                const Icon(Icons.star, color: AppColors.primaryOrange, size: 14),
                                const SizedBox(width: 4),
                                Text(shop['rating']!, style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
                                const SizedBox(width: 12),
                                const Icon(Icons.location_on_outlined, color: AppColors.textLight, size: 14),
                                const SizedBox(width: 2),
                                Text(shop['distance']!, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                              ]),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: AppColors.textLight),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
