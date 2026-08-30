import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'product_detail_screen.dart';
import 'qr_payment_screen.dart';

class SellerProfileScreen extends StatelessWidget {
  final String sellerName;
  final String category;

  const SellerProfileScreen({
    super.key,
    required this.sellerName,
    required this.category,
  });

  static const List<Map<String, String>> _products = [
    {'name': 'तांदूळ 5kg', 'price': '₹250'},
    {'name': 'गहू 5kg', 'price': '₹180'},
    {'name': 'तेल 1L', 'price': '₹140'},
    {'name': 'साखर 1kg', 'price': '₹45'},
    {'name': 'चहा पावडर 250g', 'price': '₹90'},
    {'name': 'डाळ 1kg', 'price': '₹120'},
  ];

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textLight),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14, color: AppColors.textDark))),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String name, String price) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductDetailScreen(productName: name, price: price, sellerName: sellerName)),
        );
      },
      child: Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            decoration: const BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Icon(Icons.image_outlined, color: AppColors.textLight, size: 32),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const SizedBox(height: 4),
                Text(price, style: const TextStyle(fontSize: 13, color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildReviewCard(String name, String comment, int rating) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textDark)),
              const Spacer(),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < rating ? Icons.star : Icons.star_border,
                    color: AppColors.primaryOrange,
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(comment, style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
        ],
      ),
    );
  }

  void _showCallDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('फोन नंबर'),
        content: const Text('+91 98765 43210'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('बंद करा')),
        ],
      ),
    );
  }

  void _showAllProducts(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('सर्व Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: _products.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (_, i) => ListTile(
                    leading: const Icon(Icons.inventory_2_outlined, color: AppColors.primaryBlue),
                    title: Text(_products[i]['name']!),
                    trailing: Text(_products[i]['price']!, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                    onTap: () {
                      Navigator.pop(ctx);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(productName: _products[i]['name']!, price: _products[i]['price']!, sellerName: sellerName),
                      ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: AppColors.primaryBlue,
            iconTheme: const IconThemeData(color: AppColors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primaryBlue, AppColors.royalBlue],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 36,
                        backgroundColor: AppColors.white,
                        child: Icon(Icons.store, size: 40, color: AppColors.primaryBlue),
                      ),
                      const SizedBox(height: 10),
                      Text(sellerName, style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(category, style: const TextStyle(color: AppColors.white, fontSize: 13)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QrPaymentScreen(sellerName: sellerName),
                              ),
                            );
                          },
                          icon: const Icon(Icons.qr_code, size: 18),
                          label: const Text('QR Pay करा'),
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.cyan, foregroundColor: AppColors.textDark),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _showCallDialog(context),
                          icon: const Icon(Icons.call_outlined, size: 18),
                          label: const Text('कॉल करा'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('माहिती', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 10),
                  _buildInfoRow(Icons.location_on_outlined, 'हडपसर, पुणे — ०.५ किमी'),
                  _buildInfoRow(Icons.access_time_outlined, 'सकाळी ९ ते रात्री ९'),
                  _buildInfoRow(Icons.star_outline, '4.5 रेटिंग (128 reviews)'),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.green.shade200)),
                    child: const Row(children: [
                      Icon(Icons.local_offer_outlined, color: Colors.green, size: 18),
                      SizedBox(width: 8),
                      Expanded(child: Text('सध्याची ऑफर: सर्व वस्तूंवर 10% सूट — मर्यादित काळासाठी', style: TextStyle(fontSize: 13, color: AppColors.textDark))),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Products', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      TextButton(onPressed: () => _showAllProducts(context), child: const Text('सर्व बघा')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _products.take(4).map((p) => _buildProductCard(context, p['name']!, p['price']!)).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Reviews', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 10),
                  _buildReviewCard('अनिल जोशी', 'चांगली सेवा, वेळेवर डिलिव्हरी मिळते.', 5),
                  _buildReviewCard('संगीता राणे', 'दर्जा चांगला आहे, किंमत पण योग्य.', 4),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
