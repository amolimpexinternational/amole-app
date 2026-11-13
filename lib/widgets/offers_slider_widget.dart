import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/product_model.dart';
import '../screens/buyer/product_detail_screen.dart';
import '../data/product_database.dart';

class OffersSliderWidget extends StatefulWidget {
  const OffersSliderWidget({super.key});

  @override
  State<OffersSliderWidget> createState() => _OffersSliderWidgetState();
}

class _OffersSliderWidgetState extends State<OffersSliderWidget> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _page = 0;

  final List<Map<String, dynamic>> _offers = [
    {
      'title': 'दिवाळी धमाका 20% सूट',
      'sub': 'आपल्या परिसरात सर्वाधिक मागणी',
      'image': '',
      'c1': const Color(0xFFFF6F00),
      'c2': const Color(0xFFFFB300),
      'productLink': 'https://amole.in/product/p1',
    },
    {
      'title': 'फ्रॅंचाईजी खास ऑफर',
      'sub': 'तुमच्या एरियातील दुकानांवर सूट',
      'image': '',
      'c1': const Color(0xFF00897B),
      'c2': const Color(0xFF26C6DA),
      'productLink': 'https://amole.in/product/p2',
    },
    {
      'title': 'चॅनल पार्टनर ऑफर',
      'sub': 'तुमच्या जिल्ह्यातील विशेष ऑफर',
      'image': '',
      'c1': const Color(0xFF5E35B1),
      'c2': const Color(0xFF7E57C2),
      'productLink': 'https://amole.in/product/p3',
    },
    {
      'title': 'Amole ची खास ऑफर',
      'sub': 'सर्व खरेदीदारांसाठी',
      'image': '',
      'c1': const Color(0xFF1565C0),
      'c2': const Color(0xFF00E5FF),
      'productLink': 'https://amole.in/product/p4',
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
                  child: Row(
                    children: [
                      // === फोटो (डमी) ===
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.local_offer, color: Colors.white, size: 36),
                      ),
                      const SizedBox(width: 12),
                      // === शीर्षक + उपशीर्षक ===
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              o['title'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              o['sub'] as String,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
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
// === ऑफर डिटेल स्क्रीन ===
// =========================================================================
class OfferDetailScreen extends StatelessWidget {
  final Map<String, dynamic> offer;

  const OfferDetailScreen({super.key, required this.offer});

  // === लिंक वरून प्रॉडक्ट शोधणे (डमी) ===
  ProductModel? _findProductFromLink() {
    final link = offer['productLink'] as String? ?? '';
    if (link.isEmpty) return null;

    // लिंक मधून ID काढणे (उदा. .../p1 → p1)
    final id = link.split('/').last;
    try {
      return ProductDatabase.products.firstWhere((p) => p.id == id);
    } catch (_) {
      // जर सापडलं नाही तर पहिलं प्रॉडक्ट (डमी)
      if (ProductDatabase.products.isNotEmpty) {
        return ProductDatabase.products.first;
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = _findProductFromLink();

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
            // === फोटो ===
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
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 80,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ),

            // === माहिती ===
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

                  // === "खरेदी करा" → प्रॉडक्टवर ===
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        if (product == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('प्रॉडक्ट सापडलं नाही'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(product: product),
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
