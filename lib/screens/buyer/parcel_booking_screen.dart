import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/parcel_data.dart';
import 'parcel_status_screen.dart';

class ParcelBookingScreen extends StatefulWidget {
  const ParcelBookingScreen({super.key});

  @override
  State<ParcelBookingScreen> createState() => _ParcelBookingScreenState();
}

class _ParcelBookingScreenState extends State<ParcelBookingScreen> {
  static const String _hereText = 'हडपसर, पुणे (सध्याचे ठिकाण)';

  final TextEditingController _descCtrl = TextEditingController();
  final TextEditingController _weightCtrl = TextEditingController();
  final TextEditingController _lCtrl = TextEditingController();
  final TextEditingController _wCtrl = TextEditingController();
  final TextEditingController _hCtrl = TextEditingController();
  final TextEditingController _pickCtrl = TextEditingController();
  final TextEditingController _dropCtrl = TextEditingController();

  String _vehicle = 'ton1';
  bool _pickHere = true;
  double _km = 12;

  @override
  void dispose() {
    _descCtrl.dispose();
    _weightCtrl.dispose();
    _lCtrl.dispose();
    _wCtrl.dispose();
    _hCtrl.dispose();
    _pickCtrl.dispose();
    _dropCtrl.dispose();
    super.dispose();
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  void _post() {
    if (_descCtrl.text.trim().isEmpty) {
      _toast('कोणते पार्सल पाठवायचे ते लिहा');
      return;
    }
    if (_weightCtrl.text.trim().isEmpty) {
      _toast('पार्सलचे वजन टाका');
      return;
    }
    if (!_pickHere && _pickCtrl.text.trim().isEmpty) {
      _toast('माल कुठून उचलायचा ते लिहा');
      return;
    }
    if (_dropCtrl.text.trim().isEmpty) {
      _toast('माल कुठे पोहोचवायचा ते लिहा');
      return;
    }
    final fare = ParcelData.fare(_vehicle, _km);
    final req = <String, dynamic>{
      'id': 'PC${701 + ParcelRequests.posted.length}',
      'desc': _descCtrl.text.trim(),
      'weight': _weightCtrl.text.trim(),
      'dims':
          '${_lCtrl.text.trim().isEmpty ? '-' : _lCtrl.text.trim()} x '
          '${_wCtrl.text.trim().isEmpty ? '-' : _wCtrl.text.trim()} x '
          '${_hCtrl.text.trim().isEmpty ? '-' : _hCtrl.text.trim()} cm',
      'vehicle': _vehicle,
      'pickup': _pickHere ? _hereText : _pickCtrl.text.trim(),
      'drop': _dropCtrl.text.trim(),
      'km': _km,
      'fare': fare,
    };
    ParcelRequests.posted.add(req);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ParcelStatusScreen(request: req)),
    );
  }

  Widget _label(String t) => Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 6),
        child: Text(t,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark)),
      );

  InputDecoration _deco(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      );

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

  @override
  Widget build(BuildContext context) {
    final fare = ParcelData.fare(_vehicle, _km);
    final lines = ParcelData.chartLines(_vehicle);
    final v = ParcelData.vehicleOf(_vehicle);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('📦 Parcel Cargo',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _label('काय पार्सल पाठवायचे आहे?'),
          TextField(
            controller: _descCtrl,
            maxLines: 3,
            decoration: _deco('पार्सल / मालाची माहिती लिहा'),
          ),
          _label('वजन (kg)'),
          TextField(
            controller: _weightCtrl,
            keyboardType: TextInputType.number,
            decoration: _deco('उदा. 25'),
          ),
          _label('डायमेन्शन (सेमी): लांबी x रुंदी x उंची'),
          Row(
            children: [
              Expanded(
                  child: TextField(
                      controller: _lCtrl,
                      keyboardType: TextInputType.number,
                      decoration: _deco('लांबी'))),
              const SizedBox(width: 8),
              Expanded(
                  child: TextField(
                      controller: _wCtrl,
                      keyboardType: TextInputType.number,
                      decoration: _deco('रुंदी'))),
              const SizedBox(width: 8),
              Expanded(
                  child: TextField(
                      controller: _hCtrl,
                      keyboardType: TextInputType.number,
                      decoration: _deco('उंची'))),
            ],
          ),
          _label('वाहन निवडा'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ParcelData.vehicles
                .map((x) => ChoiceChip(
                      label: Text(x.label),
                      selected: _vehicle == x.key,
                      onSelected: (_) => setState(() => _vehicle = x.key),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${v.label} भाडे',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                const SizedBox(height: 6),
                ...lines.map((l) => Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(l,
                          style: const TextStyle(
                              fontSize: 13, color: AppColors.textDark)),
                    )),
                if (v.temp) ...[
                  const SizedBox(height: 6),
                  const Text('तात्पुरते दर. खरे दर लवकरच.',
                      style:
                          TextStyle(fontSize: 11, color: Colors.deepOrange)),
                ],
              ],
            ),
          ),
          _label('माल कुठून उचलायचा?'),
          Row(
            children: [
              ChoiceChip(
                label: const Text('आत्ता जिथे आहे तिथून'),
                selected: _pickHere,
                onSelected: (_) => setState(() => _pickHere = true),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('दुसऱ्या ठिकाणाहून'),
                selected: !_pickHere,
                onSelected: (_) => setState(() => _pickHere = false),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_pickHere)
            const Text(_hereText,
                style: TextStyle(fontSize: 13, color: AppColors.textLight))
          else
            TextField(
                controller: _pickCtrl, decoration: _deco('Pickup ठिकाण')),
          _label('माल कुठे पोहोचवायचा?'),
          TextField(
            controller: _dropCtrl,
            decoration: InputDecoration(
              hintText: 'Drop ठिकाण',
              prefixIcon: const Icon(Icons.location_on_outlined),
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('अंतर (Demo)',
                  style:
                      TextStyle(fontSize: 13, color: AppColors.textLight)),
              Text('${_km.toStringAsFixed(0)} km',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue)),
            ],
          ),
          Slider(
            value: _km,
            min: 1,
            max: 300,
            divisions: 299,
            activeColor: AppColors.primaryBlue,
            onChanged: (x) => setState(() => _km = x),
          ),
          const Text('खरे अंतर नकाशावरून काढणे पुढे येईल.',
              style: TextStyle(fontSize: 11, color: AppColors.textLight)),
          const SizedBox(height: 12),
          _box(
            color: AppColors.primaryBlue.withValues(alpha: 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('अंदाजे भाडे',
                    style:
                        TextStyle(fontSize: 13, color: AppColors.textLight)),
                const SizedBox(height: 4),
                Text('₹$fare',
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                const SizedBox(height: 4),
                const Text(
                  'हे अंदाजे भाडे आहे. वाहन मालकाशी बोलून अंतिम भाडे आणि वेळ खात्री करून घ्या.',
                  style: TextStyle(fontSize: 12, color: AppColors.textLight),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _post,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Post requirement',
                  style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}