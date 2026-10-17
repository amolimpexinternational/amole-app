import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'buyer_search_screen.dart';
import 'global_shopping_home_screen.dart';
import 'buyer_profile_screen.dart';
import 'reward_wallet_screen.dart';
import 'my_wall_screen.dart';
import 'lucky_draw_screen.dart';
import 'seller_profile_screen.dart';
import '../../widgets/ad_feed_widget.dart';
import '../../widgets/offers_slider_widget.dart';
import '../../widgets/home_services_grid.dart';
import 'buyer_notification_screen.dart';
import 'cart_screen.dart';
import 'buyer_favourite_screen.dart';
import 'qr_payment_screen.dart';
import 'pincode_shops_screen.dart';
import 'coming_soon_screen.dart';
import 'all_categories_screen.dart';
import 'order_tracking_screen.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({super.key});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.shopping_basket_outlined, 'label': 'किराणा'},
    {'icon': Icons.eco_outlined, 'label': 'भाजीपाला'},
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

  final List<Map<String, dynamic>> _services = [
    {'label': 'Global\nशॉपिंग', 'icon': Icons.shopping_cart_outlined, 'action': 'shopping'},
    {'label': 'फूड ऑर्डर\nकरा', 'icon': Icons.restaurant_outlined, 'action': 'food'},
    {'label': 'इन्स्टंट लोकल\nडिलिव्हरी', 'icon': Icons.bolt_outlined, 'action': 'instant'},
    {'label': 'राईड बुक\nकरा', 'icon': Icons.two_wheeler_outlined, 'action': 'ride'},
    {'label': 'मित्र बनवा /\nसोशल कनेक्ट', 'icon': Icons.people_alt_outlined, 'action': 'social'},
    {'label': 'डिलिव्हरी /\nलॉजिस्टिक्स सेवा', 'icon': Icons.local_shipping_outlined, 'action': 'logistics'},
    {'label': 'शेतकरी', 'icon': Icons.agriculture_outlined, 'action': 'farmers'},
  ];

  void _handleServiceTap(String action) {
    switch (action) {
      case 'shopping':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const GlobalShoppingHomeScreen()));
        break;
      case 'food':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const BuyerSearchScreen(initialFilter: 'services')));
        break;
      case 'instant':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PincodeShopsScreen()));
        break;
      case 'social':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const BuyerSearchScreen(initialFilter: 'friends')));
        break;
      case 'ride':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ComingSoonScreen(title: 'राईड बुक करा')));
        break;
      case 'logistics':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ComingSoonScreen(title: 'डिलिव्हरी / लॉजिस्टिक्स सेवा')));
        break;
      case 'farmers':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ComingSoonScreen(title: 'शेतकरी यादी')));
        break;
    }
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(12, 14, 12, 18),
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
                    const Text(
                      'AMOLE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RewardWalletScreen(),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade600,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.stars, color: Colors.white, size: 14),
                                SizedBox(width: 3),
                                Text(
                                  '245 pts',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OrderTrackingScreen(),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.cyan,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.shopping_bag_outlined,
                                  color: AppColors.royalBlue,
                                  size: 14,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  'ऑर्डर',
                                  style: TextStyle(
                                    color: AppColors.royalBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 2),
                        IconButton(
                          tooltip: 'Search',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(minWidth: 28, minHeight: 32),
                          iconSize: 20,
                          icon: const Icon(Icons.search, color: Colors.white),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const BuyerSearchScreen()),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Cart',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 28,
                            minHeight: 32,
                          ),
                          iconSize: 20,
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CartScreen(),
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: 'My Favourite',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 28,
                            minHeight: 32,
                          ),
                          iconSize: 20,
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BuyerFavouriteScreen(),
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 28,
                            minHeight: 32,
                          ),
                          iconSize: 20,
                          icon: const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BuyerNotificationScreen(),
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 28,
                            minHeight: 32,
                          ),
                          iconSize: 20,
                          icon: const Icon(
                            Icons.account_circle_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BuyerProfileScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
              ],
            ),
          ),


          const OffersSliderWidget(),
          const SizedBox(height: 14),
          const HomeServicesGrid(),
          const SizedBox(height: 4),
          // Banner Ad
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PincodeShopsScreen())),
            child: Container(
              margin: const EdgeInsets.all(16),
              height: 75,
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
                    Text('🎉 आपल्या गावातील दुकाने', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('माझा पैसा माझ्या खिशात 🛒', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ),
            ),
          ),

          // Ad Block 2 — Lucky Draw
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LuckyDrawScreen())),
            child: Container(
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
                    Text('फक्त ₹5 मध्ये तिकीट घ्या — दर दिवशी ४:०० PM Draw', style: TextStyle(color: AppColors.textLight, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          const AdFeedWidget(),
          const SizedBox(height: 8),

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
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const MyWallScreen()));
          } else if (index == 2) {
            // अंगठ्याजवळ सहज पोहोचणारं मधलं स्थान — QR Scan
            Navigator.push(context, MaterialPageRoute(builder: (_) => const QrPaymentScreen(sellerName: 'QR Payment')));
          } else {
            setState(() => _currentIndex = index);
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.textLight,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'होम'),
          BottomNavigationBarItem(icon: Icon(Icons.dynamic_feed_outlined), activeIcon: Icon(Icons.dynamic_feed), label: 'My Wall'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), activeIcon: Icon(Icons.qr_code_scanner), label: 'QR Pay'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'माझे मेसेज'),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline), activeIcon: Icon(Icons.people), label: 'परिसर'),
        ],
      ),
    );
  }
}
