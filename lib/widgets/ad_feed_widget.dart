import 'package:flutter/material.dart';
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

  final List<Map<String, dynamic>> _ads = [
    {
      'seller': 'श्री गणेश किराणा', 'location': 'हडपसर, पुणे', 'category': 'किराणा',
      'avatar': 'G', 'avatarColor': Colors.orange, 'type': 'photo',
      'title': 'दिवाळी धमाका ऑफर!', 'desc': 'सर्व किराणा मालावर 20% सूट — फक्त आजपुरता!',
      'bgColor1': const Color(0xFFFF6B35), 'bgColor2': const Color(0xFFFF8F00),
      'likes': '128', 'comments': '24', 'tag': 'Sponsored',
      'pollQuestion': 'ही ऑफर तुम्हाला आवडली का?', 'pollAnswer': null,
    },
    {
      'seller': 'राज इलेक्ट्रॉनिक्स', 'location': 'कोंढवा, पुणे', 'category': 'इलेक्ट्रॉनिक्स',
      'avatar': 'R', 'avatarColor': Colors.blue, 'type': 'video',
      'title': 'नवीन Mobile आला!', 'desc': 'Samsung Galaxy A55 — Rs.32,999 मध्ये. EMI उपलब्ध.',
      'bgColor1': const Color(0xFF1565C0), 'bgColor2': const Color(0xFF00E5FF),
      'likes': '256', 'comments': '48', 'tag': 'Ad',
      'pollQuestion': 'तुम्हाला हा मोबाईल खरेदी करायला आवडेल का?', 'pollAnswer': null,
    },
    {
      'seller': 'स्वाद हॉटेल', 'location': 'वानवडी, पुणे', 'category': 'खाद्यपदार्थ',
      'avatar': 'S', 'avatarColor': Colors.green, 'type': 'photo',
      'title': 'जेवण घरपोच!', 'desc': 'ताजे, घरगुती जेवण — Rs.80 पासून. Free Delivery Rs.200 वर.',
      'bgColor1': const Color(0xFF2E7D32), 'bgColor2': const Color(0xFF66BB6A),
      'likes': '89', 'comments': '15', 'tag': 'Sponsored',
      'pollQuestion': 'तुम्ही घरपोच जेवण मागवता का?', 'pollAnswer': null,
    },
    {
      'seller': 'फॅशन पॉईंट', 'location': 'मगरपट्टा, पुणे', 'category': 'कपडे',
      'avatar': 'F', 'avatarColor': Colors.pink, 'type': 'photo',
      'title': 'नवीन Collection आली!', 'desc': 'Ladies & Gents कपडे — Buy 2 Get 1 Free. आजच या!',
      'bgColor1': const Color(0xFFAD1457), 'bgColor2': const Color(0xFFEC407A),
      'likes': '312', 'comments': '67', 'tag': 'Ad',
      'pollQuestion': 'तुम्हाला ही Offer आवडली का?', 'pollAnswer': null,
    },
  ];

  final List<Map<String, dynamic>> _myOffers = [
    {'title': 'किराणा 10% Off', 'seller': 'श्री गणेश किराणा', 'validity': '31 July पर्यंत', 'color': Colors.orange, 'saved': false},
    {'title': 'Free Delivery', 'seller': 'स्वाद हॉटेल', 'validity': 'आठवडाभर', 'color': Colors.green, 'saved': false},
    {'title': 'Mobile Cashback Rs.500', 'seller': 'राज इलेक्ट्रॉनिक्स', 'validity': '5 Aug पर्यंत', 'color': Colors.blue, 'saved': false},
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _pageController.hasClients && _selectedTab == 0) {
        final next = (_currentPage + 1) % _ads.length;
        _pageController.animateToPage(next, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
        setState(() => _currentPage = next);
      }
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _answerPoll(Map<String, dynamic> ad, bool answer) {
    setState(() => ad['pollAnswer'] = answer);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('धन्यवाद! उत्तरासाठी तुम्हाला Reward Points मिळाले 🎉'), backgroundColor: Colors.green),
    );
  }

  void _openSellerPortal(Map<String, dynamic> ad) {
    if (widget.isSeller) return;
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => SellerProfileScreen(sellerName: ad['seller'] as String, category: ad['category'] as String),
    ));
  }

  Widget _buildPollSection(Map<String, dynamic> ad) {
    final bool? answered = ad['pollAnswer'] as bool?;
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.06), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ad['pollQuestion'] as String, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 8),
          if (answered == null)
            Row(children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _answerPoll(ad, true),
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 6)),
                  child: const Text('होय 👍', style: TextStyle(fontSize: 12)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _answerPoll(ad, false),
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 6)),
                  child: const Text('नाही 👎', style: TextStyle(fontSize: 12)),
                ),
              ),
            ])
          else
            Row(children: [
              const Icon(Icons.check_circle, color: AppColors.successGreen, size: 16),
              const SizedBox(width: 6),
              Text('तुम्ही उत्तर दिलं: ${answered ? "होय" : "नाही"}', style: const TextStyle(fontSize: 12, color: AppColors.successGreen)),
            ]),
        ],
      ),
    );
  }

  Widget _buildAdCard(Map<String, dynamic> ad) {
    final double mediaHeight = widget.compact ? 180 : 220;
    return GestureDetector(
      onTap: () => _openSellerPortal(ad),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))],
        ),
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
                  const Icon(Icons.more_horiz, color: AppColors.textLight),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: mediaHeight,
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
                          size: 70,
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(ad['title'],
                              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(ad['desc'],
                              style: const TextStyle(color: Colors.white, fontSize: 13),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        setState(() {
                          final current = int.tryParse(ad['likes'].replaceAll(',', '')) ?? 0;
                          ad['liked'] = !(ad['liked'] ?? false);
                          ad['likes'] = ad['liked'] ? (current + 1).toString() : (current - 1).toString();
                        });
                      },
                      icon: Icon(
                        (ad['liked'] ?? false) ? Icons.thumb_up : Icons.thumb_up_outlined,
                        size: 16,
                        color: (ad['liked'] ?? false) ? AppColors.primaryBlue : AppColors.textLight,
                      ),
                      label: Text(
                        'आवडले',
                        style: TextStyle(
                          color: (ad['liked'] ?? false) ? AppColors.primaryBlue : AppColors.textLight,
                          fontSize: 12,
                          fontWeight: (ad['liked'] ?? false) ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        final commentController = TextEditingController();
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                          builder: (ctx) => Padding(
                            padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Comments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                                  ],
                                ),
                                const Divider(),
                                const ListTile(
                                  leading: CircleAvatar(child: Text('A')),
                                  title: Text('अनिल जोशी'),
                                  subtitle: Text('खूप छान ऑफर आहे!'),
                                ),
                                const ListTile(
                                  leading: CircleAvatar(child: Text('S')),
                                  title: Text('संगीता राणे'),
                                  subtitle: Text('किंमत योग्य आहे.'),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: commentController,
                                        decoration: InputDecoration(
                                          hintText: 'Comment लिहा...',
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      onPressed: () {
                                        if (commentController.text.isNotEmpty) {
                                          Navigator.pop(ctx);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Comment पाठवला!'), backgroundColor: Colors.green),
                                          );
                                        }
                                      },
                                      icon: const Icon(Icons.send, color: AppColors.primaryBlue),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.chat_bubble_outline, size: 16, color: AppColors.textLight),
                      label: const Text('टिप्पणी', style: TextStyle(color: AppColors.textLight, fontSize: 12)),
                    ),
                  ),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Share करा'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.chat, color: Colors.green),
                                  title: const Text('WhatsApp'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('WhatsApp वर Share होत आहे...')));
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.copy, color: AppColors.primaryBlue),
                                  title: const Text('Link Copy करा'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link Copy झाली!'), backgroundColor: Colors.green));
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.share_outlined, size: 16, color: AppColors.textLight),
                      label: const Text('Share', style: TextStyle(color: AppColors.textLight, fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
            if (!widget.isSeller) _buildPollSection(ad),
          ],
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
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: (offer['color'] as Color).withOpacity(0.3)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
          ),
          child: Row(
            children: [
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(
                  color: (offer['color'] as Color).withOpacity(0.15),
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
              ElevatedButton(
                onPressed: () => setState(() => _myOffers[index]['saved'] = !_myOffers[index]['saved']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: offer['saved'] ? Colors.grey : offer['color'] as Color,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(offer['saved'] ? 'Saved' : 'Save', style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCreateOfferTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('नवीन Offer तयार करा', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              const SizedBox(height: 16),
              const TextField(decoration: InputDecoration(labelText: 'Offer Title', hintText: 'उदा. दिवाळी 20% सूट', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              const TextField(decoration: InputDecoration(labelText: 'Discount %', hintText: '10', border: OutlineInputBorder()), keyboardType: TextInputType.number),
              const SizedBox(height: 12),
              const TextField(decoration: InputDecoration(labelText: 'Validity (दिवस)', hintText: '7', border: OutlineInputBorder()), keyboardType: TextInputType.number),
              const SizedBox(height: 12),
              const TextField(decoration: InputDecoration(labelText: 'Description', hintText: 'Offer बद्दल सांगा...', border: OutlineInputBorder()), maxLines: 3),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.primaryOrange.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = widget.isSeller
        ? ['📢 जाहिराती', '🎯 Create Offer']
        : ['📢 जाहिराती', '🎁 My Offers'];

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: List.generate(tabs.length, (i) => Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedTab = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: _selectedTab == i ? AppColors.primaryBlue : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(tabs[i], textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _selectedTab == i ? Colors.white : AppColors.textLight,
                        fontWeight: _selectedTab == i ? FontWeight.bold : FontWeight.normal,
                        fontSize: 13,
                      )),
                ),
              ),
            )),
          ),
        ),
        const SizedBox(height: 8),
        if (_selectedTab == 0) ...[
          SizedBox(
            height: widget.compact ? 420 : 480,
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
        ] else if (_selectedTab == 1 && !widget.isSeller)
          SizedBox(height: 340, child: _buildMyOffersTab())
        else if (_selectedTab == 1 && widget.isSeller)
          SizedBox(height: 420, child: _buildCreateOfferTab(context)),
      ],
    );
  }
}
