
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CpSendNotificationScreen extends StatefulWidget {
  const CpSendNotificationScreen({super.key});

  @override
  State<CpSendNotificationScreen> createState() =>
      _CpSendNotificationScreenState();
}

class _CpSendNotificationScreenState
    extends State<CpSendNotificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String _selectedAudience = 'संपूर्ण माझे नेटवर्क';
  String? _selectedFranchise;

  final List<String> _franchises = [
    'हडपसर Franchise',
    'कोथरूड Franchise',
    'वडगाव Franchise',
    'भोसरी Franchise',
    'पिंपरी Franchise',
    'चिंचवड Franchise',
    'नाशिक रोड Franchise',
    'सातपूर Franchise',
  ];

  final List<String> _audiences = [
    'संपूर्ण माझे नेटवर्क',
    'सर्व Franchise',
    'सर्व Sellers',
    'सर्व Buyers',
    'Male Buyers',
    'Female Buyers',
    'सर्व Promoters',
    'निवडलेल्या Franchise मधील Sellers',
    'निवडलेल्या Franchise मधील Buyers',
    'निवडलेल्या Franchise मधील Male Buyers',
    'निवडलेल्या Franchise मधील Female Buyers',
    'निवडलेल्या Franchise मधील Promoters',
  ];

  bool get _requiresFranchise =>
      _selectedAudience.startsWith('निवडलेल्या Franchise');

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _showPreview() async {
    if (!_formKey.currentState!.validate()) return;

    if (_requiresFranchise && _selectedFranchise == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('कृपया Franchise निवडा'),
        ),
      );
      return;
    }

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
              Text(_selectedAudience),
              if (_requiresFranchise) ...[
                const SizedBox(height: 5),
                Text('Franchise: $_selectedFranchise'),
              ],
              const Divider(height: 24),
              const Text(
                'शीर्षक',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(_titleController.text.trim()),
              const SizedBox(height: 15),
              const Text(
                'संदेश',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(_messageController.text.trim()),
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Demo Notification तयार झाली. प्रत्यक्ष पाठवलेली नाही.',
          ),
        ),
      );
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text(
          'सूचना पाठवा',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
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
                          'तुम्ही फक्त तुमच्या स्वतःच्या CP नेटवर्कमधील '
                          'सदस्यांनाच सूचना पाठवू शकता.',
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
                  setState(() {
                    _selectedAudience = value!;
                    if (!_requiresFranchise) {
                      _selectedFranchise = null;
                    }
                  });
                },
              ),

              if (_requiresFranchise) ...[
                const SizedBox(height: 16),
                _buildSectionTitle('2. Franchise निवडा'),
                DropdownButtonFormField<String>(
                  initialValue: _selectedFranchise,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  hint: const Text('Franchise निवडा'),
                  items: _franchises.map((franchise) {
                    return DropdownMenuItem(
                      value: franchise,
                      child: Text(franchise),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedFranchise = value;
                    });
                  },
                ),
              ],

              const SizedBox(height: 22),
              _buildSectionTitle('3. Notification शीर्षक'),
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
              _buildSectionTitle('4. Notification संदेश'),
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
      ),
    );
  }
}
