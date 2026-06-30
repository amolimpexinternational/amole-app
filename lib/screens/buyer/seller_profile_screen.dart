import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'product_detail_screen.dart';

class SellerProfileScreen extends StatelessWidget {
  final String sellerName;
  final String category;

  const SellerProfileScreen({
    super.key,
    required this.sellerName,
    required this.category,
  });

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
          MaterialPageRoute(builder: (_) => const ProductDetailScreen()),
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
                          onPressed: () {},
                          icon: const Icon(Icons.qr_code, size: 18),
                          label: const Text('QR Pay करा'),
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.cyan, foregroundColor: AppColors.textDark),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Products', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      TextButton(onPressed: () {}, child: const Text('सर्व बघा')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildProductCard(context, 'तांदूळ 5kg', '₹250'),
                        _buildProductCard(context, 'गहू 5kg', '₹180'),
                        _buildProductCard(context, 'तेल 1L', '₹140'),
                        _buildProductCard(context, 'साखर 1kg', '₹45'),
                      ],
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
