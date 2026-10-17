import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'seller_profile_screen.dart';

class PincodeShopsScreen extends StatelessWidget {
  final String? category;
  const PincodeShopsScreen({super.key, this.category});

  // Demo: Buyer चे ठिकाण (खरा buyer profile Stage 3 मध्ये येईल)
  static const String _buyerPincode = '411028';
  static const String _buyerTaluka = 'हवेली';
  static const String _buyerDistrict = 'पुणे';

  final List<Map<String, String>> _shops = const [
    // --- Buyer च्या पिनकोडचे ---
    {'name': 'श्री गणेश किराणा', 'category': 'किराणा', 'pincode': '411028', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.5', 'distance': '0.3 km'},
    {'name': 'राज मेडिकल', 'category': 'मेडिकल', 'pincode': '411028', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.8', 'distance': '0.5 km'},
    {'name': 'हडपसर भाजी मार्केट', 'category': 'भाजीपाला', 'pincode': '411028', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.6', 'distance': '0.6 km'},
    {'name': 'स्वाद हॉटेल', 'category': 'खाद्यपदार्थ', 'pincode': '411028', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.7', 'distance': '0.8 km'},
    {'name': 'फॅशन पॉईंट', 'category': 'कपडे', 'pincode': '411028', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.0', 'distance': '1.0 km'},
    {'name': 'होम डेकोर', 'category': 'घर', 'pincode': '411028', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.2', 'distance': '1.2 km'},
    {'name': 'इलेक्ट्रो शॉप', 'category': 'इलेक्ट्रॉनिक्स', 'pincode': '411028', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.3', 'distance': '1.5 km'},
    // --- Buyer च्या तालुक्याचे (दुसरा पिनकोड) ---
    {'name': 'सह्याद्री किराणा', 'category': 'किराणा', 'pincode': '411014', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.4', 'distance': '4.2 km'},
    {'name': 'ताजा भाजी मंडई', 'category': 'भाजीपाला', 'pincode': '411014', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.3', 'distance': '4.8 km'},
    {'name': 'आरोग्य मेडिकल', 'category': 'मेडिकल', 'pincode': '411014', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.6', 'distance': '5.0 km'},
    {'name': 'चव हॉटेल', 'category': 'खाद्यपदार्थ', 'pincode': '412308', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.1', 'distance': '8.5 km'},
    // --- Buyer च्या जिल्ह्याचे (दुसरा तालुका) ---
    {'name': 'मुळशी किराणा स्टोअर', 'category': 'किराणा', 'pincode': '412115', 'taluka': 'मुळशी', 'district': 'पुणे', 'rating': '4.2', 'distance': '32 km'},
    {'name': 'शेतकरी भाजी केंद्र', 'category': 'भाजीपाला', 'pincode': '412115', 'taluka': 'मुळशी', 'district': 'पुणे', 'rating': '4.4', 'distance': '35 km'},
    {'name': 'जुन्नर कपडे', 'category': 'कपडे', 'pincode': '410502', 'taluka': 'जुन्नर', 'district': 'पुणे', 'rating': '4.0', 'distance': '85 km'},
    {'name': 'बारामती मेडिकल', 'category': 'मेडिकल', 'pincode': '413102', 'taluka': 'बारामती', 'district': 'पुणे', 'rating': '4.5', 'distance': '98 km'},
  ];

  // 0 = Buyer चा पिनकोड, 1 = त्याचा तालुका, 2 = त्याचा जिल्हा, 3 = जिल्ह्याबाहेर
  int _level(Map<String, String> s) {
    if (s['pincode'] == _buyerPincode) return 0;
    if (s['taluka'] == _buyerTaluka && s['district'] == _buyerDistrict) return 1;
    if (s['district'] == _buyerDistrict) return 2;
    return 3;
  }

  double _km(Map<String, String> s) {
    return double.tryParse(s['distance']!.replaceAll('km', '').trim()) ?? 9999;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _shops
        .where((s) => category == null || s['category'] == category)
        .where((s) => _level(s) < 3)
        .toList()
      ..sort((a, b) {
        final l = _level(a).compareTo(_level(b));
        return l != 0 ? l : _km(a).compareTo(_km(b));
      });

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category == null ? 'आपल्या गावातील दुकाने' : '$category — दुकाने',
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text('Pincode: 411028', style: TextStyle(color: Colors.white70, fontSize: 12)),
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
            child: filtered.isEmpty
                ? const Center(child: Text('या कॅटेगिरीत सध्या कोणतंही दुकान नाही', style: TextStyle(color: AppColors.textLight)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final shop = filtered[index];
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
