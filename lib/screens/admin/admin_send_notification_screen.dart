
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminSendNotificationScreen extends StatefulWidget {
  const AdminSendNotificationScreen({super.key});

  @override
  State<AdminSendNotificationScreen> createState() =>
      _AdminSendNotificationScreenState();
}

class _AdminSendNotificationScreenState
    extends State<AdminSendNotificationScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();

  late TabController _tabController;

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

  final List<Map<String, dynamic>> _sentNotifications = [];

  int _demoRecipientCount(String audience) {
    switch (audience) {
      case 'सर्व युजर्स':
        return 32000;
      case 'सर्व Buyers':
        return 25000;
      case 'पुरुष Buyers':
        return 14000;
      case 'महिला Buyers':
        return 11000;
      case 'सर्व Sellers':
        return 1250;
      case 'सर्व Franchise':
        return 200;
      case 'सर्व Channel Partners (CP)':
        return 50;
      case 'सर्व Promoters':
        return 5000;
      case 'Weekly Sellers':
        return 150;
      case 'Riders':
        return 300;
      case 'Parcel सेवा संबंधित युजर्स':
        return 450;
      case 'Referrers':
        return 600;
      default:
        return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendNotification() {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final message = _messageController.text.trim();
    final audience = _audience;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('नोटिफिकेशन तपासा'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('कोणाला: $audience'),
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

                setState(() {
                  _sentNotifications.insert(0, {
                    'title': title,
                    'message': message,
                    'audience': audience,
                    'recipients': _demoRecipientCount(audience),
                    'dateTime': DateTime.now(),
                  });
                });

                _titleController.clear();
                _messageController.clear();

                _tabController.animateTo(1);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Demo Notification History मध्ये सेव्ह झाले.',
                    ),
                  ),
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;

    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;

    return '$day/$month/$year • $displayHour:$minute $period';
  }

  void _showNotificationDetails(Map<String, dynamic> notification) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Notification Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                _detailRow('शीर्षक', notification['title']),
                _detailRow('प्राप्तकर्ता गट', notification['audience']),
                _detailRow(
                  'प्राप्तकर्त्यांची संख्या',
                  '${notification['recipients']}',
                ),
                _detailRow(
                  'तारीख व वेळ',
                  _formatDateTime(notification['dateTime']),
                ),
                const Divider(height: 24),
                const Text(
                  'संपूर्ण संदेश',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(notification['message']),
                const SizedBox(height: 20),
                const Text(
                  'Demo नोंद • प्रत्यक्ष Notification पाठवलेले नाही.',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 145,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendForm() {
    return Form(
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
            decoration: _inputDecoration('उदा. नवीन ऑफर उपलब्ध!'),
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
            decoration: _inputDecoration('संदेशाचा तपशील टाका'),
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
    );
  }

  Widget _buildHistory() {
    if (_sentNotifications.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.notifications_none,
                size: 60,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 12),
              const Text(
                'अजून कोणतेही Notification पाठवलेले नाही.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'नवीन Notification पाठवल्यानंतर येथे दिसेल.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _sentNotifications.length,
      itemBuilder: (context, index) {
        final notification = _sentNotifications[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _showNotificationDetails(notification),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.notifications_active,
                        color: AppColors.primaryBlue,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          notification['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'प्राप्तकर्ता: ${notification['audience']}',
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'प्राप्तकर्ते: ${notification['recipients']}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatDateTime(notification['dateTime']),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notification['message'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Demo History',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('नोटिफिकेशन व्यवस्थापन'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(
              icon: Icon(Icons.add_alert_outlined),
              text: 'नवीन सूचना',
            ),
            Tab(
              icon: Icon(Icons.history),
              text: 'Sent History',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSendForm(),
          _buildHistory(),
        ],
      ),
    );
  }
}
