
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminAddSellerScreen extends StatefulWidget {
  const AdminAddSellerScreen({super.key});

  @override
  State<AdminAddSellerScreen> createState() => _AdminAddSellerScreenState();
}

class _AdminAddSellerScreenState extends State<AdminAddSellerScreen> {
  final _formKey = GlobalKey<FormState>();

  final _shopNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _pincodeController = TextEditingController();

  String? _selectedChannelPartner;
  String? _selectedFranchise;

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

  // Stage 2: Demo Franchise list with CP mapping
  final List<Map<String, String>> _franchises = [
    {
      'id': 'FR-001',
      'name': 'नाशिक फ्रँचायझी',
      'cpId': 'CP-001',
    },
    {
      'id': 'FR-002',
      'name': 'पुणे फ्रँचायझी',
      'cpId': 'CP-001',
    },
    {
      'id': 'FR-003',
      'name': 'मुंबई फ्रँचायझी',
      'cpId': 'CP-002',
    },
    {
      'id': 'FR-004',
      'name': 'औरंगाबाद फ्रँचायझी',
      'cpId': 'CP-003',
    },
  ];

  List<Map<String, String>> get _filteredFranchises {
    if (_selectedChannelPartner == null) {
      return [];
    }

    return _franchises
        .where((franchise) =>
            franchise['cpId'] == _selectedChannelPartner)
        .toList();
  }

  @override
  void dispose() {
    _shopNameController.dispose();
    _ownerNameController.dispose();
    _mobileController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  void _addSeller() {
    if (!_formKey.currentState!.validate()) return;

    final selectedCP = _channelPartners.firstWhere(
      (cp) => cp['id'] == _selectedChannelPartner,
    );

    final selectedFranchise = _franchises.firstWhere(
      (franchise) => franchise['id'] == _selectedFranchise,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${_shopNameController.text.trim()} Seller म्हणून जोडला गेला. '
          'CP: ${selectedCP['name']}, '
          'Franchise: ${selectedFranchise['name']}',
        ),
        duration: const Duration(seconds: 3),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('नवीन Seller जोडा'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _label('दुकानाचे नाव'),
            TextFormField(
              controller: _shopNameController,
              decoration: _inputDecoration('उदा. पाटील किराणा स्टोअर'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'दुकानाचे नाव टाका';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            _label('मालकाचे नाव'),
            TextFormField(
              controller: _ownerNameController,
              decoration: _inputDecoration('मालकाचे नाव'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'मालकाचे नाव टाका';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            _label('मोबाईल नंबर'),
            TextFormField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: _inputDecoration('10 अंकी मोबाईल नंबर'),
              validator: (v) {
                if (v == null || !RegExp(r'^[0-9]{10}$').hasMatch(v)) {
                  return 'योग्य 10 अंकी मोबाईल नंबर टाका';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            _label('पिनकोड'),
            TextFormField(
              controller: _pincodeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: _inputDecoration('6 अंकी पिनकोड'),
              validator: (v) {
                if (v == null || !RegExp(r'^[0-9]{6}$').hasMatch(v)) {
                  return 'योग्य 6 अंकी पिनकोड टाका';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            _label('संबंधित Channel Partner (CP)'),
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
              onChanged: (value) {
                setState(() {
                  _selectedChannelPartner = value;
                  _selectedFranchise = null;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Channel Partner निवडा';
                }
                return null;
              },
            ),

            if (_selectedChannelPartner != null) ...[
              const SizedBox(height: 10),
              _buildSelectedCPDetails(),
            ],

            const SizedBox(height: 14),

            _label('संबंधित Franchise'),
            DropdownButtonFormField<String>(
              key: ValueKey(_selectedChannelPartner),
              initialValue: _selectedFranchise,
              isExpanded: true,
              decoration: _inputDecoration(
                _selectedChannelPartner == null
                    ? 'आधी Channel Partner निवडा'
                    : 'Franchise निवडा',
              ),
              items: _filteredFranchises.map((franchise) {
                return DropdownMenuItem<String>(
                  value: franchise['id'],
                  child: Text(
                    '${franchise['name']} (${franchise['id']})',
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: _selectedChannelPartner == null
                  ? null
                  : (value) {
                      setState(() {
                        _selectedFranchise = value;
                      });
                    },
              validator: (value) {
                if (value == null) {
                  return 'Franchise निवडा';
                }
                return null;
              },
            ),

            if (_selectedFranchise != null) ...[
              const SizedBox(height: 10),
              _buildSelectedFranchiseDetails(),
            ],

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.blue.shade700,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Admin ने जोडलेल्या Seller ला स्वयंचलित पडताळणी '
                      '(Verified) दर्जा मिळेल — GPS व्हेरिफिकेशनची गरज नाही.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addSeller,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Seller जोडा',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedCPDetails() {
    final cp = _channelPartners.firstWhere(
      (item) => item['id'] == _selectedChannelPartner,
    );

    return _detailsCard(
      icon: Icons.people_alt_outlined,
      title: 'निवडलेला Channel Partner',
      lines: [
        'नाव: ${cp['name']}',
        'CP ID: ${cp['id']}',
        'मोबाईल: ${cp['mobile']}',
      ],
    );
  }

  Widget _buildSelectedFranchiseDetails() {
    final franchise = _franchises.firstWhere(
      (item) => item['id'] == _selectedFranchise,
    );

    return _detailsCard(
      icon: Icons.store_outlined,
      title: 'निवडलेली Franchise',
      lines: [
        'नाव: ${franchise['name']}',
        'Franchise ID: ${franchise['id']}',
      ],
    );
  }

  Widget _detailsCard({
    required IconData icon,
    required String title,
    required List<String> lines,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                line,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ),
        ],
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
