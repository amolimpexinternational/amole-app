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
  void _acceptRequest(String buyerId) {
    setState(() {
      BuyerSocialData.acceptFriendRequest(buyerId);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Friend Request स्वीकारली.')));
  }

  void _rejectRequest(String buyerId) {
    setState(() {
      BuyerSocialData.rejectFriendRequest(buyerId);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Friend Request नाकारली.')));
  }

  Widget _buildFriendRequests() {
    final pendingRequests = BuyerSocialData.buyers
        .where((buyer) => buyer['friendRequestStatus'] == 'pending')
        .toList();

    if (pendingRequests.isEmpty) {
      return const SizedBox.shrink();
    }

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
                        child: const Text(
                          'Reject',
                          style: TextStyle(fontSize: 12),
                        ),
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
                        child: const Text(
                          'Accept',
                          style: TextStyle(fontSize: 12),
                        ),
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
        id: 'b3',
        icon: Icons.storefront_outlined,
        color: Colors.teal,
        title: 'राज इलेक्ट्रॉनिक्स कडून मेसेज',
        desc: 'तुमच्या चौकशीला उत्तर मिळालं आहे',
        time: '2 तासांपूर्वी',
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
          _buildFriendRequests(),
          NotificationListView(notifications: notifications),
        ],
      ),
    );
  }
}
