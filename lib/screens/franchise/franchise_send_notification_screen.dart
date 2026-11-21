
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FranchiseSendNotificationScreen extends StatefulWidget {
  const FranchiseSendNotificationScreen({super.key});

  @override
  State<FranchiseSendNotificationScreen> createState() =>
      _FranchiseSendNotificationScreenState();
}

class _FranchiseSendNotificationScreenState
    extends State<FranchiseSendNotificationScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  late TabController _tabController;

  String _selectedAudience = 'संपूर्ण माझे नेटवर्क';

  final List<String> _audiences = [
    'संपूर्ण माझे नेटवर्क',
    'सर्व Sellers',
    'सर्व Buyers',
    'Male Buyers',
    'Female Buyers',
    'सर्व Promoters',
  ];

  final List<Map<String, dynamic>> _sentNotifications = [];

  int _demoRecipientCount(String audience) {
    switch (audience) {
      case 'संपूर्ण माझे नेटवर्क':
        return 874;
      case 'सर्व Sellers':
        return 24;
      case 'सर्व Buyers':
        return 850;
      case 'Male Buyers':
      case 'Female Buyers':
      case 'सर्व Promoters':
        return 0;
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

  Future<void> _showPreview() async {
    if (!_formKey.currentState!.validate()) return;

    final audience = _selectedAudience;
    final title = _titleController.text.trim();
    final message = _messageController.text.trim();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('सूचना Preview'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'कोणाला पाठवणार?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(audience),
              const Divider(height: 24),
              const Text(
                'शीर्षक',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(title),
              const SizedBox(height: 15),
              const Text(
                'संदेश',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(message),
              const SizedBox(height: 15),
              const Text(
                'Demo Preview: प्रत्यक्ष Notification पाठवली जाणार नाही.',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('बदल करा'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() {
        _sentNotifications.insert(0, {
          'title': title,
          'message': message,
          'audience': audience,
          'recipients': _demoRecipientCount(audience),
          'dateTime': DateTime.now(),
        });

        _selectedAudience = 'संपूर्ण माझे नेटवर्क';
        _titleController.clear();
        _messageController.clear();
      });

      _tabController.animateTo(1);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Demo Notification History मध्ये सेव्ह झाले.',
          ),
        ),
      );
    }
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

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
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

  void _showNotificationDetails(
    Map<String, dynamic> notification,
  ) {
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
                _detailRow(
                  'प्राप्तकर्ता गट',
                  notification['audience'],
                ),
                _detailRow(
                  'प्राप्तकर्त्यांची Demo संख्या',
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSendForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.primaryBlue,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'तुम्ही फक्त तुमच्या स्वतःच्या Franchise '
                        'नेटवर्कमधील Sellers, Buyers आणि Promoters '
                        'यांनाच सूचना पाठवू शकता.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('1. सूचना कोणाला पाठवायची?'),
            DropdownButtonFormField<String>(
              key: ValueKey(_selectedAudience),
              initialValue: _selectedAudience,
              isExpanded: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              items: _audiences.map((audience) {
                return DropdownMenuItem(
                  value: audience,
                  child: Text(
                    audience,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedAudience = value;
                });
              },
            ),
            const SizedBox(height: 22),
            _buildSectionTitle('2. Notification शीर्षक'),
            TextFormField(
              controller: _titleController,
              maxLength: 100,
              decoration: const InputDecoration(
                hintText: 'उदा. नवीन ऑफर उपलब्ध आहे',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'कृपया Notification शीर्षक लिहा';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            _buildSectionTitle('3. Notification संदेश'),
            TextFormField(
              controller: _messageController,
              maxLength: 500,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'तुमचा संदेश येथे लिहा...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'कृपया संदेश लिहा';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _showPreview,
                icon: const Icon(Icons.visibility_outlined),
                label: const Text(
                  'Preview आणि Confirm',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Stage 2 Demo • Firebase Notification Stage 3 मध्ये',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
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
                    'प्राप्तकर्त्यांची Demo संख्या: '
                    '${notification['recipients']}',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text(
          'सूचना व्यवस्थापन',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
