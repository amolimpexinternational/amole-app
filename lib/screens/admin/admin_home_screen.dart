import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/ads_data.dart';
import '../../data/local_posts_data.dart';
import 'admin_channel_partners_screen.dart';
import 'admin_subadmin_screen.dart';
import 'admin_revenue_screen.dart';
import 'admin_wallet_screen.dart';
import 'admin_franchise_list_screen.dart';
import 'admin_seller_list_screen.dart';
import 'admin_buyer_list_screen.dart';
import 'admin_notification_screen.dart';
import 'admin_profile_screen.dart';
import 'admin_approvals_screen.dart';
import 'admin_add_franchise_screen.dart';
import 'admin_add_seller_screen.dart';
import 'admin_create_ad_screen.dart';
import 'admin_send_notification_screen.dart';
import 'admin_settlement_screen.dart';
import 'admin_live_ads_screen.dart';
import 'admin_viral_posts_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const _AdminDashboard(),
    const AdminChannelPartnersScreen(),
    const AdminSubAdminScreen(),
    const AdminRevenueScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.hub_outlined), activeIcon: Icon(Icons.hub), label: 'Channel Partners'),
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings_outlined), activeIcon: Icon(Icons.admin_panel_settings), label: 'Sub-Admins'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), activeIcon: Icon(Icons.bar_chart), label: 'Revenue'),
        ],
      ),
    );
  }
}

class _AdminDashboard extends StatelessWidget {
  const _AdminDashboard();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.royalBlue, AppColors.primaryBlue], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('नमस्कार, Admin! 👋', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      Text('AMOLE Admin Panel', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    ]),
                    Row(children: [
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminWalletScreen())),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(color: Colors.green.shade600, borderRadius: BorderRadius.circular(20)),
                          child: const Row(children: [
                            Icon(Icons.currency_rupee, color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text('₹0', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                          ]),
                        ),
                      ),
                      const SizedBox(width: 6),
                      IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminNotificationScreen()))),
                      IconButton(icon: const Icon(Icons.account_circle_outlined, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminProfileScreen()))),
                    ]),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Icon(Icons.corporate_fare, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text('संपूर्ण भारत — सर्व टेरिटरी', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                      ]),
                      Text('AM-ADMIN-000001', style: TextStyle(color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminApprovalsScreen())),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              height: 48,
              decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.orange.shade200)),
              child: Row(children: [
                Icon(Icons.warning_amber_outlined, color: Colors.orange.shade700, size: 20),
                const SizedBox(width: 10),
                Expanded(child: Text('Franchise/CP कडून Approvals प्रतीक्षेत', style: TextStyle(color: Colors.orange.shade800, fontWeight: FontWeight.bold, fontSize: 13))),
                Text('बघा →', style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.bold)),
              ]),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('संपूर्ण नेटवर्क — आढावा', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textDark)),
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
              _kpi(context, 'Channel Partners', '0', 'एकूण जिल्हे', Icons.hub_outlined, Colors.indigo, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminChannelPartnersScreen()))),
              _kpi(context, 'Franchise', '0', 'एकूण पिनकोड', Icons.storefront_outlined, AppColors.primaryBlue, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminFranchiseListScreen()))),
              _kpi(context, 'एकूण Sellers', '0', 'नोंदणीकृत', Icons.store_outlined, Colors.teal, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminSellerListScreen()))),
              _kpi(context, 'एकूण Buyers', '0', 'नोंदणीकृत', Icons.people_outlined, Colors.purple, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminBuyerListScreen()))),
              _kpi(context, 'आजची विक्री', '₹0', 'एकूण व्यवसाय', Icons.currency_rupee_outlined, Colors.green, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminRevenueScreen()))),
              _kpi(context, 'महिन्याची विक्री', '₹0', 'एकूण व्यवसाय', Icons.account_balance_wallet_outlined, Colors.pink, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminRevenueScreen()))),
              _kpi(context, 'Live जाहिराती', '${AdsData.liveAds.length}', 'एकूण Live', Icons.campaign_outlined, Colors.deepOrange, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminLiveAdsScreen()))),
              _kpi(context, 'Most Viral पोस्ट', '${LocalPostsData.posts.where((p) => p.responsePoints >= 1000).length}', '1000+ Response', Icons.local_fire_department_outlined, Colors.redAccent, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminViralPostsScreen()))),
              _kpi(context, 'Daily Settlement', '', 'Seller-निहाय, तारीखनिहाय', Icons.account_balance_outlined, Colors.brown, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminSettlementScreen()))),
            ],
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('द्रुत कृती', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 0.95,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _quickAction(context, 'नवीन Channel Partner', Icons.hub_outlined, Colors.indigo, const AdminChannelPartnersScreen()),
                _quickAction(context, 'नवीन Franchise', Icons.storefront_outlined, AppColors.primaryBlue, const AdminAddFranchiseScreen()),
                _quickAction(context, 'नवीन Seller', Icons.store_outlined, Colors.teal, const AdminAddSellerScreen()),
                _quickAction(context, 'जाहिरात तयार करा', Icons.campaign_outlined, Colors.orange, const AdminCreateAdScreen()),
                _quickAction(context, 'नोटिफिकेशन पाठवा', Icons.notifications_active_outlined, Colors.pink, const AdminSendNotificationScreen()),
                _quickAction(context, 'Approvals', Icons.fact_check_outlined, Colors.deepPurple, const AdminApprovalsScreen()),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _quickAction(BuildContext context, String label, IconData icon, Color color, Widget destination) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => destination)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 20, backgroundColor: color.withValues(alpha: 0.12), child: Icon(icon, color: color, size: 20)),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          ],
        ),
      ),
    );
  }

  Widget _kpi(BuildContext context, String title, String value, String subtitle, IconData icon, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))],
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
      ),
    );
  }
}
