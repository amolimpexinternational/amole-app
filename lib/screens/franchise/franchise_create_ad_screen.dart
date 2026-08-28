import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FranchiseCreateAdScreen extends StatefulWidget {
  const FranchiseCreateAdScreen({super.key});

  @override
  State<FranchiseCreateAdScreen> createState() => _FranchiseCreateAdScreenState();
}

class _FranchiseCreateAdScreenState extends State<FranchiseCreateAdScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedDuration = '3 दिवस';
  final List<String> _durations = ['3 दिवस', '5 दिवस', '7 दिवस', '10 दिवस'];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submitAd() {
    if (_formKey.currentState!.validate()) {
      // TODO (Stage 3 - Backend): save ad to Firestore, status = 'Live'
      // Franchise's own ads go live instantly (Blueprint ch. 6) — no approval needed.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ जाहिरात Live झाली (Approval आवश्यक नाही)'),
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
        title: const Text('Create Ad', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                  color: Colors.green.shade50,
                  border: Border.all(color: Colors.green.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.flash_on, color: Colors.green.shade800, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'तुमची जाहिरात लगेच Live होईल — Approval लागणार नाही',
                        style: TextStyle(color: Colors.green.shade900, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('जाहिरातीचे शीर्षक', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                maxLength: 60,
                decoration: InputDecoration(
                  hintText: 'उदा. दिवाळी Sale — 20% सूट',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'शीर्षक आवश्यक आहे' : null,
              ),
              const SizedBox(height: 12),
              const Text('तपशील', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _contentController,
                maxLength: 200,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'जाहिरातीबद्दल अधिक माहिती लिहा',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'तपशील आवश्यक आहे' : null,
              ),
              const SizedBox(height: 12),
              const Text('कालावधी', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedDuration,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                items: _durations
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedDuration = v!),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitAd,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('जाहिरात प्रकाशित करा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
