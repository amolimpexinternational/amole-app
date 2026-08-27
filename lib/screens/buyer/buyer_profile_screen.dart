import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'reward_wallet_screen.dart';

class BuyerProfileScreen extends StatelessWidget {
  const BuyerProfileScreen({super.key});

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, String subtitle, Color iconColor, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textDark)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textLight),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primaryBlue,
            iconTheme: const IconThemeData(color: AppColors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primaryBlue, AppColors.royalBlue],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Stack(
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.white,
                            child: Icon(Icons.person, size: 45, color: AppColors.primaryBlue),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryOrange,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit, size: 14, color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('राहुल शर्मा', style: TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text('+91 98765 43210', style: TextStyle(color: AppColors.white, fontSize: 13)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryOrange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('245 Loyalty Points', style: TextStyle(color: AppColors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('माझे खाते', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 10),
                  _buildMenuItem(context, Icons.shopping_bag_outlined, 'माझे ऑर्डर', 'सर्व orders बघा', AppColors.primaryBlue, () {}),
                  _buildMenuItem(context, Icons.star_outline, 'Loyalty Points', '245 points शिल्लक', AppColors.primaryOrange, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardWalletScreen()))),
                  _buildMenuItem(context, Icons.card_giftcard_outlined, 'Lucky Draw', 'आजचा draw रात्री 8 PM', AppColors.successGreen, () {}),
                  _buildMenuItem(context, Icons.people_outline, 'Referral', 'मित्रांना invite करा', AppColors.cyan, () {}),
                  const SizedBox(height: 16),
                  const Text('सेटिंग्ज', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 10),
                  _buildMenuItem(context, Icons.location_on_outlined, 'माझा पत्ता', 'हडपसर, पुणे', AppColors.primaryBlue, () {}),
                  _buildMenuItem(context, Icons.language_outlined, 'भाषा', 'मराठी', AppColors.primaryOrange, () {}),
                  _buildMenuItem(context, Icons.notifications_outlined, 'Notifications', 'चालू आहे', AppColors.successGreen, () {}),
                  _buildMenuItem(context, Icons.help_outline, 'Help & Support', 'आम्हाला संपर्क करा', AppColors.textLight, () {}),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      icon: const Icon(Icons.logout, color: AppColors.errorRed),
                      label: const Text('Logout', style: TextStyle(color: AppColors.errorRed, fontSize: 16)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.errorRed),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      children: const [
                        Text('AMOLE v1.0.0', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                        Text('amole.in', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
