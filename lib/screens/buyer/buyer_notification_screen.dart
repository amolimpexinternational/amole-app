import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/buyer_social_data.dart';
import '../../models/notification_model.dart';
import '../../widgets/notification_list_view.dart';
import 'reward_wallet_screen.dart';
import 'order_tracking_screen.dart';
import 'my_wall_screen.dart';

class BuyerNotificationScreen extends StatefulWidget {
  const BuyerNotificationScreen({super.key});

  @override
  State<BuyerNotificationScreen> createState() =>
      _BuyerNotificationScreenState();
}

class _BuyerNotificationScreenState extends State<BuyerNotificationScreen> {
  // === डमी सेलर मेसेज (वन-वे) ===
  final List<Map<String, dynamic>> _sellerMessages = [
    {
      'seller': 'श्री गणेश किराणा',
      'message': 'नमस्कार! आमच्याकडे नवीन सुकामेवा आला आहे. 10% सूट मिळवा!',
      'time': '10 मिनिटांपूर्वी',
      'icon': Icons.storefront,
      'color': Colors.teal,
    },
    {
      'seller': 'राज इलेक्ट्रॉनिक्स',
      'message': 'तुमच्या ऑर्डरची डिलिव्हरी उद्या होईल. कृपया घरी असा.',
      'time': '2 तासांपूर्वी',
      'icon': Icons.electrical_services,
      'color': Colors.orange,
    },
    {
      'seller': 'स्वाद हॉटेल',
      'message': 'आजचे स्पेशल थाळी ₹99 मध्ये! ऑर्डर करा.',
      'time': 'काल',
      'icon': Icons.restaurant,
      'color': Colors.deepOrange,
    },
  ];

  void _acceptRequest(String buyerId) {
    setState(() {
      BuyerSocialData.acceptFriendRequest(buyerId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Friend Request स्वीकारली.')),
    );
  }

  void _rejectRequest(String buyerId) {
    setState(() {
      BuyerSocialData.rejectFriendRequest(buyerId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Friend Request नाकारली.')),
    );
  }

  Widget _buildFriendRequests() {
    final pendingRequests = BuyerSocialData.buyers
        .where((buyer) => buyer['friendRequestStatus'] == 'pending')
        .toList();

    if (pendingRequests.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person_add_alt_1, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Friend Requests',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${pendingRequests.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...pendingRequests.map((buyer) => _buildFriendRequestCard(buyer)),
        ],
      ),
    );
  }

  Widget _buildFriendRequestCard(Map<String, dynamic> buyer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
            child: Text(
              '${buyer['name']}'.isNotEmpty ? '${buyer['name']}'[0] : '?',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${buyer['name']}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${buyer['area']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _rejectRequest('${buyer['id']}'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(vertical: 7),
                        ),
                        child: const Text('Reject', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _acceptRequest('${buyer['id']}'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 7),
                        ),
                        child: const Text('Accept', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSellerMessages() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.message_outlined, color: Colors.teal),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'सेलर मेसेज',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_sellerMessages.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ..._sellerMessages.map((msg) => _buildSellerMessageCard(msg)),
        ],
      ),
    );
  }

  Widget _buildSellerMessageCard(Map<String, dynamic> msg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: (msg['color'] as Color).withOpacity(0.15),
            child: Icon(msg['icon'] as IconData, color: msg['color'] as Color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  msg['seller'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  msg['message'] as String,
                  style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                ),
                const SizedBox(height: 4),
                Text(
                  msg['time'] as String,
                  style: const TextStyle(fontSize: 11, color: AppColors.textLight),
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
    final notifications = [
      NotificationModel(
        id: 'b1',
        icon: Icons.stars_outlined,
        color: AppColors.primaryOrange,
        title: 'Reward Points मिळाले!',
        desc: 'श्री गणेश किराणा खरेदीवर तुम्हाला Points मिळाले',
        time: '10 मिनिटांपूर्वी',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RewardWalletScreen()),
        ),
      ),
      NotificationModel(
        id: 'b2',
        icon: Icons.local_shipping_outlined,
        color: AppColors.primaryBlue,
        title: 'ऑर्डर अपडेट',
        desc: 'तुमची ऑर्डर #AM-ORD-009 डिलिव्हरीसाठी निघाली आहे',
        time: '1 तासांपूर्वी',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
        ),
      ),
      NotificationModel(
        id: 'b4',
        icon: Icons.thumb_up_outlined,
        color: Colors.indigo,
        title: 'तुमच्या पोस्टला Like मिळाले',
        desc: 'सुनिता पाटील आणि 3 इतरांनी तुमची पोस्ट Like केली',
        time: '3 तासांपूर्वी',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MyWallScreen()),
        ),
      ),
      NotificationModel(
        id: 'b5',
        icon: Icons.people_outline,
        color: Colors.purple,
        title: 'मित्राचा मेसेज',
        desc: 'अनिल जोशी: "कोणाला चांगला इलेक्ट्रिशियन माहिती आहे का?"',
        time: 'काल',
      ),
      NotificationModel(
        id: 'b6',
        icon: Icons.campaign_outlined,
        color: Colors.deepOrange,
        title: 'AMOLE कडून सूचना',
        desc: 'नवीन Lucky Draw आजपासून सुरू — दररोज संध्याकाळी ४ वाजता निकाल',
        time: 'काल',
      ),
      NotificationModel(
        id: 'b7',
        icon: Icons.business_outlined,
        color: Colors.brown,
        title: 'Franchise कडून मेसेज',
        desc: 'तुमच्या परिसरात नवीन दुकाने जोडली गेली आहेत',
        time: '2 दिवसांपूर्वी',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('सूचना'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _buildSellerMessages(),
          _buildFriendRequests(),
          NotificationListView(notifications: notifications),
        ],
      ),
    );
  }
}
