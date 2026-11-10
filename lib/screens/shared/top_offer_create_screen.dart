import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/app_colors.dart';

class TopOfferCreateScreen extends StatefulWidget {
  final bool isSeller;
  const TopOfferCreateScreen({super.key, this.isSeller = true});

  @override
  State<TopOfferCreateScreen> createState() => _TopOfferCreateScreenState();
}

class _TopOfferCreateScreenState extends State<TopOfferCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _linkCtrl = TextEditingController();
  final _validityCtrl = TextEditingController();

  File? _pickedImage;
  bool _isSubmitting = false;

  // === टार्गेटिंग ===
  String _targetLevel = 'जिल्हा'; // तालुका / जिल्हा / राज्य
  final Set<String> _selectedStates = {};
  final Set<String> _selectedDistricts = {};
  final Set<String> _selectedTalukas = {};

  final List<String> _states = ['महाराष्ट्र', 'कर्नाटक', 'गुजरात', 'गोवा'];
  final Map<String, List<String>> _districtsByState = {
    'महाराष्ट्र': ['पुणे', 'मुंबई', 'नाशिक', 'नागपूर', 'औरंगाबाद'],
    'कर्नाटक': ['बेंगळुरू', 'मैसूर', 'हुबळी'],
    'गुजरात': ['अहमदाबाद', 'सुरत', 'वडोदरा'],
    'गोवा': ['पणजी', 'मडगाव'],
  };
  final Map<String, List<String>> _talukasByDistrict = {
    'पुणे': ['हवेली', 'मुळशी', 'भोर', 'वेल्हे'],
    'मुंबई': ['अंधेरी', 'बोरिवली', 'दादर'],
    'नाशिक': ['नाशिक', 'मालेगाव', 'सिन्नर'],
    'नागपूर': ['नागपूर', 'कामठी', 'हिंगणा'],
    'औरंगाबाद': ['औरंगाबाद', 'गंगापूर', 'पैठण'],
    'बेंगळुरू': ['बेंगळुरू उत्तर', 'बेंगळुरू दक्षिण'],
    'मैसूर': ['मैसूर', 'नंजनगुड'],
    'हुबळी': ['हुबळी', 'धारवाड'],
    'अहमदाबाद': ['अहमदाबाद', 'दस्क्रोई'],
    'सुरत': ['सुरत', 'ओलपाड'],
    'वडोदरा': ['वडोदरा', 'पाडरा'],
    'पणजी': ['पणजी', 'पोंडा'],
    'मडगाव': ['मडगाव', 'साल्सेट'],
  };

  Future<void> _pickImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (img != null) {
      setState(() => _pickedImage = File(img.path));
    }
  }

  Future<void> _submitOffer() async {
    if (!_formKey.currentState!.validate()) return;
    if (_pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया फोटो अपलोड करा!'), backgroundColor: Colors.red),
      );
      return;
    }

    // === टार्गेटिंग व्हॅलिडेशन ===
    final hasTarget = _selectedStates.isNotEmpty || _selectedDistricts.isNotEmpty || _selectedTalukas.isNotEmpty;
    if (!hasTarget) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया किमान एक ठिकाण निवडा!'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(widget.isSeller ? 'अप्रूव्हलसाठी पाठवलं ✅' : 'ऑफर Live झाली ✅'),
        content: Text(
          widget.isSeller
              ? 'तुमची टॉप ऑफर फ्रॅंचाईजी/CP/Admin कडे अप्रूव्हलसाठी गेली आहे.'
              : 'तुमची टॉप ऑफर थेट Live झाली आहे.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            child: const Text('ठीक आहे'),
          ),
        ],
      ),
    );
  }

  // === ठिकाण निवड यादी (multi-select dialog) ===
  void _showLocationPicker(String type) {
    List<String> items = [];
    Set<String> selected;

    if (type == 'राज्य') {
      items = _states;
      selected = _selectedStates;
    } else if (type == 'जिल्हा') {
      final allDistricts = <String>[];
      for (final s in _districtsByState.values) {
        allDistricts.addAll(s);
      }
      items = allDistricts;
      selected = _selectedDistricts;
    } else {
      final allTalukas = <String>[];
      for (final t in _talukasByDistrict.values) {
        allTalukas.addAll(t);
      }
      items = allTalukas;
      selected = _selectedTalukas;
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$type निवडा', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () {
                        setSheetState(() => selected.clear());
                      },
                      child: const Text('सर्व काढा'),
                    ),
                  ],
                ),
              ),
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
                      activeColor: Colors.pink,
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
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                    child: const Text('ठीक आहे'),
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
          color: count > 0 ? Colors.pink.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: count > 0 ? Colors.pink.shade300 : Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(Icons.location_on, color: count > 0 ? Colors.pink : Colors.grey, size: 20),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                count > 0 ? '$type: $count निवडले' : '$type निवडा',
                style: TextStyle(
                  fontSize: 13,
                  color: count > 0 ? Colors.pink.shade700 : AppColors.textLight,
                  fontWeight: count > 0 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: count > 0 ? Colors.pink : Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('क्रिएट टॉप ऑफर'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === १. फोटो (16:9 क्रॉप) ===
              const Text('ऑफर फोटो *', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickImage,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: _pickedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(11),
                            child: Image.file(_pickedImage!, fit: BoxFit.cover),
                          )
                        : const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_a_photo, size: 40, color: AppColors.textLight),
                                SizedBox(height: 8),
                                Text('फोटो निवडा (16:9 क्रॉप होईल)', style: TextStyle(color: AppColors.textLight)),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // === २. शीर्षक ===
              const Text('ऑफरचे शीर्षक *', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleCtrl,
                decoration: InputDecoration(
                  hintText: 'उदा. दिवाळी धमाका 20% सूट',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (v) => v == null || v.isEmpty ? 'शीर्षक आवश्यक' : null,
              ),
              const SizedBox(height: 16),

              // === ३. वस्तूची माहिती ===
              const Text('वस्तूची माहिती *', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descCtrl,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'वस्तूची संपूर्ण माहिती द्या...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (v) => v == null || v.isEmpty ? 'माहिती आवश्यक' : null,
              ),
              const SizedBox(height: 16),

              // === ४. किंमत ===
              const Text('किंमत (₹) *', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _priceCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'उदा. 599',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (v) => v == null || v.isEmpty ? 'किंमत आवश्यक' : null,
              ),
              const SizedBox(height: 16),

              // === ५. प्रॉडक्ट लिंक ===
              const Text('प्रॉडक्टची लिंक *', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _linkCtrl,
                decoration: InputDecoration(
                  hintText: 'https://amole.in/product/123',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.link, color: Colors.pink),
                ),
                validator: (v) => v == null || v.isEmpty ? 'लिंक आवश्यक' : null,
              ),
              const SizedBox(height: 16),

              // === ६. वैधता ===
              const Text('वैधता (दिवस) *', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _validityCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'उदा. 7',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (v) => v == null || v.isEmpty ? 'वैधता आवश्यक' : null,
              ),
              const SizedBox(height: 24),

              // === ७. टार्गेटिंग ===
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.pink.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('🎯 ऑफर कुठे दाखवायची? *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 4),
                    const Text('किमान एक ठिकाण निवडा (एकाहून जास्त निवडता येतात)', style: TextStyle(fontSize: 11, color: AppColors.textLight)),
                    const SizedBox(height: 12),
                    _locationChip('राज्य', _selectedStates),
                    const SizedBox(height: 8),
                    _locationChip('जिल्हा', _selectedDistricts),
                    const SizedBox(height: 8),
                    _locationChip('तालुका', _selectedTalukas),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // === सबमिट ===
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitOffer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          widget.isSeller ? 'अप्रूव्हलसाठी पाठवा' : 'ऑफर Live करा',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}