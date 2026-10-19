class ListingField {
  final String key;
  final String label;
  final bool multiline;
  final bool number;
  final bool required;
  final bool media;
  const ListingField(
    this.key,
    this.label, {
    this.multiline = false,
    this.number = false,
    this.required = true,
    this.media = false,
  });
}

class ListingData {
  static const int fee = 50;
  static const int days = 30;
  static const int maxWords = 500;

  static const Map<String, String> typeName = {
    'resale': 'Resale',
    'rent': 'Rent',
    'job': 'Job',
  };

  static const Map<String, List<ListingField>> fields = {
    'resale': [
      ListingField('item', 'कोणती वस्तू विकायची'),
      ListingField('keywords', 'Keywords (स्वल्पविरामाने वेगळे)'),
      ListingField('media', 'फोटो / व्हिडिओ', media: true, required: false),
      ListingField('price', 'वस्तूची किंमत (₹)', number: true),
      ListingField('where', 'ती वस्तू कुठे आहे'),
      ListingField('detail', 'वस्तूबद्दल सविस्तर माहिती (500 शब्द)',
          multiline: true),
      ListingField('contact', 'कोणाशी संपर्क करायचा (नाव / नंबर)'),
    ],
    'rent': [
      ListingField('item', 'कोणती वस्तू रेंट ने द्यायची'),
      ListingField('keywords', 'Keywords (स्वल्पविरामाने वेगळे)'),
      ListingField('media', 'फोटो / व्हिडिओ', media: true, required: false),
      ListingField('price', 'भाडे / रेंट किती आहे (₹)', number: true),
      ListingField('where', 'ती वस्तू कुठे आहे'),
      ListingField('detail', 'वस्तूबद्दल सविस्तर माहिती (500 शब्द)',
          multiline: true),
      ListingField('contact', 'कोणाशी संपर्क करायचा (नाव / नंबर)'),
    ],
    'job': [
      ListingField('company', 'कोणत्या कंपनीमध्ये जॉब आहे'),
      ListingField('vacancies', 'किती वेकेन्सी आहेत', number: true),
      ListingField('detail', 'जॉब बद्दल माहिती (500 शब्द)', multiline: true),
      ListingField('keywords', 'Keywords (स्वल्पविरामाने वेगळे)'),
      ListingField('education', 'शैक्षणिक आवश्यकता काय'),
      ListingField('skills', 'कुठले स्किल पाहिजे'),
      ListingField('age', 'वयाची अट काय'),
      ListingField('other', 'अन्य काही रिक्वायरमेंट', required: false),
      ListingField('salary', 'पगार किती आहे'),
      ListingField('hours', 'जॉब किती वेळ आहे'),
      ListingField('where', 'जॉब चे लोकेशन काय आहे'),
      ListingField('contact', 'संपर्क कोणाला करायचा'),
      ListingField('experience', 'अनुभव काय पाहिजे'),
    ],
  };
}

// Demo डेटा. खरा डेटा Stage 3 मध्ये येईल.
// owner: 'me' = या वापरकर्त्याची पोस्ट. postedAt पासून 30 दिवस सार्वजनिक.
class ListingStore {
  static int _next = 100;

  static final List<Map<String, dynamic>> posts = [
    {
      'id': 'L1',
      'type': 'resale',
      'owner': 'other',
      'postedAt': DateTime.now().subtract(const Duration(days: 4)),
      'media': 3,
      'values': {
        'item': 'जुनी सायकल (Hero)',
        'keywords': 'सायकल, cycle, hero',
        'price': '2500',
        'where': 'हडपसर, पुणे',
        'detail': 'दोन वर्ष वापरलेली सायकल, चांगल्या स्थितीत.',
        'contact': 'सुरेश 9811100001',
      },
    },
    {
      'id': 'L2',
      'type': 'resale',
      'owner': 'other',
      'postedAt': DateTime.now().subtract(const Duration(days: 12)),
      'media': 2,
      'values': {
        'item': 'सोफा सेट 3+1+1',
        'keywords': 'सोफा, furniture, sofa',
        'price': '12000',
        'where': 'मगरपट्टा, पुणे',
        'detail': 'फक्त एक वर्ष वापरलेला, कव्हर नवीन आहेत.',
        'contact': 'मनीषा 9811100002',
      },
    },
    {
      'id': 'L3',
      'type': 'resale',
      'owner': 'other',
      'postedAt': DateTime.now().subtract(const Duration(days: 31)),
      'media': 1,
      'values': {
        'item': 'जुना टीव्ही (मुदत संपलेली पोस्ट)',
        'keywords': 'tv',
        'price': '3000',
        'where': 'पुणे',
        'detail': 'ही पोस्ट 30 दिवसांनंतर गायब होते, म्हणून दिसू नये.',
        'contact': 'राजू 9811100003',
      },
    },
    {
      'id': 'L4',
      'type': 'rent',
      'owner': 'other',
      'postedAt': DateTime.now().subtract(const Duration(days: 2)),
      'media': 2,
      'values': {
        'item': 'मंडप आणि खुर्च्या (कार्यक्रमासाठी)',
        'keywords': 'मंडप, खुर्ची, tent, कार्यक्रम',
        'price': '1500 प्रति दिवस',
        'where': 'फुरसुंगी, पुणे',
        'detail': '100 खुर्च्या आणि मोठा मंडप भाड्याने उपलब्ध.',
        'contact': 'गणेश 9811100004',
      },
    },
    {
      'id': 'L5',
      'type': 'rent',
      'owner': 'other',
      'postedAt': DateTime.now().subtract(const Duration(days: 9)),
      'media': 1,
      'values': {
        'item': 'ड्रिल मशीन आणि टूल किट',
        'keywords': 'ड्रिल, tool, drill',
        'price': '200 प्रति दिवस',
        'where': 'हडपसर, पुणे',
        'detail': 'घरगुती कामासाठी भाड्याने मिळेल.',
        'contact': 'विनोद 9811100005',
      },
    },
    {
      'id': 'L6',
      'type': 'job',
      'owner': 'other',
      'postedAt': DateTime.now().subtract(const Duration(days: 3)),
      'media': 0,
      'values': {
        'company': 'श्री गणेश किराणा मार्ट',
        'vacancies': '2',
        'detail': 'दुकानात काउंटर आणि स्टॉक सांभाळण्यासाठी माणूस हवा.',
        'keywords': 'दुकान, helper, किराणा',
        'education': '10 वी पास',
        'skills': 'हिशोब, ग्राहक सेवा',
        'age': '20 ते 35',
        'other': '',
        'salary': '₹12,000 ते 15,000',
        'hours': 'पूर्ण वेळ, 9 ते 8',
        'where': 'हडपसर, पुणे',
        'contact': 'गणेश 9811100006',
        'experience': '1 वर्ष',
      },
    },
    {
      'id': 'L7',
      'type': 'job',
      'owner': 'other',
      'postedAt': DateTime.now().subtract(const Duration(days: 10)),
      'media': 0,
      'values': {
        'company': 'स्वाद हॉटेल',
        'vacancies': '3',
        'detail': 'स्वयंपाकी मदतनीस आणि वेटर हवेत.',
        'keywords': 'हॉटेल, cook, waiter',
        'education': 'शिक्षणाची अट नाही',
        'skills': 'स्वयंपाकाची आवड',
        'age': '18 ते 40',
        'other': '',
        'salary': '₹10,000 ते 14,000',
        'hours': 'पूर्ण वेळ',
        'where': 'हडपसर, पुणे',
        'contact': 'स्वाद हॉटेल 9811100007',
        'experience': 'फ्रेशर चालेल',
      },
    },
  ];

  static int daysLeft(Map<String, dynamic> p) =>
      ListingData.days -
      DateTime.now().difference(p['postedAt'] as DateTime).inDays;

  // 30 दिवसांनंतरच्या पोस्ट आपोआप दिसत नाहीत (auto delete)
  static List<Map<String, dynamic>> active(String type) {
    final list = posts
        .where((p) => p['type'] == type && daysLeft(p) > 0)
        .toList();
    list.sort((a, b) =>
        (b['postedAt'] as DateTime).compareTo(a['postedAt'] as DateTime));
    return list;
  }

  static List<Map<String, dynamic>> mine(List<String> types) {
    final list = posts
        .where((p) =>
            p['owner'] == 'me' &&
            types.contains(p['type']) &&
            daysLeft(p) > 0)
        .toList();
    list.sort((a, b) =>
        (b['postedAt'] as DateTime).compareTo(a['postedAt'] as DateTime));
    return list;
  }

  static String title(Map<String, dynamic> p) {
    final v = p['values'] as Map;
    return (p['type'] == 'job' ? v['company'] : v['item']) as String? ?? '';
  }

  static String subtitle(Map<String, dynamic> p) {
    final v = p['values'] as Map;
    if (p['type'] == 'job') {
      return '${v['salary']} · ${v['where']}';
    }
    final price = '${v['price']}';
    final shown = price.contains(RegExp(r'[^0-9]')) ? price : '₹$price';
    return '$shown · ${v['where']}';
  }

  static void add(String type, Map<String, String> values, int media) {
    _next += 1;
    posts.add({
      'id': 'L$_next',
      'type': type,
      'owner': 'me',
      'postedAt': DateTime.now(),
      'media': media,
      'values': Map<String, String>.from(values),
    });
  }

  static void update(
      Map<String, dynamic> post, Map<String, String> values, int media) {
    post['values'] = Map<String, String>.from(values);
    post['media'] = media;
  }

  static void remove(String id) {
    posts.removeWhere((p) => p['id'] == id);
  }
}