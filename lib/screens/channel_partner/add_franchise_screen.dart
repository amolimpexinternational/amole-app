import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AddFranchiseScreen extends StatefulWidget {
  const AddFranchiseScreen({super.key});

  @override
  State<AddFranchiseScreen> createState() => _AddFranchiseScreenState();
}

class _AddFranchiseScreenState extends State<AddFranchiseScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _areaController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveFranchise() {
    if (_formKey.currentState!.validate()) {
      // सध्या फक्त यश दाखवतो, पुढे Firebase ला डेटा सेव्ह होईल
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_nameController.text} franchise जोडली ✅'),
          backgroundColor: AppColors.successGreen,
        ),
      );
      Navigator.pop(context, {
        'name': _nameController.text.trim(),
        'area': _areaController.text.trim(),
        'phone': _phoneController.text.trim(),
      });
    }
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 20),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  InputDecoration _inputStyle(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.textLight, size: 20),
      filled: true,
      fillColor: AppColors.lightGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        title: const Text('नवीन Franchise जोडा'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: AppColors.primaryBlue, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'खालची माहिती भरून नवीन franchise partner जोडा',
                          style: TextStyle(fontSize: 12, color: AppColors.textDark),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildLabel('Franchise / दुकानदाराचं नाव'),
                TextFormField(
                  controller: _nameController,
                  decoration: _inputStyle('उदा. हडपसर फ्रँचाइजी', Icons.business_outlined),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'नाव टाकणं आवश्यक आहे';
                    }
                    return null;
                  },
                ),
                _buildLabel('एरिया / भाग'),
                TextFormField(
                  controller: _areaController,
                  decoration: _inputStyle('उदा. पुणे — हडपसर', Icons.location_on_outlined),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'एरिया टाकणं आवश्यक आहे';
                    }
                    return null;
                  },
                ),
                _buildLabel('मोबाईल नंबर'),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: _inputStyle('98765 43210', Icons.phone_outlined).copyWith(counterText: ''),
                  validator: (value) {
                    if (value == null || value.trim().length != 10) {
                      return '10 आकडी मोबाईल नंबर आवश्यक आहे';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveFranchise,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Franchise जोडा', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
