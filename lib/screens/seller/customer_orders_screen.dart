import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  Widget orderCard(String id, String customer, String amount) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.shopping_cart_outlined),
        title: Text(customer),
        subtitle: Text('Order ID: $id'),
        trailing: Text(
          amount,
          style: const TextStyle(
            color: AppColors.successGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Customer Orders'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          orderCard('#ORD101', 'Rahul Patil', '₹850'),
          orderCard('#ORD102', 'Sneha Kulkarni', '₹1200'),
          orderCard('#ORD103', 'Amit Shinde', '₹540'),
        ],
      ),
    );
  }
}
