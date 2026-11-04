import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import '../../constants/app_colors.dart';
import 'buyer_home_screen.dart';
import 'promoter_catalog_screen.dart';
import 'promoter_dashboard_screen.dart';
import '../seller/seller_advertisement_screen.dart';
import '../seller/registration/seller_registration_screen.dart';
import '../delivery/delivery_boy_home_screen.dart';

class ExtraIncomeScreen extends StatefulWidget {
  const ExtraIncomeScreen({super.key});

  @override
  State<ExtraIncomeScreen> createState() => _ExtraIncomeScreenState();
}

class _ExtraIncomeScreenState extends State<ExtraIncomeScreen> {
  bool _isPromoter = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPromoterStatus();
  }

  Future<void> _loadPromoterStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPromoter = prefs.getBool('isPromoter') ?? false;
      _isLoading = false;
    });
  }

  void _shareReferLink() {
    final String referLink = 'https://amole.in/ref/AMOLE-P123';
    Share.share(
      'मी AMOLE ॲप वापरतोय! तू पण जॉईन हो आणि माझ्या रेफरल लिंकने सामील हो: $referLink',
      subject: 'AMOLE App मध्ये सामील व्हा',
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('Extra Income'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPromoterCard(),
          const SizedBox(height: 24),
          const Text('कमाईच्या संधी', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 12),

          // १. पेड जाहिराती
          _buildOptionCard(
            title: '१. पेड जाहिराती तयार करा',
            subtitle: 'जाहिरात तयार करा (फ्रँचायझी/CP अप्रूव्हल आवश्यक)',
            icon: Icons.campaign,
            color: Colors.purple,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerAdvertisementScreen())),
          ),
          
          // २. जाहिराती बघून पैसे कमवा
          _buildOptionCard(
            title: '२. जाहिराती बघून पैसे कमवा',
            subtitle: 'मुख्य स्क्रीनवरील जाहिराती टॅबमध्ये जा',
            icon: Icons.play_circle_fill,
            color: Colors.blue,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const BuyerHomeScreen()));
            },
          ),

          // ३. App refer पाठवा
          _buildOptionCard(
            title: '३. App refer पाठवा',
            subtitle: 'WhatsApp, FB, Insta वर लिंक शेअर करा',
            icon: Icons.share,
            color: Colors.green,
            onTap: _shareReferLink,
          ),

          // ४. डिलिव्हरी बॉय व्हा
          _buildOptionCard(
            title: '४. डिलिव्हरी बॉय व्हा',
            subtitle: 'डिलिव्हरी बॉय म्हणून काम करा',
            icon: Icons.two_wheeler,
            color: Colors.orange,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DeliveryBoyHomeScreen())),
          ),

          // ५. आठवडी बाजार
          _buildOptionCard(
            title: '५. आठवडी बाजारात वस्तू विका',
            subtitle: '₹५० फी - प्रत्येक प्रॉडक्टसाठी (फोटोसह)',
            icon: Icons.storefront,
            color: Colors.teal,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PromoterCatalogScreen())),
          ),

          // ६. सेलर ऑन बोर्ड करा
          _buildOptionCard(
            title: '६. सेलर ऑन बोर्ड करा',
            subtitle: 'नवीन सेलर जोडा आणि कमवा',
            icon: Icons.person_add,
            color: Colors.indigo,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerRegistrationScreen())),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoterCard() {
    if (_isPromoter) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.purple, Colors.purpleAccent]),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.purple.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.verified, color: Colors.white, size: 28),
                SizedBox(width: 10),
                Text('तुम्ही प्रमोटर आहात!', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('तुमचा प्रमोटर कोड', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text('AMOLE-P123', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('एकूण कमाई', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text('₹450', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PromoterDashboardScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('माझी प्रमोटर प्रोफाइल बघा', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.purple.shade200),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)],
        ),
        child: Column(
          children: [
            const Icon(Icons.campaign, color: Colors.purple, size: 50),
            const SizedBox(height: 12),
            const Text('प्रमोटर व्हा आणि कमवा', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 6),
            const Text('इतर सेलर्सची प्रॉडक्ट्स शेअर करा आणि प्रत्येक विक्रीवर ५% कमिशन मिळवा.', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: AppColors.textLight)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isPromoter', true);
                  setState(() => _isPromoter = true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const PromoterDashboardScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('प्रमोटर व्हा (Join as Promoter)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildOptionCard({required String title, required String subtitle, required IconData icon, required Color color, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)],
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(backgroundColor: color.withValues(alpha: 0.15), child: Icon(icon, color: color)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textLight),
      ),
    );
  }
}
