import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class OffersSliderWidget extends StatefulWidget {
  const OffersSliderWidget({super.key});

  @override
  State<OffersSliderWidget> createState() => _OffersSliderWidgetState();
}

class _OffersSliderWidgetState extends State<OffersSliderWidget> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _page = 0;

  // सर्व ऑफर्स एकाच लिस्टमध्ये (आता टॅब नाहीत)
  final List<Map<String, dynamic>> _offers = [
    {
      'tag': '🔥 Most Sold',
      'title': 'सर्वाधिक विकले जाणारे प्रॉडक्ट',
      'sub': 'आपल्या परिसरात सर्वाधिक मागणी',
      'c1': const Color(0xFFFF6F00),
      'c2': const Color(0xFFFFB300),
    },
    {
      'tag': '🏪 Franchise Offer',
      'title': 'आपल्या फ्रॅंचाईजीची खास ऑफर',
      'sub': 'तुमच्या एरियातील दुकानांवर सूट',
      'c1': const Color(0xFF00897B),
      'c2': const Color(0xFF26C6DA),
    },
    {
      'tag': '🤝 Channel Partner Offer',
      'title': 'चॅनल पार्टनर ऑफर',
      'sub': 'तुमच्या जिल्ह्यातील विशेष ऑफर',
      'c1': const Color(0xFF5E35B1),
      'c2': const Color(0xFF7E57C2),
    },
    {
      'tag': '⭐ Admin Offer',
      'title': 'Amole ची खास ऑफर',
      'sub': 'सर्व खरेदीदारांसाठी',
      'c1': const Color(0xFF1565C0),
      'c2': const Color(0xFF00E5FF),
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_controller.hasClients) return;
      final next = (_page + 1) % _offers.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        
        // === स्लायडर (टॅब्स काढून टाकले आहेत) ===
        SizedBox(
          height: 110,
          child: PageView.builder(
            controller: _controller,
            itemCount: _offers.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (context, index) {
              final o = _offers[index];
              return GestureDetector(
                onTap: () {
                  // ऑफरवर क्लिक केल्यावर डिटेल्स ओपन होणे
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OfferDetailScreen(offer: o),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [o['c1'] as Color, o['c2'] as Color],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        o['tag'] as String,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        o['title'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        o['sub'] as String,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        
        // === इंडिकेटर डॉट्स ===
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_offers.length, (i) {
            final active = i == _page;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: active ? 16 : 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: active ? AppColors.primaryBlue : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// =========================================================================
// === ऑफरवर क्लिक केल्यावर उघडणारी नवीन स्क्रीन (सगळ्यांसाठी एकच) ===
// =========================================================================
class OfferDetailScreen extends StatelessWidget {
  final Map<String, dynamic> offer;

  const OfferDetailScreen({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offer Details'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === १. ऑफरचा फोटो / व्हिडिओ (डमी) ===
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [offer['c1'] as Color, offer['c2'] as Color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  // डमी फोटो (नंतर Firebase Storage मधून येईल)
                  Center(
                    child: Icon(
                      Icons.image,
                      size: 80,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  // टॅग
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        offer['tag'],
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // === २. ऑफरचं टायटल + संपूर्ण वर्णन ===
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer['title'],
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    offer['sub'],
                    style: const TextStyle(fontSize: 15, color: AppColors.textLight),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    'या ऑफर अंतर्गत दिल्या जाणाऱ्या सर्व सूट आणि नियमांची संपूर्ण माहिती इथे दिसेल. (ही स्क्रीन पुढील टप्प्यात डायनॅमिक डेटाशी जोडली जाईल)',
                    style: TextStyle(fontSize: 14, height: 1.6, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 30),

                  // === ३. "खरेदी करा" → प्रॉडक्ट/दुकानावर ===
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        // डमी: सध्या फक्त बंद करतो. नंतर संबंधित प्रॉडक्ट/दुकानावर नेईल.
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('ऑफरचं संबंधित उत्पादन/दुकान लवकरच जोडलं जाईल'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: const Text(
                        'खरेदी करा',
                        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // डमी माहिती
                  const Center(
                    child: Text(
                      'डमी डेटा — Firebase Stage 3 मध्ये डायनॅमिक होईल',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
