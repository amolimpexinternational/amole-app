import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class DeliveryBoyHomeScreen extends StatefulWidget {
  const DeliveryBoyHomeScreen({super.key});

  @override
  State<DeliveryBoyHomeScreen> createState() => _DeliveryBoyHomeScreenState();
}

class _DeliveryBoyHomeScreenState extends State<DeliveryBoyHomeScreen> {
  static const double _radiusKm = 5;

  bool _online = false;
  String _stand = 'हडपसर';
  final List<String> _stands = const ['हडपसर', 'मगरपट्टा', 'कोरेगाव पार्क'];

  // Demo ऑर्डर. kmFromStand = निवडलेल्या stand पासून pickup चे अंतर.
  // deliveryKm = pickup पासून ग्राहकापर्यंतचे अंतर (यावरून कमाई ठरते).
  // status: new / accepted / rejected
  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'ZP201', 'type': 'हॉटेल फूड', 'pickup': 'स्वाद हॉटेल',
      'drop': 'रमेश पाटील, गल्ली 4', 'deliveryKm': 2.1,
      'items': 'मिसळ पाव x2, वडापाव x2',
      'kmFromStand': {'हडपसर': 0.8, 'मगरपट्टा': 3.2, 'कोरेगाव पार्क': 9.0},
      'status': 'new',
    },
    {
      'id': 'ZP202', 'type': 'दुकान वस्तू', 'pickup': 'श्री गणेश किराणा',
      'drop': 'सुनीता जाधव, साई नगर', 'deliveryKm': 4.3,
      'items': 'तांदूळ 5kg x1, साखर 1kg x2',
      'kmFromStand': {'हडपसर': 0.3, 'मगरपट्टा': 2.5, 'कोरेगाव पार्क': 7.5},
      'status': 'new',
    },
    {
      'id': 'ZP203', 'type': 'लोकल पार्सल', 'pickup': 'अजय शिंदे, शिवाजी चौक',
      'drop': 'विकास कुलकर्णी, मगरपट्टा', 'deliveryKm': 6.4,
      'items': 'लहान पार्सल (कागदपत्रे)',
      'kmFromStand': {'हडपसर': 4.2, 'मगरपट्टा': 1.0, 'कोरेगाव पार्क': 3.0},
      'status': 'new',
    },
    {
      'id': 'ZP204', 'type': 'दुकान वस्तू', 'pickup': 'राज मेडिकल',
      'drop': 'प्रिया देशमुख, गंगा नगर', 'deliveryKm': 8.8,
      'items': 'ORS पावडर x3',
      'kmFromStand': {'हडपसर': 1.1, 'मगरपट्टा': 5.9, 'कोरेगाव पार्क': 6.2},
      'status': 'new',
    },
  ];

  // कमाई chart: 3 km ₹30, 5 km ₹45, 7 km ₹60, 10 km ₹100
  int _earning(double km) {
    if (km <= 3) return 30;
    if (km <= 5) return 45;
    if (km <= 7) return 60;
    return 100;
  }

  // निवडलेल्या stand च्या 5 km मधले, जवळचे आधी
  List<Map<String, dynamic>> get _visible {
    final list = _orders.where((o) {
      if (o['status'] == 'rejected') return false;
      final m = o['kmFromStand'] as Map<String, double>;
      return (m[_stand] ?? 999) <= _radiusKm;
    }).toList();
    list.sort((a, b) {
      final ma = (a['kmFromStand'] as Map<String, double>)[_stand] ?? 999;
      final mb = (b['kmFromStand'] as Map<String, double>)[_stand] ?? 999;
      return ma.compareTo(mb);
    });
    return list;
  }

  int get _todayEarning {
    int sum = 0;
    for (final o in _orders) {
      if (o['status'] == 'accepted') {
        sum += _earning(o['deliveryKm'] as double);
      }
    }
    return sum;
  }

  void _decide(Map<String, dynamic> o, bool accept) {
    setState(() => o['status'] = accept ? 'accepted' : 'rejected');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(accept
            ? 'ऑर्डर स्वीकारली. दुकानदार आणि ग्राहकाला कळवले.'
            : 'ऑर्डर नाकारली.'),
        backgroundColor: accept ? Colors.green : Colors.red,
      ),
    );
  }

  Color _typeColor(String t) {
    if (t == 'हॉटेल फूड') return const Color(0xFFEF6C00);
    if (t == 'लोकल पार्सल') return const Color(0xFF6D4C41);
    return const Color(0xFF2E7D32);
  }

  Widget _orderCard(Map<String, dynamic> o) {
    final fromStand =
        (o['kmFromStand'] as Map<String, double>)[_stand] ?? 0.0;
    final earn = _earning(o['deliveryKm'] as double);
    final isNew = o['status'] == 'new';
    final type = o['type'] as String;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _typeColor(type).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(type,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _typeColor(type))),
              ),
              Text('#${o['id']}',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textLight)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.store_outlined,
                  size: 18, color: AppColors.primaryBlue),
              const SizedBox(width: 6),
              Expanded(
                child: Text('कुठून: ${o['pickup']}',
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.textDark)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 18, color: Colors.red),
              const SizedBox(width: 6),
              Expanded(
                child: Text('कुठे: ${o['drop']}',
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.textDark)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(o['items'] as String,
              style:
                  const TextStyle(fontSize: 12, color: AppColors.textLight)),
          const SizedBox(height: 6),
          Text(
            'तुमच्या stand पासून $fromStand km · डिलिव्हरी अंतर ${o['deliveryKm']} km',
            style: const TextStyle(fontSize: 12, color: AppColors.textLight),
          ),
          const SizedBox(height: 4),
          Text('तुमची कमाई: ₹$earn',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          const SizedBox(height: 10),
          if (isNew)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _decide(o, false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                    child: const Text('Reject'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _decide(o, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Accept'),
                  ),
                ),
              ],
            )
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                '✅ दोघांनी स्वीकारले. ग्राहकाला confirmation आणि दुकानदार व तुमचा नंबर गेला.\n'
                'ग्राहक: 9800000001 · दुकानदार: 9811111111',
                style: TextStyle(fontSize: 12, color: AppColors.textDark),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _visible;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('🛵 डिलिव्हरी बॉय',
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.lightGrey),
            ),
            child: SwitchListTile(
              value: _online,
              onChanged: (v) => setState(() => _online = v),
              title: Text(_online ? 'Status: ON' : 'Status: OFF',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              subtitle: Text(
                _online
                    ? 'तुमच्या stand च्या 5 km मधल्या ऑर्डरच्या सूचना येतील.'
                    : 'ऑर्डर घेण्यासाठी ON करा.',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.lightGrey),
            ),
            child: Row(
              children: [
                const Icon(Icons.pin_drop_outlined,
                    color: AppColors.primaryBlue),
                const SizedBox(width: 8),
                const Text('My Stand:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: _stand,
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    items: _stands
                        .map((s) =>
                            DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _stand = v);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('आजची कमाई: ₹$_todayEarning',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                const SizedBox(height: 4),
                const Text(
                  'ऑर्डर पूर्ण झाल्यावर 24 तासांनी पैसे मिळतात (Online पेमेंटवरच).',
                  style:
                      TextStyle(fontSize: 12, color: AppColors.textLight),
                ),
                const SizedBox(height: 4),
                const Text(
                  'कमाई: 3 km ₹30 · 5 km ₹45 · 7 km ₹60 · 10 km ₹100',
                  style:
                      TextStyle(fontSize: 12, color: AppColors.textLight),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('नवीन ऑर्डर',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 8),
          if (!_online)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text('ऑर्डर पाहण्यासाठी Status ON करा',
                    style: TextStyle(color: AppColors.textLight)),
              ),
            )
          else if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text('या stand च्या 5 km मध्ये सध्या ऑर्डर नाही',
                    style: TextStyle(color: AppColors.textLight)),
              ),
            )
          else
            ..._visible.map(_orderCard),
        ],
      ),
    );
  }
}