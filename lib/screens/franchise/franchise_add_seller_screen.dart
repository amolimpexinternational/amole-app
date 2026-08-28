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
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  final _pincodeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  void _submitSeller() {
    if (_formKey.currentState!.validate()) {
      // TODO (Stage 3 - Backend): save seller to Firestore with status
      // 'pending_seller_login'. Policy: sellers added directly by Franchise
      // are permanently linked to this Franchise (excluded from
      // load-balancing, Blueprint ch. 3.4 exception) and auto-verified
      // without the usual 72-hour GPS wait. Seller will later log in with
      // their own mobile number (OTP) and complete the rest of their
      // profile (shop photo, category, products, etc.) like any seller.
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('✅ सेलर जोडला'),
          content: Text(
            "${_nameController.text} ला यशस्वीरित्या जोडलं गेलं — कायमचा या Franchise ला लिंक (auto-verified).\n\n"
            "सेलर स्वतःच्या मोबाईल नंबरने (${_mobileController.text}) लॉगिन करून बाकीची माहिती (दुकानाचा फोटो, श्रेणी, उत्पादनं) पूर्ण भरेल.",
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // dialog बंद
                Navigator.pop(context); // form स्क्रीन बंद
              },
              child: const Text('ठीक आहे'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('नवीन सेलर जोडा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  border: Border.all(color: Colors.blue.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue.shade800, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'फक्त मूलभूत माहिती भरा — सेलर स्वतःच्या फोनवरून लॉगिन करून बाकीची माहिती (फोटो, श्रेणी, उत्पादनं) पूर्ण भरेल.',
                        style: TextStyle(color: Colors.blue.shade900, fontSize: 12.5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('सेलरचे / दुकानाचे नाव', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'उदा. राजेश किराणा स्टोअर',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'नाव आवश्यक आहे' : null,
              ),
              const SizedBox(height: 14),
              const Text('मोबाईल नंबर', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: '१० अंकी मोबाईल नंबर',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (v) => (v == null || v.trim().length != 10) ? 'योग्य १० अंकी नंबर टाका' : null,
              ),
              const SizedBox(height: 14),
              const Text('पूर्ण पत्ता', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'दुकानाचा पूर्ण पत्ता लिहा',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'पत्ता आवश्यक आहे' : null,
              ),
              const SizedBox(height: 14),
              const Text('पिनकोड', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _pincodeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  hintText: '६ अंकी पिनकोड',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (v) => (v == null || v.trim().length != 6) ? 'योग्य ६ अंकी पिनकोड टाका' : null,
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: _submitSeller,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('सेलर जोडा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
