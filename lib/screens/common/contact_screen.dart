import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class ContactScreen extends StatelessWidget {
  final String role;
  const ContactScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final roleName = role == 'franchise' ? 'Franchise' : 'Channel Partner';
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.lock_outline, size: 50, color: AppColors.primaryBlue),
              ),
              const SizedBox(height: 32),
              Text(
                '$roleName Access',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'हे खाते फक्त अधिकृत $roleName साठी आहे.\nतुमचा नंबर नोंदणीकृत नाही.',
                style: const TextStyle(fontSize: 15, color: AppColors.textLight, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    const Text('AMOLE शी संपर्क करा', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    const SizedBox(height: 16),
                    _contactRow(Icons.phone_outlined, 'कॉल करा', '+91 98765 43210'),
                    const SizedBox(height: 12),
                    _contactRow(Icons.email_outlined, 'Email करा', 'franchise@amole.in'),
                    const SizedBox(height: 12),
                    _contactRow(Icons.language_outlined, 'Website', 'www.amole.in'),
                    const SizedBox(height: 12),
                    _contactRow(Icons.chat_outlined, 'WhatsApp', '+91 98765 43210'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('मागे जा'),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 36, height: 36,
          decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: AppColors.primaryBlue, size: 18),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
            Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          ],
        ),
      ],
    );
  }
}
