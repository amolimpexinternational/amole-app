import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/notification_model.dart';
import '../../widgets/notification_list_view.dart';
import 'reward_wallet_screen.dart';
import 'order_tracking_screen.dart';
import 'extra_income_screen.dart';

class BuyerNotificationScreen extends StatefulWidget {
  const BuyerNotificationScreen({super.key});

  @override
  State<BuyerNotificationScreen> createState() => _BuyerNotificationScreenState();
}

class _BuyerNotificationScreenState extends State<BuyerNotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _sellerMessages = [
    {'seller': 'श्री गणेश किराणा', 'message': 'नमस्कार! आमच्याकडे नवीन सुकामेवा आला आहे. 10% सूट मिळवा!', 'time': '10 मिनिटांपूर्वी', 'icon': Icons.storefront, 'color': Colors.teal},
    {'seller': 'राज इलेक्ट्रॉनिक्स', 'message': 'तुमच्या ऑर्डरची डिलिव्हरी उद्या होईल. कृपया घरी असा.', 'time': '2 तासांपूर्वी', 'icon': Icons.electrical_services, 'color': Colors.orange},
    {'seller': 'स्वाद हॉटेल', 'message': 'आजचे स्पेशल थाळी ₹99 मध्ये! ऑर्डर करा.', 'time': 'काल', 'icon': Icons.restaurant, 'color': Colors.deepOrange},
    {'seller': 'अमोल कपडे भांडार', 'message': 'नवीन कलेक्शन आले आहे. 20% सूट!', 'time': '2 दिवसांपूर्वी', 'icon': Icons.checkroom, 'color': Colors.purple},
    {'seller': 'साई मेडिकल', 'message': 'तुमची औषधे तयार आहेत. कधीही येऊन घ्या.', 'time': '3 दिवसांपूर्वी', 'icon': Icons.local_pharmacy, 'color': Colors.green},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showMessageDetail(Map<String, dynamic> msg) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: (msg['color'] as Color).withOpacity(0.15),
                  child: Icon(msg['icon'] as IconData, color: msg['color'] as Color, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(msg['seller'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(msg['time'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Text(msg['message'] as String, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('बंद करा', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSellerMessages() {
    final reversedMessages = _sellerMessages.reversed.toList();
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Container(
          width: double.infinity,
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
                    child: Text('सेलर मेसेज', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(12)),
                    child: Text('${_sellerMessages.length}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...reversedMessages.map((msg) => _buildSellerMessageCard(msg)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSellerMessageCard(Map<String, dynamic> msg) {
    return GestureDetector(
      onTap: () => _showMessageDetail(msg),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: const Color(0xFFF5F7FA), borderRadius: BorderRadius.circular(12)),
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
                  Text(msg['seller'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 3),
                  Text(msg['message'] as String, style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                  const SizedBox(height: 4),
                  Text(msg['time'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherNotifications() {
    final notifications = [
      NotificationModel(id: 'b1', icon: Icons.stars_outlined, color: AppColors.primaryOrange, title: 'Reward Points मिळाले!', desc: 'श्री गणेश किराणा खरेदीवर तुम्हाला Points मिळाले', time: '10 मिनिटांपूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardWalletScreen()))),
      NotificationModel(id: 'b2', icon: Icons.local_shipping_outlined, color: AppColors.primaryBlue, title: 'ऑर्डर अपडेट', desc: 'तुमची ऑर्डर #AM-ORD-009 डिलिव्हरीसाठी निघाली आहे', time: '1 तासांपूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderTrackingScreen()))),
      NotificationModel(id: 'b4', icon: Icons.thumb_up_outlined, color: Colors.indigo, title: 'तुमच्या पोस्टला Like मिळाले', desc: 'सुनिता पाटील आणि 3 इतरांनी तुमची पोस्ट Like केली', time: '3 तासांपूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ExtraIncomeScreen()))),
      NotificationModel(id: 'b5', icon: Icons.people_outline, color: Colors.purple, title: 'मित्राचा मेसेज', desc: 'अनिल जोशी: "कोणाला चांगला इलेक्ट्रिशियन माहिती आहे का?"', time: 'काल'),
      NotificationModel(id: 'b6', icon: Icons.campaign_outlined, color: Colors.deepOrange, title: 'AMOLE कडून सूचना', desc: 'नवीन Lucky Draw आजपासून सुरू — दररोज संध्याकाळी ४ वाजता निकाल', time: 'काल'),
      NotificationModel(id: 'b7', icon: Icons.business_outlined, color: Colors.brown, title: 'Franchise कडून मेसेज', desc: 'तुमच्या परिसरात नवीन दुकाने जोडली गेली आहेत', time: '2 दिवसांपूर्वी'),
    ];
    return NotificationListView(notifications: notifications);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('माझे मेसेज'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'सेलर मेसेज'),
            Tab(text: 'महत्त्वाचे नोटिफिकेशन'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSellerMessages(),
          _buildOtherNotifications(),
        ],
      ),
    );
  }
}