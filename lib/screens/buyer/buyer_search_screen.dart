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
  String _searchQuery = '';

  final List<Map<String, String>> _sellers = [
    {'name': 'श्री गणेश किराणा स्टोअर', 'category': 'किराणा', 'distance': '0.5 km', 'rating': '4.5'},
    {'name': 'राज इलेक्ट्रॉनिक्स', 'category': 'इलेक्ट्रॉनिक्स', 'distance': '1.2 km', 'rating': '4.2'},
    {'name': 'स्वाद हॉटेल', 'category': 'खाद्यपदार्थ', 'distance': '0.8 km', 'rating': '4.7'},
    {'name': 'फॅशन पॉईंट', 'category': 'कपडे', 'distance': '1.5 km', 'rating': '4.0'},
    {'name': 'मेडिकल स्टोअर', 'category': 'मेडिकल', 'distance': '0.3 km', 'rating': '4.8'},
    {'name': 'होम डेकोर शॉप', 'category': 'घर', 'distance': '2.0 km', 'rating': '4.1'},
  ];

  final List<Map<String, String>> _buyers = [
    {'name': 'अनिल पाटील', 'area': 'हडपसर, पुणे', 'mutual': '3 common friends'},
    {'name': 'सुनिता देशमुख', 'area': 'कोथरूड, पुणे', 'mutual': '1 common friend'},
    {'name': 'राहुल शिंदे', 'area': 'विमाननगर, पुणे', 'mutual': '5 common friends'},
    {'name': 'प्रिया जोशी', 'area': 'बाणेर, पुणे', 'mutual': '2 common friends'},
    {'name': 'विकास कुलकर्णी', 'area': 'कर्वेनगर, पुणे', 'mutual': '0 common friends'},
  ];

  List<Map<String, String>> get _filteredSellers {
    List<Map<String, String>> list = _sellers;
    if (_selectedFilter == 'shops') {
      list = _sellers.where((s) => ['किराणा', 'कपडे', 'घर'].contains(s['category'])).toList();
    } else if (_selectedFilter == 'products') {
      list = _sellers.where((s) => ['इलेक्ट्रॉनिक्स', 'मेडिकल'].contains(s['category'])).toList();
    } else if (_selectedFilter == 'services') {
      list = _sellers.where((s) => ['खाद्यपदार्थ'].contains(s['category'])).toList();
    }
    if (_searchQuery.isNotEmpty) {
      list = list.where((s) =>
        s['name']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        s['category']!.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    return list;
  }

  List<Map<String, String>> get _filteredBuyers {
    if (_searchQuery.isEmpty) return _buyers;
    return _buyers.where((b) =>
      b['name']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      b['area']!.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  Widget _buildFilterChip(String code, String label, IconData icon) {
    final bool isSelected = _selectedFilter == code;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _selectedFilter = code),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryBlue : AppColors.lightGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(icon, size: 14, color: isSelected ? Colors.white : AppColors.textLight),
              const SizedBox(width: 4),
              Text(label, style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textDark,
                fontSize: 13, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSellerCard(Map<String, String> item) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (_) => SellerProfileScreen(sellerName: item['name']!, category: item['category']!),
      )),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.lightGrey),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
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
                  Row(children: [
                    const Icon(Icons.star, color: AppColors.primaryOrange, size: 14),
                    const SizedBox(width: 4),
                    Text(item['rating']!, style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
                    const SizedBox(width: 12),
                    const Icon(Icons.location_on_outlined, color: AppColors.textLight, size: 14),
                    const SizedBox(width: 2),
                    Text(item['distance']!, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                  ]),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }

  Widget _buildBuyerCard(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
            child: Text(item['name']![0], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.location_on_outlined, color: AppColors.textLight, size: 14),
                  const SizedBox(width: 2),
                  Text(item['area']!, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                ]),
                const SizedBox(height: 4),
                Text(item['mutual']!, style: const TextStyle(fontSize: 11, color: AppColors.primaryBlue)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              minimumSize: Size.zero,
            ),
            child: const Text('मित्र जोडा', style: TextStyle(fontSize: 12, color: Colors.white)),
          ),
        ],
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
    final bool isFriendSearch = _selectedFilter == 'friends';
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
        title: const Text('शोधा', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() => _searchQuery = v),
                      decoration: InputDecoration(
                        hintText: isFriendSearch ? 'मित्राचं नाव किंवा परिसर शोधा...' : 'दुकान, वस्तू, सेवा, keyword शोधा...',
                        prefixIcon: const Icon(Icons.search, color: AppColors.textLight),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      _buildFilterChip('all', 'सर्व', Icons.apps),
                      _buildFilterChip('shops', 'दुकाने', Icons.store_outlined),
                      _buildFilterChip('products', 'वस्तू', Icons.inventory_2_outlined),
                      _buildFilterChip('services', 'सेवा', Icons.handyman_outlined),
                      _buildFilterChip('friends', 'मित्र शोध', Icons.people_outline),
                    ]),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isFriendSearch
                ? (_filteredBuyers.isEmpty
                  ? const Center(child: Text('कोणी सापडले नाही', style: TextStyle(color: AppColors.textLight)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredBuyers.length,
                      itemBuilder: (_, i) => _buildBuyerCard(_filteredBuyers[i]),
                    ))
                : (_filteredSellers.isEmpty
                  ? const Center(child: Text('काही सापडले नाही', style: TextStyle(color: AppColors.textLight)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredSellers.length,
                      itemBuilder: (_, i) => _buildSellerCard(_filteredSellers[i]),
                    )),
            ),
          ],
        ),
      ),
    );
  }
}
