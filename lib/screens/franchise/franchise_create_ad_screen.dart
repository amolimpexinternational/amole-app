import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'package:file_picker/file_picker.dart';

class FranchiseCreateAdScreen extends StatefulWidget {
  /// Edit mode साठी — जर दिलं तर fields pre-fill होतील
  final Map<String, dynamic>? initialAd;
  const FranchiseCreateAdScreen({super.key, this.initialAd});

  @override
  State<FranchiseCreateAdScreen> createState() => _FranchiseCreateAdScreenState();
}

class _FranchiseCreateAdScreenState extends State<FranchiseCreateAdScreen> {
  final _formKey = GlobalKey<FormState>();

  String _contentType = 'Text';
  final _titleController = TextEditingController();
  final _textController = TextEditingController();
  final _pollQuestionController = TextEditingController();
  final _budgetController = TextEditingController();

  String? _pickedFileName;
  String? _fileError;

  String _ageGroup = '२४–४०';
  String _gender = 'दोन्ही';
  String _timeSlot = 'Full Day';
  int _durationDays = 3;

  bool get _isEditMode => widget.initialAd != null;

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

  static const int _maxPhotoBytes = 5 * 1024 * 1024;

  @override
  void initState() {
    super.initState();
    // ✅ Edit mode — pre-fill fields
    final ad = widget.initialAd;
    if (ad != null) {
      _titleController.text = (ad['title'] ?? '').toString();
      _textController.text = (ad['description'] ?? '').toString();

      // Budget: '₹500' → '500'
      final budgetStr = (ad['budget'] ?? '')
          .toString()
          .replaceAll('₹', '')
          .replaceAll(',', '')
          .trim();
      if (budgetStr.isNotEmpty) _budgetController.text = budgetStr;

      // Days: '7 दिवस' → 7
      final daysStr = (ad['days'] ?? '').toString();
      final match = RegExp(r'\d+').firstMatch(daysStr);
      if (match != null) {
        final d = int.tryParse(match.group(0)!) ?? 3;
        _durationDays = d.clamp(1, 7);
      }

      // Gender: 'सर्व' → 'दोन्ही'
      final g = (ad['targetGender'] ?? '').toString();
      if (g == 'सर्व' || g == 'दोन्ही') {
        _gender = 'दोन्ही';
      } else if (g == 'स्त्री') {
        _gender = 'स्त्री';
      } else if (g == 'पुरुष') {
        _gender = 'पुरुष';
      }

      // Ad type detection
      if (ad['image'] != null) {
        _contentType = 'Photo';
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    _pollQuestionController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  double get _costPerReply {
    if (_contentType == 'Text') return 0.10;
    if (_contentType == 'Photo') return 0.25;
    if (_contentType == 'Video') return 0.50;
    return 0.10;
  }

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
          color: count > 0 ? AppColors.primaryBlue.withValues(alpha: 0.08) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: count > 0 ? AppColors.primaryBlue.withValues(alpha: 0.4) : Colors.grey.shade300),
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

  Future<void> _pickFile() async {
    setState(() => _fileError = null);
    final files = await FilePicker.pickFiles(
      type: _contentType == 'Photo' ? FileType.image : FileType.video,
    );
    if (files.isEmpty) return;

    final file = files.first;
    final size = await file.length();

    if (_contentType == 'Photo' && size > _maxPhotoBytes) {
      setState(() {
        _fileError = 'फोटो ५ MB पेक्षा मोठा आहे (सध्याचा आकार: ${(size / (1024 * 1024)).toStringAsFixed(2)} MB). कृपया लहान फोटो निवडा.';
        _pickedFileName = null;
      });
      return;
    }

    setState(() {
      _pickedFileName = file.name;
      _fileError = null;
    });
  }

  bool _validateBeforePreview() {
    if (!_formKey.currentState!.validate()) return false;

    if (_contentType != 'Text' && _pickedFileName == null && !_isEditMode) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('कृपया $_contentType फाईल निवडा')),
      );
      return false;
    }

    final budget = int.tryParse(_budgetController.text.trim()) ?? 0;
    if (budget < 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('किमान बजेट ₹१०० असणे आवश्यक आहे')),
      );
      return false;
    }

    final hasTarget = _selectedStates.isNotEmpty ||
        _selectedDistricts.isNotEmpty ||
        _selectedTalukas.isNotEmpty ||
        _selectedPincodes.isNotEmpty;
    // Edit mode मध्ये जुना targetArea असू शकतो — validation skip
    if (!_isEditMode && !hasTarget) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया किमान एक ठिकाण निवडा!')),
      );
      return false;
    }

    return true;
  }

  void _showPreview() {
    if (!_validateBeforePreview()) return;

    final budget = int.tryParse(_budgetController.text.trim()) ?? 0;
    final pollQuestion = _pollQuestionController.text.trim().isEmpty
        ? 'तुम्ही या जाहिरातीत इंटरेस्टेड आहात का?'
        : _pollQuestionController.text.trim();

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
                  Expanded(
                    child: Text(_isEditMode ? 'Edit केलेली जाहिरात' : 'जाहिरात Preview',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                        if (_contentType != 'Text')
                          Container(
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _contentType == 'Photo' ? Icons.image : Icons.videocam,
                                    color: Colors.white70,
                                    size: 50,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _pickedFileName ?? '$_contentType फाईल',
                                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (_contentType != 'Text') const SizedBox(height: 12),
                        Text(
                          _titleController.text,
                          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _contentType == 'Text' ? _textController.text : 'AMOLE Sponsored',
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
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
                    if (_contentType == 'Text') _previewRow('मजकूर', _textController.text),
                    if (_contentType != 'Text') _previewRow('प्रकार', _contentType.toUpperCase()),
                    _previewRow('पोल प्रश्न', pollQuestion),
                    _previewRow('बजेट', '₹$budget'),
                    _previewRow('कालावधी', '$_durationDays दिवस'),
                    _previewRow('प्रति पोल रिप्लाय', '₹${_costPerReply.toStringAsFixed(2)}'),
                  ]),

                  _previewSection('🎯 कोणाला दिसेल?', [
                    _previewRow('राज्य', _selectedStates.isEmpty ? '—' : _selectedStates.join(', ')),
                    _previewRow('जिल्हे', _selectedDistricts.isEmpty ? '—' : _selectedDistricts.join(', ')),
                    _previewRow('तालुके', _selectedTalukas.isEmpty ? '—' : _selectedTalukas.join(', ')),
                    _previewRow('पिनकोड', _selectedPincodes.isEmpty ? '—' : _selectedPincodes.join(', ')),
                    _previewRow('वयोगट', _ageGroup),
                    _previewRow('लिंग', _gender),
                    _previewRow('वेळ', _timeSlot),
                  ]),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.flash_on, color: Colors.green, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Franchise असल्यामुळे ही जाहिरात थेट Live होईल — Approval ची गरज नाही.',
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
                        _liveAd();
                      },
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                      label: Text(
                        _isEditMode ? 'Update करा — Live' : 'कन्फर्म करा — Live करा',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.successGreen,
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

  void _liveAd() {
    final budget = int.tryParse(_budgetController.text.trim()) ?? 0;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 28),
            const SizedBox(width: 8),
            Text(_isEditMode ? '✅ जाहिरात Update झाली' : '✅ जाहिरात Live झाली'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade300),
              ),
              child: const Row(
                children: [
                  Icon(Icons.live_tv, color: Colors.green, size: 20),
                  SizedBox(width: 8),
                  Text('Status: LIVE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text('प्रकार: ${_contentType.toUpperCase()}'),
            Text('बजेट: ₹$budget'),
            Text('कालावधी: $_durationDays दिवस'),
            const SizedBox(height: 8),
            Text(
              _isEditMode
                  ? 'Edit केलेली जाहिरात Live आहे.'
                  : 'तुमची जाहिरात आता "जाहिरात विभाग" मध्ये Live आहे.',
              style: const TextStyle(fontSize: 12, color: AppColors.textLight, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen),
            child: const Text('ठीक आहे', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 8),
        child: Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          _isEditMode ? 'जाहिरात Edit करा' : 'जाहिरात तयार करा',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                border: Border.all(color: Colors.green.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.flash_on, color: Colors.green.shade800, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Franchise ची जाहिरात थेट Live होते — Approval लागत नाही.',
                      style: TextStyle(color: Colors.green.shade900, fontSize: 12.5),
                    ),
                  ),
                ],
              ),
            ),

            _sectionTitle('१. कन्टेंट प्रकार'),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Text', label: Text('Text'), icon: Icon(Icons.text_fields)),
                ButtonSegment(value: 'Photo', label: Text('Photo'), icon: Icon(Icons.image_outlined)),
                ButtonSegment(value: 'Video', label: Text('Video'), icon: Icon(Icons.videocam_outlined)),
              ],
              selected: {_contentType},
              onSelectionChanged: (s) {
                setState(() {
                  _contentType = s.first;
                  _pickedFileName = null;
                  _fileError = null;
                });
              },
            ),

            _sectionTitle('२. जाहिरात शीर्षक'),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'उदा. दिवाळी धमाका 20% सूट',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'शीर्षक आवश्यक' : null,
            ),

            _sectionTitle('३. कंटेंट'),
            if (_contentType == 'Text')
              TextFormField(
                controller: _textController,
                maxLength: 300,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'जाहिरातीचा मजकूर लिहा (कमाल ३०० अक्षरं)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'मजकूर आवश्यक आहे' : null,
              )
            else ...[
              Text(
                _contentType == 'Photo' ? 'कमाल आकार: ५ MB' : 'कमाल कालावधी: ३ मिनिटे (१८० सेकंद)',
                style: const TextStyle(fontSize: 12, color: AppColors.textLight),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: _pickFile,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.4)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _contentType == 'Photo' ? Icons.add_photo_alternate_outlined : Icons.video_call_outlined,
                        color: AppColors.primaryBlue,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _pickedFileName == null ? '$_contentType निवडण्यासाठी टॅप करा' : _pickedFileName!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                      ),
                    ],
                  ),
                ),
              ),
              if (_fileError != null) ...[
                const SizedBox(height: 8),
                Text(_fileError!, style: const TextStyle(color: Colors.red, fontSize: 12)),
              ],
            ],

            _sectionTitle('४. पोल प्रश्न (ऐच्छिक)'),
            TextFormField(
              controller: _pollQuestionController,
              decoration: InputDecoration(
                hintText: 'रिकामं ठेवल्यास डिफॉल्ट प्रश्न वापरला जाईल',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),

            _sectionTitle('५. ऑडियन्स टार्गेटिंग'),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.2)),
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

            DropdownButtonFormField<String>(
              initialValue: _ageGroup,
              decoration: InputDecoration(labelText: 'वयोगट (Age Group)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              items: ['१३–२३', '२४–४०', '४०–६०', '६०+']
                  .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
              onChanged: (v) => setState(() => _ageGroup = v!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _gender,
              decoration: InputDecoration(labelText: 'लिंग (Gender)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              items: ['दोन्ही', 'स्त्री', 'पुरुष']
                  .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
              onChanged: (v) => setState(() => _gender = v!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _timeSlot,
              decoration: InputDecoration(labelText: 'वेळ (Time Slot)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              items: ['सकाळी ७–१२', 'दुपारी १२–५', 'संध्याकाळी ५–१०', 'रात्री १०–७', 'Full Day']
                  .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
              onChanged: (v) => setState(() => _timeSlot = v!),
            ),

            _sectionTitle('६. बजेट व कालावधी'),
            TextFormField(
              controller: _budgetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'बजेट (₹)',
                hintText: 'किमान ₹१००',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (v) {
                final n = int.tryParse(v ?? '');
                if (n == null) return 'योग्य रक्कम टाका';
                if (n < 100) return 'किमान बजेट ₹१०० आवश्यक आहे';
                return null;
              },
            ),
            const SizedBox(height: 12),
            Text('कालावधी: $_durationDays दिवस (कमाल ७ दिवस)', style: const TextStyle(fontWeight: FontWeight.w600)),
            Slider(
              value: _durationDays.toDouble(),
              min: 1,
              max: 7,
              divisions: 6,
              label: '$_durationDays दिवस',
              activeColor: AppColors.primaryBlue,
              onChanged: (v) => setState(() => _durationDays = v.round()),
            ),

            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade200)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('अंदाजित खर्च (Cost Estimate)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                  const SizedBox(height: 8),
                  Text('प्रति पोल रिप्लाय: ₹${_costPerReply.toStringAsFixed(2)}', style: const TextStyle(fontSize: 13)),
                  Text('कमाल कालावधी: $_durationDays दिवस', style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 4),
                  const Text('टीप: बजेट संपल्यास जाहिरात आपोआप बंद होईल.', style: TextStyle(fontSize: 11, color: AppColors.textLight)),
                ],
              ),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showPreview,
                icon: const Icon(Icons.visibility, color: Colors.white),
                label: Text(
                  _isEditMode ? 'Preview बघा — Update करा' : 'Preview बघा',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _isEditMode
                  ? '※ Preview बघितल्यावर बदल Update होतील.'
                  : '※ Preview बघितल्यावर Edit करता येईल किंवा थेट Live करता येईल.',
              style: const TextStyle(fontSize: 11, color: AppColors.textLight, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}