import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  Widget buildStep(
      String title,
      String subtitle,
      bool completed,
      ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: completed
            ? AppColors.successGreen
            : AppColors.lightGrey,
        child: Icon(
          completed ? Icons.check : Icons.access_time,
          color: completed
              ? AppColors.white
              : AppColors.textLight,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Order Tracking'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order ID',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('#AM123456'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Estimated Delivery',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('30 Jun 2026'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  buildStep(
                    'Order Confirmed',
                    'Your order has been confirmed',
                    true,
                  ),
                  buildStep(
                    'Packed',
                    'Seller packed your order',
                    true,
                  ),
                  buildStep(
                    'Shipped',
                    'Order shipped successfully',
                    true,
                  ),
                  buildStep(
                    'Out for Delivery',
                    'Your order is on the way',
                    false,
                  ),
                  buildStep(
                    'Delivered',
                    'Delivery pending',
                    false,
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
