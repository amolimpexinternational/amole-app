import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import 'notification_screen.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool _agreeTerms = false;
  bool _agreePrivacy = false;
  bool _agreeUpdates = false;

  bool get _canContinue => _agreeTerms && _agreePrivacy;

  void _goNext() {
    if (_canContinue) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NotificationScreen()),
      );
    }
  }

  Widget _buildCheckRow(String text, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: value,
          activeColor: AppColors.primaryBlue,
          onChanged: onChanged,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!value),
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, color: AppColors.textDark),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          AppStrings.termsAndConditions,
          style: TextStyle(color: AppColors.textDark, fontSize: 18),
        ),
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    'AMOLE App वापरण्यासाठी कृपया खालील अटी आणि शर्ती वाचा आणि स्वीकार करा. '
                    'तुमची माहिती सुरक्षित ठेवली जाईल आणि फक्त App च्या सेवांसाठी वापरली जाईल.',
                    style: TextStyle(fontSize: 14, color: AppColors.textLight, height: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildCheckRow(AppStrings.agreeTerms, _agreeTerms, (v) => setState(() => _agreeTerms = v ?? false)),
              _buildCheckRow(AppStrings.agreePrivacy, _agreePrivacy, (v) => setState(() => _agreePrivacy = v ?? false)),
              _buildCheckRow(AppStrings.agreeUpdates, _agreeUpdates, (v) => setState(() => _agreeUpdates = v ?? false)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _canContinue ? _goNext : null,
                child: const Text(AppStrings.agreeAndContinue),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
