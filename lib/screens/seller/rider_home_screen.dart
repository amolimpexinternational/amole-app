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
  bool _ready = false;
  String _stand = '';
  Map<String, dynamic>? _active;
  bool _reminderPending = false;
  int _recharge = 100;
  final List<String> _log = [];

  final List<String> _stands = const ['हडपसर', 'मगरपट्टा', 'कोरेगाव पार्क'];

  // status: new / confirmed / rejected
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
      'kmFromStand': {'हडपसर': 0.6, 'मगरपट्टा': 2.4, 'कोरेगाव पार्क': 6.0},
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
      'kmFromStand': {'हडपसर': 2.2, 'मगरपट्टा': 0.4, 'कोरेगाव पार्क': 3.5},
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
      'kmFromStand': {'हडपसर': 7.0, 'मगरपट्टा': 4.8, 'कोरेगाव पार्क': 1.1},
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
      'kmFromStand': {'हडपसर': 1.8, 'मगरपट्टा': 3.9, 'कोरेगाव पार्क': 7.5},
      'status': 'new',
    },
  ];

  bool get _exhausted => RiderWallet.balance < RideRates.rideFee;
  bool get _low => RiderWallet.balance < RideRates.lowBalance;

  double _fromStand(Map<String, dynamic> r) {
    final v = (r['kmFromStand'] as Map)[_stand];
    return v == null ? 999.0 : (v as num).toDouble();
  }

  // Ready ON + पुरेसे रिचार्ज + stand च्या 3 km मधली, जवळची आधी
  List<Map<String, dynamic>> get _visible {
    if (!_ready || _exhausted) return [];
    final list = _requests
        .where((r) =>
            r['status'] == 'new' && _fromStand(r) <= RideRates.riderRadiusKm)
        .toList();
    list.sort((a, b) => _fromStand(a).compareTo(_fromStand(b)));
    return list;
  }

  void _toast(String msg, {Color color = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }

  Future<void> _goReady() async {
    final picked = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Set Your Stand'),
        children: _stands
            .map((s) => SimpleDialogOption(
                  onPressed: () => Navigator.pop(ctx, s),
                  child: Text(s, style: const TextStyle(fontSize: 15)),
                ))
            .toList(),
      ),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _stand = picked;
      _ready = true;
      _reminderPending = false;
    });
    _toast('तुमचा Stand निश्चित केला: $picked');
  }

  void _simulateMoved() {
    setState(() {
      _ready = false;
      _reminderPending = true;
    });
    _toast('तुम्ही 250 मीटरहून जास्त हलला. Status आपोआप OFF झाला.',
        color: Colors.orange);
  }

  void _simulateFifteen() {
    setState(() => _reminderPending = false);
    _toast('15 मिनिटे झाली. पुन्हा Ready To Ride ON करा.',
        color: AppColors.primaryBlue);
  }

  void _confirm(Map<String, dynamic> r) {
    setState(() {
      r['status'] = 'confirmed';
      RiderWallet.balance -= RideRates.rideFee;
      RiderWallet.ridesConfirmed += 1;
      _active = r;
      _ready = false;
      _reminderPending = true;
    });
    _toast('राईड स्वीकारली. ₹${RideRates.rideFee} कपात झाले.');
    if (_low && !_exhausted) {
      _toast('Balance low, रिचार्ज करा.', color: Colors.orange);
    }
  }

  void _reject(Map<String, dynamic> r) {
    setState(() {
      r['status'] = 'rejected';
      _log.add('राईड #${r['id']} तुम्ही नाकारली. ₹ कपात नाही.');
    });
  }

  void _doRecharge() {
    setState(() => RiderWallet.balance += _recharge);
    _toast('₹$_recharge रिचार्ज झाले. (Demo, Online पेमेंट)');
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
            style:
                const TextStyle(fontSize: 12, color: AppColors.textLight),
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
          Wrap(
            spacing: 8,
            children: [100, 200, 300]
                .map((a) => ChoiceChip(
                      label: Text('₹$a'),
                      selected: _recharge == a,
                      onSelected: (_) => setState(() => _recharge = a),
                    ))
                .toList(),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _doRecharge,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
              ),
              child: Text('₹$_recharge रिचार्ज करा'),
            ),
          ),
          const SizedBox(height: 4),
          const Text('रिचार्जचे पैसे कंपनीकडे जमा होतात. ₹100 च्या पटीत रिचार्ज करता येते.',
              style: TextStyle(fontSize: 11, color: AppColors.textLight)),
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
              Text('तुमच्या stand पासून ${_fromStand(r)} km',
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
                        _toast('आधी रिचार्ज करा.', color: Colors.red);
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
                        ? 'Stand: $_stand. 3 km मधल्या राईडच्या सूचना येतील.'
                        : 'ON करताना Set Your Stand निवडावा लागेल.',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                if (_ready)
                  OutlinedButton(
                    onPressed: _simulateMoved,
                    child: const Text('Demo: मी 250 मीटरहून जास्त हलले'),
                  ),
                if (_reminderPending)
                  OutlinedButton(
                    onPressed: _simulateFifteen,
                    child: const Text('Demo: 15 मिनिटे झाली'),
                  ),
              ],
            ),
          ),
          _walletCard(),
          _box(
            child: Text(
              'आतापर्यंत स्वीकारलेल्या राईड: ${RiderWallet.ridesConfirmed}',
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textDark),
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
                child: Text('या stand च्या 3 km मध्ये सध्या विनंती नाही',
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