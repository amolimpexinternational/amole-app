import 'package:flutter/material.dart';
import '../models/ad_model.dart';

/// सर्व जाहिरातींचा शेअर्ड डेटा — सध्या local list.
/// TODO (Stage 3 - Backend): Firestore collection 'advertisements' मधून आणणे.
class AdsData {
  static final List<AdModel> ads = [
    AdModel(
      id: 'ad1',
      sellerName: 'श्री गणेश किराणा',
      category: 'किराणा',
      location: 'हडपसर, पुणे',
      type: 'photo',
      title: 'दिवाळी धमाका ऑफर!',
      desc: 'सर्व किराणा मालावर 20% सूट — फक्त आजपुरता!',
      avatar: 'G',
      avatarColor: Colors.orange,
      bgColor1: const Color(0xFFFF6B35),
      bgColor2: const Color(0xFFFF8F00),
      pollQuestion: 'तुम्हाला किराणा सामानावर सूट आवडते का?',
      likes: 128,
      comments: 24,
      budget: 500,
      incomeGenerated: 500,
      status: AdStatus.live,
      createdBy: 'Franchise - हडपसर',
    ),
    AdModel(
      id: 'ad2',
      sellerName: 'राज इलेक्ट्रॉनिक्स',
      category: 'इलेक्ट्रॉनिक्स',
      location: 'कोंढवा, पुणे',
      type: 'video',
      title: 'नवीन Mobile आला!',
      desc: 'Samsung Galaxy A55 — Rs.32,999 मध्ये. EMI उपलब्ध.',
      avatar: 'R',
      avatarColor: Colors.blue,
      bgColor1: const Color(0xFF1565C0),
      bgColor2: const Color(0xFF00E5FF),
      tag: 'Ad',
      pollQuestion: 'तुम्ही नवीन मोबाईल खरेदी करण्यास इंटरेस्टेड आहात का?',
      likes: 256,
      comments: 48,
      budget: 1200,
      incomeGenerated: 1200,
      status: AdStatus.live,
      createdBy: 'admin',
    ),
    AdModel(
      id: 'ad3',
      sellerName: 'स्वाद हॉटेल',
      category: 'खाद्यपदार्थ',
      location: 'वानवडी, पुणे',
      type: 'photo',
      title: 'जेवण घरपोच!',
      desc: 'ताजे, घरगुती जेवण — Rs.80 पासून. Free Delivery Rs.200 वर.',
      avatar: 'S',
      avatarColor: Colors.green,
      bgColor1: const Color(0xFF2E7D32),
      bgColor2: const Color(0xFF66BB6A),
      pollQuestion: 'तुम्ही घरपोच जेवण मागवण्यास इंटरेस्टेड आहात का?',
      likes: 89,
      comments: 15,
      budget: 300,
      durationDays: 5,
      incomeGenerated: 300,
      status: AdStatus.live,
      createdBy: 'Franchise - वानवडी',
    ),
  ];

  static List<AdModel> get liveAds => ads.where((a) => a.status == AdStatus.live).toList();

  static double get totalLiveIncome => liveAds.fold(0.0, (sum, a) => sum + a.incomeGenerated);
}
