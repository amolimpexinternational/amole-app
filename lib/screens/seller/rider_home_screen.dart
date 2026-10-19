import 'dart:async';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/ride_rates.dart';

// Demo: रायडरचे रिचार्ज wallet. खरा डेटा Stage 3 मध्ये येईल.
class RiderWallet {
  static int balance = 100;
  static int ridesConfirmed = 0;
}

class RiderHomeScreen extends StatefulWidget {
  const RiderHomeScreen({super.key});

  @override
  State<RiderHomeScreen> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
  // चाचणीसाठी false चे true करा: मग 15 मिनिटांऐवजी 10 सेकंदांत सूचना येते.
  // चाचणी झाल्यावर पुन्हा false करा.
  static const bool _testMode = false;
  Duration get _reminderAfter =>
      _testMode ? const Duration(seconds: 10) : const Duration(minutes: 15);

  bool _ready = false;
  bool _reminderShown = false;
  Map<String, dynamic>? _active;
  Timer? _timer;
  final List<String> _log = [];

  // Demo: खरे लोकेशन नसल्यामुळे रायडर "हडपसर" मध्ये आहे असे धरले आहे.
  // kmAway = रायडरपासून pickup चे अंतर.
  final List<Map<String, dynamic>> _requests = [
    {
      'id': 'RD401',
      'vehicle': 'बाईक',
      'from': 'हडपसर गाडीतळ',
      'to': 'स्वारगेट',
      'km': 9.0,
      'fare': 133,
      'buyer': 'रमेश पाटील',
      'phone': '9800000011',
      'kmAway': 0.6,
      'status': 'new',
    },
    {
      'id': 'RD402',
      'vehicle': 'रिक्षा',
      'from': 'मगरपट्टा सिटी',
      'to': 'पुणे स्टेशन',
      'km': 8.0,
      'fare': 133,
      'buyer': 'सुनीता जाधव',
      'phone': '9800000012',
      'kmAway': 2.2,
      'status': 'new',
    },
    {
      'id': 'RD403',
      'vehicle': 'कार 5 seater',
      'from': 'कोरेगाव पार्क',
      'to': 'विमानतळ',
      'km': 11.0,
      'fare': 252,
      'buyer': 'अजय शिंदे',
      'phone': '9800000013',
      'kmAway': 7.0,
      'status': 'new',
    },
    {
      'id': 'RD404',
      'vehicle': 'बाईक',
      'from': 'हडपसर बस स्टॉप',
      'to': 'फुरसुंगी',
      'km': 5.0,
      'fare': 70,
      'buyer': 'प्रिया देशमुख',
      'phone': '9800000014',
      'kmAway': 1.8,
      'status': 'new',
    },
  ];

  bool get _exhausted => RiderWallet.balance < RideRates.rideFee;
  bool get _low => RiderWallet.balance < RideRates.lowBalance;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Ready ON + पुरेसे रिचार्ज + 3 km मधली, जवळची आधी
  List<Map<String, dynamic>> get _visible {
    if (!_ready || _exhausted) return [];
    final list = _requests
        .where((r) =>
            r['status'] == 'new' &&
            (r['kmAway'] as double) <= RideRates.riderRadiusKm)
        .toList();
    list.sort((a, b) =>
        (a['kmAway'] as double).compareTo(b['kmAway'] as double));
    return list;
  }

  void _toast(String msg, {Color color = Colors.green, bool recharge = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        action: recharge
            ? SnackBarAction(
                label: 'रिचार्ज करा',
                textColor: Colors.white,
                onPressed: _showRecharge,
              )
            : null,
      ),
    );
  }

  // राईड confirm झाल्यावर किंवा 250 मीटर हालचाल झाल्यावर 15 मिनिटांचा timer
  void _startReminder() {
    _timer?.cancel();
    _reminderShown = false;
    _timer = Timer(_reminderAfter, () {
      if (!mounted) return;
      setState(() => _reminderShown = true);
      _toast('15 मिनिटे झाली. नवीन राईड घेण्यासाठी स्टेटस ON करा.',
          color: AppColors.primaryBlue);
    });
  }

  Future<void> _goReady() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Set Your Stand'),
        content: const Text(
          'तुम्ही आत्ता जिथे आहात ते लोकेशन तुमचा Stand म्हणून निश्चित केले जाईल. '
          'या लोकेशनच्या 3 km मधल्या राईडच्या सूचना तुम्हाला येतील.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('रद्द'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Set Your Stand'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    _timer?.cancel();
    setState(() {
      _ready = true;
      _reminderShown = false;
    });
    _toast('तुमचे सध्याचे लोकेशन निश्चित केले.');
  }

  // तुम्ही सांगितलेले खरे तंत्रज्ञान (tracelet, distanceFilter 250.0) हे
  // 250 मीटर हालचाल झाल्यावर हेच function बोलावेल (Stage 3).
  void _onMovedFar() {
    setState(() => _ready = false);
    _startReminder();
    _toast('तुम्ही 250 मीटरहून जास्त हलला. स्टेटस आपोआप OFF झाला.',
        color: Colors.orange);
  }

  // "स्टेटस ON करा" बटण
  void _turnOnAgain() {
    if (_exhausted) {
      _toast('आधी रिचार्ज करा.', color: Colors.red, recharge: true);
      return;
    }
    _timer?.cancel();
    setState(() {
      _ready = true;
      _reminderShown = false;
    });
    _toast('स्टेटस पुन्हा ON झाला. तुमचे सध्याचे लोकेशन नव्याने निश्चित केले.');
  }

  void _confirm(Map<String, dynamic> r) {
    setState(() {
      r['status'] = 'confirmed';
      RiderWallet.balance -= RideRates.rideFee;
      RiderWallet.ridesConfirmed += 1;
      _active = r;
      _ready = false;
    });
    _startReminder();
    if (_low) {
      _toast('राईड स्वीकारली. Balance low आहे, रिचार्ज करा.',
          color: Colors.orange, recharge: true);
    } else {
      _toast('राईड स्वीकारली. ₹${RideRates.rideFee} कपात झाले.');
    }
  }

  void _reject(Map<String, dynamic> r) {
    setState(() {
      r['status'] = 'rejected';
      _log.add('राईड #${r['id']} तुम्ही नाकारली. ₹ कपात नाही.');
    });
  }

  void _showRecharge() {
    int amount = 100;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('राईड रिचार्ज',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              const SizedBox(height: 4),
              Text('सध्याची शिल्लक: ₹${RiderWallet.balance}',
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textLight)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [100, 200, 300]
                    .map((a) => ChoiceChip(
                          label: Text('₹$a'),
                          selected: amount == a,
                          onSelected: (_) => setSheet(() => amount = a),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    setState(() => RiderWallet.balance += amount);
                    _toast('₹$amount रिचार्ज झाले. (Demo, Online पेमेंट)');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('₹$amount Online पेमेंट करा'),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'रिचार्जचे पैसे कंपनीकडे जमा होतात. ₹100 च्या पटीत रिचार्ज करता येते.',
                style: TextStyle(fontSize: 11, color: AppColors.textLight),
              ),
            ],
          ),
        ),
      ),
    );
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

  Widget _walletCard() {
    return _box(
      color: _exhausted
          ? Colors.red.withValues(alpha: 0.06)
          : AppColors.primaryBlue.withValues(alpha: 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('राईड रिचार्ज wallet: ₹${RiderWallet.balance}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 4),
          Text(
            'प्रत्येक confirm केलेल्या राईडला ₹${RideRates.rideFee} कपात होते. '
            'Reject केली तर कपात नाही.',
            style: const TextStyle(fontSize: 12, color: AppColors.textLight),
          ),
          if (_exhausted) ...[
            const SizedBox(height: 8),
            const Text(
              'रिचार्ज संपले आहे. रिचार्ज करेपर्यंत राईडच्या सूचना येणार नाहीत '
              'आणि अॅपचे इतर सर्व function बंद राहतील.',
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
          ] else if (_low) ...[
            const SizedBox(height: 8),
            const Text('⚠️ Balance low, रिचार्ज करा.',
                style: TextStyle(fontSize: 12, color: Colors.deepOrange)),
          ],
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _showRecharge,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    (_low || _exhausted) ? Colors.deepOrange : AppColors.primaryBlue,
                foregroundColor: Colors.white,
              ),
              child: const Text('रिचार्ज करा'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _requestCard(Map<String, dynamic> r) {
    return _box(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${r['vehicle']} · #${r['id']}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.textDark)),
              Text('तुमच्यापासून ${r['kmAway']} km',
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textLight)),
            ],
          ),
          const SizedBox(height: 8),
          Text('कुठून: ${r['from']}', style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 2),
          Text('कुठे: ${r['to']}', style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 6),
          Text('अंदाजे भाडे: ₹${r['fare']} · ${r['km']} km',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _reject(r),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                  child: const Text('REJECT करा'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _confirm(r),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('CONFIRM करा'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _activeCard(Map<String, dynamic> r) {
    return _box(
      color: Colors.green.withValues(alpha: 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('✅ राईड स्वीकारली',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 6),
          Text('${r['vehicle']} · कुठून: ${r['from']}',
              style: const TextStyle(fontSize: 13)),
          Text('कुठे: ${r['to']}', style: const TextStyle(fontSize: 13)),
          Text('अंदाजे भाडे: ₹${r['fare']}',
              style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 6),
          Text('प्रवासी: ${r['buyer']} · ${r['phone']}',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue)),
          const SizedBox(height: 4),
          const Text(
              'प्रवाशाला कॉल करून भाडे आणि वेळ निश्चित करा. बाकीच्या रायडरच्या सूचनेतून ही राईड गायब झाली आहे.',
              style: TextStyle(fontSize: 12, color: AppColors.textLight)),
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
          const Text('नवीन राईड घेण्यासाठी स्टेटस पुन्हा ON करा.',
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
        title: const Text('🚕 रायडर पॅनल',
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
                  value: _ready,
                  onChanged: (v) {
                    if (v) {
                      if (_exhausted) {
                        _toast('आधी रिचार्ज करा.',
                            color: Colors.red, recharge: true);
                        return;
                      }
                      _goReady();
                    } else {
                      setState(() => _ready = false);
                    }
                  },
                  title: Text(
                      _ready ? 'Ready To Ride: ON' : 'Ready To Ride: OFF',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark)),
                  subtitle: Text(
                    _ready
                        ? 'तुमचे सध्याचे लोकेशन निश्चित आहे. 3 km मधल्या राईडच्या सूचना येतील.'
                        : 'ON करताना तुमचे सध्याचे लोकेशन Stand म्हणून निश्चित होईल.',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                if (_ready)
                  OutlinedButton(
                    onPressed: _onMovedFar,
                    child: const Text(
                        'Demo (फक्त चाचणीसाठी): 250 मीटर हालचाल झाली'),
                  ),
              ],
            ),
          ),
          if (_reminderShown) _reminderCard(),
          _walletCard(),
          _box(
            child: Text(
              'आतापर्यंत स्वीकारलेल्या राईड: ${RiderWallet.ridesConfirmed}',
              style:
                  const TextStyle(fontSize: 13, color: AppColors.textDark),
            ),
          ),
          if (active != null) _activeCard(active),
          const Text('राईड विनंत्या',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 8),
          if (_exhausted)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text('रिचार्ज संपल्यामुळे सूचना बंद आहेत',
                    style: TextStyle(color: AppColors.textLight)),
              ),
            )
          else if (!_ready)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text('विनंत्या पाहण्यासाठी Ready To Ride ON करा',
                    style: TextStyle(color: AppColors.textLight)),
              ),
            )
          else if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text('तुमच्या 3 km मध्ये सध्या विनंती नाही',
                    style: TextStyle(color: AppColors.textLight)),
              ),
            )
          else
            ...items.map(_requestCard),
          if (_log.isNotEmpty) ...[
            const SizedBox(height: 8),
            const Text('सूचना',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark)),
            const SizedBox(height: 6),
            ..._log.map((t) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $t',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textLight)),
                )),
          ],
        ],
      ),
    );
  }
}