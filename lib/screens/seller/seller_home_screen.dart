import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'seller_orders_screen.dart';
import 'seller_products_screen.dart';
import 'seller_qr_screen.dart';
import 'seller_analytics_screen.dart';
import 'seller_notification_screen.dart';
import 'seller_revenue_detail_screen.dart';
import 'seller_support_screen.dart';

class SellerHomeScreen extends StatefulWidget {
  const SellerHomeScreen({super.key});

  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const _SellerDashboard(),
    const SellerOrdersScreen(),
    const SellerProductsScreen(),
    const SellerQrScreen(),
    const SellerAnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.textLight,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), activeIcon: Icon(Icons.dashboard), label: 'डॅशबोर्ड'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), activeIcon: Icon(Icons.shopping_bag), label: 'ऑर्डर'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), activeIcon: Icon(Icons.inventory_2), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_outlined), activeIcon: Icon(Icons.qr_code), label: 'QR Code'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), activeIcon: Icon(Icons.analytics), label: 'Analytics'),
        ],
      ),
    );
  }
}

class _SellerDashboard extends StatelessWidget {
  const _SellerDashboard();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 20),
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
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('नमस्कार, विक्रेता! 👋', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        Text('AMOLE Seller', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                              builder: (_) => Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('माझी कमाई', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                                    const SizedBox(height: 20),
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        const Row(children: [Icon(Icons.currency_rupee, color: Colors.green, size: 22), SizedBox(width: 8), Text('एकूण पैसे', style: TextStyle(fontSize: 16))]),
                                        Text('₹18,450', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green.shade700)),
                                      ]),
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(12)),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        const Row(children: [Icon(Icons.stars, color: Colors.amber, size: 22), SizedBox(width: 8), Text('Loyalty Points', style: TextStyle(fontSize: 16))]),
                                        Text('120 pts', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber.shade700)),
                                      ]),
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
                                      child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Row(children: [Icon(Icons.account_balance_wallet_outlined, color: AppColors.primaryBlue, size: 22), SizedBox(width: 8), Text('एकूण', style: TextStyle(fontSize: 15))]),
                                        Text('₹18,570', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(color: Colors.green.shade600, borderRadius: BorderRadius.circular(20)),
                            child: const Row(children: [
                              Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text('₹18,570', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            ]),
                          ),
                        ),
                        const SizedBox(width: 6),
                        IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerNotificationScreen()))),
                        IconButton(icon: const Icon(Icons.account_circle_outlined, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerSupportScreen()))),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Icon(Icons.verified_outlined, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text('Free Plan — पहिलं वर्ष', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                      ]),
                      Text('265 दिवस शिल्लक', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            height: 48,
            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.red.shade200)),
            child: Row(
              children: [
                Icon(Icons.pending_actions, color: Colors.red.shade600, size: 20),
                const SizedBox(width: 10),
                Expanded(child: Text('3 नवीन ऑर्डर्स प्रतीक्षेत!', style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold, fontSize: 13))),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerRevenueDetailScreen())),
                  child: Text('बघा →', style: TextStyle(color: Colors.red.shade600, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 150,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF00E5FF), Color(0xFF1565C0)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('📢 AMOLE जाहिरात', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text('तुमच्या परिसरातील ग्राहकांपर्यंत पोहोचा', style: TextStyle(color: Colors.white70, fontSize: 13)),
                SizedBox(height: 8),
                Text('जाहिरात करा — फक्त ₹100 पासून 🚀', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ]),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('माझा आढावा — 30 दिवस', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _kpiCard('प्रोफाइल व्ह्यूज', '1,248', 'आज: 42', Icons.visibility_outlined, AppColors.primaryBlue),
              _kpiCard('ऑर्डर्स', '37', '3 प्रतीक्षेत', Icons.shopping_bag_outlined, Colors.orange),
              _kpiCard('महसूल', '₹18,450', 'या महिन्यात', Icons.currency_rupee_outlined, Colors.green),
              _kpiCard('ग्राहक', '124', 'या महिन्यात', Icons.people_outlined, Colors.purple),
              _kpiCard('नवीन ग्राहक', '8', 'आज', Icons.person_add_outlined, Colors.teal),
              _kpiCard('सक्रिय जाहिराती', '2', 'चालू आहेत', Icons.campaign_outlined, Colors.pink),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _kpiCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
            Icon(icon, color: color, size: 22),
          ]),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
        ],
      ),
    );
  }
}
