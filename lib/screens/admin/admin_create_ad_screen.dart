import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminCreateAdScreen extends StatefulWidget {
  const AdminCreateAdScreen({super.key});

  @override
  State<AdminCreateAdScreen> createState() => _AdminCreateAdScreenState();
}

class _AdminCreateAdScreenState extends State<AdminCreateAdScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _pollQuestionController = TextEditingController();
  final _budgetController = TextEditingController();

  String _adType = 'text'; // text | photo | video
  String? _pickedFileName; // फाईल निवडल्याचे नाव दाखवण्यासाठी

  String _location = 'देशभर';
  String _ageGroup = 'सर्व वयोगट';
  String _gender = 'सर्व';
  String _timeSlot = 'Full Day';
  int _durationDays = 7;

  // किंमत दर (Cost per Poll Reply) मोजण्यासाठी
  double get _costPerReply {
    if (_adType == 'text') return 0.10;
    if (_adType == 'photo') return 0.25;
    if (_adType == 'video') return 0.50;
    return 0.10;
  }

  @override
  void dispose() {
    _textController.dispose();
    _pollQuestionController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  void _submitAd() {
    if (!_formKey.currentState!.validate()) return;

    if (_adType != 'text' && _pickedFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('कृपया $_adType फाईल निवडा')),
      );
      return;
    }

    final budget = int.tryParse(_budgetController.text.trim()) ?? 0;
    if (budget < 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('किमान बजेट ₹१०० असणे आवश्यक आहे')),
      );
      return;
    }

    final pollQuestion = _pollQuestionController.text.trim().isEmpty
        ? 'तुम्ही या जाहिरातीत इंटरेस्टेड आहात का?'
        : _pollQuestionController.text.trim();

    // ॲडमिनच्या जाहिराती थेट Live होतात
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('✅ जाहिरात Live झाली'),
        content: Text(
          "प्रकार: ${_adType.toUpperCase()}\n"
          "पोल प्रश्न: $pollQuestion\n"
          "बजेट: ₹$budget | कालावधी: $_durationDays दिवस\n"
          "Adv Generator: AMOLE Company (10% वाटा कंपनीला)\n\n"
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('नवीन जाहिरात तयार करा'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // === INFO BOX ===
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)),
              child: Row(children: [
                Icon(Icons.verified_outlined, color: Colors.green.shade700, size: 18),
                const SizedBox(width: 8),
                const Expanded(child: Text('Admin ने तयार केलेली जाहिरात थेट Live होते — Franchise Approval ची गरज नाही.', style: TextStyle(fontSize: 12, color: AppColors.textDark))),
              ]),
            ),
            const SizedBox(height: 18),

            // === १. कंटेंट प्रकार ===
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
                _pickedFileName = null; // प्रकार बदलल्यावर फाईल रिसेट करा
              }),
            ),
            const SizedBox(height: 14),

            if (_adType == 'text') ...[
              TextFormField(
                controller: _textController,
                maxLength: 300,
                maxLines: 4,
                decoration: _inputDecoration('जाहिरातीचा मजकूर टाका (कमाल 300 अक्षरे)'),
                validator: (v) => (v == null || v.isEmpty) ? 'मजकूर टाका' : null,
              ),
            ] else ...[
              // सेलर/फ्रँचायझी सारखे फाईल अपलोडचे आकर्षक UI
              Text(
                _adType == 'photo' ? 'कमाल आकार: ५ MB' : 'कमाल कालावधी: ३ मिनिटे (१८० सेकंद)',
                style: const TextStyle(fontSize: 12, color: AppColors.textLight),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  // TODO: file picker logic
                  setState(() {
                    _pickedFileName = _adType == 'photo' ? 'banner_image.jpg' : 'promo_video.mp4'; // डेमो फाईल
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('फाईल अपलोडचे तंत्रज्ञान पुढे जोडले जाईल')));
                },
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

            // === २. पोल प्रश्न ===
            _sectionTitle('२. पोल प्रश्न (Poll Question)'),
            TextFormField(
              controller: _pollQuestionController,
              decoration: _inputDecoration('डिफॉल्ट: "तुम्ही या जाहिरातीत इंटरेस्टेड आहात का?"'),
            ),
            const SizedBox(height: 18),

            // === ३. ऑडियन्स टार्गेटिंग ===
            _sectionTitle('३. ऑडियन्स टार्गेटिंग'),
            _label('Location'),
            DropdownButtonFormField<String>(
              initialValue: _location,
              decoration: _inputDecoration(''),
              items: ['तालुका', 'जिल्हा', 'राज्य', 'देशभर'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _location = v!),
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

            // === ४. बजेट व कालावधी ===
            _sectionTitle('४. बजेट व कालावधी'),
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

            // === ५. किंमत तपशील ===
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
            ElevatedButton(
              onPressed: _submitAd,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('जाहिरात Live करा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
            ),
            const SizedBox(height: 20),
          ],
        ),
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
}