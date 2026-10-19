import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/parcel_data.dart';

class ParcelStatusScreen extends StatefulWidget {
  final Map<String, dynamic> request;
  const ParcelStatusScreen({super.key, required this.request});

  @override
  State<ParcelStatusScreen> createState() => _ParcelStatusScreenState();
}

class _ParcelStatusScreenState extends State<ParcelStatusScreen> {
  // 0 = सूचना गेली, 1 = कार्गो सेलरने स्वीकारले, 2 = cancel
  int _stage = 0;

  Widget _box({required Widget child, Color? color}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.request;
    final vehicle = ParcelData.labelOf(r['vehicle'] as String);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('📦 पार्सल #${r['id']}',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _stage == 0
                      ? '⏳ जवळचे कार्गो वाहन शोधत आहोत...'
                      : _stage == 1
                          ? '✅ कार्गो वाहनाने तुमची Requirement स्वीकारली'
                          : '❌ Requirement cancel झाली',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark),
                ),
                if (_stage == 0) ...[
                  const SizedBox(height: 4),
                  const Text(
                    'तुमच्या pickup च्या 10 km मधील नोंदणीकृत पार्सल कार्गो सेलरना सूचना गेली आहे. '
                    'पहिला जो स्वीकारेल त्याला काम मिळेल.',
                    style:
                        TextStyle(fontSize: 12, color: AppColors.textLight),
                  ),
                ],
              ],
            ),
          ),
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$vehicle · ${(r['km'] as double).toStringAsFixed(0)} km',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                const SizedBox(height: 6),
                Text('पार्सल: ${r['desc']}',
                    style: const TextStyle(fontSize: 13)),
                Text('वजन: ${r['weight']} kg · डायमेन्शन: ${r['dims']}',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textLight)),
                const SizedBox(height: 6),
                Text('कुठून: ${r['pickup']}',
                    style: const TextStyle(fontSize: 13)),
                Text('कुठे: ${r['drop']}',
                    style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 6),
                Text('अंदाजे भाडे: ₹${r['fare']}',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue)),
              ],
            ),
          ),
          if (_stage == 1)
            _box(
              color: Colors.green.withValues(alpha: 0.08),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('कार्गो सेलर',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark)),
                  SizedBox(height: 6),
                  Text('श्री साई कार्गो सर्व्हिस · 4.6 ⭐'),
                  Text('मोबाईल: 9844000001',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue)),
                  SizedBox(height: 6),
                  Text(
                    'कार्गो सेलरला तुमचा नंबर दिसला आहे. वेळ आणि अंतिम भाडे फोनवर खात्री करून घ्या. '
                    'बाकीच्यांची सूचना बंद झाली आहे.',
                    style:
                        TextStyle(fontSize: 12, color: AppColors.textLight),
                  ),
                ],
              ),
            ),
          if (_stage == 0) ...[
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => setState(() => _stage = 1),
                child: const Text('Demo: पहिल्या कार्गो सेलरने स्वीकारले'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => setState(() => _stage = 2),
                child: const Text('Requirement cancel करा',
                    style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}