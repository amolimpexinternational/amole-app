import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({super.key});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.shopping_basket_outlined, 'label': 'किराणा'},
    {'icon': Icons.electrical_services_outlined, 'label': 'इलेक्ट्रॉनिक्स'},
    {'icon': Icons.local_hospital_outlined, 'label': 'मेडिकल'},
    {'icon': Icons.checkroom_outlined, 'label': 'कपडे'},
    {'icon': Icons.restaurant_outlined, 'label': 'खाद्यपदार्थ'},
    {'icon': Icons.home_outlined, 'label': 'घर'},
    {'icon': Icons.directions_bike_outlined, 'label': 'वाहन'},
    {'icon': Icons.school_outlined, 'label': 'शिक्षण'},
    {'icon': Icons.spa_outlined, 'label': 'सौंदर्य'},
    {'icon': Icons.sports_soccer_outlined, 'label': 'खेळ'},
    {'icon': Icons.pets_outlined, 'label': 'पाळीव'},
    {'icon': Icons.more_horiz_outlined, 'label': 'इतर'},
  ];

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryBlue, AppColors.royalBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // App Name
                    const Text('AMOLE', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        // Loyalty Points — ठळकपणे
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade600,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.stars, color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text('245 pts', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        // QR Scan Button
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.cyan,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.qr_code_scanner, color: AppColors.royalBlue, size: 16),
                              SizedBox(width: 4),
                              Text('QR Pay', style: TextStyle(color: AppColors.royalBlue, fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Notification
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                          onPressed: () {},
                        ),
                        // Profile
                        IconButton(
                          icon: const Icon(Icons.account_circle_outlined, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: AppColors.primaryBlue),
                      SizedBox(width: 10),
                      Text('दुकान, वस्तू, सेवा शोधा...', style: TextStyle(color: AppColors.textLight, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Banner Ad — 25% मोठा (120 → 150)
          Container(
            margin: const EdgeInsets.all(16),
            height: 150,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00E5FF), Color(0xFF1565C0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🎉 आपल्या गावातील दुकाने', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text('माझा पैसा माझ्या खिशात', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  SizedBox(height: 8),
                  Text('आपल्या लोकांचा आपला बाजार 🛒', style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
          ),

          // Categories
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('श्रेणी', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.85,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(_categories[index]['icon'] as IconData, color: AppColors.primaryBlue, size: 28),
                  ),
                  const SizedBox(height: 6),
                  Text(_categories[index]['label'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textDark), textAlign: TextAlign.center),
                ],
              );
            },
          ),

          const SizedBox(height: 20),

          // Nearby Sellers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('जवळचे दुकानदार', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                TextButton(onPressed: () {}, child: const Text('सर्व बघा', style: TextStyle(color: AppColors.primaryBlue))),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 3,
            itemBuilder: (context, index) {
              final sellers = [
                {'name': 'गणेश किराणा मार्ट', 'category': 'किराणा', 'distance': '0.3 km', 'rating': '4.8'},
                {'name': 'श्री मेडिकल स्टोर', 'category': 'मेडिकल', 'distance': '0.7 km', 'rating': '4.6'},
                {'name': 'राज इलेक्ट्रॉनिक्स', 'category': 'इलेक्ट्रॉनिक्स', 'distance': '1.2 km', 'rating': '4.5'},
              ];
              final seller = sellers[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.storefront_outlined, color: AppColors.primaryBlue, size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(seller['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                          const SizedBox(height: 3),
                          Text(seller['category']!, style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 3),
                          Text(seller['rating']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                        const SizedBox(height: 3),
                        Text(seller['distance']!, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),

          // Ad Block 2 — Lucky Draw
          Container(
            margin: const EdgeInsets.all(16),
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🎟️ आजचा Lucky Draw', style: TextStyle(color: AppColors.primaryBlue, fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('फक्त ₹5 मध्ये तिकीट घ्या — रात्री 8 PM Draw', style: TextStyle(color: AppColors.textLight, fontSize: 12)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(child: _buildHomeTab()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.textLight,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'होम'),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined), activeIcon: Icon(Icons.search), label: 'शोध'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), activeIcon: Icon(Icons.shopping_bag), label: 'ऑर्डर'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'माझे मेसेज'),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline), activeIcon: Icon(Icons.people), label: 'परिसर'),
        ],
      ),
    );
  }
}
