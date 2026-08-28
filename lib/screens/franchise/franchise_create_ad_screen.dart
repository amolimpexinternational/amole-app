import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FranchiseCreateAdScreen extends StatefulWidget {
  const FranchiseCreateAdScreen({super.key});

  @override
  State<FranchiseCreateAdScreen> createState() => _FranchiseCreateAdScreenState();
}

class _FranchiseCreateAdScreenState extends State<FranchiseCreateAdScreen> {
  final _formKey = GlobalKey<FormState>();

  String _contentType = 'Text'; // Text / Photo / Video
  final _textController = TextEditingController();
  final _pollQuestionController = TextEditingController();
  final _budgetController = TextEditingController();

  PlatformFile? _pickedFile;
  String? _fileError;

  String _location = 'तालुका';
  String _ageGroup = '२४–४०';
  String _gender = 'दोन्ही';
  String _timeSlot = 'Full Day';
  int _durationDays = 3;

  static const int _maxPhotoBytes = 5 * 1024 * 1024; // 5 MB (Blueprint 6.1)
  static const int _maxVideoSeconds = 180; // 3 min (Blueprint 6.1)

  @override
  void dispose() {
    _textController.dispose();
    _pollQuestionController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    setState(() => _fileError = null);
    final result = await FilePicker.platform.pickFiles(
      type: _contentType == 'Photo' ? FileType.image : FileType.video,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;

    if (_contentType == 'Photo' && file.size > _maxPhotoBytes) {
      setState(() {
        _fileError = 'फोटो ५ MB पेक्षा मोठा आहे (सध्याचा आकार: ${(file.size / (1024 * 1024)).toStringAsFixed(2)} MB). कृपया लहान फोटो निवडा.';
        _pickedFile = null;
      });
      return;
    }

    // TODO (Stage 3 - Backend): actual video duration check needs a video
    // player/metadata plugin once Firebase Storage upload is wired up.
    // For now we only warn — Blueprint limit: max 180 seconds (3 min).

    setState(() => _pickedFile = file);
  }

  void _submitAd() {
    if (!_formKey.currentState!.validate()) return;

    if (_contentType != 'Text' && _pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('कृपया $_contentType फाईल निवडा')),
      );
      return;
    }

    final budget = int.tryParse(_budgetController.text.trim()) ?? 0;
    if (budget < 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('किमान बजेट ₹१०० असणे आवश्यक आहे (Blueprint नियम)')),
      );
      return;
    }

    final pollQuestion = _pollQuestionController.text.trim().isEmpty
        ? 'तुम्ही या जाहिरातीत इंटरेस्टेड आहात का?' // default poll (Blueprint 6.3)
        : _pollQuestionController.text.trim();

    // TODO (Stage 3 - Backend): upload _pickedFile bytes to Firebase Storage,
    // save ad doc to Firestore with status 'Live' (Franchise's own ads skip
    // approval per Blueprint ch. 6.4), Adv Generator = this Franchise
    // (gets 10% of poll-reply revenue per Blueprint 6.8).
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('✅ जाहिरात Live झाली'),
        content: Text(
          "प्रकार: $_contentType\n"
          "पोल प्रश्न: $pollQuestion\n"
          "बजेट: ₹$budget | कालावधी: $_durationDays दिवस\n"
          "Adv Generator: तुमची Franchise (10% वाटा तुम्हाला)\n\n"
          "Approval आवश्यक नाही — जाहिरात लगेच Live झाली आहे.",
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
        title: const Text('Create Ad', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                      'तुमची जाहिरात लगेच Live होईल — Approval लागणार नाही (Adv Generator: तुमची Franchise, 10% वाटा तुम्हाला)',
                      style: TextStyle(color: Colors.green.shade900, fontSize: 12.5),
                    ),
                  ),
                ],
              ),
            ),

            _sectionTitle('कन्टेंट प्रकार'),
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
                  _pickedFile = null;
                  _fileError = null;
                });
              },
            ),

            if (_contentType == 'Text') ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _textController,
                maxLength: 300, // Blueprint 6.1: max 300 characters
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'जाहिरातीचा मजकूर लिहा (कमाल ३०० अक्षरं)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'मजकूर आवश्यक आहे' : null,
              ),
            ] else ...[
              const SizedBox(height: 12),
              Text(
                _contentType == 'Photo'
                    ? 'कमाल आकार: ५ MB'
                    : 'कमाल कालावधी: ३ मिनिटे (१८० सेकंद)',
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
                    border: Border.all(color: AppColors.primaryBlue.withOpacity(0.4), style: BorderStyle.solid),
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
                        _pickedFile == null
                            ? '$_contentType निवडण्यासाठी टॅप करा'
                            : '${_pickedFile!.name}  (${(_pickedFile!.size / (1024 * 1024)).toStringAsFixed(2)} MB)',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                      ),
                      if (_pickedFile != null && _contentType == 'Photo' && _pickedFile!.bytes != null) ...[
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(Uint8List.fromList(_pickedFile!.bytes!), height: 120, fit: BoxFit.cover),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (_fileError != null) ...[
                const SizedBox(height: 8),
                Text(_fileError!, style: const TextStyle(color: Colors.red, fontSize: 12)),
              ],
            ],

            _sectionTitle('Poll प्रश्न (ऐच्छिक)'),
            TextFormField(
              controller: _pollQuestionController,
              decoration: InputDecoration(
                hintText: 'रिकामं ठेवल्यास डिफॉल्ट प्रश्न वापरला जाईल: "तुम्ही या जाहिरातीत इंटरेस्टेड आहात का?"',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),

            _sectionTitle('ऑडियन्स टार्गेटिंग'),
            DropdownButtonFormField<String>(
              initialValue: _location,
              decoration: InputDecoration(labelText: 'परिसर', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              items: ['तालुका', 'जिल्हा', 'राज्य', 'देशभर']
                  .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
              onChanged: (v) => setState(() => _location = v!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _ageGroup,
              decoration: InputDecoration(labelText: 'वयोगट', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              items: ['१३–२३', '२४–४०', '४०–६०', '६०+']
                  .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
              onChanged: (v) => setState(() => _ageGroup = v!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _gender,
              decoration: InputDecoration(labelText: 'लिंग', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              items: ['दोन्ही', 'स्त्री', 'पुरुष']
                  .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
              onChanged: (v) => setState(() => _gender = v!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _timeSlot,
              decoration: InputDecoration(labelText: 'वेळ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              items: ['सकाळी ७–१२', 'दुपारी १२–५', 'संध्याकाळी ५–१०', 'रात्री १०–७', 'Full Day']
                  .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
              onChanged: (v) => setState(() => _timeSlot = v!),
            ),

            _sectionTitle('बजेट व कालावधी'),
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

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitAd,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('जाहिरात प्रकाशित करा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
