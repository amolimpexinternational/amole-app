import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/ads_data.dart';
import '../../data/local_posts_data.dart';
import '../admin/admin_live_ads_screen.dart';
import '../admin/admin_viral_posts_screen.dart';
import 'franchise_notification_screen.dart';
import 'franchise_profile_screen.dart';
import 'franchise_kyc_screen.dart';
import 'franchise_seller_list_screen.dart';
import 'franchise_buyer_list_screen.dart';
import 'franchise_revenue_screen.dart';
import 'franchise_ad_screen.dart';
import 'franchise_create_ad_screen.dart';
import 'franchise_add_seller_screen.dart';
import 'franchise_wallet_screen.dart';

class FranchiseHomeScreen extends StatelessWidget {
  const FranchiseHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String franchiseName = "हडपसर फ्रँचाइजी";
    const String areaKeyword = "हडपसर";
    const String pincode = "411001";
    const int totalSellers = 24;
    const int totalBuyers = 850;
    const int pendingVerifications = 3;
    const String monthlyBusiness = "₹85,000";

    final liveAdsCount = AdsData.liveAds.where((a) => a.location.contains(areaKeyword)).length;
    final viralPostsCount = LocalPostsData.posts.where((p) => p.responsePoints >= 1000).length;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.primaryBlue, AppColors.royalBlue], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('नमस्कार! 👋', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        Text(franchiseName, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      ]),
                      Row(children: [
                        IconButton(icon: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FranchiseWalletScreen(franchiseName: franchiseName)))),
                        IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseNotificationScreen()))),
                        IconButton(icon: const Icon(Icons.person_outline, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseProfileScreen()))),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                    child: Text('Pincode: $pincode', style: const TextStyle(color: Colors.white, fontSize: 13)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (pendingVerifications > 0)
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseKycScreen())),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(color: Colors.orange.shade50, border: Border.all(color: Colors.orange.shade200), borderRadius: BorderRadius.circular(10)),
                        child: Row(children: [
                          Icon(Icons.warning_amber_rounded, color: Colors.orange.shade800),
                          const SizedBox(width: 8),
                          Expanded(child: Text('$pendingVerifications नवीन Seller GPS verification साठी प्रतीक्षेत (72 तास)', style: TextStyle(color: Colors.orange.shade900, fontSize: 13))),
                          const Icon(Icons.chevron_right, color: Colors.orange),
                        ]),
                      ),
                    ),
                  const Text('आढावा', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.4,
                    children: [
                      _kpi(context, 'Total Sellers', '$totalSellers', 'नोंदणीकृत', Icons.storefront_outlined, AppColors.primaryBlue, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseSellerListScreen()))),
                      _kpi(context, 'Total Buyers', '$totalBuyers', 'नोंदणीकृत', Icons.people_outline, Colors.purple, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseBuyerListScreen()))),
                      _kpi(context, 'या महिन्याचा व्यवसाय', monthlyBusiness, 'एकूण', Icons.trending_up, AppColors.successGreen, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseRevenueScreen()))),
                      _kpi(context, 'Pending Verifications', '$pendingVerifications', 'GPS प्रलंबित', Icons.pending_actions, AppColors.primaryOrange, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseKycScreen()))),
                      _kpi(context, 'Live जाहिराती', '$liveAdsCount', '$franchiseName अंतर्गत', Icons.campaign_outlined, Colors.deepOrange, () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminLiveAdsScreen(locationKeyword: areaKeyword, title: '$franchiseName — Live जाहिराती')))),
                      _kpi(context, 'Most Viral पोस्ट', '$viralPostsCount', '1000+ Response', Icons.local_fire_department_outlined, Colors.redAccent, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminViralPostsScreen()))),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Quick Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 12),
                  _quickActionTile(icon: Icons.person_add_alt_1_outlined, label: 'Add Seller', subtitle: 'थेट सेलर जोडा (OTP verified)', color: AppColors.primaryBlue, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseAddSellerScreen()))),
                  _quickActionTile(icon: Icons.verified_user_outlined, label: 'Seller Verification', subtitle: 'नवीन सेलरचं GPS verification करा', color: AppColors.successGreen, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseKycScreen()))),
                  _quickActionTile(icon: Icons.campaign_outlined, label: 'Create Ad', subtitle: 'जाहिरात लगेच Live होते, approval लागत नाही', color: AppColors.primaryOrange, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseCreateAdScreen()))),
                  _quickActionTile(icon: Icons.fact_check_outlined, label: 'Ad Approvals', subtitle: 'इतरांनी सबमिट केलेल्या जाहिराती Approve/Edit/Delete करा', color: Colors.deepPurple, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseAdScreen()))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kpi(BuildContext context, String title, String value, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(child: Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textLight), maxLines: 2, overflow: TextOverflow.ellipsis)),
              Icon(icon, color: color, size: 22),
            ]),
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textLight), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _quickActionTile({required IconData icon, required String label, required String subtitle, required Color color, required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.grey.shade200)),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
