import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/services_data.dart';
import 'service_request_status_screen.dart';

class ServiceRequirementScreen extends StatefulWidget {
  final String category;
  const ServiceRequirementScreen({super.key, this.category = ''});

  @override
  State<ServiceRequirementScreen> createState() =>
      _ServiceRequirementScreenState();
}

class _ServiceRequirementScreenState extends State<ServiceRequirementScreen> {
  static const int _maxWords = 500;

  final TextEditingController _descCtrl = TextEditingController();
  final TextEditingController _qtyCtrl = TextEditingController(text: '1');
  final TextEditingController _budgetCtrl = TextEditingController();
  final TextEditingController _locCtrl = TextEditingController();

  final List<String> _whenOptions = const [
    'आत्ता तातडीने',
    'आज',
    'उद्या',
    'या आठवड्यात',
  ];
  String _when = 'आज';
  int _photos = 0;
  bool _video = false;

  @override
  void dispose() {
    _descCtrl.dispose();
    _qtyCtrl.dispose();
    _budgetCtrl.dispose();
    _locCtrl.dispose();
    super.dispose();
  }

  int get _words {
    final t = _descCtrl.text.trim();
    if (t.isEmpty) return 0;
    return t.split(RegExp(r'\s+')).length;
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  void _post() {
    if (_descCtrl.text.trim().isEmpty) {
      _toast('कोणती सेवा हवी आहे ते लिहा');
      return;
    }
    if (_words > _maxWords) {
      _toast('माहिती $_maxWords शब्दांपेक्षा जास्त आहे');
      return;
    }
    if (_locCtrl.text.trim().isEmpty) {
      _toast('सेवा कोणत्या ठिकाणी हवी ते टाका');
      return;
    }
    final req = <String, dynamic>{
      'id': 'SR${301 + ServiceRequests.posted.length}',
      'category': widget.category,
      'desc': _descCtrl.text.trim(),
      'qty': _qtyCtrl.text.trim().isEmpty ? '1' : _qtyCtrl.text.trim(),
      'when': _when,
      'budget': _budgetCtrl.text.trim(),
      'location': _locCtrl.text.trim(),
      'photos': _photos,
      'video': _video,
    };
    ServiceRequests.posted.add(req);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceRequestStatusScreen(request: req),
      ),
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

  @override
  Widget build(BuildContext context) {
    final over = _words > _maxWords;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Post your Requirement',
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (widget.category.isNotEmpty)
            Chip(label: Text('सेवा: ${widget.category}')),
          _label('काय सेवा हवी आहे?'),
          TextField(
            controller: _descCtrl,
            maxLines: 6,
            onChanged: (_) => setState(() {}),
            decoration: _deco('तुमची गरज सविस्तर लिहा (जास्तीत जास्त 500 शब्द)'),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text('$_words / $_maxWords शब्द',
                style: TextStyle(
                    fontSize: 11,
                    color: over ? Colors.red : AppColors.textLight)),
          ),
          _label('30 सेकंद व्हिडिओ किंवा 5 फोटो'),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _video
                      ? null
                      : () => setState(() {
                            if (_photos < 5) _photos++;
                          }),
                  icon: const Icon(Icons.photo_camera_outlined),
                  label: Text('फोटो जोडा ($_photos/5)'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _photos > 0
                      ? null
                      : () => setState(() => _video = !_video),
                  icon: Icon(_video
                      ? Icons.check_circle
                      : Icons.videocam_outlined),
                  label: Text(_video ? 'व्हिडिओ जोडला' : 'व्हिडिओ जोडा'),
                ),
              ),
            ],
          ),
          const Text(
            'Demo: खरे फोटो आणि व्हिडिओ निवडणे पुढे येईल.',
            style: TextStyle(fontSize: 11, color: AppColors.textLight),
          ),
          if (_photos > 0 || _video)
            TextButton(
              onPressed: () => setState(() {
                _photos = 0;
                _video = false;
              }),
              child: const Text('मीडिया काढा'),
            ),
          _label('Quantity किती पाहिजे?'),
          TextField(
            controller: _qtyCtrl,
            keyboardType: TextInputType.number,
            decoration: _deco('उदा. 1'),
          ),
          _label('कधी पाहिजे?'),
          Wrap(
            spacing: 8,
            children: _whenOptions
                .map((w) => ChoiceChip(
                      label: Text(w),
                      selected: _when == w,
                      onSelected: (_) => setState(() => _when = w),
                    ))
                .toList(),
          ),
          _label('अपेक्षित बजेट (₹)'),
          TextField(
            controller: _budgetCtrl,
            keyboardType: TextInputType.number,
            decoration: _deco('उदा. 500'),
          ),
          _label('कोणत्या ठिकाणी ही सेवा पाहिजे?'),
          TextField(
            controller: _locCtrl,
            decoration: InputDecoration(
              hintText: 'लोकेशन टाका',
              prefixIcon: const Icon(Icons.location_on_outlined),
              suffixIcon: TextButton(
                onPressed: () => setState(
                    () => _locCtrl.text = 'हडपसर, पुणे (सध्याचे ठिकाण)'),
                child: const Text('सध्याचे'),
              ),
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'पोस्ट केल्यावर या ठिकाणाच्या 20 km मधील नोंदणीकृत प्रोव्हायडरना सूचना जाईल.',
            style: TextStyle(fontSize: 11, color: AppColors.textLight),
          ),
          const SizedBox(height: 18),
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
              child: const Text('Requirement Post करा',
                  style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}