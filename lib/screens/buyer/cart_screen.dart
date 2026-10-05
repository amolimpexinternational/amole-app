import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/buyer_shopping_data.dart';
import 'order_tracking_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _usePoints = false;
  final int _availablePoints = 245;

  double get _subtotal => BuyerShoppingData.cartSubtotal;

  int get _pointsToUse {
    if (!_usePoints) return 0;
    final subtotalPoints = _subtotal.floor();
    return _availablePoints > subtotalPoints ? subtotalPoints : _availablePoints;
  }

  double get _total =>
      (_subtotal - _pointsToUse).clamp(0, double.infinity).toDouble();

  void _removeItem(String id) {
    setState(() {
      BuyerShoppingData.removeFromCart(id);
      if (BuyerShoppingData.cartItems.isEmpty) {
        _usePoints = false;
      }
    });
  }

  void _changeQty(String id, int delta) {
    setState(() {
      BuyerShoppingData.changeCartQuantity(id, delta);
    });
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    final String id = item['id'] as String;
    final String name = item['name'] as String;
    final double price = item['price'] as double;
    final double mrp = item['mrp'] as double;
    final int discount = item['discount'] as int;
    final int qty = item['qty'] as int;
    final String seller = item['seller'] as String;
    final String description = item['description'] as String;
    final bool deliveryAvailable = item['deliveryAvailable'] as bool;
    final bool isReturnable = item['isReturnable'] as bool;

    final double itemTotal = price * qty;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 38,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textLight,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        seller,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            '₹${price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.successGreen,
                            ),
                          ),
                          if (mrp > price) ...[
                            const SizedBox(width: 6),
                            Text(
                              '₹${mrp.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textLight,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '$discount% OFF',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.successGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Delete',
                  onPressed: () => _removeItem(id),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              children: [
                const Text(
                  'Quantity:',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        iconSize: 18,
                        onPressed: qty > 1
                            ? () => _changeQty(id, -1)
                            : null,
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        '$qty',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        iconSize: 18,
                        onPressed: () => _changeQty(id, 1),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${itemTotal.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      deliveryAvailable
                          ? 'Delivery उपलब्ध'
                          : 'Delivery उपलब्ध नाही',
                      style: TextStyle(
                        fontSize: 11,
                        color: deliveryAvailable
                            ? AppColors.successGreen
                            : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isReturnable ? 'Return उपलब्ध' : 'Non-returnable',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x14000000),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryOrange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.stars,
                  color: AppColors.primaryOrange,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Loyalty Points वापरा ($_availablePoints उपलब्ध)',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                Switch(
                  value: _usePoints,
                  onChanged: BuyerShoppingData.cartItems.isEmpty
                      ? null
                      : (value) => setState(() {
                            _usePoints = value;
                          }),
                  activeColor: AppColors.primaryOrange,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Items Total',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textLight,
                ),
              ),
              Text(
                '₹${_subtotal.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          if (_usePoints) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Points सवलत',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textLight,
                  ),
                ),
                Text(
                  '-₹$_pointsToUse',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.successGreen,
                  ),
                ),
              ],
            ),
          ],
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Final Amount',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '₹${_total.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.successGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: BuyerShoppingData.cartItems.isEmpty
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OrderTrackingScreen(),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Checkout करा',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = BuyerShoppingData.cartItems;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: Text('माझी Cart (${BuyerShoppingData.cartCount})'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: items.isEmpty
          ? const Center(
              child: Text(
                'तुमची Cart रिकामी आहे',
                style: TextStyle(
                  color: AppColors.textLight,
                  fontSize: 16,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return _buildCartItem(items[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  child: _buildSummary(),
                ),
              ],
            ),
    );
  }
}
