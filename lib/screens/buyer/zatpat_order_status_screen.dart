import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'zatpat_feedback_screen.dart';

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
  static const String _shopPhone = '9811111111';
  static const String _code = '4821';

  // 0 = ऑर्डर दिली ... 5 = पोहोचली
  int _stage = 0;
  // '' / cancelled / noBoy
  String _problem = '';

  final List<Map<String, String>> _stages = const [
    {'t': 'ऑर्डर दिली', 's': 'Online पेमेंट झाले. दुकानाच्या उत्तराची वाट'},
    {'t': 'दुकानाने स्वीकारले', 's': 'वस्तू तयार केल्या जात आहेत'},
    {'t': 'डिलिव्हरी बॉय मिळाला', 's': 'बॉयने ऑर्डर स्वीकारली'},
    {'t': 'वस्तू उचलल्या', 's': 'बॉयने दुकानातून वस्तू घेतल्या'},
    {'t': 'रस्त्यात आहे', 's': 'तुमच्या पत्त्याकडे येत आहे'},
    {'t': 'पोहोचली', 's': 'ऑर्डर पूर्ण झाली'},
  ];

  void _next() {
    setState(() {
      _stage++;
      if (_stage >= 2) _problem = '';
    });
    if (_stage == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ZatPatFeedbackScreen(orderId: widget.orderId),
        ),
      );
    }
  }

  Widget _timeline() {
    return Column(
      children: List.generate(_stages.length, (i) {
        final done = i <= _stage && _problem != 'cancelled';
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
                    color: (i < _stage && _problem != 'cancelled')
                        ? Colors.green
                        : AppColors.lightGrey,
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
                        fontWeight:
                            done ? FontWeight.bold : FontWeight.normal,
                        color: done
                            ? AppColors.textDark
                            : AppColors.textLight,
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

  Widget _card({required Widget child, Color? color}) {
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

  Widget _contactRow(IconData icon, String role, String name, String phone) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text('$role: $name',
                style: const TextStyle(
                    fontSize: 13, color: AppColors.textDark)),
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

  String _headline() {
    if (_problem == 'cancelled') return '❌ ऑर्डर cancel झाली';
    if (_stage == 5) return '🎉 ऑर्डर पोहोचली!';
    if (_stage >= 2) return '✅ डिलिव्हरी बॉय मिळाला';
    if (_stage == 1) return '✅ दुकानाने ऑर्डर स्वीकारली';
    return '⏳ दुकानाच्या उत्तराची वाट पाहत आहोत';
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.subtotal + widget.deliveryCharge;
    final cancelled = _problem == 'cancelled';
    final shopKnown = _stage >= 1 && !cancelled;
    final boyKnown = _stage >= 2 && !cancelled;
    final noBoy = _problem == 'noBoy' && _stage == 1;
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
                Text(_headline(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                const SizedBox(height: 4),
                Text('दुकान: ${widget.sellerName}',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textLight)),
              ],
            ),
          ),
          if (cancelled)
            _card(
              color: Colors.red.withValues(alpha: 0.06),
              child: const Text(
                'दुकानदाराने 15 मिनिटांत ऑर्डर स्वीकारली नाही, म्हणून ती आपोआप cancel झाली.',
                style: TextStyle(fontSize: 13, color: AppColors.textDark),
              ),
            ),
          if (noBoy)
            _card(
              color: Colors.orange.withValues(alpha: 0.1),
              child: const Text(
                'तुमची ऑर्डर दुकानदाराने स्वीकारली, परंतु डिलिव्हरी बॉय उपलब्ध झालेला नाही. '
                'कृपया दुकान किंवा हॉटेलशी संपर्क करा.\n'
                'दुकानाचा नंबर: $_shopPhone',
                style: TextStyle(fontSize: 13, color: AppColors.textDark),
              ),
            ),
          if (shopKnown)
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
                      widget.sellerName, _shopPhone),
                  if (boyKnown)
                    _contactRow(Icons.two_wheeler_outlined, 'डिलिव्हरी बॉय',
                        'संतोष गायकवाड', '9822222222'),
                ],
              ),
            ),
          if (boyKnown && _stage < 5)
            _card(
              color: AppColors.primaryBlue.withValues(alpha: 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('तुमचा डिलिव्हरी कोड',
                      style: TextStyle(
                          fontSize: 13, color: AppColors.textLight)),
                  const SizedBox(height: 4),
                  const Text(_code,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 6,
                          color: AppColors.textDark)),
                  const SizedBox(height: 4),
                  const Text(
                    'वस्तू हातात मिळाल्यावरच हा कोड डिलिव्हरी बॉयला सांगा.',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textLight),
                  ),
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
                        style:
                            const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          if (_stage < 5 && !cancelled) ...[
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _next,
                child: const Text('पुढचा टप्पा (Demo)'),
              ),
            ),
            if (_stage == 0)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => _problem = 'cancelled'),
                  child: const Text('Demo: दुकानाने 15 मिनिटांत स्वीकारली नाही'),
                ),
              ),
            if (_stage == 1 && _problem != 'noBoy')
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => _problem = 'noBoy'),
                  child: const Text('Demo: 15 मिनिटांत बॉय मिळाला नाही'),
                ),
              ),
          ],
          if (_stage == 5)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ZatPatFeedbackScreen(orderId: widget.orderId),
                  ),
                ),
                child: const Text('फीडबॅक द्या'),
              ),
            ),
        ],
      ),
    );
  }
}