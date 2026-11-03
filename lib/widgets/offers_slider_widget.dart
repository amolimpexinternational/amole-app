import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart'; // तुझ्या फोल्डरनुसार पाथ बदलून घे

class OffersSliderWidget extends StatefulWidget {
  const OffersSliderWidget({super.key});

  @override
  State<OffersSliderWidget> createState() => _OffersSliderWidgetState();
}

class _OffersSliderWidgetState extends State<OffersSliderWidget> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _page = 0;
  String _selectedTab = 'सर्व';

  final List<String> _tabs = ['सर्व', 'ऑफर्स', 'चॅनल पार्टनर', 'फ्रँचायझी'];

  // प्रत्येक ऑफरला एक 'type' दिला आहे जेणेकरून टॅब नुसार फिल्टर करता येईल
  final List<Map<String, dynamic>> _allOffers = [
    {
      'tag': '🔥 Most Sold',
      'title': 'सर्वाधिक विकले जाणारे प्रॉडक्ट',
      'sub': 'आपल्या परिसरात सर्वाधिक मागणी',
      'type': 'ऑफर्स',
      'c1': const Color(0xFFFF6F00),
      'c2': const Color(0xFFFFB300),
    },
    {
      'tag': '🏪 Franchise Offer',
      'title': 'आपल्या फ्रॅंचाईजीची खास ऑफर',
      'sub': 'तुमच्या एरियातील दुकानांवर सूट',
      'type': 'फ्रँचायझी',
      'c1': const Color(0xFF00897B),
      'c2': const Color(0xFF26C6DA),
    },
    {
      'tag': '🤝 Channel Partner Offer',
      'title': 'चॅनल पार्टनर ऑफर',
      'sub': 'तुमच्या जिल्ह्यातील विशेष ऑफर',
      'type': 'चॅनल पार्टनर',
      'c1': const Color(0xFF5E35B1),
      'c2': const Color(0xFF7E57C2),
    },
    {
      'tag': '⭐ Admin Offer',
      'title': 'Amole ची खास ऑफर',
      'sub': 'सर्व खरेदीदारांसाठी',
      'type': 'ऑफर्स',
      'c1': const Color(0xFF1565C0),
      'c2': const Color(0xFF00E5FF),
    },
  ];

  // निवडलेल्या टॅबनुसार ऑफर्स फिल्टर करणारे फंक्शन
  List<Map<String, dynamic>> get _filteredOffers {
    if (_selectedTab == 'सर्व') return _allOffers;
    return _allOffers.where((o) => o['type'] == _selectedTab).toList();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_controller.hasClients) return;
      final offers = _filteredOffers;
      if (offers.isEmpty) return;
      final next = (_page + 1) % offers.length;
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
    final offers = _filteredOffers;

    return Column(
      children: [
        const SizedBox(height: 10),
        
        // === १. टॅब्स (Tabs) चा भाग ===
        SizedBox(
          height: 35,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _tabs.length,
            itemBuilder: (context, index) {
              final tab = _tabs[index];
              final isSelected = _selectedTab == tab;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTab = tab;
                    _page = 0; // टॅब बदलल्यावर पहिल्या ऑफरवर जा
                    if (_controller.hasClients) {
                      _controller.jumpToPage(0);
                    }
                  });
                  _startTimer(); // टाइमर रिस्टार्ट कर
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryBlue : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
                  ),
                  child: Text(
                    tab,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.primaryBlue,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),

        // === २. स्लायडर चा भाग ===
        SizedBox(
          height: 110,
          child: offers.isEmpty
              ? const Center(child: Text('कोणतीही ऑफर नाही', style: TextStyle(color: AppColors.textLight)))
              : PageView.builder(
                  controller: _controller,
                  itemCount: offers.length,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemBuilder: (context, index) {
                    final o = offers[index];
                    return GestureDetector(
                      onTap: () {
                        // === ३. ऑफरवर क्लिक केल्यावर डिटेल्स ओपन होणे ===
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
        if (offers.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(offers.length, (i) {
              final active = i == _page;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: active ? 16 : 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: active ? const Color(0xFF1565C0) : Colors.grey.shade300,
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
// === खालील भाग म्हणजे ऑफरवर क्लिक केल्यावर उघडणारी नवीन स्क्रीन (एकाच फाईलमध्ये) ===
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
          children: [
            // मोठा फोटो/व्हिडिओ (सध्या फक्त रंगाचा बॅनर)
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [offer['c1'] as Color, offer['c2'] as Color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  offer['tag'],
                  style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            
            // डिटेल्स
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer['title'],
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    offer['sub'],
                    style: const TextStyle(fontSize: 16, color: AppColors.textLight),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'या ऑफर अंतर्गत दिल्या जाणाऱ्या सर्व सूट आणि नियमांची संपूर्ण माहिती इथे दिसेल. (ही स्क्रीन पुढील टप्प्यात डायनॅमिक डेटाशी जोडली जाईल)',
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('खरेदी करा', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}