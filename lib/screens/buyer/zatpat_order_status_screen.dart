import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class ZatPatOrderStatusScreen extends StatefulWidget {
  final String orderId;
  final String sellerName;
  final double subtotal;
  final int deliveryCharge;

  const ZatPatOrderStatusScreen({
    super.key,
    this.orderId = 'ZP301',
    this.sellerName = 'श्री गणेश किराणा',
    this.subtotal = 340,
    this.deliveryCharge = 30,
  });

  @override
  State<ZatPatOrderStatusScreen> createState() =>
      _ZatPatOrderStatusScreenState();
}

class _ZatPatOrderStatusScreenState extends State<ZatPatOrderStatusScreen> {
  // Demo: 0 = ऑर्डर दिली ... 5 = पोहोचली
  int _stage = 0;

  final List<Map<String, String>> _stages = const [
    {'t': 'ऑर्डर दिली', 's': 'Online पेमेंट झाले'},
    {'t': 'दुकानदाराने स्वीकारले', 's': 'वस्तू तयार केल्या जात आहेत'},
    {'t': 'डिलिव्हरी बॉय मिळाला', 's': 'दुकानदार आणि डिलिव्हरी बॉय दोघांनी स्वीकारले'},
    {'t': 'वस्तू उचलल्या', 's': 'डिलिव्हरी बॉयने दुकानातून वस्तू घेतल्या'},
    {'t': 'रस्त्यात आहे', 's': 'तुमच्या पत्त्याकडे येत आहे'},
    {'t': 'पोहोचली', 's': 'ऑर्डर पूर्ण झाली'},
  ];

  Widget _timeline() {
    return Column(
      children: List.generate(_stages.length, (i) {
        final done = i <= _stage;
        final last = i == _stages.length - 1;
        final color = done ? Colors.green : AppColors.textLight;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Icon(
                  done ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: color,
                  size: 22,
                ),
                if (!last)
                  Container(
                    width: 2,
                    height: 34,
                    color: i < _stage ? Colors.green : AppColors.lightGrey,
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _stages[i]['t']!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: done ? FontWeight.bold : FontWeight.normal,
                        color: done ? AppColors.textDark : AppColors.textLight,
                      ),
                    ),
                    Text(
                      _stages[i]['s']!,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textLight),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: child,
    );
  }

  Widget _contactRow(IconData icon, String role, String name, String phone) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$role: $name',
              style: const TextStyle(fontSize: 13, color: AppColors.textDark),
            ),
          ),
          Text(phone,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.subtotal + widget.deliveryCharge;
    final partnerKnown = _stage >= 2;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('⚡ ZatPat ऑर्डर #${widget.orderId}',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _stage == 5
                      ? '🎉 ऑर्डर पोहोचली!'
                      : partnerKnown
                          ? '✅ ऑर्डर confirm झाली'
                          : '⏳ दुकानदार आणि डिलिव्हरी बॉयची वाट पाहत आहोत',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark),
                ),
                const SizedBox(height: 4),
                Text('दुकान: ${widget.sellerName}',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textLight)),
              ],
            ),
          ),
          if (partnerKnown)
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('संपर्क',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark)),
                  _contactRow(Icons.store_outlined, 'दुकानदार',
                      widget.sellerName, '9811111111'),
                  _contactRow(Icons.two_wheeler_outlined, 'डिलिव्हरी बॉय',
                      'संतोष गायकवाड', '9822222222'),
                ],
              ),
            ),
          _card(child: _timeline()),
          _card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('वस्तूंची किंमत'),
                    Text('₹${widget.subtotal.toStringAsFixed(0)}'),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('डिलिव्हरी चार्ज'),
                    Text('₹${widget.deliveryCharge}'),
                  ],
                ),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('एकूण (Online पेमेंट)',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('₹${total.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          if (_stage < 5)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => setState(() => _stage++),
                child: const Text('पुढचा टप्पा (Demo)'),
              ),
            ),
        ],
      ),
    );
  }
}