import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminSendNotificationScreen extends StatefulWidget {
  const AdminSendNotificationScreen({super.key});

  @override
  State<AdminSendNotificationScreen> createState() => _AdminSendNotificationScreenState();
}

class _AdminSendNotificationScreenState extends State<AdminSendNotificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  String _audience = 'सर्व युजर्स';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('नोटिफिकेशन पाठवा'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _label('कोणाला पाठवायचे?'),
            DropdownButtonFormField<String>(
              initialValue: _audience,
              decoration: _inputDecoration(''),
              items: ['सर्व युजर्स', 'सर्व Buyers', 'सर्व Sellers', 'सर्व Franchise', 'सर्व Channel Partners']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _audience = v!),
            ),
            const SizedBox(height: 14),
            _label('शीर्षक (Title)'),
            TextFormField(
              controller: _titleController,
              decoration: _inputDecoration('उदा. नवीन ऑफर उपलब्ध!'),
              validator: (v) => (v == null || v.isEmpty) ? 'शीर्षक टाका' : null,
            ),
            const SizedBox(height: 14),
            _label('संदेश (Message)'),
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: _inputDecoration('संदेशाचा तपशील टाका'),
              validator: (v) => (v == null || v.isEmpty) ? 'संदेश टाका' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: save notification to Firestore and trigger push via Firebase Cloud Messaging
                  // fields: title, message, audience, sentBy: 'admin', sentAt
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('नोटिफिकेशन यशस्वीरित्या पाठवली गेली')),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('नोटिफिकेशन पाठवा'),
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
