import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import '../../../constants/app_colors.dart';

class SellerRegistrationScreen extends StatefulWidget {
  const SellerRegistrationScreen({super.key});
  @override
  State<SellerRegistrationScreen> createState() => _SellerRegistrationScreenState();
}

class _SellerRegistrationScreenState extends State<SellerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _businessNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _publicContactController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _villageController = TextEditingController();
  final _talukaController = TextEditingController();
  final _districtController = TextEditingController();
  final _stateController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _keywordsController = TextEditingController();

  // KYC Controllers
  final _aadhaarController = TextEditingController();
  final _panController = TextEditingController();
  final _vehicleController = TextEditingController();
  final _licenseController = TextEditingController();

  File? _businessImage;
  bool _gpsLoading = false;
  String _gpsStatus = 'GPS Location नाही';
  bool _gpsEnabled = false;

  // Categories - मुख्य १२ मॉड्यूल + इतर
  final List<Map<String, String>> _allCategories = [
    {'name': 'Global Shopping', 'code': 'GS'},
    {'name': 'ZatPat (स्थानिक किराणा)', 'code': 'ZP'},
    {'name': 'हॉटेल फूड', 'code': 'HF'},
    {'name': 'रिक्षा / टॅक्सी', 'code': 'TX'},
    {'name': 'सर्व्हिसेस (Repair)', 'code': 'SV'},
    {'name': 'पार्सल कार्गो', 'code': 'PC'},
    {'name': 'रिसेल / Rent', 'code': 'RR'},
    {'name': 'किराणा मार्ट', 'code': 'KM'},
    {'name': 'नोकरी (Jobs)', 'code': 'JB'},
    {'name': 'Mom\'s Miracle (Baby)', 'code': 'MM'},
    {'name': 'मॅन्युफॅक्चरर', 'code': 'MF'},
    {'name': 'शेतकरी व भाजीपाला', 'code': 'FV'},
    // इतर पर्याय
    {'name': 'इलेक्ट्रॉनिक्स', 'code': 'EL'},
    {'name': 'कपडे व फॅशन', 'code': 'CF'},
    {'name': 'दागिने', 'code': 'JW'},
    {'name': 'ब्युटी पार्लर', 'code': 'BP'},
    {'name': 'मेडिकल', 'code': 'MD'},
    {'name': 'बेकरी', 'code': 'BK'},
    {'name': 'इतर', 'code': 'OT'},
  ];
  final List<String> _selectedCategories = [];

  @override
  void dispose() {
    _businessNameController.dispose();
    _ownerNameController.dispose();
    _mobileController.dispose();
    _publicContactController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _villageController.dispose();
    _talukaController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _pinCodeController.dispose();
    _keywordsController.dispose();
    _aadhaarController.dispose();
    _panController.dispose();
    _vehicleController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  // ── Image Picker ──────────────────────────────────────────
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source, imageQuality: 80, maxWidth: 1200);
    if (image == null) return;
    setState(() => _businessImage = File(image.path));
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) => SafeArea(
        child: Wrap(children: [
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Gallery मधून निवडा'),
            onTap: () { Navigator.pop(ctx); _pickImage(ImageSource.gallery); },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt_outlined),
            title: const Text('Camera ने फोटो घ्या'),
            onTap: () { Navigator.pop(ctx); _pickImage(ImageSource.camera); },
          ),
          if (_businessImage != null)
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Photo काढा', style: TextStyle(color: Colors.red)),
              onTap: () { Navigator.pop(ctx); setState(() => _businessImage = null); },
            ),
        ]),
      ),
    );
  }

  // ── GPS ───────────────────────────────────────────────────
  Future<void> _getGPS() async {
    setState(() => _gpsLoading = true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() { _gpsStatus = 'Location service बंद आहे'; _gpsLoading = false; });
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() { _gpsStatus = 'Permission नाकारली'; _gpsLoading = false; });
          return;
        }
      }
      final position = await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.high));
      final lat = position.latitude;
      final lng = position.longitude;
      setState(() {
        _gpsEnabled = true;
        _gpsStatus = 'GPS मिळाली: ${lat.toStringAsFixed(4)}, ${lng.toStringAsFixed(4)}';
        _gpsLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('GPS Location मिळाली! ✅'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      setState(() { _gpsStatus = 'GPS Error: $e'; _gpsLoading = false; });
    }
  }

  // ── Continue ──────────────────────────────────────────────
  void _continue() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('किमान एक Category निवडा'), backgroundColor: Colors.red),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration Step 1 पूर्ण! ✅'), backgroundColor: Colors.green),
    );
  }

  // ── Helpers ───────────────────────────────────────────────
  InputDecoration _inputDeco({required String label, required IconData icon, String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(top: 24, bottom: 10),
    child: Row(children: [
      Container(width: 4, height: 18,
        decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(2))),
      const SizedBox(width: 8),
      Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
    ]),
  );

  Widget _card(Widget child) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: child,
  );

  // ── Category Section ──────────────────────────────────────
  Widget _buildCategories() => _card(Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        const Text('Category निवडा', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(10)),
          child: Text('${_selectedCategories.length} निवडले', style: const TextStyle(color: Colors.white, fontSize: 11)),
        ),
      ]),
      const SizedBox(height: 4),
      const Text('एकापेक्षा जास्त निवडता येते', style: TextStyle(fontSize: 11, color: AppColors.textLight)),
      const SizedBox(height: 10),
      Wrap(
        spacing: 8, runSpacing: 8,
        children: _allCategories.map((cat) {
          final sel = _selectedCategories.contains(cat['code']);
          return GestureDetector(
            onTap: () => setState(() {
              if (sel) {
                _selectedCategories.remove(cat['code']);
              } else {
                _selectedCategories.add(cat['code']!);
              }
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: sel ? AppColors.primaryBlue : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: sel ? AppColors.primaryBlue : Colors.grey.shade300),
              ),
              child: Text(cat['name']!, style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500,
                color: sel ? Colors.white : AppColors.textDark,
              )),
            ),
          );
        }).toList(),
      ),
    ],
  ));

  // ── GPS Section ───────────────────────────────────────────
  Widget _buildGPS() => _card(Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('GPS Location', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
      const SizedBox(height: 4),
      const Text('दुकानाची अचूक location – Customer ला Map वर दिसेल', style: TextStyle(fontSize: 11, color: AppColors.textLight)),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _gpsEnabled ? Colors.green.shade50 : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _gpsEnabled ? Colors.green.shade200 : Colors.grey.shade300),
            ),
            child: Text(_gpsStatus, style: TextStyle(
              fontSize: 12, color: _gpsEnabled ? Colors.green.shade700 : AppColors.textLight)),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: _gpsLoading ? null : _getGPS,
          icon: _gpsLoading
            ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : const Icon(Icons.my_location, size: 16),
          label: Text(_gpsLoading ? 'शोधत आहे...' : 'GPS घ्या', style: const TextStyle(fontSize: 12)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: Colors.white,
            minimumSize: const Size(0, 40),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ]),
    ],
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Seller Registration'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text('Step 1 of Seller Registration',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryBlue)),
              const SizedBox(height: 6),
              const Text('Basic Business Information',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('तुमच्या व्यवसायाची माहिती भरा.',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
              const SizedBox(height: 20),

              // Photo
              Center(
                child: GestureDetector(
                  onTap: _showImageOptions,
                  child: Stack(children: [
                    CircleAvatar(
                      radius: 58,
                      backgroundColor: Colors.white,
                      backgroundImage: _businessImage != null ? FileImage(_businessImage!) : null,
                      child: _businessImage == null
                        ? const Icon(Icons.storefront_outlined, size: 54, color: AppColors.primaryBlue)
                        : null,
                    ),
                    Positioned(right: 0, bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle),
                        child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                      ),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 8),
              const Center(child: Text('दुकानाचा फोटो / Logo', style: TextStyle(fontWeight: FontWeight.w600))),
              const SizedBox(height: 20),

              // Business Info
              _sectionTitle('व्यवसाय माहिती'),
              TextFormField(
                controller: _businessNameController,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDeco(label: 'Business Name', icon: Icons.business_outlined, hint: 'दुकानाचे / व्यवसायाचे नाव'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Business Name आवश्यक आहे' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _ownerNameController,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDeco(label: 'Owner Name', icon: Icons.person_outline, hint: 'मालकाचे नाव'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Owner Name आवश्यक आहे' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _keywordsController,
                decoration: _inputDeco(label: 'Search Keywords', icon: Icons.search_outlined, hint: 'उदा: grocery, किराणा, seeds'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Keywords आवश्यक आहे' : null,
              ),
              const SizedBox(height: 4),
              Text('Customer हे keywords टाकून तुम्हाला शोधतील',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),

              // Categories
              _sectionTitle('व्यवसाय Category'),
              _buildCategories(),

              // Contact
              _sectionTitle('संपर्क माहिती'),
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: _inputDeco(label: 'Login Mobile (OTP साठी)', icon: Icons.phone_android_outlined, hint: '10 अंकी नंबर').copyWith(counterText: ''),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Mobile Number आवश्यक आहे';
                  if (v.replaceAll(RegExp(r'\D'), '').length != 10) return 'Valid 10 अंकी नंबर टाका';
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _publicContactController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: _inputDeco(label: 'Public Contact Number', icon: Icons.contact_phone_outlined, hint: 'Customer ला दिसणारा नंबर').copyWith(counterText: ''),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Public Contact आवश्यक आहे';
                  if (v.replaceAll(RegExp(r'\D'), '').length != 10) return 'Valid 10 अंकी नंबर टाका';
                  return null;
                },
              ),
              const SizedBox(height: 4),
              Text('हा नंबर Customer ला Profile वर दिसेल', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              const SizedBox(height: 14),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDeco(label: 'Email (Optional)', icon: Icons.email_outlined, hint: 'example@email.com'),
              ),

              // Address
              _sectionTitle('पत्ता'),
              TextFormField(
                controller: _addressController,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 2,
                decoration: _inputDeco(label: 'पूर्ण पत्ता', icon: Icons.location_on_outlined, hint: 'दुकानाचा संपूर्ण पत्ता'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'पत्ता आवश्यक आहे' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _villageController,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDeco(label: 'गाव / शहर', icon: Icons.location_city_outlined),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'गाव/शहर आवश्यक आहे' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _talukaController,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDeco(label: 'तालुका', icon: Icons.map_outlined),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'तालुका आवश्यक आहे' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _districtController,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDeco(label: 'जिल्हा', icon: Icons.account_balance_outlined),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'जिल्हा आवश्यक आहे' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _stateController,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDeco(label: 'राज्य', icon: Icons.flag_outlined),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'राज्य आवश्यक आहे' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _pinCodeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: _inputDeco(label: 'PIN Code', icon: Icons.pin_drop_outlined, hint: '6 अंकी PIN Code').copyWith(counterText: ''),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'PIN Code आवश्यक आहे';
                  if (!RegExp(r'^\d{6}$').hasMatch(v.trim())) return 'Valid 6 अंकी PIN Code टाका';
                  return null;
                },
              ),

              // GPS
              _sectionTitle('GPS Location'),
              _buildGPS(),

              // KYC Details (Optional)
              _sectionTitle('Optional KYC Details'),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Text(
                  'या माहितीची सक्ती नाही. ही माहिती तुम्ही नंतर KYC करताना Franchise ला देखील देऊ शकता.',
                  style: TextStyle(fontSize: 11, color: Colors.blue.shade700),
                ),
              ),
              TextFormField(
                controller: _aadhaarController,
                keyboardType: TextInputType.number,
                maxLength: 12,
                decoration: _inputDeco(label: 'Aadhaar Number (आधार)', icon: Icons.credit_card).copyWith(counterText: ''),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _panController,
                textCapitalization: TextCapitalization.characters,
                maxLength: 10,
                decoration: _inputDeco(label: 'PAN Number (पॅन)', icon: Icons.badge_outlined).copyWith(counterText: ''),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _vehicleController,
                textCapitalization: TextCapitalization.characters,
                decoration: _inputDeco(label: 'Vehicle Number (गाडी नंबर)', icon: Icons.directions_car_outlined, hint: 'उदा. MH-12-AB-1234'),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _licenseController,
                textCapitalization: TextCapitalization.characters,
                decoration: _inputDeco(label: 'Driving License (लायसन)', icon: Icons.drive_eta_outlined, hint: 'उदा. MH1220180012345'),
              ),

              const SizedBox(height: 28),
              SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}