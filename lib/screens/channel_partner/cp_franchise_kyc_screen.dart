import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/app_colors.dart';

class CpFranchiseKycScreen extends StatefulWidget {
  final Map<String, dynamic> franchise;
  const CpFranchiseKycScreen({super.key, required this.franchise});

  @override
  State<CpFranchiseKycScreen> createState() => _CpFranchiseKycScreenState();
}

class _CpFranchiseKycScreenState extends State<CpFranchiseKycScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameCtrl;
  late TextEditingController _ownerCtrl;
  late TextEditingController _mobileCtrl;
  late TextEditingController _altMobileCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _pincodeCtrl;
  late TextEditingController _mapsCtrl;
  late TextEditingController _aadharCtrl;
  late TextEditingController _panCtrl;
  late TextEditingController _vehicleCtrl;
  late TextEditingController _licenseCtrl;
  late TextEditingController _bankAccCtrl;
  late TextEditingController _ifscCtrl;
  late TextEditingController _bankNameCtrl;

  File? _shopPhoto;
  File? _selfie;
  bool _agreeTerms = false;
  bool _selfDeclaration = false;

  @override
  void initState() {
    super.initState();
    final f = widget.franchise;
    _nameCtrl = TextEditingController(text: f['name'] ?? '');
    _ownerCtrl = TextEditingController(text: f['owner'] ?? '');
    _mobileCtrl = TextEditingController(text: f['phone'] ?? '');
    _altMobileCtrl = TextEditingController(text: f['altPhone'] ?? '');
    _addressCtrl = TextEditingController(text: f['address'] ?? '');
    _pincodeCtrl = TextEditingController(text: f['pincode'] ?? '');
    _mapsCtrl = TextEditingController(text: f['mapsLink'] ?? '');
    _aadharCtrl = TextEditingController(text: f['aadhar'] ?? '');
    _panCtrl = TextEditingController(text: f['pan'] ?? '');
    _vehicleCtrl = TextEditingController(text: f['vehicle'] ?? '');
    _licenseCtrl = TextEditingController(text: f['license'] ?? '');
    _bankAccCtrl = TextEditingController(text: f['bankAcc'] ?? '');
    _ifscCtrl = TextEditingController(text: f['ifsc'] ?? '');
    _bankNameCtrl = TextEditingController(text: f['bankName'] ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); _ownerCtrl.dispose(); _mobileCtrl.dispose();
    _altMobileCtrl.dispose(); _addressCtrl.dispose(); _pincodeCtrl.dispose();
    _mapsCtrl.dispose(); _aadharCtrl.dispose(); _panCtrl.dispose();
    _vehicleCtrl.dispose(); _licenseCtrl.dispose(); _bankAccCtrl.dispose();
    _ifscCtrl.dispose(); _bankNameCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage(bool isShop) async {
    final img = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 70);
    if (img != null) setState(() => isShop ? _shopPhoto = File(img.path) : _selfie = File(img.path));
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeTerms || !_selfDeclaration) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('T&C आणि स्वयं-घोषणा स्वीकारा'), backgroundColor: Colors.red));
      return;
    }

    // TODO: Stage 3 — Firestore मध्ये सेव्ह करा
    widget.franchise['name'] = _nameCtrl.text;
    widget.franchise['owner'] = _ownerCtrl.text;
    widget.franchise['phone'] = _mobileCtrl.text;
    widget.franchise['altPhone'] = _altMobileCtrl.text;
    widget.franchise['address'] = _addressCtrl.text;
    widget.franchise['pincode'] = _pincodeCtrl.text;
    widget.franchise['mapsLink'] = _mapsCtrl.text;
    widget.franchise['aadhar'] = _aadharCtrl.text;
    widget.franchise['pan'] = _panCtrl.text;
    widget.franchise['vehicle'] = _vehicleCtrl.text;
    widget.franchise['license'] = _licenseCtrl.text;
    widget.franchise['bankAcc'] = _bankAccCtrl.text;
    widget.franchise['ifsc'] = _ifscCtrl.text;
    widget.franchise['bankName'] = _bankNameCtrl.text;

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('Franchise KYC'),
        actions: [
          IconButton(icon: const Icon(Icons.check), onPressed: _save),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // === मूलभूत ===
            _sectionTitle('मूलभूत माहिती'),
            _field('Franchise नाव *', _nameCtrl, 'Franchise नाव', (v) => v!.trim().isEmpty ? 'आवश्यक' : null),
            _field('मालकाचे नाव *', _ownerCtrl, 'मालकाचे नाव', (v) => v!.trim().isEmpty ? 'आवश्यक' : null),
            _field('मोबाईल *', _mobileCtrl, '१० अंकी', (v) => v!.trim().length != 10 ? '१० अंकी' : null, keyboardType: TextInputType.phone, maxLength: 10),
            _field('पर्यायी मोबाईल', _altMobileCtrl, 'ऐच्छिक', (v) => null, keyboardType: TextInputType.phone, maxLength: 10),
            _field('पूर्ण पत्ता *', _addressCtrl, 'पत्ता', (v) => v!.trim().isEmpty ? 'आवश्यक' : null, maxLines: 2),
            _field('पिनकोड *', _pincodeCtrl, '६ अंकी', (v) => v!.trim().length != 6 ? '६ अंकी' : null, keyboardType: TextInputType.number, maxLength: 6),
            _field('GPS/Maps Link *', _mapsCtrl, 'https://maps.app.goo.gl/...', (v) => v!.trim().isEmpty ? 'आवश्यक' : null),

            const SizedBox(height: 12),
            _sectionTitle('KYC माहिती'),
            _field('आधार क्रमांक *', _aadharCtrl, '१२ अंकी', (v) => v!.trim().length != 12 ? '१२ अंकी' : null, keyboardType: TextInputType.number, maxLength: 12),
            _field('पॅन क्रमांक *', _panCtrl, 'उदा. ABCDE1234F', (v) => v!.trim().length != 10 ? '१० अक्षरी' : null, maxLength: 10),
            _field('गाडी नंबर (असल्यास)', _vehicleCtrl, 'MH12AB1234', (v) => null),
            _field('लायसन नंबर (असल्यास)', _licenseCtrl, 'DL नंबर', (v) => null),

            const SizedBox(height: 12),
            _sectionTitle('बँक माहिती'),
            _field('बँकेचे नाव *', _bankNameCtrl, 'SBI / HDFC', (v) => v!.trim().isEmpty ? 'आवश्यक' : null),
            _field('खाते क्रमांक *', _bankAccCtrl, 'खाते क्र.', (v) => v!.trim().isEmpty ? 'आवश्यक' : null, keyboardType: TextInputType.number),
            _field('IFSC कोड *', _ifscCtrl, 'SBIN0001234', (v) => v!.trim().length != 11 ? '११ अक्षरी' : null),

            const SizedBox(height: 12),
            _sectionTitle('फोटो'),
            Row(children: [
              Expanded(child: _photoBox('दुकानाचा फोटो', _shopPhoto, () => _pickImage(true))),
              const SizedBox(width: 12),
              Expanded(child: _photoBox('सेल्फी', _selfie, () => _pickImage(false))),
            ]),

            const SizedBox(height: 16),
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

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                child: const Text('✅ सेव्ह करा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
    );
  }

  Widget _field(String label, TextEditingController ctrl, String hint, String? Function(String?) validator, {TextInputType? keyboardType, int? maxLength, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      ]),
    );
  }

  Widget _photoBox(String label, File? file, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: file == null ? Colors.grey.shade100 : null,
          border: Border.all(color: file == null ? Colors.grey.shade300 : AppColors.successGreen, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: file != null
            ? ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.file(file, fit: BoxFit.cover, width: double.infinity))
            : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.add_a_photo, color: AppColors.primaryBlue, size: 28),
                const SizedBox(height: 6),
                Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11)),
              ]),
      ),
    );
  }
}
