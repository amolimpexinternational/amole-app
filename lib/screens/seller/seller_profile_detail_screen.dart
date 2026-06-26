import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerProfileDetailScreen extends StatelessWidget {
  const SellerProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Seller Profile'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),
            Card(
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('Seller Name'),
                    subtitle: Text('AMOLE Farmer Store'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.phone_outlined),
                    title: Text('Mobile'),
                    subtitle: Text('+91 9876543210'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.location_on_outlined),
                    title: Text('Address'),
                    subtitle: Text('Pune, Maharashtra'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
