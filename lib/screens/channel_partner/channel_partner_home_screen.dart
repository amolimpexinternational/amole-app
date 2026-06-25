import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

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
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2)),
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

  Widget _buildQuickAction(String label, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 26),
            const SizedBox(height: 6),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: AppColors.textDark, fontWeight: FontWeight.w600)),
          ],
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
            backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
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
              color: statusColor.withOpacity(0.12),
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
                        children: const [
                          Icon(Icons.notifications_outlined, color: AppColors.white),
                          SizedBox(width: 16),
                          CircleAvatar(radius: 16, backgroundColor: AppColors.white, child: Icon(Icons.person, color: AppColors.primaryBlue, size: 18)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.12),
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
                        _buildQuickAction('नवीन Franchise', Icons.add_business_outlined),
                        _buildQuickAction('Revenue Report', Icons.bar_chart_outlined),
                        _buildQuickAction('Broadcast Ad', Icons.campaign_outlined),
                        _buildQuickAction('Support', Icons.headset_mic_outlined),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Franchise List', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                        TextButton(onPressed: () {}, child: const Text('सर्व बघा')),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'डॅशबोर्ड'),
          BottomNavigationBarItem(icon: Icon(Icons.business_outlined), label: 'Franchise'),
          BottomNavigationBarItem(icon: Icon(Icons.campaign_outlined), label: 'Ads'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Revenue'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
