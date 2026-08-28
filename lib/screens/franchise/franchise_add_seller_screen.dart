import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FranchiseAddSellerScreen extends StatefulWidget {
  const FranchiseAddSellerScreen({super.key});

  @override
  State<FranchiseAddSellerScreen> createState() => _FranchiseAddSellerScreenState();
}

class _FranchiseAddSellerScreenState extends State<FranchiseAddSellerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _shopController = TextEditingController();
  final _mobileController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _shopController.dispose();
    _mobileController.dispose();
    _pincodeController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    if (_mobileController.text.trim().length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया योग्य १० अंकी मोबाईल नंबर टाका')),
      );
      return;
    }
    // TODO (Stage 3 - Backend): trigger real OTP via Firebase Auth
    setState(() => _otpSent = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP पाठवला (डेमो: कोणताही ४ अंक टाका)')),
    );
  }

  void _submitSeller() {
    if (_formKey.currentState!.validate()) {
      if (!_otpSent) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('कृपया आधी OTP पाठवा व टाका')),
        );
        return;
      }
      // TODO (Stage 3 - Backend): save seller to Firestore.
      // Policy decision: sellers added directly by Franchise/Admin are
      // permanently linked to this Franchise (excluded from load-balancing,
      // Blueprint ch. 3.4 exception) and auto-verified without GPS wait.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ सेलर जोडला — कायमचा या Franchise ला लिंक (auto-verified)'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Add Seller', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('सेलरचे नाव', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'नाव आवश्यक आहे' : null,
              ),
              const SizedBox(height: 12),
              const Text('दुकानाचे नाव', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _shopController,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'दुकानाचे नाव आवश्यक आहे' : null,
              ),
              const SizedBox(height: 12),
              const Text('पिनकोड', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _pincodeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                validator: (v) => (v == null || v.trim().length != 6) ? 'योग्य ६ अंकी पिनकोड टाका' : null,
              ),
              const SizedBox(height: 8),
              const Text('मोबाईल नंबर', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                      validator: (v) => (v == null || v.trim().length != 10) ? 'योग्य १० अंकी नंबर टाका' : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _sendOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                    ),
                    child: const Text('OTP पाठवा', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              if (_otpSent) ...[
                const SizedBox(height: 4),
                const Text('OTP टाका', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  validator: (v) => (_otpSent && (v == null || v.trim().isEmpty)) ? 'OTP टाका' : null,
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitSeller,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('सेलर जोडा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
