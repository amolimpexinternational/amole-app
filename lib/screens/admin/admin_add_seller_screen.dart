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
  String? _selectedFranchise;

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
              validator: (v) => (v == null || v.isEmpty) ? 'दुकानाचे नाव टाका' : null,
            ),
            const SizedBox(height: 14),
            _label('मालकाचे नाव'),
            TextFormField(
              controller: _ownerNameController,
              decoration: _inputDecoration('मालकाचे नाव'),
              validator: (v) => (v == null || v.isEmpty) ? 'नाव टाका' : null,
            ),
            const SizedBox(height: 14),
            _label('मोबाईल नंबर'),
            TextFormField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              decoration: _inputDecoration('10 अंकी मोबाईल नंबर'),
              validator: (v) => (v == null || v.length != 10) ? 'योग्य मोबाईल नंबर टाका' : null,
            ),
            const SizedBox(height: 14),
            _label('पिनकोड'),
            TextFormField(
              controller: _pincodeController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration('6 अंकी पिनकोड'),
              validator: (v) => (v == null || v.length != 6) ? 'योग्य पिनकोड टाका' : null,
            ),
            const SizedBox(height: 14),
            _label('संबंधित Franchise'),
            DropdownButtonFormField<String>(
              initialValue: _selectedFranchise,
              decoration: _inputDecoration('Franchise निवडा'),
              // TODO: populate items from Firestore (collection: franchises)
              items: const [],
              onChanged: (v) => setState(() => _selectedFranchise = v),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade700, size: 18),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('Admin ने जोडलेल्या सेलरला स्वयंचलित पडताळणी (verified) दर्जा मिळेल — GPS व्हेरिफिकेशनची गरज नाही.', style: TextStyle(fontSize: 12, color: AppColors.textDark)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: save new seller document to Firestore (collection: sellers)
                  // fields: shopName, ownerName, mobile, pincode, franchiseId,
                  // status: 'verified', addedBy: 'admin', createdAt
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Seller यशस्वीरित्या जोडला गेला')),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Seller जोडा'),
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
