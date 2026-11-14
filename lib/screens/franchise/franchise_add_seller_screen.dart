import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/app_colors.dart';

class FranchiseAddSellerScreen extends StatefulWidget {
  const FranchiseAddSellerScreen({super.key});

  @override
  State<FranchiseAddSellerScreen> createState() => _FranchiseAddSellerScreenState();
}

class _FranchiseAddSellerScreenState extends State<FranchiseAddSellerScreen> {
  int _currentStep = 0;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  // Step 1 Controllers
  final _shopNameCtrl = TextEditingController();
  final _ownerNameCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _altMobileCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _pincodeCtrl = TextEditingController();
  final _mapsLinkCtrl = TextEditingController();
  String _category = 'किराणा';

  // Step 2 Controllers
  final _aadharCtrl = TextEditingController();
  final _panCtrl = TextEditingController();
  final _vehicleCtrl = TextEditingController();
  final _licenseCtrl = TextEditingController();
  final _bankAccCtrl = TextEditingController();
  final _ifscCtrl = TextEditingController();
  final _bankNameCtrl = TextEditingController();

  File? _shopPhoto;
  File? _selfie;
  bool _agreeTerms = false;
  bool _selfDeclaration = false;

  final List<String> _categories = [
    'किराणा', 'भाजीपाला', 'मेडिकल', 'कपडे', 'खाद्यपदार्थ',
    'इलेक्ट्रॉनिक', 'हार्डवेअर', 'सौंदर्य', 'इतर',
  ];

  @override
  void dispose() {
    _shopNameCtrl.dispose(); _ownerNameCtrl.dispose();
    _mobileCtrl.dispose(); _altMobileCtrl.dispose();
    _addressCtrl.dispose(); _pincodeCtrl.dispose();
    _mapsLinkCtrl.dispose(); _aadharCtrl.dispose();
    _panCtrl.dispose(); _vehicleCtrl.dispose();
    _licenseCtrl.dispose(); _bankAccCtrl.dispose();
    _ifscCtrl.dispose(); _bankNameCtrl.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_formKey1.currentState!.validate()) {
      setState(() => _currentStep = 1);
    }
  }

  void _previousStep() {
    setState(() => _currentStep = 0);
  }

  Future<void> _pickImage(bool isShopPhoto) async {
    final img = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 70);
    if (img != null) {
      setState(() {
        if (isShopPhoto) {
          _shopPhoto = File(img.path);
        } else {
          _selfie = File(img.path);
        }
      });
    }
  }

  void _submitSeller() {
    if (!_formKey2.currentState!.validate()) return;
    if (_shopPhoto == null || _selfie == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('दुकानाचा फोटो आणि सेल्फी आवश्यक'), backgroundColor: Colors.red),
      );
      return;
    }
    if (!_agreeTerms || !_selfDeclaration) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('T&C आणि स्वयं-घोषणा स्वीकारा'), backgroundColor: Colors.red),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('✅ सेलर जोडला'),
        content: Text(
          "${_shopNameCtrl.text} ला यशस्वीरित्या जोडलं गेलं.\n\n"
          "स्थिती: Pending Verification (72 तास)\n"
          "Franchise GPS visit नंतर अप्रूव्ह होईल.",
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('ठीक आहे'),
          ),
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
        title: const Text('नवीन सेलर जोडा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // === Step Indicator ===
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                _stepItem(1, 'मूलभूत माहिती', _currentStep >= 0),
                _stepDivider(),
                _stepItem(2, 'KYC + बँक', _currentStep >= 1),
              ],
            ),
          ),
          Expanded(
            child: _currentStep == 0 ? _buildStep1() : _buildStep2(),
          ),
        ],
      ),
    );
  }

  Widget _stepItem(int num, String label, bool active) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: active ? AppColors.primaryBlue : Colors.grey.shade300,
            child: Text('$num', style: TextStyle(color: active ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 11, fontWeight: active ? FontWeight.bold : FontWeight.normal, color: active ? AppColors.primaryBlue : AppColors.textLight)),
        ],
      ),
    );
  }

  Widget _stepDivider() => Container(width: 40, height: 2, color: AppColors.lightGrey);

  Widget _buildStep1() {
    return Form(
      key: _formKey1,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Step 1 — मूलभूत माहिती', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          _field('दुकानाचे / सेलरचे नाव *', _shopNameCtrl, 'उदा. राजेश किराणा स्टोअर', (v) => v!.trim().isEmpty ? 'आवश्यक' : null),
          _field('मालकाचे नाव *', _ownerNameCtrl, 'उदा. राजेश पाटील', (v) => v!.trim().isEmpty ? 'आवश्यक' : null),
          _field('मोबाईल नंबर *', _mobileCtrl, '१० अंकी', (v) => v!.trim().length != 10 ? '१० अंकी नंबर' : null, keyboardType: TextInputType.phone, maxLength: 10),
          _field('पर्यायी मोबाईल', _altMobileCtrl, 'पर्यायी नंबर (ऐच्छिक)', (v) => null, keyboardType: TextInputType.phone, maxLength: 10),
          _field('पूर्ण पत्ता *', _addressCtrl, 'दुकानाचा पूर्ण पत्ता', (v) => v!.trim().isEmpty ? 'आवश्यक' : null, maxLines: 3),
          _field('पिनकोड *', _pincodeCtrl, '६ अंकी', (v) => v!.trim().length != 6 ? '६ अंकी पिनकोड' : null, keyboardType: TextInputType.number, maxLength: 6),
          _field('GPS / Google Maps Location Link *', _mapsLinkCtrl, 'https://maps.app.goo.gl/...', (v) => v!.trim().isEmpty ? 'Location link आवश्यक' : null),

          const SizedBox(height: 8),
          const Text('श्रेणी *', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _category,
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), contentPadding: const EdgeInsets.symmetric(horizontal: 12)),
            items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() => _category = v!),
          ),

          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _nextStep,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('पुढे जा → KYC', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return Form(
      key: _formKey2,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Step 2 — KYC + बँक + फोटो', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          _field('आधार क्रमांक *', _aadharCtrl, '१२ अंकी', (v) => v!.trim().length != 12 ? '१२ अंकी आधार' : null, keyboardType: TextInputType.number, maxLength: 12),
          _field('पॅन क्रमांक *', _panCtrl, 'उदा. ABCDE1234F', (v) => v!.trim().length != 10 ? '१० अक्षरी पॅन' : null, maxLength: 10),
          _field('गाडी नंबर (असल्यास)', _vehicleCtrl, 'उदा. MH12AB1234', (v) => null),
          _field('लायसन नंबर (असल्यास)', _licenseCtrl, 'DL नंबर', (v) => null),

          const SizedBox(height: 8),
          const Text('बँक माहिती *', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _field('बँकेचे नाव *', _bankNameCtrl, 'उदा. SBI, HDFC', (v) => v!.trim().isEmpty ? 'आवश्यक' : null),
          _field('खाते क्रमांक *', _bankAccCtrl, 'बँक खाते क्र.', (v) => v!.trim().isEmpty ? 'आवश्यक' : null, keyboardType: TextInputType.number),
          _field('IFSC कोड *', _ifscCtrl, 'उदा. SBIN0001234', (v) => v!.trim().length != 11 ? '११ अक्षरी IFSC' : null),

          const SizedBox(height: 16),
          const Text('फोटो *', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _photoBox('दुकानाचा फोटो', _shopPhoto, () => _pickImage(true))),
              const SizedBox(width: 12),
              Expanded(child: _photoBox('सेल्फी (दुकानासमोर)', _selfie, () => _pickImage(false))),
            ],
          ),

          const SizedBox(height: 20),
          CheckboxListTile(
            value: _agreeTerms,
            onChanged: (v) => setState(() => _agreeTerms = v ?? false),
            title: const Text('मी Amole कंपनीच्या सर्व अटी व शर्तींना संमती देतो.', style: TextStyle(fontSize: 13)),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppColors.primaryBlue,
          ),
          CheckboxListTile(
            value: _selfDeclaration,
            onChanged: (v) => setState(() => _selfDeclaration = v ?? false),
            title: const Text('मी दिलेली सर्व माहिती बरोबर आणि खरी आहे असे स्वयं-घोषणा देतो.', style: TextStyle(fontSize: 13)),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppColors.primaryBlue,
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text('← मागे'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _submitSeller,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.successGreen,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('✅ सेलर जोडा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, String hint, String? Function(String?) validator, {TextInputType? keyboardType, int? maxLength, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 6),
          TextFormField(
            controller: ctrl,
            keyboardType: keyboardType,
            maxLength: maxLength,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              counterText: '',
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }

  Widget _photoBox(String label, File? file, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: file == null ? Colors.grey.shade100 : null,
          border: Border.all(color: file == null ? Colors.grey.shade300 : AppColors.successGreen, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: file != null
            ? ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.file(file, fit: BoxFit.cover, width: double.infinity))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_a_photo, color: AppColors.primaryBlue, size: 28),
                  const SizedBox(height: 6),
                  Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11)),
                ],
              ),
      ),
    );
  }
}
