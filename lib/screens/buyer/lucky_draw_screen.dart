import 'dart:async';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class LuckyDrawScreen extends StatefulWidget {
  const LuckyDrawScreen({super.key});

  @override
  State<LuckyDrawScreen> createState() => _LuckyDrawScreenState();
}

class _LuckyDrawScreenState extends State<LuckyDrawScreen> {
  bool _ticketBought = false;
  final ScrollController _winnersController = ScrollController();
  Timer? _autoScrollTimer;

  // Demo data — गेल्या ३० दिवसांतील विजेते (backend स्टेजमध्ये API मधून येईल)
  final List<Map<String, String>> _recentWinners = const [
    {'name': 'सुनिता पवार', 'date': '२७ ऑगस्ट', 'points': '₹५५ Points'},
    {'name': 'राहुल जाधव', 'date': '२६ ऑगस्ट', 'points': '₹४० Points'},
    {'name': 'अंजली शिंदे', 'date': '२५ ऑगस्ट', 'points': '₹७० Points'},
    {'name': 'विकास पाटील', 'date': '२४ ऑगस्ट', 'points': '₹३० Points'},
    {'name': 'प्रिया देशमुख', 'date': '२३ ऑगस्ट', 'points': '₹६० Points'},
    {'name': 'संदीप कदम', 'date': '२१ ऑगस्ट', 'points': '₹४५ Points'},
    {'name': 'नेहा भोसले', 'date': '१९ ऑगस्ट', 'points': '₹५० Points'},
    {'name': 'गणेश मोरे', 'date': '१७ ऑगस्ट', 'points': '₹३५ Points'},
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (!_winnersController.hasClients) return;
      final maxScroll = _winnersController.position.maxScrollExtent;
      double next = _winnersController.offset + 0.8;
      if (next >= maxScroll) {
        next = 0;
      }
      _winnersController.jumpTo(next);
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _winnersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Lucky Draw 🏆', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6A1B9A), Color(0xFF1565C0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text('🎰', style: TextStyle(fontSize: 60)),
                  const SizedBox(height: 12),
                  const Text('आजचा Lucky Draw', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('निकाल: संध्याकाळी ४:०० वाजता', style: TextStyle(color: Colors.white70, fontSize: 15)),
                  const SizedBox(height: 4),
                  const Text('(तिकीट खरेदीची अंतिम वेळ: ३:५० वाजेपर्यंत)', style: TextStyle(color: Colors.white60, fontSize: 12)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(30)),
                    child: const Text('🏆 बक्षीस Reward Points स्वरूपात मिळते', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // गेल्या ३० दिवसांतील विजेते — auto-scrolling पट्टी
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('गेल्या ३० दिवसांतील विजेते 🎉', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 78,
                    child: ListView.builder(
                      controller: _winnersController,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      // यादी दुप्पट करून seamless loop चा आभास दिला
                      itemCount: _recentWinners.length * 2,
                      itemBuilder: (context, index) {
                        final winner = _recentWinners[index % _recentWinners.length];
                        return _buildWinnerCard(winner);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // ₹१,००० खरेदीवर १ तिकीट मोफत गिफ्ट
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  const Text('🎁', style: TextStyle(fontSize: 32)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 14, color: AppColors.textDark),
                        children: [
                          TextSpan(text: '₹१,००० च्या खरेदीवर ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '१ Lucky Draw तिकीट मोफत गिफ्ट मिळेल!'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('टिकीट माहिती', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('एका टिकीटाची किंमत', style: TextStyle(color: AppColors.textLight)),
                      const Text('₹5', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('तुमचे Loyalty Points', style: TextStyle(color: AppColors.textLight)),
                      const Text('245 pts', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (!_ticketBought)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A1B9A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => setState(() => _ticketBought = true),
                  child: const Text('₹5 मध्ये टिकीट घ्या 🎟️', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.green.shade300)),
                child: const Column(
                  children: [
                    Text('🎟️ टिकीट यशस्वीरित्या घेतलं!', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 4),
                    Text('संध्याकाळी ४:०० वाजता निकाल जाहीर होईल', style: TextStyle(color: Colors.green, fontSize: 13)),
                  ],
                ),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildWinnerCard(Map<String, String> winner) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🏆', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  winner['name']!,
                  style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(winner['date']!, style: const TextStyle(fontSize: 10.5, color: AppColors.textLight)),
          const SizedBox(height: 2),
          Text(winner['points']!, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: Colors.green)),
        ],
      ),
    );
  }
}
