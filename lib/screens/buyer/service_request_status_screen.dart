import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class ServiceRequestStatusScreen extends StatefulWidget {
  final Map<String, dynamic> request;
  const ServiceRequestStatusScreen({super.key, required this.request});

  @override
  State<ServiceRequestStatusScreen> createState() =>
      _ServiceRequestStatusScreenState();
}

class _ServiceRequestStatusScreenState
    extends State<ServiceRequestStatusScreen> {
  static const String _code = '7359';

  // 0 = सूचना गेली, 1 = प्रोव्हायडर मिळाला, 2 = काम पूर्ण (रिपोर्ट), 3 = कोड दिला
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

  Widget _row(String a, String b, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(a, style: const TextStyle(fontSize: 13)),
          Text(b,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  String get _title {
    switch (_stage) {
      case 0:
        return '⏳ प्रोव्हायडरच्या उत्तराची वाट पाहत आहोत';
      case 1:
        return '✅ प्रोव्हायडरने तुमची Requirement स्वीकारली';
      case 2:
        return '🔧 काम पूर्ण झाले, रिपोर्ट आला';
      default:
        return '🎉 काम पूर्ण झाले';
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.request;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Requirement #${r['id']}',
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
                Text(_title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                if (_stage == 0) ...[
                  const SizedBox(height: 4),
                  const Text(
                    'तुमच्या ठिकाणाच्या 20 km मधील प्रोव्हायडरना सूचना गेली आहे. '
                    'पहिला जो स्वीकारेल त्याला काम मिळेल.',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textLight),
                  ),
                ],
              ],
            ),
          ),
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    r['category'] == '' ? 'तुमची Requirement' : '${r['category']}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                const SizedBox(height: 6),
                Text(r['desc'] as String,
                    style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 8),
                Text(
                  'Quantity: ${r['qty']} · कधी: ${r['when']}'
                  '${(r['budget'] as String).isEmpty ? '' : ' · बजेट ₹${r['budget']}'}',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textLight),
                ),
                Text('ठिकाण: ${r['location']}',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textLight)),
                Text(
                  'मीडिया: ${r['video'] == true ? '1 व्हिडिओ' : '${r['photos']} फोटो'}',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textLight),
                ),
              ],
            ),
          ),
          if (_stage >= 1)
            _box(
              color: Colors.green.withValues(alpha: 0.08),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('प्रोव्हायडर',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark)),
                  SizedBox(height: 6),
                  Text('गणेश प्लंबिंग सर्व्हिस · 4.7 ⭐'),
                  Text('मोबाईल: 9833000001',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue)),
                  SizedBox(height: 6),
                  Text(
                    'प्रोव्हायडरला तुमचा नंबर दिसला आहे. बाकीच्यांची सूचना बंद झाली आहे.',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textLight),
                  ),
                ],
              ),
            ),
          if (_stage == 2)
            _box(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('सर्व्हिस रिपोर्ट',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark)),
                  const SizedBox(height: 6),
                  const Text('काय काम केले: बाथरूमच्या नळाची गळती दुरुस्त केली',
                      style: TextStyle(fontSize: 13)),
                  const Text('बदललेले spare part: वॉशर, पॅकिंग',
                      style: TextStyle(fontSize: 13)),
                  const Text('सूचना: 2 दिवस नळ जोरात उघडू नका',
                      style: TextStyle(fontSize: 13)),
                  const Text('फोटो: 2 जोडले',
                      style: TextStyle(
                          fontSize: 12, color: AppColors.textLight)),
                  const Divider(height: 22),
                  const Text('बिल',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark)),
                  _row('सेवा शुल्क', '₹350'),
                  _row('Spare part', '₹40'),
                  const Divider(height: 18),
                  _row('एकूण', '₹390', bold: true),
                ],
              ),
            ),
          if (_stage == 2)
            _box(
              color: AppColors.primaryBlue.withValues(alpha: 0.08),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('तुमचा पूर्णत्व कोड',
                      style: TextStyle(
                          fontSize: 13, color: AppColors.textLight)),
                  SizedBox(height: 4),
                  Text(_code,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 6,
                          color: AppColors.textDark)),
                  SizedBox(height: 4),
                  Text(
                    'काम तुमच्या मनासारखे झाले असेल तरच हा कोड प्रोव्हायडरला सांगा. '
                    'त्यानंतर काम पूर्ण मानले जाईल.',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textLight),
                  ),
                ],
              ),
            ),
          if (_stage == 0)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => setState(() => _stage = 1),
                child: const Text('Demo: पहिल्या प्रोव्हायडरने स्वीकारले'),
              ),
            ),
          if (_stage == 1)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => setState(() => _stage = 2),
                child: const Text('Demo: प्रोव्हायडरने काम पूर्ण केले'),
              ),
            ),
          if (_stage == 2)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => setState(() => _stage = 3),
                child: const Text('Demo: कोड प्रोव्हायडरला दिला'),
              ),
            ),
        ],
      ),
    );
  }
}