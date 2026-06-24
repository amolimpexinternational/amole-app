import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('AMOLE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.storefront_outlined, size: 80, color: AppColors.primaryBlue),
            SizedBox(height: 16),
            Text('Seller Home Screen', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            SizedBox(height: 8),
            Text('विक्रेता होम स्क्रीन — लवकरच येतंय!', style: TextStyle(fontSize: 15, color: AppColors.textLight)),
          ],
        ),
      ),
    );
  }
}
