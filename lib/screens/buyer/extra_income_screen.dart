import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'promoter_profile_screen.dart';
import 'promoter_dashboard_screen.dart';
import '../seller/seller_advertisement_screen.dart';
import '../delivery/delivery_boy_home_screen.dart';
import '../seller/registration/seller_registration_screen.dart';
import '../../widgets/ad_feed_widget.dart';

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

  void _openCreateAd() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerAdvertisementScreen()));
  }

  void _openWatchAds() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (ctx, scroll) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.ondemand_video, color: AppColors.primaryBlue, size: 28),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('जाहिराती बघून कमवा', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                        Text('प्रत्येक पोल रिप्लायवर रिवॉर्ड पॉईंट्स', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                      ],
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: scroll,
                padding: const EdgeInsets.all(16),
                children: const [
                  AdFeedWidget(isSeller: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReferral() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('App Refer करा आणि कमवा', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 6),
            const Text('तुमची रेफरन्स लिंक मित्रांना शेअर करा.', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const Icon(Icons.link, color: AppColors.primaryBlue),
                  const SizedBox(width: 10),
                  const Expanded(child: Text('https://amole.in/ref/AMOLE12345', style: TextStyle(fontSize: 13, color: AppColors.textDark))),
                  IconButton(
                    icon: const Icon(Icons.copy, color: AppColors.primaryBlue, size: 18),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('लिंक कॉपी झाली!'), backgroundColor: Colors.green));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Share मेनू उघडत आहे...'), backgroundColor: Colors.green));
                },
                icon: const Icon(Icons.share, color: Colors.white),
                label: const Text('शेअर करा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openDeliveryBoy() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const DeliveryBoyHomeScreen()));
  }

  void _showWeeklyMarket() {
    final _titleCtrl = TextEditingController();
    final _priceCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom + 20, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('आठवडी बाजारात वस्तू विका', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 6),
            const Text('दर शनिवारी दुपारी 3 ते रात्री 12. एक वस्तू पोस्ट करण्यासाठी ₹50 फी.', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
            const SizedBox(height: 16),
            TextField(controller: _titleCtrl, decoration: InputDecoration(labelText: 'वस्तूचं नाव', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14))),
            const SizedBox(height: 12),
            TextField(controller: _priceCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'किंमत (₹)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14))),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.orange.shade200)),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange.shade700, size: 18),
                  const SizedBox(width: 8),
                  const Expanded(child: Text('₹50 फी भरल्यावरच वस्तू आठवडी बाजारात दिसेल.', style: TextStyle(fontSize: 12, color: AppColors.textDark))),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('₹50 फी भरली. वस्तू आठवडी बाजारात पोस्ट झाली! ✅'), backgroundColor: Colors.green));
                },
                icon: const Icon(Icons.upload, color: Colors.white),
                label: const Text('₹50 भरा आणि पोस्ट करा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openSellerOnboard() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerRegistrationScreen()));
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
          const Text('एक्स्ट्रा इन्कम कसे कमवू शकता?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildOptionTile(number: '1', icon: Icons.campaign_outlined, title: 'पेड जाहिराती तयार करा', subtitle: 'जाहिरात तयार करून कमवा', color: Colors.deepOrange, onTap: _openCreateAd),
          _buildOptionTile(number: '2', icon: Icons.ondemand_video, title: 'जाहिराती बघून पैसे कमवा', subtitle: 'प्रत्येक पोल रिप्लायवर रिवॉर्ड पॉईंट्स', color: Colors.blue, onTap: _openWatchAds),
          _buildOptionTile(number: '3', icon: Icons.share, title: 'App Refer पाठवा', subtitle: 'रेफरन्स लिंक शेअर करा आणि कमवा', color: Colors.purple, onTap: _showReferral),
          _buildOptionTile(number: '4', icon: Icons.delivery_dining, title: 'डिलिव्हरी बॉय व्हा', subtitle: 'डिलिव्हरी बॉय सर्विस देऊन कमवा', color: Colors.teal, onTap: _openDeliveryBoy),
          _buildOptionTile(number: '5', icon: Icons.shopping_basket, title: 'आठवडी बाजारात वस्तू विका', subtitle: '₹50 फी - दर शनिवारी एक वस्तू पोस्ट करा', color: Colors.brown, onTap: _showWeeklyMarket),
          _buildOptionTile(number: '6', icon: Icons.storefront, title: 'सेलर ऑनबोर्ड करा', subtitle: 'नवीन सेलर जोडून कमवा', color: AppColors.primaryBlue, onTap: _openSellerOnboard),
        ],
      ),
    );
  }

  Widget _buildPromoterCard() {
    final bool registered = PromoterState.registered;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.royalBlue, AppColors.primaryBlue], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(registered ? 'माझा प्रमोटर डॅशबोर्ड' : 'प्रमोटर व्हा', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(registered ? 'तुमचा कॅटलॉग आणि मिळालेले कमिशन पाहा' : 'प्रमोटर झाल्यामुळे 5% कमिशन मिळू शकते', style: const TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              onPressed: _openPromoter,
              child: Text(registered ? 'डॅशबोर्ड उघडा' : 'प्रमोटर व्हा', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required String number,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.2)),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 20, backgroundColor: color.withValues(alpha: 0.15), child: Icon(icon, color: color, size: 22)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(Icons.arrow_forward_ios, color: color, size: 12),
            ),
          ],
        ),
      ),
    );
  }
}
