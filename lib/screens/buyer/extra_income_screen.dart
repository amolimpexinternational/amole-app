import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_colors.dart';
import 'promoter_dashboard_screen.dart';

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

  // === ७ पर्याय + माहिती ===
  final List<Map<String, dynamic>> _options = [
    {
      'title': 'पेड जाहिराती तयार करा',
      'short': 'जाहिरात तयार करा',
      'icon': Icons.campaign,
      'color': Colors.purple,
      'info': 'जाहिरात प्रसिद्ध करण्यासाठी आपण प्रती जाहिरात ₹50 ते ₹500 फी जाहिरात देणाऱ्या ग्राहकांकडून स्वीकारू शकतात.',
    },
    {
      'title': 'जाहिराती बघून पैसे कमवा',
      'short': 'जाहिरात बघा',
      'icon': Icons.play_circle_fill,
      'color': Colors.blue,
      'info': 'तुमच्या प्रोफाइल वर दिसणाऱ्या जाहिराती बघून फीडबॅक दिल्यावर आपल्याला 100% रिवॉर्ड पॉइंट च्या स्वरूपात कमाई करता येते.',
    },
    {
      'title': 'App refer करा',
      'short': 'App refer',
      'icon': Icons.share,
      'color': Colors.green,
      'info': 'तुम्हाला प्रत्येकाला app refer करण्यासाठी unique link व reference id मिळाले आहे. त्या माध्यमातून तुम्ही app सोबत कोणाला जोडले तर आपल्याला कायम त्या व्यक्तीच्या खरेदी मागे रिवॉर्ड पॉइंट मिळत राहणार आहे.',
    },
    {
      'title': 'डिलिव्हरी बॉय व्हा',
      'short': 'डिलिव्हरी बॉय',
      'icon': Icons.two_wheeler,
      'color': Colors.orange,
      'info': 'कंपनी ला स्थानिक ठिकाणी सेवा देणाऱ्या प्रोफेशनल व्यक्तींची आवश्यकता असते. आपल्याकडे बाईक वर आवश्यक KYC documents असतील तर पार्ट टाइम किंवा फुल टाइम आपण डिलिव्हरी सेवा देऊन आर्थिक लाभ कमवू शकतात.',
    },
    {
      'title': 'आठवडी बाजारात वस्तू विका',
      'short': 'आठवडी बाजार',
      'icon': Icons.storefront,
      'color': Colors.teal,
      'info': 'ह्या माध्यमातून आपण दर आठवड्याला आपल्या कडची किंवा ज्याला तांत्रिक ज्ञान नाही पण दर्जेदार उत्पादन त्यांच्याकडे आहे अशा स्थानिक व्यावसायिकांची उत्पादने तुम्ही राज्यभर विकून पैसे कमवू शकतात.',
    },
    {
      'title': 'Seller onboard करा',
      'short': 'Seller जोडा',
      'icon': Icons.person_add,
      'color': Colors.indigo,
      'info': 'आपण आपल्या परिसरातील seller, service provider, rikshaw taxi, parcel service, hotel, kirana shop यांना app ची माहिती देऊन प्लॅटफॉर्म शी जोडून त्यांच्या कडून ₹100 ते ₹500 पर्यंत फी घेऊ शकतात.',
    },
    {
      'title': 'प्रमोटर होऊन',
      'short': 'प्रमोटर',
      'icon': Icons.workspace_premium,
      'color': Colors.amber.shade700,
      'info': 'App वर असलेले चांगले उत्पादन तुमच्या सोशल मिडिया किंवा तुमच्या स्वतःच्या मार्केटिंग स्ट्रॅटर्जी नुसार विकून स्वतःचे दुकान नसतांना सुद्धा आपण 5% नफा प्रत्येक उत्पादन विक्री मागे कमवू शकतात.',
    },
  ];

  void _showOptionInfo(Map<String, dynamic> option) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: (option['color'] as Color).withOpacity(0.15),
                  child: Icon(option['icon'] as IconData, color: option['color'] as Color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    option['title'] as String,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              option['info'] as String,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: option['color'] as Color,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('ठीक आहे', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
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
          _buildPromoterCard(),

          const SizedBox(height: 24),
          const Text(
            'कमाईच्या संधी',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
          ),
          const SizedBox(height: 4),
          const Text(
            'टॅबवर क्लिक करून माहिती बघा',
            style: TextStyle(fontSize: 12, color: AppColors.textLight, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 12),

          // === ७ आडवे टॅब ===
          SizedBox(
            height: 130,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _options.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return _buildHorizontalOptionCard(_options[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalOptionCard(Map<String, dynamic> option) {
    return GestureDetector(
      onTap: () => _showOptionInfo(option),
      child: Container(
        width: 115,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: (option['color'] as Color).withOpacity(0.3)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: (option['color'] as Color).withOpacity(0.15),
              child: Icon(option['icon'] as IconData, color: option['color'] as Color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              option['short'] as String,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark),
            ),
          ],
        ),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PromoterDashboardScreen()),
                  );
                  // परत आल्यावर status पुन्हा लोड कर (KYC पूर्ण झाली असेल तर)
                  _loadPromoterStatus();
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
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PromoterDashboardScreen()),
                  );
                  // KYC पूर्ण करून परत आल्यावर status refresh → "प्रोफाइल बघा" दिसेल
                  _loadPromoterStatus();
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
}