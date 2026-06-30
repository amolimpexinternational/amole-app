import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'order_tracking_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Widget buildCartItem(
      String name, String price, String qty) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 26,
          child: Icon(Icons.shopping_bag_outlined),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('Quantity: $qty'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              price,
              style: const TextStyle(
                color: AppColors.successGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Icon(
              Icons.delete_outline,
              color: Colors.red,
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
        title: const Text('My Cart'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  buildCartItem(
                    'Organic Alphonso Mango',
                    '₹850',
                    '2',
                  ),
                  buildCartItem(
                    'Fresh Tomatoes',
                    '₹120',
                    '5',
                  ),
                  buildCartItem(
                    'Natural Honey',
                    '₹450',
                    '1',
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₹1,420',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              AppColors.successGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
                        );
                      },
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.primaryBlue,
                        padding:
                            const EdgeInsets.symmetric(
                                vertical: 14),
                      ),
                      child: const Text(
                        'Proceed to Checkout',
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                    ),
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
