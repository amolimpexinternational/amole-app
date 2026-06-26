import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerSupportScreen extends StatelessWidget {
  const SellerSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Seller Support'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Column(
            children: const [
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Support Number'),
                subtitle: Text('+91 9876543210'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.email_outlined),
                title: Text('Email Support'),
                subtitle: Text('support@amole.com'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
