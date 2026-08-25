import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminAddFranchiseScreen extends StatefulWidget {
  const AdminAddFranchiseScreen({super.key});

  @override
  State<AdminAddFranchiseScreen> createState() => _AdminAddFranchiseScreenState();
}

class _AdminAddFranchiseScreenState extends State<AdminAddFranchiseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _talukaController = TextEditingController();
  final _districtController = TextEditingController();
  final _stateController = TextEditingController();
  String? _selectedChannelPartner;

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
            _label('तालुका'),
            TextFormField(controller: _talukaController, decoration: _inputDecoration('तालुका')),
            const SizedBox(height: 14),
            _label('जिल्हा'),
            TextFormField(controller: _districtController, decoration: _inputDecoration('जिल्हा')),
            const SizedBox(height: 14),
            _label('राज्य'),
            TextFormField(controller: _stateController, decoration: _inputDecoration('राज्य')),
            const SizedBox(height: 14),
            _label('संबंधित Channel Partner'),
            DropdownButtonFormField<String>(
              initialValue: _selectedChannelPartner,
              decoration: _inputDecoration('Channel Partner निवडा'),
              // TODO: populate items from Firestore (collection: channel_partners)
              items: const [],
              onChanged: (v) => setState(() => _selectedChannelPartner = v),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: save new franchise document to Firestore (collection: franchises)
                  // fields: name, mobile, pincode, taluka, district, state, channelPartnerId,
                  // status: 'active', createdAt
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Franchise यशस्वीरित्या जोडली गेली')),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Franchise जोडा'),
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
