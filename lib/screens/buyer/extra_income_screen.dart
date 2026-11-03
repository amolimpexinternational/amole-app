import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'promoter_profile_screen.dart';
import 'promoter_dashboard_screen.dart';

class ExtraIncomeScreen extends StatefulWidget {
  const ExtraIncomeScreen({super.key});

  @override
  State<ExtraIncomeScreen> createState() => _ExtraIncomeScreenState();
}

class _ExtraIncomeScreenState extends State<ExtraIncomeScreen> {
  Future<void> _openPromoter() async {
    final Widget next = PromoterState.registered
        ? const PromoterDashboardScreen()
        : const PromoterProfileScreen();
    await Navigator.push(context, MaterialPageRoute(builder: (_) => next));
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('💰 Extra Income'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPromoterCard(),
          const SizedBox(height: 24),
          const Text(
            'एक्स्ट्रा इन्कम कसे कमवू शकता?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildWayTile('1', Icons.campaign, 'प्रमोटर होऊन 5% कमिशन'),
          _buildWayTile('2', Icons.ondemand_video, 'जाहिराती बघून'),
          _buildWayTile('3', Icons.group_add, 'refer केल्यामुळे referee च्या प्रत्येक खरेदीमागे'),
          _buildWayTile('4', Icons.delivery_dining, 'डिलिव्हरी बॉय सर्विस देऊन'),
          _buildWayTile('5', Icons.ads_click, 'जाहिराती आणून'),
          _buildWayTile('6', Icons.storefront, 'Seller onboarding करून'),
          _buildWayTile('7', Icons.shopping_basket, 'आठवडी बाजारात वस्तू विकून'),
        ],
      ),
    );
  }

  Widget _buildPromoterCard() {
    final bool registered = PromoterState.registered;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.royalBlue, AppColors.primaryBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            registered ? 'माझा प्रमोटर डॅशबोर्ड' : 'प्रमोटर व्हा',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            registered
                ? 'तुमचा कॅटलॉग आणि मिळालेले कमिशन पाहा'
                : 'प्रमोटर झाल्यामुळे 5% कमिशन मिळू शकते',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 4),
          const Text(
            'स्वतःचा कॅटलॉग बनवा, WhatsApp वर शेअर करा आणि प्रत्येक विक्रीवर कमिशन मिळवा',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primaryBlue,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _openPromoter,
              child: Text(
                registered ? 'डॅशबोर्ड उघडा' : 'प्रमोटर व्हा',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWayTile(String number, IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primaryBlue,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: AppColors.primaryBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}