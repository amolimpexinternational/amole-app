import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CpCreateAdScreen extends StatefulWidget {
  const CpCreateAdScreen({super.key});

  @override
  State<CpCreateAdScreen> createState() => _CpCreateAdScreenState();
}

class _CpCreateAdScreenState extends State<CpCreateAdScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _textController = TextEditingController();
  final _pollQuestionController = TextEditingController();
  final _budgetController = TextEditingController();

  String _adType = 'text';
  String? _pickedFileName;

  String _ageGroup = 'सर्व वयोगट';
  String _gender = 'सर्व';
  String _timeSlot = 'Full Day';
  int _durationDays = 7;

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

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    _pollQuestionController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  double get _costPerReply {
    if (_adType == 'text') return 0.10;
    if (_adType == 'photo') return 0.25;
    if (_adType == 'video') return 0.50;
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

  bool _validateBeforePreview() {
    if (!_formKey.currentState!.validate()) return false;

    if (_adType != 'text' && _pickedFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('कृपया $_adType फाईल निवडा')),
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

    final hasTarget = _selectedStates.isNotEmpty || _selectedDistricts.isNotEmpty ||
        _selectedTalukas.isNotEmpty || _selectedPincodes.isNotEmpty;
    if (!hasTarget) {
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
                        if (_adType != 'text')
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
                                    _adType == 'photo' ? Icons.image : Icons.videocam,
                                    color: Colors.white70,
                                    size: 50,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _pickedFileName ?? '$_adType फाईल',
                                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (_adType != 'text') const SizedBox(height: 12),
                        Text(
                          _titleController.text,
                          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _adType == 'text' ? _textController.text : 'AMOLE Sponsored',
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
                    if (_adType == 'text') _previewRow('मजकूर', _textController.text),
                    if (_adType != 'text') _previewRow('प्रकार', _adType.toUpperCase()),
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
                            'Channel Partner असल्यामुळे ही जाहिरात थेट Live होईल — Approval ची गरज नाही.',
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
                      label: const Text('कन्फर्म करा — Live करा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text('✅ जाहिरात Live झाली'),
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
            Text('प्रकार: ${_adType.toUpperCase()}'),
            Text('बजेट: ₹$budget'),
            Text('कालावधी: $_durationDays दिवस'),
            const SizedBox(height: 8),
            const Text(
              'तुमची जाहिरात आता "जाहिरात विभाग" मध्ये Live आहे.',
              style: TextStyle(fontSize: 12, color: AppColors.textLight, fontStyle: FontStyle.italic),
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
        padding: const EdgeInsets.only(top: 10, bottom: 8),
        child: Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
      );

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textLight)),
      );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('नवीन जाहिरात तयार करा', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)),
              child: Row(children: [
                Icon(Icons.verified_outlined, color: Colors.green.shade700, size: 18),
                const SizedBox(width: 8),
                const Expanded(child: Text('Channel Partner ने तयार केलेली जाहिरात थेट Live होते — Approval ची गरज नाही.', style: TextStyle(fontSize: 12, color: AppColors.textDark))),
              ]),
            ),
            const SizedBox(height: 18),

            _sectionTitle('१. कन्टेंट प्रकार'),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'text', label: Text('Text'), icon: Icon(Icons.text_fields)),
                ButtonSegment(value: 'photo', label: Text('Photo'), icon: Icon(Icons.image_outlined)),
                ButtonSegment(value: 'video', label: Text('Video'), icon: Icon(Icons.videocam_outlined)),
              ],
              selected: {_adType},
              onSelectionChanged: (v) => setState(() {
                _adType = v.first;
                _pickedFileName = null;
              }),
            ),
            const SizedBox(height: 14),

            _sectionTitle('२. जाहिरात शीर्षक'),
            TextFormField(
              controller: _titleController,
              decoration: _inputDecoration('उदा. दिवाळी धमाका 20% सूट'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'शीर्षक आवश्यक' : null,
            ),
            const SizedBox(height: 14),

            _sectionTitle('३. कंटेंट'),
            if (_adType == 'text')
              TextFormField(
                controller: _textController,
                maxLength: 300,
                maxLines: 4,
                decoration: _inputDecoration('जाहिरातीचा मजकूर टाका (कमाल 300 अक्षरे)'),
                validator: (v) => (v == null || v.isEmpty) ? 'मजकूर टाका' : null,
              )
            else ...[
              Text(
                _adType == 'photo' ? 'कमाल आकार: ५ MB' : 'कमाल कालावधी: ३ मिनिटे (१८० सेकंद)',
                style: const TextStyle(fontSize: 12, color: AppColors.textLight),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  setState(() {
                    _pickedFileName = _adType == 'photo' ? 'banner_image.jpg' : 'promo_video.mp4';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('फाईल अपलोडचे तंत्रज्ञान पुढे जोडले जाईल')));
                },
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
                        _adType == 'photo' ? Icons.add_photo_alternate_outlined : Icons.video_call_outlined,
                        color: AppColors.primaryBlue,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _pickedFileName == null ? '${_adType == 'photo' ? 'फोटो' : 'व्हिडिओ'} निवडण्यासाठी टॅप करा' : _pickedFileName!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 14),

            _sectionTitle('४. पोल प्रश्न (Poll Question)'),
            TextFormField(
              controller: _pollQuestionController,
              decoration: _inputDecoration('डिफॉल्ट: "तुम्ही या जाहिरातीत इंटरेस्टेड आहात का?"'),
            ),
            const SizedBox(height: 18),

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

            _label('Age Group'),
            DropdownButtonFormField<String>(
              initialValue: _ageGroup,
              decoration: _inputDecoration(''),
              items: ['सर्व वयोगट', '13-23', '24-40', '40-60', '60+'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _ageGroup = v!),
            ),
            const SizedBox(height: 14),
            _label('Gender'),
            DropdownButtonFormField<String>(
              initialValue: _gender,
              decoration: _inputDecoration(''),
              items: ['सर्व', 'स्त्री', 'पुरुष'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _gender = v!),
            ),
            const SizedBox(height: 14),
            _label('Time Slot'),
            DropdownButtonFormField<String>(
              initialValue: _timeSlot,
              decoration: _inputDecoration(''),
              items: ['सकाळी 7-12', 'दुपारी 12-5', 'संध्याकाळी 5-10', 'रात्र 10-7', 'Full Day']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _timeSlot = v!),
            ),
            const SizedBox(height: 18),

            _sectionTitle('६. बजेट व कालावधी'),
            _label('बजेट (किमान ₹100)'),
            TextFormField(
              controller: _budgetController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration('उदा. 500'),
              validator: (v) {
                final n = int.tryParse(v ?? '');
                if (n == null || n < 100) return 'किमान ₹100 बजेट आवश्यक आहे';
                return null;
              },
            ),
            const SizedBox(height: 14),
            _label('कालावधी: $_durationDays दिवस'),
            Slider(
              value: _durationDays.toDouble(),
              min: 1,
              max: 7,
              divisions: 6,
              activeColor: AppColors.primaryBlue,
              label: '$_durationDays दिवस',
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
              '※ Preview बघितल्यावर Edit करता येईल किंवा थेट Live करता येईल.',
              style: TextStyle(fontSize: 11, color: AppColors.textLight, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}