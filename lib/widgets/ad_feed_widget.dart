import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart'; // नवीन ॲड केले
import '../constants/app_colors.dart';
import '../screens/buyer/seller_profile_screen.dart';

class AdFeedWidget extends StatefulWidget {
  final bool compact;
  final bool isSeller;
  const AdFeedWidget({super.key, this.compact = false, this.isSeller = false});

  @override
  State<AdFeedWidget> createState() => _AdFeedWidgetState();
}

class _AdFeedWidgetState extends State<AdFeedWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _selectedTab = 0;

  // टॅब्स: सेलरसाठी ३ आणि बायरसाठी २
  List<String> get _tabs => widget.isSeller
      ? ['📢 जाहिराती', '🎁 My Offers', '🎯 Create Offer']
      : ['📢 जाहिराती', '🎁 My Offers'];

  final List<Map<String, dynamic>> _ads = [
    {
      'seller': 'श्री गणेश किराणा',
      'category': 'किराणा',
      'location': 'हडपसर, पुणे',
      'avatar': 'G',
      'avatarColor': Colors.orange,
      'type': 'photo',
      'title': 'दिवाळी धमाका ऑफर!',
      'desc': 'सर्व किराणा मालावर 20% सूट — फक्त आजपुरता!',
      'bgColor1': const Color(0xFFFF6B35),
      'bgColor2': const Color(0xFFFF8F00),
      'likes': '128',
      'comments': '24',
      'tag': 'Sponsored',
      'pollQuestion': 'तुम्हाला किराणा सामानावर सूट आवडते का?',
    },
    {
      'seller': 'राज इलेक्ट्रॉनिक्स',
      'category': 'इलेक्ट्रॉनिक्स',
      'location': 'कोंढवा, पुणे',
      'avatar': 'R',
      'avatarColor': Colors.blue,
      'type': 'video',
      'title': 'नवीन Mobile आला!',
      'desc': 'Samsung Galaxy A55 — Rs.32,999 मध्ये. EMI उपलब्ध.',
      'bgColor1': const Color(0xFF1565C0),
      'bgColor2': const Color(0xFF00E5FF),
      'likes': '256',
      'comments': '48',
      'tag': 'Ad',
      'pollQuestion': 'तुम्ही नवीन मोबाईल खरेदी करण्यास इंटरेस्टेड आहात का?',
    },
  ];

  final List<Map<String, dynamic>> _myOffers = [
    {'title': 'किराणा 10% Off', 'seller': 'श्री गणेश किराणा', 'validity': '31 July पर्यंत', 'color': Colors.orange, 'desc': 'सर्व किराणा मालावर 10% सूट. आजच खरेदी करा!', 'saved': false},
    {'title': 'Free Delivery', 'seller': 'स्वाद हॉटेल', 'validity': 'आठवडाभर', 'color': Colors.green, 'desc': 'Rs.200 वरील ऑर्डरवर मोफत डिलिव्हरी.', 'saved': false},
    {'title': 'Mobile Cashback Rs.500', 'seller': 'राज इलेक्ट्रॉनिक्स', 'validity': '5 Aug पर्यंत', 'color': Colors.blue, 'desc': 'नवीन मोबाईल खरेदीवर Rs.500 कॅशबॅक.', 'saved': false},
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _pageController.hasClients && _selectedTab == 0) {
        final next = (_currentPage + 1) % _ads.length;
        _pageController.animateToPage(next, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
        setState(() => _currentPage = next);
      }
      _startAutoScroll();
    });
  }

  // === जेव्हा बायर जाहिरात टॅबवर (व्हिडिओ) असेल तेव्हा स्क्रीन ऑन ठेवा, अन्यथा बंद ===
  void _updateWakelock() {
    if (_selectedTab == 0) {
      // जाहिरात टॅबवर - स्क्रीन ऑन ठेवा (व्हिडिओ पाहण्यासाठी)
      WakelockPlus.enable();
    } else {
      // इतर टॅबवर - बॅटरी वाचवण्यासाठी बंद करा
      WakelockPlus.disable();
    }
  }

  @override
  void dispose() {
    // विजेट बंद होताच वेकलॉक पूर्णपणे बंद करा
    WakelockPlus.disable();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildPollSection(Map<String, dynamic> ad) {
    final bool answered = ad['pollAnswer'] != null;
    final String question = ad['pollQuestion'] ?? 'तुम्ही या जाहिरातीत इंटरेस्टेड आहात का?';

    void answer(bool yes) {
      setState(() => ad['pollAnswer'] = yes);
      double reward = 0.0;
      if (ad['type'] == 'video') reward = 0.175;
      else if (ad['type'] == 'photo') reward = 0.0875;
      else reward = 0.035;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ धन्यवाद! तुम्हाला ₹${reward.toStringAsFixed(3)} रिवॉर्ड मिळाले'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.poll_outlined, size: 16, color: AppColors.primaryBlue),
              const SizedBox(width: 6),
              Expanded(
                child: Text(question, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: answered ? null : () => answer(true),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: (answered && ad['pollAnswer'] == true) ? Colors.green : Colors.transparent,
                    side: const BorderSide(color: Colors.green),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: Text('Yes', style: TextStyle(color: (answered && ad['pollAnswer'] == true) ? Colors.white : Colors.green, fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: answered ? null : () => answer(false),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: (answered && ad['pollAnswer'] == false) ? Colors.red : Colors.transparent,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: Text('No', style: TextStyle(color: (answered && ad['pollAnswer'] == false) ? Colors.white : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ),
            ],
          ),
          if (answered) ...[
            const SizedBox(height: 6),
            Text('तुमचं उत्तर नोंदवलं गेलं ✅', style: TextStyle(fontSize: 10.5, color: Colors.green.shade700)),
          ],
        ],
      ),
    );
  }

  Widget _buildAdCard(Map<String, dynamic> ad) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (_) => SellerProfileScreen(sellerName: ad['seller'], category: ad['category'] ?? ''),
      )),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: ad['avatarColor'] as Color,
                      child: Text(ad['avatar'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ad['seller'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 11, color: AppColors.textLight),
                              const SizedBox(width: 2),
                              Text(ad['location'], style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(4)),
                                child: Text(ad['tag'], style: const TextStyle(fontSize: 9, color: AppColors.textLight)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.textLight),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 4 / 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [ad['bgColor1'] as Color, ad['bgColor2'] as Color],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              ad['type'] == 'video' ? Icons.play_circle_filled : Icons.image_outlined,
                              color: Colors.white.withValues(alpha: 0.3),
                              size: 60,
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(ad['title'], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                            ),
                            const SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(ad['desc'], style: const TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildPollSection(ad),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyOffersTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _myOffers.length,
      itemBuilder: (context, index) {
        final offer = _myOffers[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => OfferDetailScreen(offer: offer)));
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: (offer['color'] as Color).withValues(alpha: 0.3)),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6)],
            ),
            child: Row(
              children: [
                Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(
                    color: (offer['color'] as Color).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.local_offer, color: offer['color'] as Color, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(offer['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                      const SizedBox(height: 3),
                      Text(offer['seller'], style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                      const SizedBox(height: 3),
                      Row(children: [
                        const Icon(Icons.access_time, size: 12, color: AppColors.textLight),
                        const SizedBox(width: 3),
                        Text(offer['validity'], style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                      ]),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textLight),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCreateOfferTab(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('नवीन Offer तयार करा', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 16),

            Center(
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('फोटो अपलोडचे तंत्रज्ञान पुढे जोडले जाईल')));
                },
                child: Container(
                  height: 100, width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.textLight, width: 1),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate_outlined, size: 30, color: AppColors.textLight),
                      SizedBox(height: 4),
                      Text('फोटो जोडा', style: TextStyle(fontSize: 10, color: AppColors.textLight)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const TextField(decoration: InputDecoration(labelText: 'Offer Title', hintText: 'उदा. दिवाळी 20% सूट', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'Validity (दिवस)', hintText: '7', border: OutlineInputBorder()), keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'Description', hintText: 'Offer बद्दल सांगा...', border: OutlineInputBorder()), maxLines: 2),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.primaryOrange.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
              child: const Row(children: [
                Icon(Icons.info_outline, color: AppColors.primaryOrange, size: 18),
                SizedBox(width: 8),
                Expanded(child: Text('Offer Franchise कडून approve झाल्यावर Buyers ला दिसेल', style: TextStyle(fontSize: 12, color: AppColors.textDark))),
              ]),
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Offer Approval साठी पाठवला!'), backgroundColor: Colors.green)),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('Approve साठी Submit करा', style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double adsFeedHeight = (MediaQuery.of(context).size.width - 32) * 5 / 4 + 200;

    // टॅब बदलला की वेकलॉक अपडेट करा
    _updateWakelock();

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: List.generate(_tabs.length, (i) => Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() => _selectedTab = i);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: _selectedTab == i ? AppColors.primaryBlue : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(_tabs[i], textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _selectedTab == i ? Colors.white : AppColors.textLight,
                        fontWeight: _selectedTab == i ? FontWeight.bold : FontWeight.normal,
                        fontSize: 11,
                      )),
                ),
              ),
            )),
          ),
        ),
        const SizedBox(height: 8),

        if (_selectedTab == 0) ...[
          SizedBox(
            height: adsFeedHeight,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemCount: _ads.length,
              itemBuilder: (context, index) => _buildAdCard(_ads[index]),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_ads.length, (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentPage == i ? 16 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentPage == i ? AppColors.primaryBlue : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(3),
              ),
            )),
          ),
          const SizedBox(height: 8),
        ]
        else if (_selectedTab == 1)
        ...[
          SizedBox(height: 300, child: _buildMyOffersTab())
        ]
        else if (widget.isSeller && _selectedTab == 2)
        ...[
          _buildCreateOfferTab(context)
        ],
      ],
    );
  }
}

// =========================================================================
// === ऑफरवर क्लिक केल्यावर उघडणारी नवीन स्क्रीन ===
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: (offer['color'] as Color).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.local_offer, color: offer['color'] as Color, size: 80),
            ),
            const SizedBox(height: 24),
            Text(offer['title'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(offer['seller'], style: const TextStyle(fontSize: 16, color: AppColors.textLight)),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.orange),
                const SizedBox(width: 6),
                Text('Validity: ${offer['validity']}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange)),
              ],
            ),
            const Divider(height: 32),
            const Text('Offer Details:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(offer['desc'], style: const TextStyle(fontSize: 15, height: 1.5)),
          ],
        ),
      ),
    );
  }
}