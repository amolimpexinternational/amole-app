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
  String _adType = 'Photo';
  File? _mediaFile;
  bool _isMediaSelected = false;

  // Duration
  int _selectedDays = 3;
  final List<int> _durationOptions = [1, 2, 3, 4, 5, 6, 7];

  // === Hierarchical Location Data ===
  final Map<String, Map<String, Map<String, List<String>>>> _locationData = {
    'महाराष्ट्र': {
      'पुणे': {
        'हवेली': ['411028', '411001', '411014', '411036'],
        'मुळशी': ['412115', '412108', '412109'],
        'जुन्नर': ['410502', '410503', '410504'],
        'बारामती': ['413102', '413103', '413104'],
      },
      'मुंबई': {
        'अंधेरी': ['400053', '400058', '400069'],
        'बोरिवली': ['400066', '400091', '400092'],
        'दादर': ['400014', '400028'],
      },
      'नाशिक': {
        'नाशिक': ['422001', '422002', '422003'],
        'मालेगाव': ['423203', '423204'],
        'सिन्नर': ['422103', '422104'],
      },
    },
    'कर्नाटक': {
      'बेंगळुरू': {
        'बेंगळुरू उत्तर': ['560001', '560002', '560003'],
        'बेंगळुरू दक्षिण': ['560004', '560005', '560006'],
      },
      'मैसूर': {
        'मैसूर': ['570001', '570002', '570003'],
        'नंजनगुड': ['571301', '571302'],
      },
    },
    'गुजरात': {
      'अहमदाबाद': {
        'अहमदाबाद': ['380001', '380002', '380003'],
        'दस्क्रोई': ['382210', '382213'],
      },
      'सुरत': {
        'सुरत': ['395001', '395002', '395003'],
        'ओलपाड': ['394540', '394541'],
      },
    },
  };

  final Set<String> _selectedStates = {};
  final Set<String> _selectedDistricts = {};
  final Set<String> _selectedTalukas = {};
  final Set<String> _selectedPincodes = {};

  // Target Audience
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

  // === Location Helpers ===
  List<String> _allDistricts() {
    final list = <String>[];
    for (final d in _locationData.values) list.addAll(d.keys);
    return list;
  }

  List<String> _allTalukas() {
    final list = <String>[];
    for (final d in _locationData.values) {
      for (final t in d.values) list.addAll(t.keys);
    }
    return list;
  }

  List<String> _allPincodes() {
    final list = <String>[];
    for (final d in _locationData.values) {
      for (final t in d.values) {
        for (final p in t.values) list.addAll(p);
      }
    }
    return list;
  }

  void _showLocationPicker(String type) {
    List<String> items = [];
    Set<String> selected;

    switch (type) {
      case 'राज्य':
        items = _locationData.keys.toList();
        selected = _selectedStates;
        break;
      case 'जिल्हा':
        items = _allDistricts();
        selected = _selectedDistricts;
        break;
      case 'तालुका':
        items = _allTalukas();
        selected = _selectedTalukas;
        break;
      case 'पिनकोड':
        items = _allPincodes();
        selected = _selectedPincodes;
        break;
      default:
        return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (ctx, scrollController) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('$type निवडा', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    TextButton(
                      onPressed: () {
                        setSheetState(() {
                          if (selected.length == items.length) {
                            selected.clear();
                          } else {
                            selected.clear();
                            selected.addAll(items);
                          }
                        });
                        setState(() {});
                      },
                      child: Text(
                        selected.length == items.length ? 'सर्व काढा' : 'सर्व निवडा',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${selected.length} / ${items.length} निवडले',
                    style: const TextStyle(fontSize: 12, color: AppColors.textLight),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return CheckboxListTile(
                      title: Text(item),
                      value: selected.contains(item),
                      activeColor: AppColors.primaryBlue,
                      onChanged: (v) {
                        setSheetState(() {
                          if (v == true) {
                            selected.add(item);
                          } else {
                            selected.remove(item);
                          }
                        });
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14)),
                    child: const Text('ठीक आहे', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _locationChip(String type, Set<String> selected) {
    final count = selected.length;
    return InkWell(
      onTap: () => _showLocationPicker(type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: count > 0 ? AppColors.primaryBlue.withOpacity(0.08) : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: count > 0 ? AppColors.primaryBlue.withOpacity(0.4) : Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(Icons.location_on, color: count > 0 ? AppColors.primaryBlue : Colors.grey, size: 20),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                count > 0 ? '$type: $count निवडले' : '$type निवडा',
                style: TextStyle(
                  fontSize: 13,
                  color: count > 0 ? AppColors.primaryBlue : AppColors.textLight,
                  fontWeight: count > 0 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: count > 0 ? AppColors.primaryBlue : Colors.grey),
          ],
        ),
      ),
    );
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

  double get _costPerReply {
    if (_adType == 'Text') return 0.10;
    if (_adType == 'Photo') return 0.25;
    if (_adType == 'Video') return 0.50;
    return 0.10;
  }

  bool _validateBeforePreview() {
    if (_adType != 'Text' && !_isMediaSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('कृपया $_adType निवडा'), backgroundColor: AppColors.errorRed),
      );
      return false;
    }
    if (!_formKey.currentState!.validate()) return false;

    final budget = double.tryParse(_budgetController.text) ?? 0;
    if (budget < 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('किमान बजेट ₹100 असणे आवश्यक आहे'), backgroundColor: AppColors.errorRed),
      );
      return false;
    }

    final hasTarget = _selectedStates.isNotEmpty || _selectedDistricts.isNotEmpty ||
        _selectedTalukas.isNotEmpty || _selectedPincodes.isNotEmpty;
    if (!hasTarget) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया किमान एक ठिकाण निवडा!'), backgroundColor: AppColors.errorRed),
      );
      return false;
    }
    return true;
  }

  // ✅ Preview Dialog
  void _showPreview() {
    if (!_validateBeforePreview()) return;

    final budget = int.tryParse(_budgetController.text.trim()) ?? 0;
    final pollQuestion = _pollController.text.trim().isEmpty
        ? 'तुम्ही या जाहिरातीत इंटरेस्टेड आहात का?'
        : _pollController.text.trim();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (ctx, scrollCtrl) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.visibility, color: AppColors.primaryBlue),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('जाहिरात Preview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: scrollCtrl,
                padding: const EdgeInsets.all(16),
                children: [
                  // जाहिरात कशी दिसेल
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primaryBlue, AppColors.royalBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_adType != 'Text' && _mediaFile != null)
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(_mediaFile!, fit: BoxFit.cover),
                            ),
                          )
                        else if (_adType != 'Text')
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Icon(Icons.campaign, color: Colors.white70, size: 60),
                            ),
                          ),
                        const SizedBox(height: 12),
                        Text(_titleController.text, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(
                          _adType == 'Text' ? _descController.text : 'AMOLE Sponsored',
                          style: const TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('Poll: $pollQuestion', style: const TextStyle(color: Colors.white, fontSize: 11)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  _previewSection('📋 जाहिरात तपशील', [
                    _previewRow('शीर्षक', _titleController.text),
                    if (_adType == 'Text') _previewRow('मजकूर', _descController.text),
                    if (_adType != 'Text') _previewRow('प्रकार', _adType.toUpperCase()),
                    _previewRow('पोल प्रश्न', pollQuestion),
                    _previewRow('बजेट', '₹$budget'),
                    _previewRow('कालावधी', '$_selectedDays दिवस (7 दिवसांनंतर आपोआप बंद)'),
                    _previewRow('प्रति पोल रिप्लाय', '₹${_costPerReply.toStringAsFixed(2)}'),
                    _previewRow('Adv Generator', _advGenerator),
                  ]),

                  _previewSection('🎯 कोणाला दिसेल?', [
                    _previewRow('राज्य', _selectedStates.isEmpty ? '—' : _selectedStates.join(', ')),
                    _previewRow('जिल्हे', _selectedDistricts.isEmpty ? '—' : _selectedDistricts.join(', ')),
                    _previewRow('तालुके', _selectedTalukas.isEmpty ? '—' : _selectedTalukas.join(', ')),
                    _previewRow('पिनकोड', _selectedPincodes.isEmpty ? '—' : _selectedPincodes.join(', ')),
                    _previewRow('वयोगट', _selectedAgeGroups.join(', ')),
                    _previewRow('लिंग', _genderTarget),
                    _previewRow('वेळ', _timeSlot),
                  ]),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.orange, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'तुमची जाहिरात प्रथम फ्रँचायझीकडे अप्रूव्हलसाठी जाईल. मंजूर झाल्यावरच ती Live होईल.',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(ctx),
                      icon: const Icon(Icons.edit, color: AppColors.primaryBlue),
                      label: const Text('Edit करा', style: TextStyle(color: AppColors.primaryBlue)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: AppColors.primaryBlue),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        minimumSize: const Size(0, 44),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _submitAd();
                      },
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                      label: const Text('अप्रूव्हलसाठी पाठवा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        minimumSize: const Size(0, 44),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewSection(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _previewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  // ✅ Approval साठी पाठवा
  void _submitAd() {
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
                  maxLength: 300,
                  decoration: _inputStyle('जाहिरातीबद्दल थोडक्यात माहिती... (Max 300 अक्षरे)'),
                  validator: (v) => v!.isEmpty ? 'वर्णन आवश्यक आहे' : null,
                ),

                // === ३. टार्गेट ऑडियन्स ===
                _buildSectionTitle('३. टार्गेट ऑडियन्स (कोणाला दाखवायची?)'),

                // ✅ Hierarchical Location
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('🎯 जाहिरात कुठे दाखवायची?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(height: 4),
                      const Text('राज्य → जिल्हा → तालुका → पिनकोड', style: TextStyle(fontSize: 11, color: AppColors.textLight)),
                      const SizedBox(height: 10),
                      _locationChip('राज्य', _selectedStates),
                      const SizedBox(height: 8),
                      _locationChip('जिल्हा', _selectedDistricts),
                      const SizedBox(height: 8),
                      _locationChip('तालुका', _selectedTalukas),
                      const SizedBox(height: 8),
                      _locationChip('पिनकोड', _selectedPincodes),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

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
                // ✅ Preview बटन
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _showPreview,
                    icon: const Icon(Icons.visibility, color: Colors.white),
                    label: const Text('Preview बघा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '※ Preview बघितल्यावर Edit करता येईल किंवा अप्रूव्हलसाठी पाठवता येईल.',
                  style: TextStyle(fontSize: 11, color: AppColors.textLight, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
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
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14))
