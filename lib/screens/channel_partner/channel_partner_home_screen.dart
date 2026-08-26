import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'cp_franchise_screen.dart';
import 'cp_seller_screen.dart';
import 'cp_ads_screen.dart';
import 'cp_create_ad_screen.dart';
import 'cp_approvals_screen.dart';
import 'cp_revenue_screen.dart';
import 'cp_profile_screen.dart';
import 'cp_notification_screen.dart';

class ChannelPartnerHomeScreen extends StatelessWidget {
  const ChannelPartnerHomeScreen({super.key});

  Widget _buildKpiCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 22),
            ],
          ),
          const SizedBox(height: 10),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 2),
          Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
        ],
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, String label, IconData icon, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primaryBlue, size: 26),
              const SizedBox(height: 6),
              Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: AppColors.textDark, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFranchiseRow(String name, String area, String status, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
            child: const Icon(Icons.store_outlined, color: AppColors.primaryBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                Text(area, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(status, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.w600)),
          ),
        ],
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
                  colors: [AppColors.primaryBlue, AppColors.royalBlue],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('AMOLE Channel Partner',
                          style: TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CpNotificationScreen())),
                            child: const Icon(Icons.notifications_outlined, color: AppColors.white),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CpProfileScreen())),
                            child: const CircleAvatar(radius: 16, backgroundColor: AppColors.white, child: Icon(Icons.person, color: AppColors.primaryBlue, size: 18)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
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
                            Text('पुणे जिल्हा', style: TextStyle(color: AppColors.white, fontSize: 13)),
                            SizedBox(height: 4),
                            Text('₹38,400', style: TextStyle(color: AppColors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                            Text('या महिन्याचं Revenue Share', style: TextStyle(color: AppColors.white, fontSize: 11)),
                          ],
                        ),
                        const Icon(Icons.account_balance_wallet_outlined, color: AppColors.cyan, size: 32),
                      ],
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
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CpApprovalsScreen())),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.orange.shade200)),
                        child: Row(children: [
                          Icon(Icons.warning_amber_outlined, color: Colors.orange.shade700, size: 20),
                          const SizedBox(width: 10),
                          Expanded(child: Text('Franchise/Seller कडून Approvals प्रतीक्षेत', style: TextStyle(color: Colors.orange.shade800, fontWeight: FontWeight.bold, fontSize: 13))),
                          Text('बघा →', style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.bold)),
                        ]),
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.4,
                      children: [
                        _buildKpiCard('एकूण Franchise', '8', Icons.business_outlined, AppColors.primaryBlue),
                        _buildKpiCard('Active Sellers', '142', Icons.storefront_outlined, AppColors.successGreen),
                        _buildKpiCard('एकूण Buyers', '3,250', Icons.people_outline, AppColors.primaryOrange),
                        _buildKpiCard('महिन्याचं Revenue', '₹38,400', Icons.trending_up, AppColors.successGreen),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text('Quick Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildQuickAction(context, 'नवीन Franchise', Icons.add_business_outlined,
                            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CpFranchiseScreen()))),
                        _buildQuickAction(context, 'नवीन Seller', Icons.storefront_outlined,
                            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CpSellerScreen()))),
                        _buildQuickAction(context, 'जाहिरात तयार करा', Icons.campaign_outlined,
                            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CpCreateAdScreen()))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildQuickAction(context, 'Revenue Report', Icons.bar_chart_outlined,
                            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CpRevenueScreen()))),
                        _buildQuickAction(context, 'Approvals', Icons.fact_check_outlined,
                            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CpApprovalsScreen()))),
                        _buildQuickAction(context, 'Broadcast Msg', Icons.forum_outlined,
                            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CpAdsScreen()))),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Franchise List', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                        TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CpFranchiseScreen())),
                          child: const Text('सर्व बघा'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildFranchiseRow('हडपसर फ्रँचाइजी', 'पुणे — हडपसर', 'Active', AppColors.successGreen),
                    _buildFranchiseRow('कोथरूड फ्रँचाइजी', 'पुणे — कोथरूड', 'Active', AppColors.successGreen),
                    _buildFranchiseRow('वडगाव फ्रँचाइजी', 'पुणे — वडगाव', 'KYC Pending', AppColors.primaryOrange),
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
            Navigator.push(context, MaterialPageRoute(builder: (_) => const CpFranchiseScreen()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const CpSellerScreen()));
          } else if (index == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const CpRevenueScreen()));
          } else if (index == 4) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const CpProfileScreen()));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'डॅशबोर्ड'),
          BottomNavigationBarItem(icon: Icon(Icons.business_outlined), label: 'Franchise'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront_outlined), label: 'Sellers'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Revenue'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
