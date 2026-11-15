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
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, padding: const EdgeInsets.symmetric(vertical: 14)),
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

  Future<void> _pickImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (img != null) setState(() => _pickedImage = File(img.path));
  }

  // === Validation ===
  bool _validateBeforePreview() {
    if (!_formKey.currentState!.validate()) return false;
    if (_pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया फोटो अपलोड करा!'), backgroundColor: Colors.red),
      );
      return false;
    }
    final hasTarget = _selectedStates.isNotEmpty || _selectedDistricts.isNotEmpty ||
        _selectedTalukas.isNotEmpty || _selectedPincodes.isNotEmpty;
    if (!hasTarget) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया किमान एक ठिकाण निवडा!'), backgroundColor: Colors.red),
      );
      return false;
    }
    return true;
  }

  // ✅ Preview dialog
  void _showPreview() {
    if (!_validateBeforePreview()) return;

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
                  const Icon(Icons.visibility, color: Colors.pink),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('ऑफर Preview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: scrollCtrl,
                padding: const EdgeInsets.all(16),
                children: [
                  // === ऑफर कशी दिसेल (Top Offer Slider सारखी) ===
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.pink, Colors.pinkAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(_pickedImage!, fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(_titleCtrl.text, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(_descCtrl.text, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text('₹${_priceCtrl.text}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            const Icon(Icons.access_time, color: Colors.white70, size: 14),
                            const SizedBox(width: 4),
                            Text('${_validityCtrl.text} दिवस', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // === ऑफर तपशील ===
                  _previewSection('ऑफर तपशील', [
                    _previewRow('शीर्षक', _titleCtrl.text),
                    _previewRow('वर्णन', _descCtrl.text),
                    _previewRow('किंमत', '₹${_priceCtrl.text}'),
                    _previewRow('वैधता', '${_validityCtrl.text} दिवस (7 दिवसांनंतर आपोआप डिलीट)'),
                    _previewRow('प्रॉडक्ट लिंक', _linkCtrl.text),
                  ]),

                  // === टार्गेटिंग ===
                  _previewSection('🎯 टार्गेटिंग', [
                    _previewRow('राज्य', _selectedStates.isEmpty ? '—' : _selectedStates.join(', ')),
                    _previewRow('जिल्हे', _selectedDistricts.isEmpty ? '—' : _selectedDistricts.join(', ')),
                    _previewRow('तालुके', _selectedTalukas.isEmpty ? '—' : _selectedTalukas.join(', ')),
                    _previewRow('पिनकोड', _selectedPincodes.isEmpty ? '—' : _selectedPincodes.join(', ')),
                  ]),
                ],
              ),
            ),
            // === Edit + Approval बटन ===
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(ctx),
                      icon: const Icon(Icons.edit, color: Colors.pink),
                      label: const Text('Edit करा', style: TextStyle(color: Colors.pink)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Colors.pink),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _submitOffer();
                      },
                      icon: Icon(
                        widget.isSeller ? Icons.send : Icons.check_circle,
                        color: Colors.white,
                      ),
                      label: Text(
                        widget.isSeller ? 'अप्रूव्हलसाठी पाठवा' : 'ऑफर Live करा',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
        color: AppColors.lightGrey.withValues(alpha: 0.5),
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

  // ✅ Submit (preview नंतर)
  Future<void> _submitOffer() async {
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
              ? 'तुमची टॉप ऑफर फ्रॅंचाईजी/CP/Admin कडे अप्रूव्हलसाठी गेली आहे.\n\n'
                  'निवडलेले: ${_selectedStates.length} राज्य, ${_selectedDistricts.length} जिल्हे, '
                  '${_selectedTalukas.length} तालुके, ${_selectedPincodes.length} पिनकोड'
              : 'तुमची टॉप ऑफर थेट Live झाली आहे.\n\n'
                  'निवडलेले: ${_selectedStates.length} राज्य, ${_selectedDistricts.length} जिल्हे, '
                  '${_selectedTalukas.length} तालुके, ${_selectedPincodes.length} पिनकोड',
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
              // === फोटो ===
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
                        ? ClipRRect(borderRadius: BorderRadius.circular(11), child: Image.file(_pickedImage!, fit: BoxFit.cover))
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

              // === शीर्षक ===
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

              // === वर्णन ===
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

              // === किंमत ===
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

              // === प्रॉडक्ट लिंक ===
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

              // ✅ वैधता — 1 ते 7 दिवस
              const Text('वैधता (दिवस) *', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _validityCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '1 ते 7 दिवस',
                  helperText: 'कमाल 7 दिवस — 7 दिवसांनंतर ऑफर आपोआप डिलीट होईल',
                  helperMaxLines: 2,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'वैधता आवश्यक';
                  final days = int.tryParse(v);
                  if (days == null) return 'फक्त आकडे टाका';
                  if (days < 1 || days > 7) return 'वैधता 1 ते 7 दिवसांपर्यंत असावी';
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // === Hierarchical Target Audience ===
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
                    const Text(
                      'राज्य → जिल्हा → तालुका → पिनकोड (प्रत्येक स्तरावर Select All)',
                      style: TextStyle(fontSize: 11, color: AppColors.textLight),
                    ),
                    const SizedBox(height: 12),
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
              const SizedBox(height: 30),

              // ✅ Preview बटन
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _showPreview,
                  icon: const Icon(Icons.visibility, color: Colors.white),
                  label: const Text('Preview बघा', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '※ Preview बघितल्यावर Edit करता येईल किंवा Approval साठी पाठवता येईल.',
                style: TextStyle(fontSize: 11, color: AppColors.textLight, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}