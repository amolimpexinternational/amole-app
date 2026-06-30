import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'seller_profile_screen.dart';

class BuyerSearchScreen extends StatefulWidget {
  const BuyerSearchScreen({super.key});

  @override
  State<BuyerSearchScreen> createState() => _BuyerSearchScreenState();
}

class _BuyerSearchScreenState extends State<BuyerSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all';

  final List<Map<String, String>> _results = [
    {'name': 'श्री गणेश किराणा स्टोअर', 'category': 'किराणा', 'distance': '0.5 km', 'rating': '4.5'},
    {'name': 'राज इलेक्ट्रॉनिक्स', 'category': 'इलेक्ट्रॉनिक्स', 'distance': '1.2 km', 'rating': '4.2'},
    {'name': 'स्वाद हॉटेल', 'category': 'खाद्यपदार्थ', 'distance': '0.8 km', 'rating': '4.7'},
    {'name': 'फॅशन पॉईंट', 'category': 'कपडे', 'distance': '1.5 km', 'rating': '4.0'},
  ];

  Widget _buildFilterChip(String code, String label) {
    final bool isSelected = _selectedFilter == code;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: AppColors.primaryBlue,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.white : AppColors.textDark,
          fontSize: 13,
        ),
        backgroundColor: AppColors.lightGrey,
        onSelected: (_) {
          setState(() {
            _selectedFilter = code;
          });
        },
      ),
    );
  }

  Widget _buildResultCard(Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SellerProfileScreen(
              sellerName: item['name']!,
              category: item['category']!,
            ),
          ),
        );
      },
      child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.store_outlined, color: AppColors.primaryBlue, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                const SizedBox(height: 4),
                Text(item['category']!, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.primaryOrange, size: 14),
                    const SizedBox(width: 4),
                    Text(item['rating']!, style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
                    const SizedBox(width: 12),
                    const Icon(Icons.location_on_outlined, color: AppColors.textLight, size: 14),
                    const SizedBox(width: 2),
                    Text(item['distance']!, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textLight),
        ],
      ),
    ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
        title: const Text('शोधा', style: TextStyle(color: AppColors.textDark)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'दुकान, वस्तू, सेवा शोधा...',
                    prefixIcon: Icon(Icons.search, color: AppColors.textLight),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('all', 'सर्व'),
                    _buildFilterChip('shops', 'दुकाने'),
                    _buildFilterChip('products', 'वस्तू'),
                    _buildFilterChip('services', 'सेवा'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) => _buildResultCard(_results[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
