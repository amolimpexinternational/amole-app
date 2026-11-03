import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'promoter_dashboard_screen.dart';

// Demo साठी: Promoter नोंदणी झाली की नाही (फक्त memory मध्ये, Stage 3 मध्ये Firestore)
class PromoterState {
  static bool registered = false;
  static String name = '';
}

class PromoterProfileScreen extends StatefulWidget {
  const PromoterProfileScreen({super.key});

  @override
  State<PromoterProfileScreen> createState() => _PromoterProfileScreenState();
}

class _PromoterProfileScreenState extends State<PromoterProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _pincodeCtrl = TextEditingController();
  final _aadhaarCtrl = TextEditingController();
  final _otherDocCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _mobileCtrl.dispose();
    _addressCtrl.dispose();
    _pincodeCtrl.dispose();
    _aadhaarCtrl.dispose();
    _otherDocCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    PromoterState.registered = true;
    PromoterState.name = _nameCtrl.text.trim();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('माहिती Franchise कडे verification साठी पाठवली आहे'),
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const PromoterDashboardScreen()),
    );
  }

  String? _required(String? v, String label) {
    if (v == null || v.trim().isEmpty) return '$label भरा';
    return null;
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    TextInputType keyboard = TextInputType.text,
    int? maxLength,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        maxLength: maxLength,
        maxLines: maxLines,
        validator: validator ?? (v) => _required(v, label),
        decoration: InputDecoration(
          labelText: label,
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('Promoter Profile बनवा'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  '💰 प्रमोटर झाल्यामुळे 5% कमिशन मिळू शकते',
                  style: TextStyle(
                    color: AppColors.royalBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _field(controller: _nameCtrl, label: 'पूर्ण नाव'),
              _field(
                controller: _mobileCtrl,
                label: 'मोबाईल नंबर',
                keyboard: TextInputType.phone,
                maxLength: 10,
                validator: (v) {
                  if (v == null || v.trim().length != 10) {
                    return '10 अंकी मोबाईल नंबर भरा';
                  }
                  return null;
                },
              ),
              _field(
                controller: _addressCtrl,
                label: 'पूर्ण पत्ता',
                maxLines: 3,
              ),
              _field(
                controller: _pincodeCtrl,
                label: 'पिनकोड',
                keyboard: TextInputType.number,
                maxLength: 6,
                validator: (v) {
                  if (v == null || v.trim().length != 6) {
                    return '6 अंकी पिनकोड भरा';
                  }
                  return null;
                },
              ),
              _field(
                controller: _aadhaarCtrl,
                label: 'आधार कार्ड नंबर',
                keyboard: TextInputType.number,
                maxLength: 12,
                validator: (v) {
                  if (v == null || v.trim().length != 12) {
                    return '12 अंकी आधार नंबर भरा';
                  }
                  return null;
                },
              ),
              _field(
                controller: _otherDocCtrl,
                label: 'इतर डॉक्युमेंट नंबर (उदा. PAN)',
              ),
              const SizedBox(height: 4),
              const Text(
                'Submit केल्यानंतर तुमची माहिती Franchise कडे verification साठी जाईल.',
                style: TextStyle(fontSize: 12, color: AppColors.textLight),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _submit,
                  child: const Text(
                    'Submit करा',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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