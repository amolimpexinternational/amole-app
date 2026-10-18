import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/zatpat_data.dart';

class ZatPatDeliveryScreen extends StatefulWidget {
  const ZatPatDeliveryScreen({super.key});

  @override
  State<ZatPatDeliveryScreen> createState() => _ZatPatDeliveryScreenState();
}

class _ZatPatDeliveryScreenState extends State<ZatPatDeliveryScreen> {
  late bool _on = ZatPatData.isOn(ZatPatData.demoSeller, true);

  // Demo ऑर्डर. status: new / accepted / rejected
  final List<Map<String, dynamic>> _orders = [
    {'id': 'ZP101', 'buyer': 'रमेश पाटील', 'items': 'तांदूळ 5kg x1, साखर 1kg x2', 'amount': 340.0, 'km': 1.2, 'status': 'new'},
    {'id': 'ZP102', 'buyer': 'सुनीता जाधव', 'items': 'डाळ 1kg x1', 'amount': 120.0, 'km': 4.1, 'status': 'new'},
    {'id': 'ZP103', 'buyer': 'अजय शिंदे', 'items': 'नैसर्गिक मध x1, तांदूळ 5kg x1', 'amount': 700.0, 'km': 6.5, 'status': 'new'},
  ];

  int _charge(double km) {
    if (km <= 3) return 30;
    if (km <= 5) return 45;
    if (km <= 7) return 60;
    return 100;
  }

  void _decide(Map<String, dynamic> o, bool accept) {
    setState(() => o['status'] = accept ? 'accepted' : 'rejected');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(accept
            ? 'ऑर्डर स्वीकारली. जवळच्या डिलिव्हरी बॉयना सूचना पाठवली.'
            : 'ऑर्डर नाकारली.'),
        backgroundColor: accept ? Colors.green : Colors.red,
      ),
    );
  }

  Widget _statusChip(String status) {
    final accepted = status == 'accepted';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (accepted ? Colors.green : Colors.red).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        accepted ? 'स्वीकारली · डिलिव्हरी बॉयची वाट' : 'नाकारली',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: accepted ? Colors.green.shade800 : Colors.red.shade700,
        ),
      ),
    );
  }

  Widget _orderCard(Map<String, dynamic> o) {
    final km = o['km'] as double;
    final charge = _charge(km);
    final isNew = o['status'] == 'new';
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
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
              Text('$km km', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
            ],
          ),
          const SizedBox(height: 6),
          Text(o['items'] as String, style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
          const SizedBox(height: 6),
          Text(
            'वस्तू ₹${(o['amount'] as double).toStringAsFixed(0)} · डिलिव्हरी ₹$charge · Online पेमेंट',
            style: const TextStyle(fontSize: 12, color: AppColors.textLight),
          ),
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
            _statusChip(o['status'] as String),
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
            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
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
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
              subtitle: Text(
                _on
                    ? 'ON: तुमची दुकाने आणि वस्तू ZatPat मध्ये दिसतात आणि जवळच्या डिलिव्हरी बॉयना ऑर्डरची सूचना जाते.'
                    : 'OFF: तुमची वस्तू ZatPat मध्ये दिसणार नाहीत.',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('आलेल्या ऑर्डर',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textDark)),
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