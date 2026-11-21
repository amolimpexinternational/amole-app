
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminSendNotificationScreen extends StatefulWidget {
  const AdminSendNotificationScreen({super.key});

  @override
  State<AdminSendNotificationScreen> createState() =>
      _AdminSendNotificationScreenState();
}

class _AdminSendNotificationScreenState
    extends State<AdminSendNotificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();

  String _audience = 'सर्व युजर्स';

  final List<String> _audiences = [
    'सर्व युजर्स',
    'सर्व Buyers',
    'पुरुष Buyers',
    'महिला Buyers',
    'सर्व Sellers',
    'सर्व Franchise',
    'सर्व Channel Partners (CP)',
    'सर्व Promoters',
    'Weekly Sellers',
    'Riders',
    'Parcel सेवा संबंधित युजर्स',
    'Referrers',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendNotification() {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final message = _messageController.text.trim();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('नोटिफिकेशन तपासा'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('कोणाला: $_audience'),
              const SizedBox(height: 10),
              const Text(
                'शीर्षक:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(title),
              const SizedBox(height: 10),
              const Text(
                'संदेश:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(message),
              const SizedBox(height: 12),
              const Text(
                'ही Demo प्रक्रिया आहे. प्रत्यक्ष Notification पाठवली जाणार नाही.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('बदल करा'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '$_audience साठी Demo Notification तयार झाले.',
                    ),
                    duration: const Duration(seconds: 3),
                  ),
                );

                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

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
              isExpanded: true,
              decoration: _inputDecoration('Audience निवडा'),
              items: _audiences.map((audience) {
                return DropdownMenuItem<String>(
                  value: audience,
                  child: Text(
                    audience,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _audience = value;
                  });
                }
              },
              validator: (value) {
                if (value == null) {
                  return 'Audience निवडा';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            _label('शीर्षक (Title)'),

            TextFormField(
              controller: _titleController,
              maxLength: 100,
              decoration: _inputDecoration(
                'उदा. नवीन ऑफर उपलब्ध!',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'शीर्षक टाका';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            _label('संदेश (Message)'),

            TextFormField(
              controller: _messageController,
              maxLines: 4,
              maxLength: 500,
              decoration: _inputDecoration(
                'संदेशाचा तपशील टाका',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'संदेश टाका';
                }
                return null;
              },
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.primaryBlue,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'ही Stage 2 Demo स्क्रीन आहे. '
                      'प्रत्यक्ष Push Notification आणि Audience Filtering '
                      'Stage 3 मध्ये Firebase द्वारे जोडले जाईल.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _sendNotification,
                icon: const Icon(Icons.notifications_active_outlined),
                label: const Text('नोटिफिकेशन पाठवा'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.lightGrey,
      counterText: '',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
    );
  }
}
