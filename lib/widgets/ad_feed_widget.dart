import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdFeedWidget extends StatefulWidget {
  final bool compact;
  const AdFeedWidget({super.key, this.compact = false});

  @override
  State<AdFeedWidget> createState() => _AdFeedWidgetState();
}

class _AdFeedWidgetState extends State<AdFeedWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _ads = [
    {
      'seller': 'श्री गणेश किराणा',
      'location': 'हडपसर, पुणे',
      'avatar': 'G',
      'avatarColor': Colors.orange,
      'type': 'photo',
      'title': '🎉 दिवाळी धमाका ऑफर!',
      'desc': 'सर्व किराणा मालावर 20% सूट — फक्त आजपुरता!',
      'bgColor1': Color(0xFFFF6B35),
      'bgColor2': Color(0xFFFF8F00),
      'likes': '128',
      'comments': '24',
      'tag': 'Sponsored',
    },
    {
      'seller': 'राज इलेक्ट्रॉनिक्स',
      'location': 'कोंढवा, पुणे',
      'avatar': 'R',
      'avatarColor': Colors.blue,
      'type': 'video',
      'title': '📱 नवीन Mobile आला!',
      'desc': 'Samsung Galaxy A55 — ₹32,999 मध्ये. EMI उपलब्ध.',
      'bgColor1': Color(0xFF1565C0),
      'bgColor2': Color(0xFF00E5FF),
      'likes': '256',
      'comments': '48',
      'tag': 'Ad',
    },
    {
      'seller': 'स्वाद हॉटेल',
      'location': 'वानवडी, पुणे',
      'avatar': 'S',
      'avatarColor': Colors.green,
      'type': 'photo',
      'title': '🍱 जेवण घरपोच!',
      'desc': 'ताजे, घरगुती जेवण — ₹80 पासून. Free Delivery ₹200 वर.',
      'bgColor1': Color(0xFF2E7D32),
      'bgColor2': Color(0xFF66BB6A),
      'likes': '89',
      'comments': '15',
      'tag': 'Sponsored',
    },
    {
      'seller': 'फॅशन पॉईंट',
      'location': 'मगरपट्टा, पुणे',
      'avatar': 'F',
      'avatarColor': Colors.pink,
      'type': 'photo',
      'title': '👗 नवीन Collection आली!',
      'desc': 'Ladies & Gents कपडे — Buy 2 Get 1 Free. आजच या!',
      'bgColor1': Color(0xFFAD1457),
      'bgColor2': Color(0xFFEC407A),
      'likes': '312',
      'comments': '67',
      'tag': 'Ad',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _pageController.hasClients) {
        final next = (_currentPage + 1) % _ads.length;
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() => _currentPage = next);
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildAdCard(Map<String, dynamic> ad) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
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
                const Icon(Icons.more_horiz, color: AppColors.textLight),
              ],
            ),
          ),
          // Media
          Container(
            width: double.infinity,
            height: widget.compact ? 160 : 200,
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
                        color: Colors.white.withOpacity(0.3),
                        size: 60,
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(ad['title'],
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(ad['desc'],
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
                if (ad['type'] == 'video')
                  Positioned(
                    top: 8, right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
                      child: const Row(children: [
                        Icon(Icons.videocam, color: Colors.white, size: 12),
                        SizedBox(width: 3),
                        Text('Video', style: TextStyle(color: Colors.white, fontSize: 10)),
                      ]),
                    ),
                  ),
              ],
            ),
          ),
          // Engagement
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: Row(
              children: [
                const Icon(Icons.thumb_up, color: AppColors.primaryBlue, size: 14),
                const SizedBox(width: 4),
                Text('${ad['likes']} आवडले', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                const Spacer(),
                Text('${ad['comments']} comments', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
              ],
            ),
          ),
          const Divider(height: 1),
          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.thumb_up_outlined, size: 16, color: AppColors.textLight),
                    label: const Text('आवडले', style: TextStyle(color: AppColors.textLight, fontSize: 12)),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.chat_bubble_outline, size: 16, color: AppColors.textLight),
                    label: const Text('Comment', style: TextStyle(color: AppColors.textLight, fontSize: 12)),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share_outlined, size: 16, color: AppColors.textLight),
                    label: const Text('Share', style: TextStyle(color: AppColors.textLight, fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.compact ? 320 : 360,
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
      ],
    );
  }
}
