import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/delivery_rates.dart';
import '../../data/zatpat_data.dart';

class ZatPatDeliveryScreen extends StatefulWidget {
  const ZatPatDeliveryScreen({super.key});

  @override
  State<ZatPatDeliveryScreen> createState() => _ZatPatDeliveryScreenState();
}

class _ZatPatDeliveryScreenState extends State<ZatPatDeliveryScreen> {
  late bool _on = ZatPatData.isOn(ZatPatData.demoSeller, true);

  // Demo: जवळचे ON डिलिव्हरी बॉय (दुकानाच्या 5 km मधले)
  final List<Map<String, String>> _boys = const [
    {'name': 'संतोष गायकवाड', 'phone': '9822222222', 'km': '1.2 km'},
    {'name': 'अनिल पवार', 'phone': '9822222223', 'km': '2.8 km'},
    {'name': 'मंगेश जाधव', 'phone': '9822222224', 'km': '4.5 km'},
  ];

  // status: new / accepted / boy / rejected / cancelled
  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'ZP101',
      'buyer': 'रमेश पाटील',
      'items': 'तांदूळ 5kg x1, साखर 1kg x2',
      'amount': 340.0,
      'km': 1.2,
      'status': 'new',
      'noBoy': false,
      'reason': '',
    },
    {
      'id': 'ZP102',
      'buyer': 'सुनीता जाधव',
      'items': 'डाळ 1kg x1',
      'amount': 120.0,
      'km': 4.1,
      'status': 'new',
      'noBoy': false,
      'reason': '',
    },
    {
      'id': 'ZP103',
      'buyer': 'अजय शिंदे',
      'items': 'नैसर्गिक मध x1, तांदूळ 5kg x1',
      'amount': 700.0,
      'km': 6.5,
      'status': 'new',
      'noBoy': false,
      'reason': '',
    },
  ];

  void _toast(String msg, {Color color = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }

  void _set(Map<String, dynamic> o, String status, {String reason = ''}) {
    setState(() {
      o['status'] = status;
      o['reason'] = reason;
    });
  }

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w600, color: color),
      ),
    );
  }

  Widget _boyRow(Map<String, String> b) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          const Icon(Icons.two_wheeler_outlined,
              size: 18, color: AppColors.primaryBlue),
          const SizedBox(width: 8),
          Expanded(
            child: Text(b['name']!,
                style: const TextStyle(
                    fontSize: 13, color: AppColors.textDark)),
          ),
          Text('${b['km']} · ${b['phone']}',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue)),
        ],
      ),
    );
  }

  List<Widget> _statusBlock(Map<String, dynamic> o) {
    final status = o['status'] as String;

    if (status == 'new') {
      return [
        const Text(
          '15 मिनिटांत स्वीकारा, नाहीतर ऑर्डर आपोआप cancel होईल.',
          style: TextStyle(fontSize: 12, color: Colors.deepOrange),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  _set(o, 'rejected', reason: 'तुम्ही नाकारली');
                  _toast('ऑर्डर नाकारली. ग्राहकाला कळवले.',
                      color: Colors.red);
                },
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
                onPressed: () {
                  _set(o, 'accepted');
                  _toast('ऑर्डर स्वीकारली. जवळच्या डिलिव्हरी बॉयना सूचना गेली.');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Accept'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              _set(o, 'cancelled', reason: '15 मिनिटांत स्वीकारली नाही');
              _toast('15 मिनिटे संपली. ऑर्डर आपोआप cancel झाली.',
                  color: Colors.orange);
            },
            child: const Text('Demo: 15 मिनिटे संपली'),
          ),
        ),
      ];
    }

    if (status == 'accepted') {
      return [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'डिलिव्हरी बॉय अरेंज करण्यासाठी खालच्या बॉयना संपर्क करा. '
            'कोणीही तयार नसेल तर ऑर्डर पोहोचवण्याची जबाबदारी तुमची आहे.',
            style: TextStyle(fontSize: 12, color: AppColors.textDark),
          ),
        ),
        const SizedBox(height: 6),
        const Text('जवळचे डिलिव्हरी बॉय (ON)',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark)),
        ..._boys.map(_boyRow),
        if (o['noBoy'] == true) ...[
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              '15 मिनिटांत कोणत्याही बॉयने ऑर्डर घेतली नाही. ग्राहकाला सूचना गेली: '
              'दुकानाने ऑर्डर स्वीकारली पण बॉय उपलब्ध नाही, दुकानाशी संपर्क करा.',
              style: TextStyle(fontSize: 12, color: AppColors.textDark),
            ),
          ),
        ],
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              setState(() => o['status'] = 'boy');
              _toast('डिलिव्हरी बॉयने ऑर्डर स्वीकारली.');
            },
            child: const Text('Demo: बॉयने स्वीकारले'),
          ),
        ),
        if (o['noBoy'] != true)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => setState(() => o['noBoy'] = true),
              child: const Text('Demo: 15 मिनिटांत बॉय मिळाला नाही'),
            ),
          ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              _set(o, 'cancelled', reason: 'तुम्ही cancel केली');
              _toast('ऑर्डर cancel केली.', color: Colors.red);
            },
            child: const Text('ऑर्डर cancel करा',
                style: TextStyle(color: Colors.red)),
          ),
        ),
      ];
    }

    if (status == 'boy') {
      return [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            '✅ डिलिव्हरी बॉय: संतोष गायकवाड · 9822222222\n'
            'ग्राहकाला confirmation आणि बॉयचा नंबर गेला.',
            style: TextStyle(fontSize: 12, color: AppColors.textDark),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              _set(o, 'cancelled', reason: 'तुम्ही cancel केली');
              _toast('ऑर्डर cancel केली. अंतिम निर्णय तुमचा आहे.',
                  color: Colors.red);
            },
            child: const Text('ऑर्डर cancel करा',
                style: TextStyle(color: Colors.red)),
          ),
        ),
      ];
    }

    // rejected / cancelled
    return [_chip('Cancel: ${o['reason']}', Colors.red.shade700)];
  }

  Widget _orderCard(Map<String, dynamic> o) {
    final km = (o['km'] as num).toDouble();
    final charge = DeliveryRates.chargeForKm(km);
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
              Text('#${o['id']} · ${o['buyer']}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.textDark)),
              Text('$km km',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textLight)),
            ],
          ),
          const SizedBox(height: 6),
          Text(o['items'] as String,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textDark)),
          const SizedBox(height: 6),
          Text(
            'वस्तू ₹${(o['amount'] as double).toStringAsFixed(0)} · '
            'डिलिव्हरी ₹$charge · Online पेमेंट',
            style: const TextStyle(
                fontSize: 12, color: AppColors.textLight),
          ),
          const SizedBox(height: 10),
          ..._statusBlock(o),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('⚡ ZatPat डिलिव्हरी',
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
              value: _on,
              onChanged: (v) {
                setState(() => _on = v);
                ZatPatData.setOn(ZatPatData.demoSeller, v);
              },
              title: const Text('Add delivery partner',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              subtitle: Text(
                _on
                    ? 'ON: तुमची दुकाने आणि वस्तू ZatPat मध्ये दिसतात.'
                    : 'OFF: तुमच्या वस्तू ZatPat मध्ये दिसणार नाहीत.',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('आलेल्या ऑर्डर',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 8),
          if (!_on)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text('ऑर्डर घेण्यासाठी वरचे बटण ON करा',
                    style: TextStyle(color: AppColors.textLight)),
              ),
            )
          else
            ..._orders.map(_orderCard),
        ],
      ),
    );
  }
}