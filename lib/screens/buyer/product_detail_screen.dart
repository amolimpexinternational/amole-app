import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productName;
  final String price;
  final String sellerName;

  const ProductDetailScreen({
    super.key,
    this.productName = 'उत्पादन',
    this.price = '₹0',
    this.sellerName = 'AMOLE Seller',
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  double get _unitPrice => double.tryParse(widget.price.replaceAll('₹', '').replaceAll(',', '')) ?? 0;
  double get _totalPrice => _unitPrice * quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('उत्पादनाची माहिती'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.price,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.successGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'वर्णन',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'ताजी, दर्जेदार वस्तू — थेट विक्रेत्याकडून.',
                    style: TextStyle(
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.store),
                    ),
                    title: Text(widget.sellerName),
                    subtitle: const Text('Verified Seller'),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'संख्या:',
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
                      const Spacer(),
                      Text('एकूण: ₹${_totalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${widget.productName} कार्टमध्ये टाकलं'), backgroundColor: Colors.green),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryOrange,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Cart मध्ये टाका',
                            style: TextStyle(color: AppColors.white),
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
                            backgroundColor: AppColors.primaryBlue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'आत्ता खरेदी करा',
                            style: TextStyle(color: AppColors.white),
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
