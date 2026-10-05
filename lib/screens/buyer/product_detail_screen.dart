import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/buyer_shopping_data.dart';
import '../../models/product_model.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productName;
  final String price;
  final String sellerName;
  final ProductModel? product;

  const ProductDetailScreen({
    super.key,
    this.productName = 'उत्पादन',
    this.price = '₹0',
    this.sellerName = 'AMOLE Seller',
    this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  ProductModel? get _product => widget.product;

  String get _name => _product?.name ?? widget.productName;

  String get _seller => _product?.sellerName ?? widget.sellerName;

  double get _unitPrice {
    if (_product != null) {
      return _product!.sellingPrice;
    }

    return double.tryParse(
          widget.price.replaceAll('₹', '').replaceAll(',', ''),
        ) ??
        0;
  }

  double get _mrp => _product?.mrp ?? _unitPrice;

  double get _discount => _product?.discount ?? 0;

  int get _stock => _product?.stock ?? 20;

  String get _description => _product?.description.isNotEmpty == true
      ? _product!.description
      : 'ताजी, दर्जेदार वस्तू — थेट विक्रेत्याकडून.';

  String get _productId => _product?.id ?? '${_seller.trim()}|${_name.trim()}';

  double get _totalPrice => _unitPrice * quantity;

  Map<String, dynamic> get _shoppingItem => {
    'id': _productId,
    'name': _name,
    'price': _unitPrice,
    'qty': quantity,
    'seller': _seller,
    'description': _description,
    'image': _product?.image ?? '',
    'mrp': _mrp,
    'discount': _discount,
    'stock': _stock,
    'deliveryAvailable': _product?.deliveryAvailable ?? true,
    'isReturnable': _product?.isReturnable ?? true,
  };

  bool get _isFavourite => BuyerShoppingData.isFavourite(_productId);

  void _addToCart({bool goToCart = false}) {
    BuyerShoppingData.addToCart(
      id: _productId,
      name: _name,
      price: _unitPrice,
      qty: quantity,
      seller: _seller,
      description: _description,
      image: _product?.image ?? '',
      mrp: _mrp,
      discount: _discount,
      stock: _stock,
      deliveryAvailable: _product?.deliveryAvailable ?? true,
      isReturnable: _product?.isReturnable ?? true,
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
        content: Text('$_name Cart मध्ये जोडले'),
        duration: const Duration(seconds: 2),
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
              ? '$_name Favourite मध्ये जोडले'
              : '$_name Favourite मधून काढले',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _infoRow(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: AppColors.primaryBlue),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(color: AppColors.textLight),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  String _yesNo(bool value) => value ? 'होय' : 'नाही';

  String get _weightText {
    if (_product == null || _product!.productWeight <= 0) {
      return 'माहिती उपलब्ध नाही';
    }

    return '${_product!.productWeight.toStringAsFixed(0)} ${_product!.weightUnit}';
  }

  String get _shippingWeightText {
    if (_product == null || _product!.shippingWeight <= 0) {
      return 'माहिती उपलब्ध नाही';
    }

    return '${_product!.shippingWeight.toStringAsFixed(0)} ${_product!.weightUnit}';
  }

  String get _dimensionText {
    if (_product == null ||
        _product!.packageLength <= 0 ||
        _product!.packageWidth <= 0 ||
        _product!.packageHeight <= 0) {
      return 'माहिती उपलब्ध नाही';
    }

    return '${_product!.packageLength.toStringAsFixed(0)} × '
        '${_product!.packageWidth.toStringAsFixed(0)} × '
        '${_product!.packageHeight.toStringAsFixed(0)} '
        '${_product!.dimensionUnit}';
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
              child: _product?.image.isNotEmpty == true
                  ? Image.network(
                      _product!.image,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.image_outlined,
                        size: 120,
                        color: AppColors.textLight,
                      ),
                    )
                  : const Icon(
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
                    _name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${_unitPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.successGreen,
                        ),
                      ),
                      if (_discount > 0) ...[
                        const SizedBox(width: 10),
                        Text(
                          '₹${_mrp.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                            color: AppColors.textLight,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${_discount.toStringAsFixed(0)}% OFF',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.successGreen,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  _sectionCard(
                    title: 'वर्णन',
                    icon: Icons.description_outlined,
                    children: [
                      Text(
                        _description,
                        style: const TextStyle(
                          color: AppColors.textLight,
                          height: 1.4,
                        ),
                      ),
                      if (_product?.keywords.isNotEmpty == true)
                        _infoRow(
                          'Keywords',
                          _product!.keywords,
                          icon: Icons.search,
                        ),
                      if (_product?.brand.isNotEmpty == true)
                        _infoRow(
                          'Brand',
                          _product!.brand,
                          icon: Icons.branding_watermark_outlined,
                        ),
                      if (_product?.sku.isNotEmpty == true)
                        _infoRow(
                          'SKU / Product Code',
                          _product!.sku,
                          icon: Icons.qr_code_2,
                        ),
                      _infoRow(
                        'Category',
                        _product?.category ?? 'माहिती उपलब्ध नाही',
                        icon: Icons.category_outlined,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
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
                          onPressed: _stock > 0 ? () => _addToCart() : null,
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
                          final minimum = _product?.minimumOrderQty ?? 1;
                          if (quantity > minimum) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove_circle),
                      ),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        onPressed: () {
                          if (quantity < _stock) {
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _stock > 0
                          ? () => _addToCart(goToCart: true)
                          : null,
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
                  _sectionCard(
                    title: 'विक्रेता',
                    icon: Icons.store_outlined,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const CircleAvatar(child: Icon(Icons.store)),
                        title: Text(_seller),
                        subtitle: Text(
                          _product?.sellerId.isNotEmpty == true
                              ? 'Seller ID: ${_product!.sellerId}'
                              : 'Verified Seller',
                        ),
                      ),
                    ],
                  ),
                  _sectionCard(
                    title: 'स्टॉक आणि ऑर्डर',
                    icon: Icons.inventory_2_outlined,
                    children: [
                      _infoRow(
                        'उपलब्ध स्टॉक',
                        '$_stock',
                        icon: Icons.inventory_outlined,
                      ),
                      _infoRow(
                        'किमान ऑर्डर',
                        '${_product?.minimumOrderQty ?? 1}',
                        icon: Icons.shopping_basket_outlined,
                      ),
                    ],
                  ),
                  _sectionCard(
                    title: 'वजन आणि पॅकेज',
                    icon: Icons.scale_outlined,
                    children: [
                      _infoRow(
                        'उत्पादनाचे वजन',
                        _weightText,
                        icon: Icons.scale_outlined,
                      ),
                      _infoRow(
                        'Shipping / Packed Weight',
                        _shippingWeightText,
                        icon: Icons.local_shipping_outlined,
                      ),
                      _infoRow(
                        'पॅकेज संख्या',
                        '${_product?.packageCount ?? 1}',
                        icon: Icons.inventory_2_outlined,
                      ),
                      _infoRow(
                        'Package Dimensions',
                        _dimensionText,
                        icon: Icons.straighten_outlined,
                      ),
                      if (_product != null && _product!.volumetricWeight > 0)
                        _infoRow(
                          'Volumetric Weight',
                          '${_product!.volumetricWeight.toStringAsFixed(2)} kg',
                          icon: Icons.view_in_ar_outlined,
                        ),
                    ],
                  ),
                  _sectionCard(
                    title: 'डिलिव्हरी / ट्रान्सपोर्ट',
                    icon: Icons.local_shipping_outlined,
                    children: [
                      _infoRow(
                        'Home Delivery',
                        _yesNo(_product?.deliveryAvailable ?? true),
                      ),
                      _infoRow(
                        'AMOLE Delivery',
                        _yesNo(_product?.amoleDelivery ?? true),
                      ),
                      _infoRow(
                        'Seller Self Delivery',
                        _yesNo(_product?.sellerSelfDelivery ?? false),
                      ),
                      _infoRow(
                        'Courier / Transport',
                        _yesNo(_product?.courierDelivery ?? true),
                      ),
                      _infoRow(
                        'Local Delivery',
                        _yesNo(_product?.localDelivery ?? true),
                      ),
                      _infoRow(
                        'Inter-city Delivery',
                        _yesNo(_product?.interCityDelivery ?? true),
                      ),
                      _infoRow(
                        'Processing / Dispatch',
                        _product?.processingTime ?? '1-2 दिवस',
                      ),
                    ],
                  ),
                  _sectionCard(
                    title: 'डिलिव्हरी गणनेसाठी विशेष माहिती',
                    icon: Icons.route_outlined,
                    children: [
                      _infoRow('Fragile', _yesNo(_product?.fragile ?? false)),
                      _infoRow('Liquid', _yesNo(_product?.liquid ?? false)),
                      _infoRow(
                        'Perishable',
                        _yesNo(_product?.perishable ?? false),
                      ),
                      _infoRow(
                        'Oversized',
                        _yesNo(_product?.oversized ?? false),
                      ),
                      _infoRow(
                        'COD Eligible',
                        _yesNo(_product?.codEligible ?? true),
                      ),
                      _infoRow(
                        'Reverse Pickup',
                        _yesNo(_product?.reversePickup ?? true),
                      ),
                    ],
                  ),
                  _sectionCard(
                    title: 'Return आणि Delivery',
                    icon: Icons.assignment_return_outlined,
                    children: [
                      _infoRow(
                        'Returnable',
                        _yesNo(_product?.isReturnable ?? true),
                      ),
                      _infoRow(
                        'Delivery Available',
                        _yesNo(_product?.deliveryAvailable ?? true),
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
