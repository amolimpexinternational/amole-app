import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class PromoterKycScreen extends StatefulWidget {
  const PromoterKycScreen({super.key});

  @override
  State<PromoterKycScreen> createState() => _PromoterKycScreenState();
}

class _PromoterKycScreenState extends State<PromoterKycScreen> {
  final _formKey = GlobalKey<FormState>();
  final _aadharController = TextEditingController();
  final _panController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _aadharController.dispose();
    _panController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _submitKyc() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    // TODO: Firebase Stage 3 — Firestore मध्ये सेव्ह करा
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('KYC सबमिट झाली ✅'),
        content: const Text(
          'तुमची KYC फ्रॅंचाईजीकडे व्हेरिफिकेशनसाठी पाठवली आहे. '
          'व्हेरिफिकेशन झाल्यावर तुम्हाला कळवले जाईल.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context, true);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            child: const Text('ठीक आहे'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        title: const Text('प्रमोटर KYC'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.purpleAccent],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('KYC पूर्ण करा', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text(
                      'प्रमोटर होण्यासाठी खालील माहिती भरा. ही माहिती फ्रॅंचाईजीद्वारे व्हेरिफाय केली जाईल.',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // आधार क्रमांक
              const Text('आधार क्रमांक *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _aadharController,
                keyboardType: TextInputType.number,
                maxLength: 12,
                decoration: InputDecoration(
                  hintText: '१२ अंकी आधार क्रमांक',
                  prefixIcon: const Icon(Icons.credit_card, color: Colors.purple),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'आधार क्रमांक आवश्यक';
                  if (v.length != 12) return 'आधार क्रमांक १२ अंकी असावा';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // पॅन क्रमांक
              const Text('पॅन क्रमांक *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _panController,
                textCapitalization: TextCapitalization.characters,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: 'उदा. ABCDE1234F',
                  prefixIcon: const Icon(Icons.badge, color: Colors.purple),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'पॅन क्रमांक आवश्यक';
                  if (v.length != 10) return 'पॅन क्रमांक १० अक्षरी असावा';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // पत्ता
              const Text('पूर्ण पत्ता *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'घर क्रमांक, गल्ली, गाव/शहर, तालुका, जिल्हा, पिनकोड',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Icon(Icons.location_on, color: Colors.purple),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'पत्ता आवश्यक';
                  if (v.length < 10) return 'पूर्ण पत्ता द्या';
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Submit
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitKyc,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('KYC सबमिट करा', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),

              // माहिती
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.amber, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'KYC व्हेरिफिकेशन झाल्यावर तुम्ही प्रमोटर म्हणून काम सुरू करू शकता.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}