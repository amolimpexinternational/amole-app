import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class SellerRegistrationScreen extends StatelessWidget {
  const SellerRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text("Seller Registration"),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [

          TextField(
            decoration: InputDecoration(
              labelText: 'Business Name',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 16),

          TextField(
            decoration: InputDecoration(
              labelText: 'Owner Name',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 16),

          TextField(
            decoration: InputDecoration(
              labelText: 'Mobile Number',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 16),

          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 16),

          TextField(
            decoration: InputDecoration(
              labelText: 'Village / City',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 16),

          TextField(
            decoration: InputDecoration(
              labelText: 'Pin Code',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 30),

          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: null,
              child: Text("Continue"),
            ),
          ),

        ],
      ),
    );
  }
}
