import 'package:flutter/material.dart';
import 'franchise_notification_screen.dart';
import 'franchise_profile_screen.dart';
import 'franchise_kyc_screen.dart';
import 'franchise_seller_list_screen.dart';
import 'franchise_buyer_list_screen.dart';
import 'franchise_revenue_screen.dart';
import 'franchise_ad_screen.dart';
import 'franchise_create_ad_screen.dart';
import 'franchise_add_seller_screen.dart';

class FranchiseHomeScreen extends StatelessWidget {
  const FranchiseHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO (Stage 3 - Backend): replace mock data with Firestore data
    // scoped to this Franchise's pincode.
    const String franchiseName = "Demo Franchise";
    const String pincode = "411001";
    const int totalSellers = 42;
    const int totalBuyers = 1250;
    const int pendingVerifications = 3;
    const String monthlyBusiness = "₹1,85,000";

    return Scaffold(
      appBar: AppBar(
        title: Text(franchiseName),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            tooltip: "Notifications",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const FranchiseNotificationScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            tooltip: "Profile",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const FranchiseProfileScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pincode: $pincode",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),

            // ---- Pending Verification Banner (Blueprint ch. 8.2 --
            // 72-hour GPS verification requirement) — entire banner tappable ----
            if (pendingVerifications > 0)
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const FranchiseKycScreen()));
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    border: Border.all(color: Colors.orange.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          color: Colors.orange.shade800),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "$pendingVerifications new seller(s) waiting for "
                          "GPS verification (72-hour window)",
                          style: TextStyle(color: Colors.orange.shade900),
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.orange),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // ---- KPI Cards ----
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: [
                _kpiCard(
                  "Total Sellers",
                  "$totalSellers",
                  Icons.storefront_outlined,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const FranchiseSellerListScreen()));
                  },
                ),
                _kpiCard(
                  "Total Buyers",
                  "$totalBuyers",
                  Icons.people_outline,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const FranchiseBuyerListScreen()));
                  },
                ),
                _kpiCard(
                  "This Month's Business",
                  monthlyBusiness,
                  Icons.trending_up,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const FranchiseRevenueScreen()));
                  },
                ),
                _kpiCard("Pending Verifications", "$pendingVerifications", Icons.pending_actions,
                    onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const FranchiseKycScreen()));
                }),
              ],
            ),

            const SizedBox(height: 24),
            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // ---- Quick Actions ----
            _quickActionTile(
              icon: Icons.person_add_alt_1_outlined,
              label: "Add Seller",
              subtitle: "Directly onboard a seller (OTP verified)",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FranchiseAddSellerScreen()));
              },
            ),
            _quickActionTile(
              icon: Icons.verified_user_outlined,
              label: "Seller Verification",
              subtitle: "GPS-verify newly onboarded sellers",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FranchiseKycScreen()));
              },
            ),
            _quickActionTile(
              icon: Icons.campaign_outlined,
              label: "Create Ad",
              subtitle: "Post an ad — goes live instantly, no approval needed",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FranchiseCreateAdScreen()));
              },
            ),
            _quickActionTile(
              icon: Icons.fact_check_outlined,
              label: "Ad Approvals",
              subtitle: "Approve / Edit / Delete ads submitted by others",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FranchiseAdScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _kpiCard(String label, String value, IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: Colors.teal),
            const SizedBox(height: 6),
            Text(value,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _quickActionTile({
    required IconData icon,
    required String label,
    required String subtitle,
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
        leading: Icon(icon, color: Colors.teal),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
