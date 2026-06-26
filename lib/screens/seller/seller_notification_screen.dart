import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerNotificationScreen extends StatelessWidget {
  const SellerNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.notifications_active),
            title: Text('New Order Received'),
            subtitle: Text('Order #ORD101 placed successfully'),
          ),
          ListTile(
            leading: Icon(Icons.payments_outlined),
            title: Text('Payment Received'),
            subtitle: Text('₹1200 credited to your account'),
          ),
          ListTile(
            leading: Icon(Icons.inventory_outlined),
            title: Text('Low Stock Alert'),
            subtitle: Text('Organic Mango stock is low'),
          ),
        ],
      ),
    );
  }
}
