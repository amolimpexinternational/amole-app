import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/buyer_shopping_data.dart';
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

  double get _unitPrice =>
      double.tryParse(widget.price.replaceAll('₹', '').replaceAll(',', '')) ?? 0;

  double get _totalPrice => _unitPrice * quantity;

  String get _productId =>
      '${widget.sellerName.trim()}|${widget.productName.trim()}';

  Map<String, dynamic> get _shoppingItem => {
        'id': _productId,
        'name': widget.productName,
        'price': _unitPrice,
        'qty': quantity,
        'seller': widget.sellerName,
        'description': 'ताजी, दर्जेदार वस्तू — थेट विक्रेत्याकडून.',
        'image': '',
        'mrp': _unitPrice,
        'discount': 0.0,
        'stock': 20,
        'deliveryAvailable': true,
        'isReturnable': true,
      };

  bool get _isFavourite => BuyerShoppingData.isFavourite(_productId);

  void _addToCart({bool goToCart = false}) {
    BuyerShoppingData.addToCart(
      id: _productId,
      name: widget.productName,
      price: _unitPrice,
      qty: quantity,
      seller: widget.sellerName,
      description: 'ताजी, दर्जेदार वस्तू — थेट विक्रेत्याकडून.',
      image: '',
      mrp: _unitPrice,
      discount: 0,
      stock: 20,
      deliveryAvailable: true,
      isReturnable: true,
    );

    if (goToCart) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CartScreen()),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.productName} कार्टमध्ये टाकलं'),
        backgroundColor: AppColors.successGreen,
        action: SnackBarAction(
          label: 'Cart पहा',
          textColor: AppColors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            );
          },
        ),
      ),
    );
  }

  void _toggleFavourite() {
    setState(() {
      BuyerShoppingData.toggleFavourite(_shoppingItem);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavourite
              ? '${widget.productName} Favourite मध्ये जोडले'
              : '${widget.productName} Favourite मधून काढले',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('उत्पादनाची माहिती'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
            tooltip: 'My Favourite',
            onPressed: _toggleFavourite,
            icon: Icon(
              _isFavourite ? Icons.favorite : Icons.favorite_border,
              color: _isFavourite ? Colors.redAccent : AppColors.white,
            ),
          ),
          IconButton(
            tooltip: 'Cart',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
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
                          if (quantity < 20) {
                            setState(() {
                              quantity++;
                            });
                          }
                        },
                        icon: const Icon(Icons.add_circle),
                      ),
                      const Spacer(),
                      Text(
                        'एकूण: ₹${_totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.local_shipping_outlined,
                              color: AppColors.successGreen,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'डिलिव्हरी उपलब्ध',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.assignment_return_outlined,
                              color: AppColors.primaryBlue,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Demo मध्ये Return सुविधा उपलब्ध',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _toggleFavourite,
                          icon: Icon(
                            _isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          label: Text(
                            _isFavourite ? 'Favourite मध्ये आहे' : 'Favourite',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            foregroundColor: Colors.redAccent,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _addToCart(),
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
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _addToCart(goToCart: true),
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
            ),
          ],
        ),
      ),
    );
  }
}
