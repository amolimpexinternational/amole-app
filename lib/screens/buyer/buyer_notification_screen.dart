import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class BuyerNotificationScreen extends StatelessWidget {
  const BuyerNotificationScreen({super.key});

  // TODO (Stage 3 - Backend): replace with real data from Firestore
  // (collection: buyer_notifications, filtered by buyerId, ordered by time desc)
  static final List<Map<String, dynamic>> _notifications = [
    {
      'category': 'reward',
      'icon': Icons.stars_outlined,
      'color': AppColors.primaryOrange,
      'title': 'Reward Points मिळाले!',
      'desc': 'श्री गणेश किराणा खरेदीवर तुम्हाला Points मिळाले',
      'time': '10 मिनिटांपूर्वी',
    },
    {
      'category': 'order',
      'icon': Icons.local_shipping_outlined,
      'color': AppColors.primaryBlue,
      'title': 'ऑर्डर अपडेट',
      'desc': 'तुमची ऑर्डर #AM-ORD-009 डिलिव्हरीसाठी निघाली आहे',
      'time': '1 तासापूर्वी',
    },
    {
      'category': 'seller_message',
      'icon': Icons.storefront_outlined,
      'color': Colors.teal,
      'title': 'राज इलेक्ट्रॉनिक्स कडून मेसेज',
      'desc': 'तुमच्या चौकशीला उत्तर मिळालं आहे',
      'time': '2 तासांपूर्वी',
    },
    {
      'category': 'social',
      'icon': Icons.thumb_up_outlined,
      'color': Colors.indigo,
      'title': 'तुमच्या पोस्टला Like मिळाले',
      'desc': 'सुनिता पाटील आणि 3 इतरांनी तुमची पोस्ट Like केली',
      'time': '3 तासांपूर्वी',
    },
    {
      'category': 'friend',
      'icon': Icons.people_outline,
      'color': Colors.purple,
      'title': 'मित्राचा मेसेज',
      'desc': 'अनिल जोशी: "कोणाला चांगला इलेक्ट्रिशियन माहिती आहे का?"',
      'time': 'काल',
    },
    {
      'category': 'app',
      'icon': Icons.campaign_outlined,
      'color': Colors.deepOrange,
      'title': 'AMOLE कडून सूचना',
      'desc': 'नवीन Lucky Draw आजपासून सुरू — दररोज संध्याकाळी ४ वाजता निकाल',
      'time': 'काल',
    },
    {
      'category': 'franchise_message',
      'icon': Icons.business_outlined,
      'color': Colors.brown,
      'title': 'Franchise कडून मेसेज',
      'desc': 'तुमच्या परिसरात नवीन दुकाने जोडली गेली आहेत',
      'time': '2 दिवसांपूर्वी',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('सूचना'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.notifications_none_outlined, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text('सध्या कोणतीही सूचना नाही', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final n = _notifications[index];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: (n['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(n['icon'] as IconData, color: n['color'] as Color, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(n['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                            const SizedBox(height: 3),
                            Text(n['desc'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                            const SizedBox(height: 4),
                            Text(n['time'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
