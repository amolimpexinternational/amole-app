import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../shared/chat_screen.dart';

class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  Widget orderCard(BuildContext context, String id, String customer, String amount) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.shopping_cart_outlined),
        title: Text(customer),
        subtitle: Text('Order ID: $id'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              amount,
              style: const TextStyle(
                color: AppColors.successGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline, color: AppColors.primaryBlue, size: 20),
              tooltip: 'Message',
              onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (_) => ChatScreen(contactName: customer, contactRole: 'ग्राहक'),
              )),
            ),
            IconButton(
              icon: const Icon(Icons.call_outlined, color: AppColors.primaryBlue, size: 20),
              tooltip: 'Call',
              onPressed: () => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => CallDialog(contactName: customer),
              ),
            ),
          ],
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
          orderCard(context, '#ORD101', 'Rahul Patil', '₹850'),
          orderCard(context, '#ORD102', 'Sneha Kulkarni', '₹1200'),
          orderCard(context, '#ORD103', 'Amit Shinde', '₹540'),
        ],
      ),
    );
  }
}
