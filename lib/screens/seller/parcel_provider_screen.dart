import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // GPS साठी इम्पोर्ट
import '../../constants/app_colors.dart';
import '../../data/parcel_data.dart';

// Demo: कार्गो सेलरचे wallet. खरा डेटा Stage 3 मध्ये येईल.
class CargoWallet {
  static int balance = 300;
  static int jobsAccepted = 0;
}

class ParcelProviderScreen extends StatefulWidget {
  const ParcelProviderScreen({super.key});

  @override
  State<ParcelProviderScreen> createState() => _ParcelProviderScreenState();
}

class _ParcelProviderScreenState extends State<ParcelProviderScreen> {
  static const bool _testMode = false;
  Duration get _reminderAfter =>
      _testMode ? const Duration(seconds: 10) : const Duration(minutes: 15);

  String _myVehicle = 'ton1';

  bool _ready = false;
  bool _reminderShown = false;
  Map<String, dynamic>? _active;
  Timer? _timer;
  final List<String> _log = [];

  // GPS ट्रॅकिंगसाठी व्हेरिएबल्स
  Position? _standPosition;
  StreamSubscription<Position>? _positionStream;

  final List<Map<String, dynamic>> _requests = [
    {
      'id': 'PC801',
      'vehicle': 'ton1',
      'desc': 'फर्निचर: 2 खुर्च्या आणि टेबल',
      'weight': '60',
      'dims': '120 x 60 x 80 cm',
      'pickup': 'हडपसर गाडीतळ',
      'drop': 'कात्रज',
      'km': 14.0,
      'kmAway': 1.4,
      'buyer': 'रमेश पाटील',
      'phone': '9800000031',
      'status': 'new',
    },
    {
      'id': 'PC802',
      'vehicle': 'bike',
      'desc': 'कागदपत्रांचे लहान पार्सल',
      'weight': '2',
      'dims': '30 x 20 x 10 cm',
      'pickup': 'मगरपट्टा',
      'drop': 'शिवाजीनगर',
      'km': 8.0,
      'kmAway': 0.8,
      'buyer': 'सुनीता जाधव',
      'phone': '9800000032',
      'status': 'new',
    },
    {
      'id': 'PC803',
      'vehicle': 'three',
      'desc': 'दुकानाचा माल: 15 बॉक्स',
      'weight': '150',
      'dims': '100 x 80 x 60 cm',
      'pickup': 'फुरसुंगी',
      'drop': 'चाकण',
      'km': 22.0,
      'kmAway': 3.5,
      'buyer': 'अजय शिंदे',
      'phone': '9800000033',
      'status': 'new',
    },
    {
      'id': 'PC804',
      'vehicle': 'ton1',
      'desc': 'घरगुती सामान (शिफ्टिंग)',
      'weight': '400',
      'dims': 'मोठे सामान',
      'pickup': 'हडपसर, साधना बँक चौक',
      'drop': 'नाशिक',
      'km': 60.0,
      'kmAway': 7.2,
      'buyer': 'प्रिया देशमुख',
      'phone': '9800000034',
      'status': 'new',
    },
    {
      'id': 'PC805',
      'vehicle': 'ton1',
      'desc': 'शेतीचे साहित्य',
      'weight': '300',
      'dims': 'पोती',
      'pickup': 'सासवड',
      'drop': 'पुणे मार्केट यार्ड',
      'km': 30.0,
      'kmAway': 12.0,
      'buyer': 'विकास कुलकर्णी',
      'phone': '9800000035',
      'status': 'new',
    },
  ];

  int get _fee => ParcelData.feeOf(_myVehicle);
  bool get _noBalance => CargoWallet.balance < _fee;
  bool get _low =>
      CargoWallet.balance <
      (_fee > ParcelData.lowBalanceMin ? _fee : ParcelData.lowBalanceMin);

  @override
  void dispose() {
    _timer?.cancel();
    _stopGpsTracking(); // ॲप बंद झाल्यावर GPS बंद
    super.dispose();
  }

  List<Map<String, dynamic>> get _visible {
    if (!_ready || _noBalance || _active != null) return [];
    final list = _requests
        .where((r) =>
            r['status'] == 'new' &&
            r['vehicle'] == _myVehicle &&
            (r['kmAway'] as double) <= ParcelData.radiusKm)
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

  // === GPS सुरू करण्याचे फंक्शन ===
  Future<void> _startGpsTracking() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _toast('GPS परवानगी नाकारली! स्टँड सेट करता येणार नाही.', color: Colors.red);
        return;
      }
    }

    _standPosition = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    _positionStream?.cancel();
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 250, // २५० मीटर हालचाल
      ),
    ).listen((Position position) {
      if (_standPosition == null) return;

      double distance = Geolocator.distanceBetween(
        _standPosition!.latitude,
        _standPosition!.longitude,
        position.latitude,
        position.longitude,
      );

      if (distance >= 250) {
        _onMovedFar();
      }
    });
  }

  // === GPS बंद करण्याचे फंक्शन ===
  void _stopGpsTracking() {
    _positionStream?.cancel();
    _positionStream = null;
    _standPosition = null;
  }

  void _startReminder() {
    _timer?.cancel();
    _reminderShown = false;
    _timer = Timer(_reminderAfter, () {
      if (!mounted) return;
      setState(() => _reminderShown = true);
      _toast('15 मिनिटे झाली. नवीन काम घेण्यासाठी स्टेटस ON करा.',
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
          'तुम्ही 250 मीटरहून जास्त हलल्यास स्टेटस आपोआप OFF होईल.',
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

    // GPS सुरू करा
    await _startGpsTracking();

    _timer?.cancel();
    setState(() {
      _ready = true;
      _reminderShown = false;
    });
    _toast('तुमचे स्टँड निश्चित केले. GPS सुरू आहे.');
  }

  // २५० मीटर हालचाल झाल्यावर ऑटोमॅटिक कॉल होईल
  void _onMovedFar() {
    if (!mounted) return;
    _stopGpsTracking();
    setState(() => _ready = false);
    _startReminder();
    _toast('तुम्ही 250 मीटरहून जास्त हलला. स्टेटस आपोआप OFF झाला.',
        color: Colors.orange);
  }

  void _turnOnAgain() {
    if (_noBalance) {
      _toast('आधी रिचार्ज करा.', color: Colors.red, recharge: true);
      return;
    }
    _goReady(); // पुन्हा GPS सुरू होईल
  }

  void _accept(Map<String, dynamic> r) {
    setState(() {
      r['status'] = 'accepted';
      CargoWallet.balance -= _fee;
      CargoWallet.jobsAccepted += 1;
      _active = r;
      _ready = false;
    });
    _stopGpsTracking(); // काम मिळाल्यावर GPS बंद
    _startReminder();
    if (_low) {
      _toast('काम स्वीकारले. Balance low आहे, रिचार्ज करा.',
          color: Colors.orange, recharge: true);
    } else {
      _toast('काम स्वीकारले. ₹$_fee कपात झाले.');
    }
  }

  void _reject(Map<String, dynamic> r) {
    setState(() {
      r['status'] = 'rejected';
      _log.add('#${r['id']} तुम्ही नाकारली. ₹ कपात नाही.');
    });
  }

  void _finish() {
    final a = _active;
    if (a == null) return;
    setState(() {
      a['status'] = 'done';
      _active = null;
      _log.add('#${a['id']} काम पूर्ण झाले.');
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
              const Text('कार्गो रिचार्ज',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              const SizedBox(height: 4),
              Text('सध्याची शिल्लक: ₹${CargoWallet.balance}',
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textLight)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [100, 200, 300, 500, 1000]
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
                    setState(() => CargoWallet.balance += amount);
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
                'किमान ₹100, आणि ₹100 च्या पटीत रिचार्ज करता येते. '
                'रिचार्जचे पैसे कंपनीकडे जमा होतात.',
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
      color: _noBalance
          ? Colors.red.withValues(alpha: 0.06)
          : AppColors.primaryBlue.withValues(alpha: 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('कार्गो wallet: ₹${CargoWallet.balance}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 4),
          Text(
            'प्रत्येक स्वीकारलेल्या कामाला तुमच्या वाहनाची फी ₹$_fee कपात होते. '
            'Reject केले तर कपात नाही.',
            style: const TextStyle(fontSize: 12, color: AppColors.textLight),
          ),
          if (_noBalance) ...[
            const SizedBox(height: 8),
            const Text(
              'रिचार्ज संपले आहे. रिचार्ज करेपर्यंत नवीन कामांच्या सूचना येणार नाहीत.',
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
                backgroundColor: (_low || _noBalance)
                    ? Colors.deepOrange
                    : AppColors.primaryBlue,
                foregroundColor: Colors.white,
              ),
              child: const Text('रिचार्ज करा'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _vehicleCard() {
    return _box(
      child: Row(
        children: [
          const Icon(Icons.local_shipping_outlined,
              color: AppColors.primaryBlue),
          const SizedBox(width: 10),
          const Text('माझे वाहन:',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButton<String>(
              value: _myVehicle,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              items: ParcelData.vehicles
                  .map((v) => DropdownMenuItem(
                        value: v.key,
                        child: Text('${v.label} (फी ₹${v.fee})'),
                      ))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _myVehicle = v);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _requestCard(Map<String, dynamic> r) {
    final fare = ParcelData.fare(r['vehicle'] as String, r['km'] as double);
    return _box(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${ParcelData.labelOf(r['vehicle'] as String)} · #${r['id']}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.textDark)),
              Text('तुमच्यापासून ${r['kmAway']} km',
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textLight)),
            ],
          ),
          const SizedBox(height: 6),
          Text('पार्सल: ${r['desc']}', style: const TextStyle(fontSize: 13)),
          Text('वजन: ${r['weight']} kg · ${r['dims']}',
              style:
                  const TextStyle(fontSize: 12, color: AppColors.textLight)),
          const SizedBox(height: 6),
          Text('कुठून: ${r['pickup']}', style: const TextStyle(fontSize: 13)),
          Text('कुठे: ${r['drop']}', style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 6),
          Text(
              'अंतर: ${(r['km'] as double).toStringAsFixed(0)} km · अंदाजे भाडे: ₹$fare',
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
                  child: const Text('Reject'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _accept(r),
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

  Widget _activeCard(Map<String, dynamic> r) {
    final fare = ParcelData.fare(r['vehicle'] as String, r['km'] as double);
    return _box(
      color: Colors.green.withValues(alpha: 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('✅ काम स्वीकारले · #${r['id']}',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 6),
          Text('पार्सल: ${r['desc']}', style: const TextStyle(fontSize: 13)),
          Text('कुठून: ${r['pickup']}', style: const TextStyle(fontSize: 13)),
          Text('कुठे: ${r['drop']}', style: const TextStyle(fontSize: 13)),
          Text('अंदाजे भाडे: ₹$fare', style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 6),
          Text('ग्राहक: ${r['buyer']} · ${r['phone']}',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue)),
          const SizedBox(height: 4),
          const Text(
            'ग्राहकाला कॉल करून वेळ आणि अंतिम भाडे निश्चित करा. ग्राहकाला तुमचा नंबर दिसला आहे. '
            'बाकीच्या सेलरच्या सूचना बंद झाल्या आहेत.',
            style: TextStyle(fontSize: 12, color: AppColors.textLight),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _finish,
              child: const Text('काम पूर्ण झाले'),
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
          const Text('नवीन काम घेण्यासाठी स्टेटस पुन्हा ON करा.',
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
        title: const Text('🚚 पार्सल कार्गो पॅनल',
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _vehicleCard(),
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _ready,
                  onChanged: (v) {
                    if (v) {
                      if (_noBalance) {
                        _toast('आधी रिचार्ज करा.',
                            color: Colors.red, recharge: true);
                        return;
                      }
                      _goReady();
                    } else {
                      _stopGpsTracking(); // OFF केल्यावर GPS बंद
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
                        ? 'GPS ट्रॅकिंग सुरू. 250 मीटर हालचाल झाल्यास स्टेटस आपोआप OFF होईल.'
                        : 'ON करताना तुमचे सध्याचे लोकेशन Stand म्हणून निश्चित होईल.',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                // Demo बटण काढून टाकले आहे
                if (_ready)
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        Icon(Icons.gps_fixed, size: 14, color: Colors.green),
                        SizedBox(width: 4),
                        Text('GPS सक्रिय आहे (खरा ट्रॅकिंग)',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (_reminderShown) _reminderCard(),
          _walletCard(),
          _box(
            child: Text(
              'आतापर्यंत स्वीकारलेली कामे: ${CargoWallet.jobsAccepted}',
              style:
                  const TextStyle(fontSize: 13, color: AppColors.textDark),
            ),
          ),
          if (active != null) _activeCard(active),
          const Text('नवीन कामाच्या सूचना',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 4),
          const Text('तुमच्या वाहनाच्या, 10 km मधल्या Requirements',
              style: TextStyle(fontSize: 11, color: AppColors.textLight)),
          const SizedBox(height: 8),
          if (_noBalance)
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
                child: Text('सूचना पाहण्यासाठी Ready To Ride ON करा',
                    style: TextStyle(color: AppColors.textLight)),
              ),
            )
          else if (active != null)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text('सध्याचे काम पूर्ण झाल्यावर नवीन सूचना दिसतील',
                    style: TextStyle(color: AppColors.textLight)),
              ),
            )
          else if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text('तुमच्या 10 km मध्ये सध्या नवीन Requirement नाही',
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