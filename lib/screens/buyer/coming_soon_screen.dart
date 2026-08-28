import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class ComingSoonScreen extends StatelessWidget {
  final String title;
  const ComingSoonScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.rocket_launch_outlined, size: 64, color: AppColors.primaryBlue.withOpacity(0.4)),
              const SizedBox(height: 16),
              Text('$title लवकरच येत आहे 🚀',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  textAlign: TextAlign.center),
              const SizedBox(height: 8),
              const Text('ही सेवा पुढच्या टप्प्यात (Investor फंडिंगनंतर) जोडली जाईल.',
                  style: TextStyle(fontSize: 13, color: AppColors.textLight), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
