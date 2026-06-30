import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'franchise_kyc_screen.dart';
import 'franchise_ad_screen.dart';
import 'franchise_revenue_screen.dart';
import 'franchise_notification_screen.dart';
import 'franchise_profile_screen.dart';

class FranchiseHomeScreen extends StatefulWidget {
  const FranchiseHomeScreen({super.key});

  @override
  State<FranchiseHomeScreen> createState() => _FranchiseHomeScreenState();
}

class _FranchiseHomeScreenState extends State<FranchiseHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const _FranchiseDashboard(),
    const FranchiseKycScreen(),
    const FranchiseAdScreen(),
    const FranchiseRevenueScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.how_to_reg_outlined), activeIcon: Icon(Icons.how_to_reg), label: 'Seller KYC'),
          BottomNavigationBarItem(icon: Icon(Icons.approval_outlined), activeIcon: Icon(Icons.approval), label: 'Ad Approval'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), activeIcon: Icon(Icons.bar_chart), label: 'Revenue'),
        ],
      ),
    );
  }
}

class _FranchiseDashboard extends StatelessWidget {
  const _FranchiseDashboard();

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
                        Text('नमस्कार, फ्रँचाइजी! 👋', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        Text('AMOLE Franchise', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: Colors.green.shade600, borderRadius: BorderRadius.circular(20)),
                        child: const Row(children: [
                          Icon(Icons.currency_rupee, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text('₹4,250', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                      const SizedBox(width: 6),
                      IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseNotificationScreen()))),
                      IconButton(icon: const Icon(Icons.account_circle_outlined, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseProfileScreen()))),
                    ]),
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
                        Icon(Icons.location_on_outlined, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text('पुणे — हडपसर तालुका', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                      ]),
                      Text('AM-IN-MH-PN-F-000001', style: TextStyle(color: Colors.white70, fontSize: 11)),
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
            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.orange.shade200)),
            child: Row(children: [
              Icon(Icons.warning_amber_outlined, color: Colors.orange.shade700, size: 20),
              const SizedBox(width: 10),
              Expanded(child: Text('5 Seller KYC प्रतीक्षेत — 7 दिवसांत पूर्ण करा', style: TextStyle(color: Colors.orange.shade800, fontWeight: FontWeight.bold, fontSize: 13))),
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                onPressed: () {},
                child: Text('बघा →', style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.bold)),
              ),
            ]),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('माझा परिसर — आढावा', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textDark)),
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
              _kpi('एकूण Sellers', '48', '5 KYC प्रतीक्षेत', Icons.storefront_outlined, AppColors.primaryBlue),
              _kpi('एकूण ग्राहक', '1,240', 'या महिन्यात', Icons.people_outlined, Colors.purple),
              _kpi('जाहिराती', '12', '3 Approval बाकी', Icons.campaign_outlined, Colors.orange),
              _kpi('Delivery Partners', '8', '2 KYC बाकी', Icons.delivery_dining_outlined, Colors.teal),
              _kpi('आजची कमाई', '₹420', 'Commission', Icons.currency_rupee_outlined, Colors.green),
              _kpi('महिन्याची कमाई', '₹4,250', 'एकूण', Icons.account_balance_wallet_outlined, Colors.pink),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _kpi(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(14),
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
