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
  String _location = 'देशभर';
  String _ageGroup = 'सर्व वयोगट';
  String _gender = 'सर्व';
  String _timeSlot = 'Full Day';
  int _durationDays = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _label('जाहिरात प्रकार'),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'text', label: Text('Text'), icon: Icon(Icons.text_fields)),
                ButtonSegment(value: 'photo', label: Text('Photo'), icon: Icon(Icons.image_outlined)),
                ButtonSegment(value: 'video', label: Text('Video'), icon: Icon(Icons.videocam_outlined)),
              ],
              selected: {_adType},
              onSelectionChanged: (v) => setState(() => _adType = v.first),
            ),
            const SizedBox(height: 14),
            if (_adType == 'text') ...[
              _label('जाहिरात मजकूर (कमाल 300 अक्षरे)'),
              TextFormField(
                controller: _textController,
                maxLength: 300,
                maxLines: 4,
                decoration: _inputDecoration('जाहिरातीचा मजकूर टाका'),
                validator: (v) => (v == null || v.isEmpty) ? 'मजकूर टाका' : null,
              ),
            ] else if (_adType == 'photo') ...[
              _label('फोटो अपलोड करा (कमाल 5 MB)'),
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: pick image and upload to Firebase Storage
                },
                icon: const Icon(Icons.upload_outlined),
                label: const Text('फोटो निवडा'),
              ),
            ] else ...[
              _label('व्हिडिओ अपलोड करा (कमाल 3 मिनिटे)'),
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: pick video and upload to Firebase Storage
                },
                icon: const Icon(Icons.upload_outlined),
                label: const Text('व्हिडिओ निवडा'),
              ),
            ],
            const SizedBox(height: 14),
            _label('पोल प्रश्न (Poll Question)'),
            TextFormField(
              controller: _pollQuestionController,
              decoration: _inputDecoration('डिफॉल्ट: "तुम्ही या जाहिरातीत इंटरेस्टेड आहात का?"'),
            ),
            const SizedBox(height: 18),
            const Text('ऑडियन्स टार्गेटिंग', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 10),
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
            const Text('बजेट व कालावधी', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 10),
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
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: save ad document to Firestore (collection: advertisements)
                  // fields: type, content, pollQuestion, targeting{location,ageGroup,gender,timeSlot},
                  // budget, durationDays, createdBy: 'admin', advGenerator: 'Amole Company',
                  // status: 'live' (admin ads skip approval), createdAt
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('जाहिरात यशस्वीरित्या Live झाली')),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('जाहिरात Live करा'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
      );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.lightGrey,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      );
}
