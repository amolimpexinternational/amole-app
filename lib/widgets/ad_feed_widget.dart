import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../data/local_posts_data.dart';
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

  // बायरसाठी टॅब क्रम: 0 = लोकल कनेक्ट, 1 = जाहिराती, 2 = My Offers, 3 = Most Viral
  // सेलरसाठी: 0 = जाहिराती, 1 = Create Offer
  int get _adsTabIndex => widget.isSeller ? 0 : 1;
  int get _offersTabIndex => widget.isSeller ? 1 : 2;
  int get _viralTabIndex => 3;
  bool get _hasLocalConnect => !widget.isSeller;
  bool get _hasViralTab => !widget.isSeller;

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
    {
      'seller': 'स्वाद हॉटेल',
      'category': 'खाद्यपदार्थ',
      'location': 'वानवडी, पुणे',
      'avatar': 'S',
      'avatarColor': Colors.green,
      'type': 'photo',
      'title': 'जेवण घरपोच!',
      'desc': 'ताजे, घरगुती जेवण — Rs.80 पासून. Free Delivery Rs.200 वर.',
      'bgColor1': const Color(0xFF2E7D32),
      'bgColor2': const Color(0xFF66BB6A),
      'likes': '89',
      'comments': '15',
      'tag': 'Sponsored',
      'pollQuestion': 'तुम्ही घरपोच जेवण मागवण्यास इंटरेस्टेड आहात का?',
    },
    {
      'seller': 'फॅशन पॉईंट',
      'category': 'कपडे',
      'location': 'मगरपट्टा, पुणे',
      'avatar': 'F',
      'avatarColor': Colors.pink,
      'type': 'photo',
      'title': 'नवीन Collection आली!',
      'desc': 'Ladies & Gents कपडे — Buy 2 Get 1 Free. आजच या!',
      'bgColor1': const Color(0xFFAD1457),
      'bgColor2': const Color(0xFFEC407A),
      'likes': '312',
      'comments': '67',
      'tag': 'Ad',
      'pollQuestion': 'तुम्ही या जाहिरातीत इंटरेस्टेड आहात का?',
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
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _pageController.hasClients && _selectedTab == _adsTabIndex) {
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

  // फेसबुक-स्टाईल रंगीत टेक्स्ट-स्टेटस पार्श्वभूमी (मजकूर पोस्टसाठी)
  static const List<List<Color>> _textStatusGradients = [
    [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
    [Color(0xFFFF512F), Color(0xFFDD2476)],
    [Color(0xFF11998E), Color(0xFF38EF7D)],
    [Color(0xFF2193B0), Color(0xFF6DD5ED)],
    [Color(0xFFEE9CA7), Color(0xFFFFDDE1)],
  ];

  List<Color> _gradientFor(String postId) =>
      _textStatusGradients[postId.hashCode.abs() % _textStatusGradients.length];

  void _toggleLike(LocalPost post) {
    setState(() {
      post.likedByMe = !post.likedByMe;
      post.likes += post.likedByMe ? 1 : -1;
    });
  }

  void _addComment(LocalPost post) {
    final controller = TextEditingController();
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
            const Text('Comment लिहा', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'तुमची प्रतिक्रिया लिहा...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    if (controller.text.trim().isEmpty) return;
                    setState(() => post.comments += 1);
                    Navigator.pop(ctx);
                  },
                  icon: const Icon(Icons.send, color: AppColors.primaryBlue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _sharePost(LocalPost post) {
    setState(() => post.shares += 1);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('पोस्ट Share झाली!'), backgroundColor: Colors.green),
    );
  }

  Widget _buildFeedPostCard(LocalPost post) {
    final grad = _gradientFor(post.id);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))],
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
                  backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                  child: Text(post.authorName.isNotEmpty ? post.authorName[0] : '?',
                      style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.authorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                      Text(post.timeLabel, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                    ],
                  ),
                ),
                if (post.isViral)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: Colors.deepOrange.shade50, borderRadius: BorderRadius.circular(20)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 14),
                        SizedBox(width: 2),
                        Text('Viral', style: TextStyle(color: Colors.deepOrange, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // मोठा, आकर्षक मीडिया विभाग — जाहिरातींसारखा
          if (post.mediaType == PostMediaType.text)
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 160),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: grad, begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Center(
                child: Text(
                  post.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3),
                ),
              ),
            )
          else
            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: grad, begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          post.mediaType == PostMediaType.video ? Icons.play_circle_filled : Icons.image_outlined,
                          color: Colors.white.withValues(alpha: 0.35),
                          size: 64,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            post.text,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (post.mediaType == PostMediaType.video)
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

          if (post.isViral)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Row(
                children: [
                  const Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 14),
                  const SizedBox(width: 4),
                  Text('${post.responsePoints} Response Points', style: const TextStyle(fontSize: 11, color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

          const Divider(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _toggleLike(post),
                    icon: Icon(
                      post.likedByMe ? Icons.thumb_up : Icons.thumb_up_outlined,
                      size: 16,
                      color: post.likedByMe ? AppColors.primaryBlue : AppColors.textLight,
                    ),
                    label: Text('${post.likes}', style: TextStyle(color: post.likedByMe ? AppColors.primaryBlue : AppColors.textLight, fontSize: 12, fontWeight: post.likedByMe ? FontWeight.bold : FontWeight.normal)),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _addComment(post),
                    icon: const Icon(Icons.chat_bubble_outline, size: 16, color: AppColors.textLight),
                    label: Text('${post.comments}', style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _sharePost(post),
                    icon: const Icon(Icons.share_outlined, size: 16, color: AppColors.textLight),
                    label: Text('${post.shares}', style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildLocalConnectTab() {
    final posts = List<LocalPost>.from(LocalPostsData.posts)
      ..sort((a, b) => b.postedAt.compareTo(a.postedAt));
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: posts.length,
      itemBuilder: (context, index) => _buildFeedPostCard(posts[index]),
    );
  }

  Widget _buildMostViralTab() {
    final viral = LocalPostsData.viralPosts;
    if (viral.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.local_fire_department_outlined, size: 48, color: Colors.grey.shade300),
            const SizedBox(height: 10),
            const Text('सध्या कोणतीही Viral पोस्ट नाही', style: TextStyle(color: AppColors.textLight, fontSize: 13)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: viral.length,
      itemBuilder: (context, index) => _buildFeedPostCard(viral[index]),
    );
  }

  // Blueprint 6.8: poll-reply cost split
  // Blueprint 6.8: poll-reply cost split — replier gets 35% of cost per reply.
  double _pollRewardFor(Map<String, dynamic> ad) {
    switch (ad['type']) {
      case 'video':
        return 0.175;
      case 'photo':
        return 0.0875;
      default:
        return 0.035;
    }
  }

  Widget _buildPollSection(Map<String, dynamic> ad) {
    final bool answered = ad['pollAnswer'] != null;
    final String question = ad['pollQuestion'] ?? 'तुम्ही या जाहिरातीत इंटरेस्टेड आहात का?';

    void answer(bool yes) {
      setState(() => ad['pollAnswer'] = yes);
      final reward = _pollRewardFor(ad);
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
    final double mediaHeight = widget.compact ? 180 : (widget.isSeller ? 220 : 220);
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
                          color: Colors.white.withValues(alpha: 0.3),
                          size: 60,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(ad['title'],
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),
                        const SizedBox(height: 6),
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
            _buildPollSection(ad),
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
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6)]),
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = widget.isSeller
        ? ['📢 जाहिराती', '🎯 Create Offer']
        : ['🧑‍🤝‍🧑 लोकल कनेक्ट', '📢 जाहिराती', '🎁 My Offers', '🔥 Most Viral'];

    final double feedHeight = widget.compact ? 340 : (widget.isSeller ? 400 : 440);
    // Poll विभागामुळे जाहिरात कार्ड उंच झालं आहे — ads टॅबसाठी जास्त उंची
    final double adsFeedHeight = widget.compact ? 460 : (widget.isSeller ? 440 : 560);

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
                        fontSize: 11,
                      )),
                ),
              ),
            )),
          ),
        ),
        const SizedBox(height: 8),
        if (_hasLocalConnect && _selectedTab == 0) ...[
          SizedBox(height: feedHeight, child: _buildLocalConnectTab()),
        ] else if (_selectedTab == _adsTabIndex) ...[
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
        ] else if (_selectedTab == _offersTabIndex && !widget.isSeller)
          SizedBox(height: feedHeight, child: _buildMyOffersTab())
        else if (_selectedTab == _offersTabIndex && widget.isSeller)
          SizedBox(height: 420, child: _buildCreateOfferTab(context))
        else if (_hasViralTab && _selectedTab == _viralTabIndex)
          SizedBox(height: feedHeight, child: _buildMostViralTab()),
      ],
    );
  }
}
