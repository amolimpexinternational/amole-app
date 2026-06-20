import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import 'mobile_number_screen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'marathi';

  Widget _buildLanguageOption(String code, String label) {
    final bool isSelected = _selectedLanguage == code;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = code;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue.withOpacity(0.08) : AppColors.white,
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.lightGrey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primaryBlue : AppColors.textLight,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToMobileScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MobileNumberScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                AppStrings.chooseLanguage,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 32),
              _buildLanguageOption('marathi', AppStrings.marathi),
              _buildLanguageOption('hindi', AppStrings.hindi),
              _buildLanguageOption('english', AppStrings.english),
              const Spacer(),
              ElevatedButton(
                onPressed: _goToMobileScreen,
                child: const Text(AppStrings.continueText),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
