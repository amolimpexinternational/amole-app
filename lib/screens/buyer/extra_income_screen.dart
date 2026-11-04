import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_colors.dart';

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

  // ॲप उघडल्यावर आधीच प्रमोटर आहे का ते तपासणे
  Future<void> _loadPromoterStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPromoter = prefs.getBool('isPromoter') ?? false;
      _isLoading = false;
    });
  }

  // प्रमोटर होण्याचे बटण दाबल्यावर
  Future<void> _becomePromoter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPromoter', true); // प्रमोटर स्टेटस सेव्ह करा
    setState(() {
      _isPromoter = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('अभिनंदन! तुम्ही आता प्रमोटर आहात. 🎉'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
          // === १. प्रमोटर स्टेटस कार्ड (डायनॅमिक) ===
          _buildPromoterCard(),

          const SizedBox(height: 24),
          const Text('कमाईच्या संधी', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 12),

          // === २. एकूण ६ पर्याय ===
          _buildOptionCard(
            title: '१. पेड जाहिराती तयार करा',
            subtitle: 'जाहिरात तयार करा (फ्रँचायझी/CP अप्रूव्हल आवश्यक)',
            icon: Icons.campaign,
            color: Colors.purple,
            onTap: () {},
          ),
          _buildOptionCard(
            title: '२. जाहिराती बघून पैसे कमवा',
            subtitle: 'जाहिरात टॅबमध्ये जाऊन पोलची उत्तरे द्या',
            icon: Icons.play_circle_fill,
            color: Colors.blue,
            onTap: () {},
          ),
          _buildOptionCard(
            title: '३. App refer करा',
            subtitle: 'रेफरन्स लिंक शेअर करा आणि कमवा',
            icon: Icons.share,
            color: Colors.green,
            onTap: () {},
          ),
          _buildOptionCard(
            title: '४. डिलिव्हरी बॉय व्हा',
            subtitle: 'डिलिव्हरी बॉय म्हणून काम करा',
            icon: Icons.two_wheeler,
            color: Colors.orange,
            onTap: () {},
          ),
          _buildOptionCard(
            title: '५. आठवडी बाजारात वस्तू विका',
            subtitle: '₹५० फी - प्रत्येक प्रॉडक्टसाठी',
            icon: Icons.storefront,
            color: Colors.teal,
            onTap: () {},
          ),
          _buildOptionCard(
            title: '६. सेलर ऑन बोर्ड करा',
            subtitle: 'नवीन सेलर जोडा आणि कमवा',
            icon: Icons.person_add,
            color: Colors.indigo,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // === प्रमोटर कार्डची रचना ===
  Widget _buildPromoterCard() {
    if (_isPromoter) {
      // जर आधीच प्रमोटर असेल तर प्रोफाइल दाखवा
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.purple, Colors.purpleAccent]),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
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
                  // TODO: प्रमोटर प्रोफाइल स्क्रीन उघडण्यासाठी
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('प्रमोटर प्रोफाइल स्क्रीन पुढे जोडली जाईल')));
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
      // जर प्रमोटर नसेल तर 'प्रमोटर व्हा' बटन दाखवा
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.purple.shade200),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
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
                onPressed: _becomePromoter,
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

  // === ६ पर्यायांसाठी कार्ड ===
  Widget _buildOptionCard({required String title, required String subtitle, required IconData icon, required Color color, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textLight),
      ),
    );
  }
}
