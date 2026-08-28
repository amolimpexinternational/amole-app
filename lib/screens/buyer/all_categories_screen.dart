import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'pincode_shops_screen.dart';
import 'seller_profile_screen.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  static const List<Map<String, dynamic>> _categories = [
    {'icon': Icons.shopping_basket_outlined, 'label': 'किराणा'},
    {'icon': Icons.electrical_services_outlined, 'label': 'इलेक्ट्रॉनिक्स'},
    {'icon': Icons.local_hospital_outlined, 'label': 'मेडिकल'},
    {'icon': Icons.checkroom_outlined, 'label': 'कपडे'},
    {'icon': Icons.restaurant_outlined, 'label': 'खाद्यपदार्थ'},
    {'icon': Icons.home_outlined, 'label': 'घर'},
    {'icon': Icons.directions_bike_outlined, 'label': 'वाहन'},
    {'icon': Icons.school_outlined, 'label': 'शिक्षण'},
    {'icon': Icons.spa_outlined, 'label': 'सौंदर्य'},
    {'icon': Icons.sports_soccer_outlined, 'label': 'खेळ'},
    {'icon': Icons.pets_outlined, 'label': 'पाळीव'},
    {'icon': Icons.more_horiz_outlined, 'label': 'इतर'},
  ];

  // TODO (Stage 3 - Backend): replace with Firestore query of all sellers
  // in the buyer's pincode.
  static const List<Map<String, String>> _allShops = [
    {'name': 'श्री गणेश किराणा', 'category': 'किराणा', 'rating': '4.5', 'distance': '0.3 km'},
    {'name': 'राज मेडिकल', 'category': 'मेडिकल', 'rating': '4.8', 'distance': '0.5 km'},
    {'name': 'स्वाद हॉटेल', 'category': 'खाद्यपदार्थ', 'rating': '4.7', 'distance': '0.8 km'},
    {'name': 'फॅशन पॉईंट', 'category': 'कपडे', 'rating': '4.0', 'distance': '1.0 km'},
    {'name': 'होम डेकोर', 'category': 'घर', 'rating': '4.2', 'distance': '1.2 km'},
    {'name': 'इलेक्ट्रो शॉप', 'category': 'इलेक्ट्रॉनिक्स', 'rating': '4.3', 'distance': '1.5 km'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('सर्व कॅटेगिरी व दुकाने', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('श्रेणी', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.85,
              crossAxisSpacing: 10,
              mainAxisSpacing: 14,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final c = _categories[index];
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (_) => PincodeShopsScreen(category: c['label'] as String),
                )),
                child: Column(
                  children: [
                    Container(
                      width: 56, height: 56,
                      decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
                      child: Icon(c['icon'] as IconData, color: AppColors.primaryBlue, size: 28),
                    ),
                    const SizedBox(height: 6),
                    Text(c['label'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textDark), textAlign: TextAlign.center),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          const Text('सर्व दुकाने', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _allShops.length,
            itemBuilder: (context, index) {
              final shop = _allShops[index];
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
        ],
      ),
    );
  }
}
