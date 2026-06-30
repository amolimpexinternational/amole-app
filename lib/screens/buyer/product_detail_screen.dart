import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState
    extends State<ProductDetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: AppColors.white,
              child: const Icon(
                Icons.image_outlined,
                size: 120,
                color: AppColors.textLight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Organic Alphonso Mango',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '₹850',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.successGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Fresh organic Alphonso mangoes directly from farmers. Premium quality and naturally ripened.',
                    style: TextStyle(
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.store),
                    ),
                    title: Text('AMOLE Farmer Store'),
                    subtitle: Text('Verified Seller'),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Quantity:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove_circle),
                      ),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(Icons.add_circle),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const CartScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.primaryOrange,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                                color: AppColors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const CartScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.primaryBlue,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14),
                          ),
                          child: const Text(
                            'Buy Now',
                            style: TextStyle(
                                color: AppColors.white),
                          ),
                        ),
                      ),
                    ],
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
