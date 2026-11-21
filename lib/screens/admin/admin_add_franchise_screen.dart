
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminAddFranchiseScreen extends StatefulWidget {
  const AdminAddFranchiseScreen({super.key});

  @override
  State<AdminAddFranchiseScreen> createState() =>
      _AdminAddFranchiseScreenState();
}

class _AdminAddFranchiseScreenState
    extends State<AdminAddFranchiseScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _talukaController = TextEditingController();
  final _districtController = TextEditingController();
  final _stateController = TextEditingController();

  String? _selectedChannelPartner;

  // Stage 2: Demo Channel Partners
  final List<Map<String, String>> _channelPartners = [
    {
      'id': 'CP-001',
      'name': 'अमोल देशमुख',
      'mobile': '9876543210',
    },
    {
      'id': 'CP-002',
      'name': 'संजय पाटील',
      'mobile': '9876543211',
    },
    {
      'id': 'CP-003',
      'name': 'राजेश शिंदे',
      'mobile': '9876543212',
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _pincodeController.dispose();
    _talukaController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('नवीन Franchise जोडा'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _label('फ्रँचायझीचे नाव'),
            TextFormField(
              controller: _nameController,
              decoration: _inputDecoration('उदा. राजेश पाटील'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty)
                      ? 'नाव टाका'
                      : null,
            ),

            const SizedBox(height: 14),

            _label('मोबाईल नंबर'),
            TextFormField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: _inputDecoration('10 अंकी मोबाईल नंबर'),
              validator: (v) =>
                  (v == null || !RegExp(r'^[0-9]{10}$').hasMatch(v))
                      ? 'योग्य 10 अंकी मोबाईल नंबर टाका'
                      : null,
            ),

            const SizedBox(height: 14),

            _label('पिनकोड'),
            TextFormField(
              controller: _pincodeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: _inputDecoration('6 अंकी पिनकोड'),
              validator: (v) =>
                  (v == null || !RegExp(r'^[0-9]{6}$').hasMatch(v))
                      ? 'योग्य 6 अंकी पिनकोड टाका'
                      : null,
            ),

            const SizedBox(height: 14),

            _label('तालुका'),
            TextFormField(
              controller: _talukaController,
              decoration: _inputDecoration('तालुका'),
            ),

            const SizedBox(height: 14),

            _label('जिल्हा'),
            TextFormField(
              controller: _districtController,
              decoration: _inputDecoration('जिल्हा'),
            ),

            const SizedBox(height: 14),

            _label('राज्य'),
            TextFormField(
              controller: _stateController,
              decoration: _inputDecoration('राज्य'),
            ),

            const SizedBox(height: 14),

            _label('संबंधित Channel Partner'),

            DropdownButtonFormField<String>(
              initialValue: _selectedChannelPartner,
              isExpanded: true,
              decoration: _inputDecoration('Channel Partner निवडा'),
              items: _channelPartners.map((cp) {
                return DropdownMenuItem<String>(
                  value: cp['id'],
                  child: Text(
                    '${cp['name']} (${cp['id']})',
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              validator: (value) =>
                  value == null ? 'Channel Partner निवडा' : null,
              onChanged: (value) {
                setState(() {
                  _selectedChannelPartner = value;
                });
              },
            ),

            if (_selectedChannelPartner != null) ...[
              const SizedBox(height: 10),
              _buildSelectedPartnerDetails(),
            ],

            const SizedBox(height: 28),

            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _addFranchise,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Franchise जोडा',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedPartnerDetails() {
    final selectedCP = _channelPartners.firstWhere(
      (cp) => cp['id'] == _selectedChannelPartner,
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.primaryBlue.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'निवडलेला Channel Partner',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 6),
          Text('नाव: ${selectedCP['name']}'),
          Text('CP ID: ${selectedCP['id']}'),
          Text('मोबाईल: ${selectedCP['mobile']}'),
        ],
      ),
    );
  }

  void _addFranchise() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final selectedCP = _channelPartners.firstWhere(
      (cp) => cp['id'] == _selectedChannelPartner,
    );

    // Stage 2: Demo only.
    // Stage 3 मध्ये Firestore मध्ये Franchise Save होईल.

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${_nameController.text.trim()} यांची Franchise Demo मध्ये जोडली गेली. CP: ${selectedCP['name']}',
        ),
        duration: const Duration(seconds: 3),
      ),
    );

    Navigator.pop(context);
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
      counterText: '',
      filled: true,
      fillColor: AppColors.lightGrey,
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
