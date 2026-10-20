import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

// Demo: प्रोव्हायडरचे service wallet. खरा डेटा Stage 3 मध्ये येईल.
class ServiceWallet {
  static int balance = 200;
  static const int acceptFee = 50;
  static const int lowBalance = 100;
  static const double radiusKm = 20;
}

class ServiceProviderScreen extends StatefulWidget {
  const ServiceProviderScreen({super.key});

  @override
  State<ServiceProviderScreen> createState() => _ServiceProviderScreenState();
}

class _ServiceProviderScreenState extends State<ServiceProviderScreen> {
  static const String _code = '7359';

  // Demo: खरे लोकेशन नसल्यामुळे प्रोव्हायडर "हडपसर" मध्ये आहे असे धरले आहे.
  // kmAway = प्रोव्हायडरपासून त्या ठिकाणाचे अंतर.
  // status: new / accepted / rejected / taken / done
  final List<Map<String, dynamic>> _requests = [
    {
      'id': 'SR501',
      'category': 'प्लंबर',
      'desc': 'बाथरूमच्या नळाला गळती आहे. वॉशर बदलावा लागेल.',
      'qty': '1',
      'when': 'आज',
      'budget': '400',
      'location': 'हडपसर, पुणे',
      'kmAway': 2.5,
      'photos': 2,
      'video': false,
      'buyer': 'रमेश पाटील',
      'phone': '9800000021',
      'status': 'new',
    },
    {
      'id': 'SR502',
      'category': 'प्लंबर',
      'desc': 'किचन सिंकचा पाईप जाम झाला आहे.',
      'qty': '1',
      'when': 'उद्या',
      'budget': '',
      'location': 'मगरपट्टा, पुणे',
      'kmAway': 8.0,
      'photos': 0,
      'video': true,
      'buyer': 'सुनीता जाधव',
      'phone': '9800000022',
      'status': 'new',
    },
    {
      'id': 'SR503',
      'category': 'प्लंबर',
      'desc': '2 नळ बदलायचे आहेत.',
      'qty': '2',
      'when': 'आत्ता तातडीने',
      'budget': '600',
      'location': 'फुरसुंगी, पुणे',
      'kmAway': 14.5,
      'photos': 1,
      'video': false,
      'buyer': 'अजय शिंदे',
      'phone': '9800000023',
      'status': 'new',
    },
    {
      'id': 'SR504',
      'category': 'प्लंबर',
      'desc': 'सोसायटीची पाण्याची टाकी तपासायची आहे.',
      'qty': '1',
      'when': 'या आठवड्यात',
      'budget': '1500',
      'location': 'सासवड',
      'kmAway': 26.0,
      'photos': 0,
      'video': false,
      'buyer': 'प्रिया देशमुख',
      'phone': '9800000024',
      'status': 'new',
    },
  ];

  Map<String, dynamic>? _active;
  // 'working' = काम सुरू, 'report' = रिपोर्ट भरत आहे, 'submitted' = रिपोर्ट पाठवला
  String _phase = 'working';
  int _doneCount = 0;
  final List<String> _log = [];

  final TextEditingController _workCtrl = TextEditingController();
  final TextEditingController _feeCtrl = TextEditingController();
  final TextEditingController _partsCtrl = TextEditingController();
  final TextEditingController _notesCtrl = TextEditingController();
  final TextEditingController _codeCtrl = TextEditingController();
  int _reportPhotos = 0;
  String _codeError = '';

  bool get _noBalance => ServiceWallet.balance < ServiceWallet.acceptFee;
  bool get _low => ServiceWallet.balance < ServiceWallet.lowBalance;

  @override
  void dispose() {
    _workCtrl.dispose();
    _feeCtrl.dispose();
    _partsCtrl.dispose();
    _notesCtrl.dispose();
    _codeCtrl.dispose();
    super.dispose();
  }

  // 20 km मधल्या नवीन विनंत्या, जवळच्या आधी. wallet संपले तर सूचना नाहीत.
  List<Map<String, dynamic>> get _visible {
    if (_noBalance || _active != null) return [];
    final list = _requests
        .where((r) =>
            r['status'] == 'new' &&
            (r['kmAway'] as double) <= ServiceWallet.radiusKm)
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

  void _accept(Map<String, dynamic> r) {
    setState(() {
      r['status'] = 'accepted';
      ServiceWallet.balance -= ServiceWallet.acceptFee;
      _active = r;
      _phase = 'working';
      _codeError = '';
      _codeCtrl.clear();
      _workCtrl.clear();
      _feeCtrl.clear();
      _partsCtrl.clear();
      _notesCtrl.clear();
      _reportPhotos = 0;
      // बाकीच्या विनंत्यांच्या सूचना बंद (Demo: ही सूचना या प्रोव्हायडरकडून काढली)
    });
    if (_low) {
      _toast('काम स्वीकारले. Balance low आहे, रिचार्ज करा.',
          color: Colors.orange, recharge: true);
    } else {
      _toast('काम स्वीकारले. ₹${ServiceWallet.acceptFee} कपात झाले.');
    }
  }

  void _reject(Map<String, dynamic> r) {
    setState(() {
      r['status'] = 'rejected';
      _log.add('#${r['id']} तुम्ही नाकारली. ₹ कपात नाही.');
    });
  }

  // दुसऱ्या प्रोव्हायडरने आधी स्वीकारल्याची नक्कल
  void _takenByOther(Map<String, dynamic> r) {
    setState(() {
      r['status'] = 'taken';
      _log.add('#${r['id']} दुसऱ्या प्रोव्हायडरने आधी स्वीकारली. तुमची सूचना बंद झाली.');
    });
  }

  void _sendReport() {
    if (_workCtrl.text.trim().isEmpty) {
      _toast('काय काम केले ते लिहा', color: Colors.red);
      return;
    }
    if (_feeCtrl.text.trim().isEmpty) {
      _toast('किती fee घेतली ते लिहा', color: Colors.red);
      return;
    }
    setState(() => _phase = 'submitted');
    _toast('रिपोर्ट आणि बिल ग्राहकाला पाठवले.');
  }

  void _submitCode() {
    final a = _active;
    if (a == null) return;
    if (_codeCtrl.text.trim() == _code) {
      setState(() {
        a['status'] = 'done';
        _active = null;
        _doneCount += 1;
        _codeError = '';
        _log.add('#${a['id']} काम पूर्ण झाले.');
      });
      _toast('काम पूर्ण झाले. ग्राहकाला सूचना गेली.');
    } else {
      setState(() => _codeError = 'कोड चुकीचा आहे. ग्राहकाकडून पुन्हा विचारा.');
    }
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
              const Text('सर्व्हिस रिचार्ज',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              const SizedBox(height: 4),
              Text('सध्याची शिल्लक: ₹${ServiceWallet.balance}',
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textLight)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [100, 200, 300, 500]
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
                    setState(() => ServiceWallet.balance += amount);
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

  InputDecoration _deco(String label) => InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      );

  Widget _walletCard() {
    return _box(
      color: _noBalance
          ? Colors.red.withValues(alpha: 0.06)
          : AppColors.primaryBlue.withValues(alpha: 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('सर्व्हिस wallet: ₹${ServiceWallet.balance}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 4),
          Text(
            'प्रत्येक स्वीकारलेल्या कामाला ₹${ServiceWallet.acceptFee} कपात होते. '
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

  String _media(Map<String, dynamic> r) =>
      r['video'] == true ? '1 व्हिडिओ' : '${r['photos']} फोटो';

  Widget _requestCard(Map<String, dynamic> r) {
    return _box(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${r['category']} · #${r['id']}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.textDark)),
              Text('${r['kmAway']} km',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textLight)),
            ],
          ),
          const SizedBox(height: 6),
          Text(r['desc'] as String, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 6),
          Text(
            'Quantity: ${r['qty']} · कधी: ${r['when']}'
            '${(r['budget'] as String).isEmpty ? '' : ' · बजेट ₹${r['budget']}'}',
            style: const TextStyle(fontSize: 12, color: AppColors.textLight),
          ),
          Text('ठिकाण: ${r['location']} · मीडिया: ${_media(r)}',
              style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
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
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => _takenByOther(r),
              child: const Text('Demo: दुसऱ्या प्रोव्हायडरने आधी स्वीकारले'),
            ),
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
          Text('✅ काम स्वीकारले · #${r['id']}',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 6),
          Text('${r['category']}: ${r['desc']}',
              style: const TextStyle(fontSize: 13)),
          Text('ठिकाण: ${r['location']}',
              style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
          const SizedBox(height: 6),
          Text('ग्राहक: ${r['buyer']} · ${r['phone']}',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue)),
          const SizedBox(height: 4),
          const Text(
            'ग्राहकाला कॉल करून वेळ आणि दर निश्चित करा. बाकीच्या प्रोव्हायडरच्या सूचना बंद झाल्या आहेत.',
            style: TextStyle(fontSize: 12, color: AppColors.textLight),
          ),
          const Divider(height: 24),
          if (_phase == 'working')
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => setState(() => _phase = 'report'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('काम झाले, रिपोर्ट भरा'),
              ),
            ),
          if (_phase == 'report') ...[
            const Text('सर्व्हिस रिपोर्ट',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark)),
            const SizedBox(height: 10),
            TextField(
                controller: _workCtrl,
                maxLines: 3,
                decoration: _deco('काय काम केले')),
            const SizedBox(height: 10),
            TextField(
                controller: _feeCtrl,
                keyboardType: TextInputType.number,
                decoration: _deco('किती fee घेतली (₹)')),
            const SizedBox(height: 10),
            TextField(
                controller: _partsCtrl,
                decoration: _deco('कोणते spare part बदलले')),
            const SizedBox(height: 10),
            TextField(
                controller: _notesCtrl,
                maxLines: 2,
                decoration: _deco('महत्त्वाच्या सूचना / remark')),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () => setState(() {
                if (_reportPhotos < 5) _reportPhotos++;
              }),
              icon: const Icon(Icons.photo_camera_outlined),
              label: Text('फोटो जोडा ($_reportPhotos/5)'),
            ),
            const Text('Demo: खरा फोटो काढणे पुढे येईल.',
                style: TextStyle(fontSize: 11, color: AppColors.textLight)),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _sendReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Work Complete, रिपोर्ट पाठवा'),
              ),
            ),
          ],
          if (_phase == 'submitted') ...[
            const Text('रिपोर्ट आणि बिल ग्राहकाला पाठवले.',
                style: TextStyle(
                    fontSize: 13, color: AppColors.textDark)),
            const SizedBox(height: 4),
            const Text(
              'ग्राहकाच्या स्क्रीनवर एक कोड आला आहे. तो कोड ग्राहकाकडून घ्या आणि इथे टाका.',
              style: TextStyle(fontSize: 12, color: AppColors.textLight),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _codeCtrl,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: InputDecoration(
                hintText: '4 अंकी कोड',
                counterText: '',
                errorText: _codeError.isEmpty ? null : _codeError,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const Text('Demo कोड: 7359',
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
                child: const Text('Submit करा, काम पूर्ण'),
              ),
            ),
          ],
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
        title: const Text('🛠️ सर्व्हिस प्रोव्हायडर',
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _walletCard(),
          _box(
            child: Text('आतापर्यंत पूर्ण केलेली कामे: $_doneCount',
                style:
                    const TextStyle(fontSize: 13, color: AppColors.textDark)),
          ),
          if (active != null) _activeCard(active),
          const Text('नवीन कामाच्या सूचना',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 4),
          const Text('तुमच्या 20 km मधील Requirements',
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
                child: Text('तुमच्या 20 km मध्ये सध्या नवीन Requirement नाही',
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
