
import '../shared/top_offer_create_screen.dart';
import '../shared/weekly_market_catalog_screen.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../widgets/offers_slider_widget.dart';
import 'cp_franchise_screen.dart';
import 'cp_seller_screen.dart';
import 'cp_buyer_screen.dart';
import 'cp_ads_screen.dart';
import 'cp_approvals_screen.dart';
import 'cp_revenue_screen.dart';
import 'cp_seller_revenue_screen.dart';
import 'cp_profile_screen.dart';
import 'cp_notification_screen.dart';
import 'cp_ecosystem_screen.dart';
import 'promoter_list_screen.dart';
import '../buyer/promoter_catalog_screen.dart';

class ChannelPartnerHomeScreen extends StatelessWidget {
  const ChannelPartnerHomeScreen({super.key});

  Widget _buildKpiCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
    Widget destination,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => destination),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.lightGrey),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 22),
                const Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: AppColors.textLight,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryBlue,
                    AppColors.royalBlue,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'AMOLE Channel Partner',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CpNotificationScreen(),
                              ),
                            ),
                            child: const Icon(
                              Icons.notifications_outlined,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CpProfileScreen(),
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 16,
                              backgroundColor: AppColors.white,
                              child: Icon(
                                Icons.person,
                                color: AppColors.primaryBlue,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CpSellerRevenueScreen(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'पुणे जिल्हा',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '₹38,400',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'या महिन्याचं Revenue Share — सेलर-निहाय बघा →',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.account_balance_wallet_outlined,
                            color: AppColors.cyan,
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Approval alert
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CpApprovalsScreen(),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.orange.shade200,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning_amber_outlined,
                              color: Colors.orange.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Franchise/Seller कडून Approvals प्रतीक्षेत',
                                style: TextStyle(
                                  color: Colors.orange.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Text(
                              'बघा →',
                              style: TextStyle(
                                color: Colors.orange.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const OffersSliderWidget(),
                    const SizedBox(height: 16),

                    // KPI Grid
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.4,
                      children: [
                        _buildKpiCard(
                          context,
                          'एकूण Franchise',
                          '8',
                          Icons.business_outlined,
                          AppColors.primaryBlue,
                          const CpFranchiseScreen(),
                        ),
                        _buildKpiCard(
                          context,
                          'Active Sellers',
                          '142',
                          Icons.storefront_outlined,
                          AppColors.successGreen,
                          const CpSellerScreen(),
                        ),
                        _buildKpiCard(
                          context,
                          'एकूण Buyers',
                          '3,250',
                          Icons.people_outline,
                          AppColors.primaryOrange,
                          const CpBuyerScreen(),
                        ),
                        _buildKpiCard(
                          context,
                          'महिन्याचं Revenue',
                          '₹38,400',
                          Icons.trending_up,
                          AppColors.successGreen,
                          const CpSellerRevenueScreen(),
                        ),
                        _buildKpiCard(
                          context,
                          'जाहिरात विभाग',
                          '५',
                          Icons.campaign_outlined,
                          Colors.orange,
                          const CpAdsScreen(),
                        ),
                        _buildKpiCard(
                          context,
                          'क्रिएट टॉप ऑफर',
                          'नवीन',
                          Icons.local_offer_outlined,
                          Colors.pink,
                          const TopOfferCreateScreen(isSeller: false),
                        ),
                        _buildKpiCard(
                          context,
                          'प्रमोटर यादी',
                          '३',
                          Icons.people_alt_outlined,
                          Colors.amber,
                          const PromoterListScreen(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 12),

                    _quickActionTile(
                      icon: Icons.add_business_outlined,
                      label: 'नवीन Franchise जोडा',
                      subtitle: 'नवीन Franchise नोंदणी करा',
                      color: AppColors.primaryBlue,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CpFranchiseScreen(),
                        ),
                      ),
                    ),

                    _quickActionTile(
                      icon: Icons.verified_user_outlined,
                      label: 'Franchise Verification',
                      subtitle: 'Franchise KYC verify करा',
                      color: AppColors.successGreen,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CpApprovalsScreen(),
                        ),
                      ),
                    ),

                    _quickActionTile(
                      icon: Icons.storefront_outlined,
                      label: 'नवीन Seller जोडा',
                      subtitle: 'थेट Seller जोडा (OTP verified)',
                      color: Colors.teal,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CpSellerScreen(),
                        ),
                      ),
                    ),

                    _quickActionTile(
                      icon: Icons.person_add_alt_1_outlined,
                      label: 'Seller Verification',
                      subtitle: 'नवीन Seller KYC verify करा',
                      color: Colors.orange,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CpApprovalsScreen(),
                        ),
                      ),
                    ),

                    _quickActionTile(
                      icon: Icons.fact_check_outlined,
                      label: 'Approval Pending जाहिराती',
                      subtitle: 'जाहिराती आणि टॉप ऑफर्स अप्रूव्ह करा',
                      color: Colors.deepPurple,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CpAdsScreen(),
                        ),
                      ),
                    ),

                    _quickActionTile(
                      icon: Icons.bar_chart_outlined,
                      label: 'Revenue Report',
                      subtitle: 'जिल्हा revenue चा तपशील बघा',
                      color: AppColors.primaryBlue,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CpRevenueScreen(),
                        ),
                      ),
                    ),

                    _quickActionTile(
                      icon: Icons.storefront,
                      label: 'आठवडी बाजार',
                      subtitle: 'वस्तू जोडा आणि विक्री करा',
                      color: Colors.teal,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WeeklyMarketCatalogScreen(),
                        ),
                      ),
                    ),

                    _quickActionTile(
                      icon: Icons.workspace_premium,
                      label: 'प्रमोटर कॅटलॉग',
                      subtitle: 'प्रमोटरचा कॅटलॉग बघा',
                      color: Colors.amber.shade700,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PromoterCatalogScreen(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.textLight,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CpFranchiseScreen(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CpSellerScreen(),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CpEcosystemScreen(),
              ),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CpProfileScreen(),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'डॅशबोर्ड',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_outlined),
            label: 'Franchise',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            label: 'Sellers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inclusive),
            label: 'Amole Ecosystem',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
