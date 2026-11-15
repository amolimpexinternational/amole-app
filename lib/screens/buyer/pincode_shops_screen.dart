import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'seller_profile_screen.dart';

class PincodeShopsScreen extends StatefulWidget {
  final String? category;
  const PincodeShopsScreen({super.key, this.category});

  @override
  State<PincodeShopsScreen> createState() => _PincodeShopsScreenState();
}

class _PincodeShopsScreenState extends State<PincodeShopsScreen> {
  // ✅ State variables — बदलता येतील
  String _buyerPincode = '411028';
  String _buyerTaluka = 'हवेली';
  String _buyerDistrict = 'पुणे';

  final List<Map<String, String>> _shops = const [
    {'name': 'श्री गणेश किराणा', 'category': 'किराणा', 'pincode': '411028', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.5', 'distance': '0.3 km'},
    {'name': 'राज मेडिकल', 'category': 'मेडिकल', 'pincode': '411028', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.8', 'distance': '0.5 km'},
    {'name': 'हडपसर भाजी मार्केट', 'category': 'भाजीपाला', 'pincode': '411028', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.6', 'distance': '0.6 km'},
    {'name': 'स्वाद हॉटेल', 'category': 'खाद्यपदार्थ', 'pincode': '411028', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.7', 'distance': '0.8 km'},
    {'name': 'फॅशन पॉईंट', 'category': 'कपडे', 'pincode': '411028', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.0', 'distance': '1.0 km'},
    {'name': 'होम डेकोर', 'category': 'घर', 'pincode': '411028', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.2', 'distance': '1.2 km'},
    {'name': 'इलेक्ट्रो शॉप', 'category': 'इलेक्ट्रॉनिक्स', 'pincode': '411028', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.3', 'distance': '1.5 km'},
    {'name': 'सह्याद्री किराणा', 'category': 'किराणा', 'pincode': '411014', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.4', 'distance': '4.2 km'},
    {'name': 'ताजा भाजी मंडई', 'category': 'भाजीपाला', 'pincode': '411014', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.3', 'distance': '4.8 km'},
    {'name': 'आरोग्य मेडिकल', 'category': 'मेडिकल', 'pincode': '411014', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.6', 'distance': '5.0 km'},
    {'name': 'चव हॉटेल', 'category': 'खाद्यपदार्थ', 'pincode': '412308', 'taluka': 'हवेली', 'district': 'पुणे', 'rating': '4.1', 'distance': '8.5 km'},
    {'name': 'मुळशी किराणा स्टोअर', 'category': 'किराणा', 'pincode': '412115', 'taluka': 'मुळशी', 'district': 'पुणे', 'rating': '4.2', 'distance': '32 km'},
    {'name': 'शेतकरी भाजी केंद्र', 'category': 'भाजीपाला', 'pincode': '412115', 'taluka': 'मुळशी', 'district': 'पुणे', 'rating': '4.4', 'distance': '35 km'},
    {'name': 'जुन्नर कपडे', 'category': 'कपडे', 'pincode': '410502', 'taluka': 'जुन्नर', 'district': 'पुणे', 'rating': '4.0', 'distance': '85 km'},
    {'name': 'बारामती मेडिकल', 'category': 'मेडिकल', 'pincode': '413102', 'taluka': 'बारामती', 'district': 'पुणे', 'rating': '4.5', 'distance': '98 km'},
    // ✅ नवीन — मुंबई/नाशिक (डेमो)
    {'name': 'अंधेरी किराणा', 'category': 'किराणा', 'pincode': '400053', 'taluka': 'अंधेरी', 'district': 'मुंबई', 'rating': '4.3', 'distance': '1.2 km'},
    {'name': 'बोरिवली मेडिकल', 'category': 'मेडिकल', 'pincode': '400066', 'taluka': 'बोरिवली', 'district': 'मुंबई', 'rating': '4.5', 'distance': '2.0 km'},
    {'name': 'नाशिक किराणा', 'category': 'किराणा', 'pincode': '422001', 'taluka': 'नाशिक', 'district': 'नाशिक', 'rating': '4.2', 'distance': '1.5 km'},
  ];

  // ✅ जिल्हा → तालुके
  final Map<String, List<String>> _districtTalukas = {
    'पुणे': ['हवेली', 'मुळशी', 'जुन्नर', 'बारामती'],
    'मुंबई': ['अंधेरी', 'बोरिवली', 'दादर'],
    'नाशिक': ['नाशिक', 'मालेगाव', 'सिन्नर'],
  };

  List<String> get _districts => _districtTalukas.keys.toList();
  List<String> get _talukas => _districtTalukas[_buyerDistrict] ?? [];

  int _level(Map<String, String> s) {
    if (s['pincode'] == _buyerPincode) return 0;
    if (s['taluka'] == _buyerTaluka && s['district'] == _buyerDistrict) return 1;
    if (s['district'] == _buyerDistrict) return 2;
    return 3;
  }

  double _km(Map<String, String> s) {
    return double.tryParse(s['distance']!.replaceAll('km', '').trim()) ?? 9999;
  }

  // ✅ Location बदलण्याचा Dialog
  void _showChangeLocationDialog() {
    final pincodeCtrl = TextEditingController(text: _buyerPincode);
    String tempDistrict = _buyerDistrict;
    String tempTaluka = _buyerTaluka;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          final talukas = _districtTalukas[tempDistrict] ?? [];
          // जर सध्याचा तालुका नवीन जिल्ह्यात नसेल तर पहिला निवडा
          if (!talukas.contains(tempTaluka) && talukas.isNotEmpty) {
            tempTaluka = talukas.first;
          }
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Row(
              children: [
                Icon(Icons.location_on, color: AppColors.primaryBlue),
                SizedBox(width: 8),
                Text('स्थान बदला'),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: pincodeCtrl,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'पिनकोड',
                      prefixIcon: Icon(Icons.pin_drop_outlined),
                      border: OutlineInputBorder(),
                      counterText: '',
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: tempDistrict,
                    decoration: const InputDecoration(
                      labelText: 'जिल्हा',
                      prefixIcon: Icon(Icons.location_city),
                      border: OutlineInputBorder(),
                    ),
                    items: _districts.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                    onChanged: (v) {
                      if (v != null) {
                        setDialogState(() {
                          tempDistrict = v;
                          tempTaluka = _districtTalukas[v]!.first;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: tempTaluka,
                    decoration: const InputDecoration(
                      labelText: 'तालुका',
                      prefixIcon: Icon(Icons.map_outlined),
                      border: OutlineInputBorder(),
                    ),
                    items: talukas.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                    onChanged: (v) {
                      if (v != null) setDialogState(() => tempTaluka = v);
                    },
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: AppColors.primaryBlue, size: 16),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'स्थान बदलल्यावर त्या परिसरातील दुकाने दिसतील',
                            style: TextStyle(fontSize: 11, color: AppColors.textDark),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('रद्द करा'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (pincodeCtrl.text.trim().length != 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('६ अंकी पिनकोड टाका'), backgroundColor: Colors.red),
                    );
                    return;
                  }
                  setState(() {
                    _buyerPincode = pincodeCtrl.text.trim();
                    _buyerDistrict = tempDistrict;
                    _buyerTaluka = tempTaluka;
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('स्थान बदललं: $tempTaluka, $tempDistrict — ${pincodeCtrl.text.trim()}'),
                      backgroundColor: AppColors.successGreen,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
                child: const Text('बदला', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _shops
        .where((s) => widget.category == null || s['category'] == widget.category)
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
              widget.category == null ? 'आपल्या गावातील दुकाने' : '${widget.category} — दुकाने',
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('Pincode: $_buyerPincode', style: const TextStyle(color: Colors.white70, fontSize: 12)),
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
                Expanded(
                  child: Text(
                    '$_buyerTaluka, $_buyerDistrict — $_buyerPincode',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton.icon(
                  onPressed: _showChangeLocationDialog,
                  icon: const Icon(Icons.edit_outlined, size: 14),
                  label: const Text('बदला', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'या परिसरात सध्या कोणतंही दुकान नाही.\n\n"बदला" वर क्लिक करून दुसरं स्थान निवडा.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.textLight),
                      ),
                    ),
                  )
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