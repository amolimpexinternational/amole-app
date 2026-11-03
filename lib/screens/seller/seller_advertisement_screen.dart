import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/app_colors.dart';

class SellerAdvertisementScreen extends StatefulWidget {
  const SellerAdvertisementScreen({super.key});

  @override
  State<SellerAdvertisementScreen> createState() => _SellerAdvertisementScreenState();
}

class _SellerAdvertisementScreenState extends State<SellerAdvertisementScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Basic Details
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _pollController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController(text: '100');
  
  // Ad Type & Content
  String _adType = 'Photo'; // 'Text', 'Photo', 'Video'
  File? _mediaFile;
  bool _isMediaSelected = false;

  // Duration
  int _selectedDays = 3;
  final List<int> _durationOptions = [1, 2, 3, 4, 5, 6, 7]; // Max 7 Days per rule

  // Target Audience
  String _locationTarget = 'तालुका';
  final List<String> _locationOptions = ['तालुका', 'जिल्हा', 'राज्य', 'देशभर'];
  
  List<String> _selectedAgeGroups = ['२४-४०'];
  final List<String> _ageOptions = ['१३-२३', '२४-४०', '४०-६०', '६०+'];
  
  String _genderTarget = 'सर्व';
  final List<String> _genderOptions = ['सर्व', 'पुरुष', 'स्त्री'];
  
  String _timeSlot = 'Full Day';
  final List<String> _timeOptions = ['सकाळी ७-१२', 'दुपारी १२-५', 'संध्याकाळी ५-१०', 'रात्र १०-७', 'Full Day'];

  // Adv Generator
  String _advGenerator = 'AMOLE (Company)';
  final List<String> _generatorOptions = ['AMOLE (Company)', 'स्वतः (Seller)'];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _pollController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _pickMedia(ImageSource source) async {
    final picker = ImagePicker();
    if (_adType == 'Photo') {
      final img = await picker.pickImage(source: source, imageQuality: 80, maxWidth: 1200);
      if (img != null) setState(() { _mediaFile = File(img.path); _isMediaSelected = true; });
    } else if (_adType == 'Video') {
      final vid = await picker.pickVideo(source: source, maxDuration: const Duration(minutes: 3));
      if (vid != null) setState(() { _mediaFile = File(vid.path); _isMediaSelected = true; });
    }
  }

  // किंमत दर (Cost per Poll Reply) मोजण्यासाठी
  double get _costPerReply {
    if (_adType == 'Text') return 0.10;
    if (_adType == 'Photo') return 0.25;
    if (_adType == 'Video') return 0.50;
    return 0.10;
  }

  void _submitAd() {
    FocusScope.of(context).unfocus();

    if (_adType != 'Text' && !_isMediaSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('कृपया $_adType निवडा'), backgroundColor: AppColors.errorRed),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    final budget = double.tryParse(_budgetController.text) ?? 0;
    if (budget < 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('किमान बजेट ₹100 असणे आवश्यक आहे'), backgroundColor: AppColors.errorRed),
      );
      return;
    }

    // नियमानुसार जर Franchise/CP/Admin असेल तर डायरेक्ट Live, पण सध्या हे Seller स्क्रीन आहे.
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.check_circle, color: AppColors.successGreen, size: 28),
            SizedBox(width: 10),
            Text('जाहिरात पाठवली!'),
          ],
        ),
        content: const Text(
          'तुमची जाहिरात तुमच्या स्थानिक Franchise कडे approval साठी पाठवली आहे. मंजूर झाल्यावर ती Buyers ना दिसायला सुरु होईल.',
          style: TextStyle(color: AppColors.textDark),
        ),
        actions: [
          TextButton(
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

  InputDecoration _inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.lightGrey,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 24),
      child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('जाहिरात तयार करा'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === INFO BOX ===
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: const [
                      Icon(Icons.info_outline, color: Colors.orange, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'तुमची जाहिरात प्रथम फ्रँचायझीकडे अप्रूव्हलसाठी जाईल. मंजूर झाल्यावरच ती Live होईल.',
                          style: TextStyle(fontSize: 12, color: AppColors.textDark),
                        ),
                      ),
                    ],
                  ),
                ),

                // === १. जाहिरातीचा प्रकार ===
                _buildSectionTitle('१. जाहिरातीचा प्रकार निवडा'),
                Wrap(
                  spacing: 10,
                  children: ['Text', 'Photo', 'Video'].map((type) {
                    final isSel = _adType == type;
                    return ChoiceChip(
                      label: Text(type == 'Text' ? 'फक्त मजकूर (₹0.10)' : type == 'Photo' ? 'फोटो (₹0.25)' : 'व्हिडिओ (₹0.50)'),
                      selected: isSel,
                      onSelected: (_) => setState(() { _adType = type; _isMediaSelected = false; _mediaFile = null; }),
                      selectedColor: AppColors.primaryBlue,
                      labelStyle: TextStyle(color: isSel ? Colors.white : AppColors.textDark, fontWeight: FontWeight.bold),
                    );
                  }).toList(),
                ),

                // === २. कंटेंट ===
                _buildSectionTitle('२. जाहिरातीचा फोटो / व्हिडिओ / मजकूर'),
                if (_adType != 'Text')
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => SafeArea(
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.photo_library_outlined),
                                title: const Text('गॅलरीतून निवडा'),
                                onTap: () { Navigator.pop(context); _pickMedia(ImageSource.gallery); },
                              ),
                              ListTile(
                                leading: const Icon(Icons.camera_alt_outlined),
                                title: const Text('कॅमेऱ्यातून निवडा'),
                                onTap: () { Navigator.pop(context); _pickMedia(ImageSource.camera); },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 120, width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _isMediaSelected ? AppColors.successGreen : AppColors.textLight, width: 2),
                      ),
                      child: _isMediaSelected
                          ? const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Icon(Icons.check_circle, color: AppColors.successGreen, size: 40),
                              SizedBox(height: 8),
                              Text('निवड झाली ✓', style: TextStyle(color: AppColors.successGreen, fontWeight: FontWeight.bold)),
                            ])
                          : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Icon(_adType == 'Video' ? Icons.video_library_outlined : Icons.add_photo_alternate_outlined, size: 40, color: AppColors.textLight),
                              const SizedBox(height: 8),
                              Text(_adType == 'Video' ? 'व्हिडिओ निवडण्यासाठी टॅप करा (Max 3 मिनिटे)' : 'फोटो निवडण्यासाठी टॅप करा (Max 5MB)', style: const TextStyle(color: AppColors.textLight, fontSize: 13)),
                            ]),
                    ),
                  ),
                const SizedBox(height: 12),
                
                TextFormField(
                  controller: _titleController,
                  maxLength: 30,
                  decoration: _inputStyle('जाहिरातीचं शीर्षक (उदा. होळी स्पेशल)').copyWith(counterText: ''),
                  validator: (v) => v!.isEmpty ? 'शीर्षक आवश्यक आहे' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descController,
                  maxLines: 3,
                  maxLength: 300, // Text limit rule
                  decoration: _inputStyle('जाहिरातीबद्दल थोडक्यात माहिती... (Max 300 अक्षरे)'),
                  validator: (v) => v!.isEmpty ? 'वर्णन आवश्यक आहे' : null,
                ),

                // === ३. टार्गेट ऑडियन्स ===
                _buildSectionTitle('३. टार्गेट ऑडियन्स (कोणाला दाखवायची?)'),
                _buildDropdown('एरिया (Location)', _locationTarget, _locationOptions, (val) => setState(() => _locationTarget = val!)),
                const SizedBox(height: 10),
                _buildDropdown('वेळ (Time Slot)', _timeSlot, _timeOptions, (val) => setState(() => _timeSlot = val!)),
                const SizedBox(height: 10),
                _buildDropdown('जेंडर (Gender)', _genderTarget, _genderOptions, (val) => setState(() => _genderTarget = val!)),
                const SizedBox(height: 10),
                const Text('वयोगट (Age Group):', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textLight)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  children: _ageOptions.map((age) {
                    final isSel = _selectedAgeGroups.contains(age);
                    return FilterChip(
                      label: Text(age),
                      selected: isSel,
                      onSelected: (val) {
                        setState(() {
                          if (val) _selectedAgeGroups.add(age);
                          else _selectedAgeGroups.remove(age);
                        });
                      },
                      selectedColor: AppColors.primaryBlue.withOpacity(0.2),
                      checkmarkColor: AppColors.primaryBlue,
                    );
                  }).toList(),
                ),

                // === ४. अनिवार्य पोल (Poll) ===
                _buildSectionTitle('४. पोल प्रश्न (अनिवार्य)'),
                TextFormField(
                  controller: _pollController,
                  decoration: _inputStyle('तुमचा प्रश्न (न टाकल्यास डिफॉल्ट प्रश्न विचारला जाईल)'),
                ),
                const SizedBox(height: 4),
                const Text('डिफॉल्ट: "तुम्ही या जाहिरातीत इंटरेस्टेड आहात का?" (Yes/No)', style: TextStyle(fontSize: 11, color: AppColors.textLight)),

                // === ५. ॲड जनरेटर ===
                _buildSectionTitle('५. Adv Generator (जाहिरात निर्माता)'),
                _buildDropdown('जाहिरात कोणी बनवली?', _advGenerator, _generatorOptions, (val) => setState(() => _advGenerator = val!)),
                const SizedBox(height: 4),
                const Text('नियम: निवडलेल्या जनरेटरला १०% वाटा मिळेल.', style: TextStyle(fontSize: 11, color: AppColors.textLight)),

                // === ६. बजेट आणि कालावधी ===
                _buildSectionTitle('६. बजेट आणि कालावधी'),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _budgetController,
                        keyboardType: TextInputType.number,
                        decoration: _inputStyle('किमान बजेट (₹100)'),
                        validator: (v) => v!.isEmpty ? 'बजेट टाका' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('कालावधी (कमाल ७ दिवस):', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textLight)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  children: _durationOptions.map((days) {
                    final isSel = _selectedDays == days;
                    return ChoiceChip(
                      label: Text('$days दिवस'),
                      selected: isSel,
                      onSelected: (_) => setState(() => _selectedDays = days),
                      selectedColor: AppColors.primaryBlue,
                      labelStyle: TextStyle(color: isSel ? Colors.white : AppColors.textDark),
                    );
                  }).toList(),
                ),

                // === ७. किंमत तपशील ===
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade200)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('अंदाजित खर्च (Cost Estimate)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                      const SizedBox(height: 8),
                      Text('प्रति पोल रिप्लाय: ₹${_costPerReply.toStringAsFixed(2)}', style: const TextStyle(fontSize: 13)),
                      Text('कमाल कालावधी: $_selectedDays दिवस', style: const TextStyle(fontSize: 13)),
                      const SizedBox(height: 4),
                      const Text('टीप: बजेट संपल्यास जाहिरात आपोआप बंद होईल.', style: TextStyle(fontSize: 11, color: AppColors.textLight)),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitAd,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('अप्रूव्हलसाठी पाठवा', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textLight)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(12)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}