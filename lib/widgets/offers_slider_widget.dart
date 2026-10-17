import 'dart:async';
import 'package:flutter/material.dart';

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
      'tag': '🔥 Most Sold',
      'title': 'सर्वाधिक विकले जाणारे प्रॉडक्ट',
      'sub': 'आपल्या परिसरात सर्वाधिक मागणी',
      'c1': Color(0xFFFF6F00),
      'c2': Color(0xFFFFB300),
    },
    {
      'tag': '🏪 Franchise Offer',
      'title': 'आपल्या फ्रॅंचाईजीची खास ऑफर',
      'sub': 'तुमच्या एरियातील दुकानांवर सूट',
      'c1': Color(0xFF00897B),
      'c2': Color(0xFF26C6DA),
    },
    {
      'tag': '🤝 Channel Partner Offer',
      'title': 'चॅनल पार्टनर ऑफर',
      'sub': 'तुमच्या जिल्ह्यातील विशेष ऑफर',
      'c1': Color(0xFF5E35B1),
      'c2': Color(0xFF7E57C2),
    },
    {
      'tag': '⭐ Admin Offer',
      'title': 'Amole ची खास ऑफर',
      'sub': 'सर्व खरेदीदारांसाठी',
      'c1': Color(0xFF1565C0),
      'c2': Color(0xFF00E5FF),
    },
  ];

  @override
  void initState() {
    super.initState();
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
        const SizedBox(height: 14),
        SizedBox(
          height: 110,
          child: PageView.builder(
            controller: _controller,
            itemCount: _offers.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (context, index) {
              final o = _offers[index];
              return Container(
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