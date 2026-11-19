import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../widgets/ad_feed_widget.dart';
import '../../widgets/offers_slider_widget.dart';
import 'seller_orders_screen.dart';
import 'seller_products_screen.dart';
import 'seller_qr_screen.dart';
import 'seller_community_screen.dart';
import 'seller_notification_screen.dart';
import 'seller_revenue_detail_screen.dart';
import 'seller_profile_detail_screen.dart';
import 'seller_advertisements_screen.dart';
import 'seller_customer_profile_screen.dart';
import 'seller_subscription_screen.dart';
import 'expenses_wallet_screen.dart';
import '../../widgets/seller_delivery_tiles.dart';
import '../buyer/weekly_market_screen.dart';
import '../shared/weekly_market_catalog_screen.dart';
import '../shared/top_offer_create_screen.dart';

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
    const SellerCommunityScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.people_outlined), activeIcon: Icon(Icons.people), label: 'Community'),
        ],
      ),
    );
  }
}

class _SellerDashboard extends StatefulWidget {
  const _SellerDashboard();

  @override
  State<_SellerDashboard> createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<_SellerDashboard> {
  bool _isShopOpen = true;

  void _toggleShopStatus(bool value) {
    setState(() => _isShopOpen = value);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // === HEADER ===
          Container(
            padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
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
                      'AMOLE Seller',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(minWidth: 30, minHeight: 32),
                          iconSize: 20,
                          icon: const Icon(Icons.workspace_premium_outlined, color: Colors.white),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerSubscriptionScreen())),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(minWidth: 30, minHeight: 32),
                          iconSize: 20,
                          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerNotificationScreen())),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(minWidth: 30, minHeight: 32),
                          iconSize: 20,
                          icon: const Icon(Icons.account_circle_outlined, color: Colors.white),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerProfileDetailScreen())),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerRevenueDetailScreen()));
                                    },
                                    icon: const Icon(Icons.bar_chart, color: Colors.white),
                                    label: const Text('पूर्ण तपशील बघा', style: TextStyle(color: Colors.white, fontSize: 15)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryBlue,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: Colors.green.shade600, borderRadius: BorderRadius.circular(20)),
                        child: const Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text('₹18,570', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                        ]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ExpensesWalletScreen())),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: Colors.purple.shade400, borderRadius: BorderRadius.circular(20)),
                        child: const Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.account_balance_wallet, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text('₹250', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                        ]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // === नवीन ऑर्डर्स ===
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerOrdersScreen())),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              height: 48,
              decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.red.shade200)),
              child: Row(
                children: [
                  Icon(Icons.pending_actions, color: Colors.red.shade600, size: 20),
                  const SizedBox(width: 10),
                  Expanded(child: Text('3 नवीन ऑर्डर्स प्रतीक्षेत!', style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold, fontSize: 13))),
                  const Icon(Icons.chevron_right, color: Colors.red),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // === Shop Status ===
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: _isShopOpen ? Colors.green.shade50 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _isShopOpen ? Colors.green.shade300 : Colors.grey.shade400),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(_isShopOpen ? Icons.storefront : Icons.store_mall_directory_outlined, color: _isShopOpen ? Colors.green.shade700 : Colors.grey.shade700),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_isShopOpen ? 'Shop Open' : 'Shop Closed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _isShopOpen ? Colors.green.shade800 : Colors.grey.shade800)),
                          Text(_isShopOpen ? 'ऑर्डर्स स्वीकारल्या जात आहेत' : 'नवीन ऑर्डर्स बंद आहेत', style: TextStyle(fontSize: 11, color: _isShopOpen ? Colors.green.shade600 : Colors.grey.shade600)),
                        ],
                      ),
                    ],
                  ),
                  Switch(value: _isShopOpen, onChanged: _toggleShopStatus, activeThumbColor: Colors.green.shade600),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
          const OffersSliderWidget(),

          // === आठवडी बाजार ===
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WeeklyMarketScreen())),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 75,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF00897B), Color(0xFF26C6DA)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('🎪 आठवडी बाजार', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('दर शनिवारी दुपारी ३ ते रात्री १२', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const WeeklyMarketCatalogScreen()));
                },
                icon: const Icon(Icons.add, size: 18, color: Colors.teal),
                label: const Text('वस्तू जोडा', style: TextStyle(color: Colors.teal, fontSize: 14)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.teal.shade300),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const SellerDeliveryTiles(),
          const SizedBox(height: 4),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('जाहिरात विभाग', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          ),
          const SizedBox(height: 8),
          const AdFeedWidget(isSeller: true),
          const SizedBox(height: 8),

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
            childAspectRatio: 1.7,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              // ✅ बदल: "प्रोफाइल व्ह्यूज" → "Amole Ecosystem Network"
              _kpiCard('Amole Ecosystem', '1,248', 'नेटवर्क बघा', Icons.hub_outlined, Colors.indigo, onTap: () => _showAmoleEcosystem(context)),
              _kpiCard('विक्री झालेल्या वस्तू', '37', '3 प्रतीक्षेत', Icons.shopping_bag_outlined, Colors.orange, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerOrdersScreen()))),
              _kpiCard('महसूल', '₹18,450', 'या महिन्यात', Icons.currency_rupee_outlined, Colors.green, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerRevenueDetailScreen()))),
              _kpiCard('ग्राहक', '124', 'या महिन्यात', Icons.people_outlined, Colors.purple, onTap: () => _showCustomerList(context)),
              _kpiCard('जाहिरात विभाग', '8', 'आज', Icons.campaign_outlined, Colors.teal, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerAdvertisementsScreen()))),
              _kpiCard('टॉप ऑफर टॅब', '3', 'चालू आहेत', Icons.local_offer_outlined, Colors.pink, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TopOfferCreateScreen(isSeller: true)))),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _kpiCard(String title, String value, String subtitle, IconData icon, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(child: Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textLight), maxLines: 1, overflow: TextOverflow.ellipsis)),
              Icon(icon, color: color, size: 22),
            ]),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
          ],
        ),
      ),
    );
  }

  // ✅ नवीन: Amole Ecosystem Network dialog — ४ stats चार्ट स्वरूपात
  void _showAmoleEcosystem(BuildContext context) {
    // Demo data — Stage 3 मध्ये Firestore वरून रोज update होईल
    const int totalBuyers = 8250;
    const int totalSellers = 1420;
    const int totalFranchise = 85;
    const int totalPromoters = 320;
    const int totalProducts = 5680;
    const int totalCustomers = totalBuyers + totalSellers + totalFranchise; // 9755

    final stats = [
      {
        'label': 'प्लॅटफॉर्म वरील एकूण ग्राहक',
        'sublabel': 'Buyers + Sellers + Franchise',
        'value': totalCustomers,
        'icon': Icons.people_alt_outlined,
        'color': AppColors.primaryBlue,
        'percent': 1.0,
      },
      {
        'label': 'एकूण Sellers',
        'sublabel': 'नोंदणीकृत',
        'value': totalSellers,
        'icon': Icons.storefront_outlined,
        'color': AppColors.successGreen,
        'percent': totalSellers / totalCustomers,
      },
      {
        'label': 'एकूण Promoters',
        'sublabel': 'Active',
        'value': totalPromoters,
        'icon': Icons.workspace_premium_outlined,
        'color': Colors.amber.shade700,
        'percent': totalPromoters / totalCustomers,
      },
      {
        'label': 'एकूण Products',
        'sublabel': 'App वर उपलब्ध',
        'value': totalProducts,
        'icon': Icons.inventory_2_outlined,
        'color': Colors.purple,
        'percent': 1.0,
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (ctx, scrollCtrl) => Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryBlue, AppColors.royalBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.hub, color: Colors.white, size: 26),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amole Ecosystem Network',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'संपूर्ण प्लॅटफॉर्मचा आढावा',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                controller: scrollCtrl,
                padding: const EdgeInsets.all(16),
                children: [
                  // Highlighted total
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'एकूण नेटवर्क ग्राहक',
                          style: TextStyle(fontSize: 13, color: AppColors.textLight),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          totalCustomers.toString(),
                          style: const TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.update, size: 12, color: AppColors.successGreen),
                            SizedBox(width: 4),
                            Text(
                              'दररोज update होते',
                              style: TextStyle(fontSize: 11, color: AppColors.successGreen),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '📊 Ecosystem Breakdown',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 12),
                  // Stats चार्ट स्वरूपात
                  ...stats.map((s) => _buildStatChartCard(
                        label: s['label'] as String,
                        sublabel: s['sublabel'] as String,
                        value: s['value'] as int,
                        icon: s['icon'] as IconData,
                        color: s['color'] as Color,
                        percent: (s['percent'] as double).clamp(0.0, 1.0),
                      )),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, size: 16, color: Colors.blue),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'सर्व आकडे रोज update होतात. Stage 3 मध्ये Firestore वरून live येतील.',
                            style: TextStyle(fontSize: 11, color: Colors.blue),
                          ),
                        ),
                      ],
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

  Widget _buildStatChartCard({
    required String label,
    required String sublabel,
    required int value,
    required IconData icon,
    required Color color,
    required double percent,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),
                    ),
                    Text(
                      sublabel,
                      style: const TextStyle(fontSize: 11, color: AppColors.textLight),
                    ),
                  ],
                ),
              ),
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Progress bar (chart स्वरूप)
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 8,
              backgroundColor: color.withValues(alpha: 0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomerList(BuildContext context) {
    final customers = [
      {'name': 'अनिल जोशी', 'purchase': '₹1,200', 'visits': '5 वेळा'},
      {'name': 'संगीता राणे', 'purchase': '₹3,500', 'visits': '12 वेळा'},
      {'name': 'रमेश पाटील', 'purchase': '₹850', 'visits': '3 वेळा'},
    ];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (ctx, scrollController) => Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('ग्राहक यादी', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  final c = customers[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                      child: Text(c['name']![0], style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                    ),
                    title: Text(c['name']!, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('एकूण खरेदी: ${c['purchase']} | ${c['visits']}'),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textLight),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (_) => SellerCustomerProfileScreen(
                          customerName: c['name']!,
                          totalPurchase: c['purchase']!,
                          visits: c['visits']!,
                        ),
                      ));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}