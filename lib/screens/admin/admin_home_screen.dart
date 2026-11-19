import '../shared/top_offer_create_screen.dart';
import '../shared/weekly_market_catalog_screen.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../widgets/offers_slider_widget.dart';
import '../../data/ads_data.dart';
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
import 'admin_send_notification_screen.dart';
import 'admin_settlement_screen.dart';
import 'admin_live_ads_screen.dart';
import '../buyer/promoter_catalog_screen.dart';

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
          // === HEADER ===
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

          // === Approvals alert ===
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

          const SizedBox(height: 16),
          const OffersSliderWidget(),

          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('संपूर्ण नेटवर्क — आढावा', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          ),
          const SizedBox(height: 12),

          // === KPI Grid ===
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _kpi(context, 'Channel Partners', '0', 'एकूण जिल्हे', Icons.hub_outlined, Colors.indigo, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminChannelPartnersScreen()))),
              _kpi(context, 'Franchise', '0', 'एकूण पिनकोड', Icons.storefront_outlined, AppColors.primaryBlue, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminFranchiseListScreen()))),
              _kpi(context, 'एकूण Sellers', '0', 'नोंदणीकृत', Icons.store_outlined, Colors.teal, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminSellerListScreen()))),
              _kpi(context, 'एकूण Buyers', '0', 'नोंदणीकृत', Icons.people_outlined, Colors.purple, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminBuyerListScreen()))),
              _kpi(context, 'आजची विक्री', '₹0', 'एकूण व्यवसाय', Icons.currency_rupee_outlined, Colors.green, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminRevenueScreen()))),
              _kpi(context, 'महिन्याची विक्री', '₹0', 'एकूण व्यवसाय', Icons.account_balance_wallet_outlined, Colors.pink, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminRevenueScreen()))),
              _kpi(context, 'जाहिरात विभाग', '५', 'जाहिराती बघा', Icons.campaign_outlined, Colors.orange, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminLiveAdsScreen()))),
              _kpi(context, 'क्रिएट टॉप ऑफर', 'नवीन', 'ऑफर तयार करा', Icons.local_offer_outlined, Colors.pink, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TopOfferCreateScreen(isSeller: false)))),
              // ✅ बदल: Weekly Market → Product Details dialog
              _kpi(context, 'आठवडी बाजार', '६', 'एकूण वस्तू बघा', Icons.storefront, Colors.teal, onTap: () => _showWeeklyMarketDetails(context)),
              _kpi(context, 'Daily Settlement', '', 'Seller-निहाय, तारीखनिहाय', Icons.account_balance_outlined, Colors.brown, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminSettlementScreen()))),
            ],
          ),

          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('द्रुत कृती', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          ),
          const SizedBox(height: 12),

          // === ✅ Quick Actions — Franchise style (Card + ListTile) ===
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // 1. Add Channel Partner
                _quickActionTile(
                  icon: Icons.hub_outlined,
                  label: 'नवीन Channel Partner जोडा',
                  subtitle: 'नवीन CP नोंदणी करा',
                  color: Colors.indigo,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminChannelPartnersScreen())),
                ),
                // 2. Add Franchise
                _quickActionTile(
                  icon: Icons.add_business_outlined,
                  label: 'नवीन Franchise जोडा',
                  subtitle: 'नवीन Franchise नोंदणी करा',
                  color: AppColors.primaryBlue,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminAddFranchiseScreen())),
                ),
                // 3. Add Seller
                _quickActionTile(
                  icon: Icons.storefront_outlined,
                  label: 'नवीन Seller जोडा',
                  subtitle: 'थेट Seller जोडा (OTP verified)',
                  color: Colors.teal,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminAddSellerScreen())),
                ),
                // 4. Buyers List
                _quickActionTile(
                  icon: Icons.people_outline,
                  label: 'एकूण Buyers',
                  subtitle: 'सर्व Buyers ची यादी बघा',
                  color: Colors.purple,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminBuyerListScreen())),
                ),
                // 5. Promoters
                _quickActionTile(
                  icon: Icons.workspace_premium,
                  label: 'प्रमोटर कॅटलॉग',
                  subtitle: 'सर्व प्रमोटर आणि कॅटलॉग बघा',
                  color: Colors.amber.shade700,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PromoterCatalogScreen())),
                ),
                // 6. Send Notification
                _quickActionTile(
                  icon: Icons.notifications_active_outlined,
                  label: 'नोटिफिकेशन पाठवा',
                  subtitle: 'सर्वांना किंवा विशिष्ट role ला',
                  color: Colors.pink,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminSendNotificationScreen())),
                ),
                // 7. Approvals
                _quickActionTile(
                  icon: Icons.fact_check_outlined,
                  label: 'Approvals',
                  subtitle: 'Franchise/CP/Seller चे approval',
                  color: Colors.deepPurple,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminApprovalsScreen())),
                ),
                // 8. Weekly Market
                _quickActionTile(
                  icon: Icons.storefront,
                  label: 'आठवडी बाजार',
                  subtitle: 'वस्तू जोडा आणि विक्री करा',
                  color: Colors.teal,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WeeklyMarketCatalogScreen())),
                ),
                // 9. Daily Settlement
                _quickActionTile(
                  icon: Icons.account_balance_outlined,
                  label: 'Daily Settlement',
                  subtitle: 'Seller-निहाय, तारीखनिहाय',
                  color: Colors.brown,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminSettlementScreen())),
                ),
                // 10. Revenue Report
                _quickActionTile(
                  icon: Icons.bar_chart_outlined,
                  label: 'Revenue Report',
                  subtitle: 'संपूर्ण revenue चा तपशील',
                  color: Colors.green,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminRevenueScreen())),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // === ✅ Weekly Market Products Detail Dialog ===
  void _showWeeklyMarketDetails(BuildContext context) {
    // Demo data — Stage 3 मध्ये Firestore वरून live
    final products = [
      {'name': 'हातमाग साडी', 'seller': 'सुनीता जाधव', 'price': '₹1,200', 'district': 'पुणे', 'category': 'कपडे', 'active': true},
      {'name': 'मातीची भांडी', 'seller': 'रमेश कुंभार', 'price': '₹350', 'district': 'पुणे', 'category': 'घर', 'active': true},
      {'name': 'घरगुती पापड', 'seller': 'संगीता राणे', 'price': '₹150', 'district': 'पुणे', 'category': 'खाद्यपदार्थ', 'active': true},
      {'name': 'हस्तकला खेळणी', 'seller': 'विकास पाटील', 'price': '₹500', 'district': 'मुंबई', 'category': 'खेळणी', 'active': true},
      {'name': 'सेंद्रिय मध', 'seller': 'शेतकरी गट', 'price': '₹450', 'district': 'नाशिक', 'category': 'खाद्यपदार्थ', 'active': true},
      {'name': 'भरतकामाची पिशवी', 'seller': 'प्रिया देशमुख', 'price': '₹800', 'district': 'पुणे', 'category': 'कपडे', 'active': true},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.8,
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
                  colors: [Color(0xFF00897B), Color(0xFF26C6DA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.storefront, color: Colors.white, size: 26),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('आठवडी बाजार — संपूर्ण प्लॅटफॉर्म', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                        SizedBox(height: 2),
                        Text('सध्या Live असलेल्या सर्व वस्तू', style: TextStyle(color: Colors.white70, fontSize: 11)),
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
            // Summary
            Container(
              padding: const EdgeInsets.all(14),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Column(children: [
                      Text('${products.length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF00897B))),
                      const Text('एकूण वस्तू', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                    ]),
                  ),
                  Expanded(
                    child: Column(children: [
                      Text('${products.map((p) => p['seller']).toSet().length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.successGreen)),
                      const Text('विक्रेते', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                    ]),
                  ),
                  Expanded(
                    child: Column(children: [
                      Text('${products.map((p) => p['district']).toSet().length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange)),
                      const Text('जिल्हे', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                    ]),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // List
            Expanded(
              child: ListView.separated(
                controller: scrollCtrl,
                padding: const EdgeInsets.all(16),
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final p = products[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00897B).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.shopping_bag, color: Color(0xFF00897B), size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              const SizedBox(height: 2),
                              Text('🏪 ${p['seller']}', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 11, color: Colors.grey.shade500),
                                  const SizedBox(width: 2),
                                  Text(p['district'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(p['category'] as String, style: const TextStyle(fontSize: 10, color: AppColors.textLight)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(p['price'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.successGreen)),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('Live', style: TextStyle(fontSize: 9, color: Colors.green, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === Franchise-style Quick Action ===
  Widget _quickActionTile({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
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