import 'dart:async';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/delivery_rates.dart';

class DeliveryBoyHomeScreen extends StatefulWidget {
  const DeliveryBoyHomeScreen({super.key});

  @override
  State<DeliveryBoyHomeScreen> createState() => _DeliveryBoyHomeScreenState();
}

class _DeliveryBoyHomeScreenState extends State<DeliveryBoyHomeScreen> {
  static const String _demoCode = '4821';

  // चाचणीसाठी false चे true करा: मग 15 मिनिटांऐवजी 10 सेकंदांत सूचना येते.
  // चाचणी झाल्यावर पुन्हा false करा.
  static const bool _testMode = false;
  Duration get _reminderAfter =>
      _testMode ? const Duration(seconds: 10) : const Duration(minutes: 15);

  bool _online = false;
  bool _reminderShown = false;
  Map<String, dynamic>? _active;
  String _codeError = '';
  Timer? _timer;
  final TextEditingController _codeCtrl = TextEditingController();

  // Demo: खरे लोकेशन नसल्यामुळे बॉय "हडपसर" मध्ये आहे असे धरले आहे.
  // kmAway = बॉयपासून pickup चे अंतर. deliveryKm = pickup पासून ग्राहकापर्यंत.
  // status: new / accepted / rejected / done
  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'ZP201',
      'type': 'हॉटेल फूड',
      'pickup': 'स्वाद हॉटेल, हडपसर',
      'drop': 'रमेश पाटील, गल्ली 4',
      'deliveryKm': 2.1,
      'items': [
        {'name': 'मिसळ पाव', 'detail': 'मध्यम तिखट, 2 पाव', 'qty': 2},
        {'name': 'वडापाव', 'detail': 'चटणी सह', 'qty': 2},
      ],
      'kmAway': 0.8,
      'shopPhone': '9811111111',
      'buyerPhone': '9800000001',
      'status': 'new',
    },
    {
      'id': 'ZP202',
      'type': 'दुकान वस्तू',
      'pickup': 'श्री गणेश किराणा',
      'drop': 'सुनीता जाधव, साई नगर',
      'deliveryKm': 4.3,
      'items': [
        {'name': 'तांदूळ 5kg', 'detail': 'दर्जेदार तांदूळ', 'qty': 1},
        {'name': 'साखर 1kg', 'detail': 'पॅक केलेली', 'qty': 2},
      ],
      'kmAway': 0.3,
      'shopPhone': '9811111112',
      'buyerPhone': '9800000002',
      'status': 'new',
    },
    {
      'id': 'ZP203',
      'type': 'लोकल पार्सल',
      'pickup': 'अजय शिंदे, शिवाजी चौक',
      'drop': 'विकास कुलकर्णी, मगरपट्टा',
      'deliveryKm': 6.4,
      'items': [
        {'name': 'लहान पार्सल', 'detail': 'कागदपत्रे', 'qty': 1},
      ],
      'kmAway': 4.2,
      'shopPhone': '9811111113',
      'buyerPhone': '9800000003',
      'status': 'new',
    },
    {
      'id': 'ZP204',
      'type': 'दुकान वस्तू',
      'pickup': 'राज मेडिकल, कोरेगाव पार्क',
      'drop': 'प्रिया देशमुख, गंगा नगर',
      'deliveryKm': 8.8,
      'items': [
        {'name': 'ORS पावडर', 'detail': 'लिंबू चव', 'qty': 3},
      ],
      'kmAway': 6.2,
      'shopPhone': '9811111114',
      'buyerPhone': '9800000004',
      'status': 'new',
    },
  ];

  @override
  void dispose() {
    _timer?.cancel();
    _codeCtrl.dispose();
    super.dispose();
  }

  int _earning(Map<String, dynamic> o) =>
      DeliveryRates.chargeForKm((o['deliveryKm'] as num).toDouble());

  // ON असताना, 5 km मधल्या नवीन ऑर्डर, जवळच्या आधी
  List<Map<String, dynamic>> get _visible {
    final list = _orders
        .where((o) =>
            o['status'] == 'new' &&
            (o['kmAway'] as double) <= DeliveryRates.boyRadiusKm)
        .toList();
    list.sort((a, b) =>
        (a['kmAway'] as double).compareTo(b['kmAway'] as double));
    return list;
  }

  int get _todayEarning {
    int sum = 0;
    for (final o in _orders) {
      if (o['status'] == 'done') sum += _earning(o);
    }
    return sum;
  }

  void _toast(String msg, {Color color = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }

  // ऑर्डर accept केल्यावर किंवा 250 मीटर हालचाल झाल्यावर 15 मिनिटांचा timer
  void _startReminder() {
    _timer?.cancel();
    _reminderShown = false;
    _timer = Timer(_reminderAfter, () {
      if (!mounted) return;
      setState(() => _reminderShown = true);
      _toast('15 मिनिटे झाली. नवीन ऑर्डर घेण्यासाठी स्टेटस ON करा.',
          color: AppColors.primaryBlue);
    });
  }

  Future<void> _goOnline() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select My Stand'),
        content: const Text(
          'तुम्ही आत्ता जिथे आहात ते लोकेशन तुमचा Stand म्हणून निश्चित केले जाईल. '
          'या लोकेशनच्या 5 km मधल्या ऑर्डरच्या सूचना तुम्हाला येतील.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('रद्द'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Select My Stand'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    _timer?.cancel();
    setState(() {
      _online = true;
      _reminderShown = false;
    });
    _toast('तुमचे सध्याचे लोकेशन निश्चित केले.');
  }

  // तुम्ही सांगितलेले खरे तंत्रज्ञान (tracelet, distanceFilter 250.0) हे
  // 250 मीटर हालचाल झाल्यावर हेच function बोलावेल (Stage 3).
  void _onMovedFar() {
    setState(() => _online = false);
    _startReminder();
    _toast('तुम्ही 250 मीटरहून जास्त हलला. स्टेटस आपोआप OFF झाला.',
        color: Colors.orange);
  }

  // "स्टेटस ON करा" बटण
  void _turnOnAgain() {
    _timer?.cancel();
    setState(() {
      _online = true;
      _reminderShown = false;
    });
    _toast('स्टेटस पुन्हा ON झाला. तुमचे सध्याचे लोकेशन नव्याने निश्चित केले.');
  }

  void _reject(Map<String, dynamic> o) {
    setState(() => o['status'] = 'rejected');
    _toast('ऑर्डर नाकारली.', color: Colors.red);
  }

  void _accept(Map<String, dynamic> o) {
    setState(() {
      o['status'] = 'accepted';
      _active = o;
      _online = false; // ऑर्डर accept केली की status OFF
      _codeError = '';
      _codeCtrl.clear();
    });
    _startReminder();
    _toast('ऑर्डर स्वीकारली. दुकानदार आणि ग्राहकाला कळवले.');
  }

  void _submitCode() {
    final a = _active;
    if (a == null) return;
    if (_codeCtrl.text.trim() == _demoCode) {
      setState(() {
        a['status'] = 'done';
        _active = null;
        _codeError = '';
        _codeCtrl.clear();
      });
      _toast('ऑर्डर पूर्ण झाली. ग्राहकाला सूचना गेली.');
    } else {
      setState(() => _codeError = 'कोड चुकीचा आहे. ग्राहकाकडून पुन्हा विचारा.');
    }
  }

  Color _typeColor(String t) {
    if (t == 'हॉटेल फूड') return const Color(0xFFEF6C00);
    if (t == 'लोकल पार्सल') return const Color(0xFF6D4C41);
    return const Color(0xFF2E7D32);
  }

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

  Widget _typeChip(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _typeColor(type).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(type,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _typeColor(type))),
    );
  }

  List<Widget> _itemLines(Map<String, dynamic> o) {
    final items = o['items'] as List;
    return items.map<Widget>((raw) {
      final it = raw as Map;
      return Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          '• ${it['name']} x${it['qty']} — ${it['detail']}',
          style: const TextStyle(fontSize: 12, color: AppColors.textDark),
        ),
      );
    }).toList();
  }

  Widget _routeLines(Map<String, dynamic> o) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.store_outlined,
                size: 18, color: AppColors.primaryBlue),
            const SizedBox(width: 6),
            Expanded(
              child: Text('कुठून घ्यायचे: ${o['pickup']}',
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
              child: Text('कुठे द्यायचे: ${o['drop']}',
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textDark)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _orderCard(Map<String, dynamic> o) {
    return _box(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _typeChip(o['type'] as String),
              Text('#${o['id']}',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textLight)),
            ],
          ),
          const SizedBox(height: 10),
          _routeLines(o),
          const SizedBox(height: 8),
          ..._itemLines(o),
          const SizedBox(height: 8),
          Text(
            'तुमच्यापासून ${o['kmAway']} km · डिलिव्हरी अंतर ${o['deliveryKm']} km',
            style: const TextStyle(fontSize: 12, color: AppColors.textLight),
          ),
          const SizedBox(height: 4),
          Text('तुमची कमाई: ₹${_earning(o)}',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _reject(o),
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
                  onPressed: () => _accept(o),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Accept'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _activeCard(Map<String, dynamic> o) {
    return _box(
      color: Colors.green.withValues(alpha: 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('🛵 ऑर्डर सुरू आहे',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              Text('#${o['id']}',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textLight)),
            ],
          ),
          const SizedBox(height: 4),
          const Text('तुम्ही ही ऑर्डर स्वीकारली आहे. ती पूर्ण करणे बाकी आहे.',
              style: TextStyle(fontSize: 12, color: AppColors.textLight)),
          const SizedBox(height: 10),
          _typeChip(o['type'] as String),
          const SizedBox(height: 10),
          _routeLines(o),
          const SizedBox(height: 8),
          ..._itemLines(o),
          const SizedBox(height: 8),
          Text('दुकान: ${o['shopPhone']} · ग्राहक: ${o['buyerPhone']}',
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue)),
          const SizedBox(height: 4),
          Text('तुमची कमाई: ₹${_earning(o)}',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          const Divider(height: 24),
          const Text('ग्राहकाकडून डिलिव्हरी कोड घ्या आणि इथे टाका',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          const SizedBox(height: 8),
          TextField(
            controller: _codeCtrl,
            keyboardType: TextInputType.number,
            maxLength: 4,
            decoration: InputDecoration(
              hintText: '4 अंकी कोड',
              counterText: '',
              errorText: _codeError.isEmpty ? null : _codeError,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 4),
          const Text('Demo कोड: 4821',
              style: TextStyle(fontSize: 11, color: AppColors.textLight)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Submit करा, ऑर्डर पूर्ण'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reminderCard() {
    return _box(
      color: AppColors.primaryBlue.withValues(alpha: 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🔔 15 मिनिटे झाली',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 4),
          const Text('नवीन ऑर्डर घेण्यासाठी स्टेटस पुन्हा ON करा.',
              style: TextStyle(fontSize: 12, color: AppColors.textLight)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _turnOnAgain,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
              ),
              child: const Text('स्टेटस ON करा'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _visible;
    final active = _active;
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
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _online,
                  onChanged: (v) {
                    if (v) {
                      _goOnline();
                    } else {
                      setState(() => _online = false);
                    }
                  },
                  title: Text(_online ? 'Status: ON' : 'Status: OFF',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark)),
                  subtitle: Text(
                    _online
                        ? 'तुमचे सध्याचे लोकेशन निश्चित आहे. 5 km मधल्या ऑर्डरच्या सूचना येतील.'
                        : 'ON करताना तुमचे सध्याचे लोकेशन Stand म्हणून निश्चित होईल.',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                if (_online)
                  OutlinedButton(
                    onPressed: _onMovedFar,
                    child: const Text(
                        'Demo (फक्त चाचणीसाठी): 250 मीटर हालचाल झाली'),
                  ),
              ],
            ),
          ),
          if (_reminderShown) _reminderCard(),
          _box(
            color: AppColors.primaryBlue.withValues(alpha: 0.08),
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
                    'ऑर्डर पूर्ण झाल्यावर 24 तासांनी पैसे मिळतात.',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textLight)),
                const SizedBox(height: 4),
                Text('कमाई: ${DeliveryRates.chartText}',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textLight)),
              ],
            ),
          ),
          if (active != null) _activeCard(active),
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
                child: Text('तुमच्या 5 km मध्ये सध्या ऑर्डर नाही',
                    style: TextStyle(color: AppColors.textLight)),
              ),
            )
          else
            ...items.map(_orderCard),
        ],
      ),
    );
  }
}