/// Local Connect / Social Feed चा सामायिक डेटा — My Wall आणि
/// Ad Feed च्या "लोकल कनेक्ट" व "Most Viral" टॅबसाठी वापरला जातो.
/// (Blueprint प्रकरण ४.१०)
///
/// TODO (Stage 3 - Backend): Firestore collection 'wall_posts' मधून
/// प्रत्यक्ष डेटा आणणे, ७ दिवसांनी auto-delete (५,००० response points
/// मिळाल्यास ४८ तास मुदतवाढ, नंतर प्रत्येक १,००० पॉईंट्समागे आणखी ४८ तास).
library;

enum PostMediaType { text, photo, video }

class LocalPost {
  final String id;
  final String authorName;
  final DateTime postedAt;
  final String text;
  final PostMediaType mediaType;
  int likes;
  int comments;
  int shares;
  bool likedByMe;

  LocalPost({
    required this.id,
    required this.authorName,
    required this.postedAt,
    required this.text,
    this.mediaType = PostMediaType.text,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.likedByMe = false,
  });

  /// Response Points = Like×1 + Comment×2 + Share×3 (Blueprint ४.१०)
  int get responsePoints => (likes * 1) + (comments * 2) + (shares * 3);

  /// "Most Viral" टॅबसाठी निकष — ३०० पेक्षा जास्त Response Points
  bool get isViral => responsePoints > 300;

  String get timeLabel {
    final diff = DateTime.now().difference(postedAt);
    if (diff.inMinutes < 60) return '${diff.inMinutes} मिनिटांपूर्वी';
    if (diff.inHours < 24) return '${diff.inHours} तासांपूर्वी';
    return '${diff.inDays} दिवसांपूर्वी';
  }
}

class LocalPostsData {
  // सर्वात नवीन पोस्ट यादीत सर्वात आधी (index 0) — Facebook-प्रकारे फीड.
  static final List<LocalPost> posts = [
    LocalPost(
      id: 'p1',
      authorName: 'सुनिता पाटील',
      postedAt: DateTime.now().subtract(const Duration(minutes: 20)),
      text: 'कोणाला चांगला इलेक्ट्रिशियन माहिती आहे का? घरी काम आहे.',
      mediaType: PostMediaType.text,
      likes: 12,
      comments: 3,
      shares: 1,
    ),
    LocalPost(
      id: 'p2',
      authorName: 'राहुल शिंदे',
      postedAt: DateTime.now().subtract(const Duration(hours: 2)),
      text: 'आज स्थानिक बाजारात ताजी भाजी मिळाली, खूप छान दर्जा!',
      mediaType: PostMediaType.photo,
      likes: 145,
      comments: 22,
      shares: 18,
    ),
    LocalPost(
      id: 'p3',
      authorName: 'AMOLE Admin',
      postedAt: DateTime.now().subtract(const Duration(hours: 5)),
      text: 'या आठवड्यात आपल्या जिल्ह्यात नवीन ३ Sellers जोडले गेले — त्यांना भेट द्या!',
      mediaType: PostMediaType.video,
      likes: 320,
      comments: 40,
      shares: 55,
    ),
    LocalPost(
      id: 'p4',
      authorName: 'प्रिया देशमुख',
      postedAt: DateTime.now().subtract(const Duration(hours: 20)),
      text: 'AMOLE मुळे माझ्या परिसरातल्या दुकानांची माहिती मिळाली, खूप उपयोगी App आहे.',
      mediaType: PostMediaType.text,
      likes: 34,
      comments: 6,
      shares: 2,
    ),
    LocalPost(
      id: 'p5',
      authorName: 'स्थानिक बातमी',
      postedAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      text: 'उद्या परिसरातील बाजारपेठेत वीज दुरुस्तीचं काम आहे — सकाळी ११ ते दुपारी २.',
      mediaType: PostMediaType.text,
      likes: 8,
      comments: 1,
      shares: 0,
    ),
  ];

  static List<LocalPost> get viralPosts {
    final list = posts.where((p) => p.isViral).toList();
    list.sort((a, b) => b.responsePoints.compareTo(a.responsePoints));
    return list;
  }
}
