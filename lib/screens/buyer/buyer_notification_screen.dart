import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/notification_model.dart';
import '../../widgets/notification_list_view.dart';
import 'reward_wallet_screen.dart';
import 'order_tracking_screen.dart';
import 'my_wall_screen.dart';

class BuyerNotificationScreen extends StatelessWidget {
  const BuyerNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      NotificationModel(id: 'b1', icon: Icons.stars_outlined, color: AppColors.primaryOrange, title: 'Reward Points मिळाले!', desc: 'श्री गणेश किराणा खरेदीवर तुम्हाला Points मिळाले', time: '10 मिनिटांपूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardWalletScreen()))),
      NotificationModel(id: 'b2', icon: Icons.local_shipping_outlined, color: AppColors.primaryBlue, title: 'ऑर्डर अपडेट', desc: 'तुमची ऑर्डर #AM-ORD-009 डिलिव्हरीसाठी निघाली आहे', time: '1 तासापूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderTrackingScreen()))),
      NotificationModel(id: 'b3', icon: Icons.storefront_outlined, color: Colors.teal, title: 'राज इलेक्ट्रॉनिक्स कडून मेसेज', desc: 'तुमच्या चौकशीला उत्तर मिळालं आहे', time: '2 तासांपूर्वी'),
      NotificationModel(id: 'b4', icon: Icons.thumb_up_outlined, color: Colors.indigo, title: 'तुमच्या पोस्टला Like मिळाले', desc: 'सुनिता पाटील आणि 3 इतरांनी तुमची पोस्ट Like केली', time: '3 तासांपूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyWallScreen()))),
      NotificationModel(id: 'b5', icon: Icons.people_outline, color: Colors.purple, title: 'मित्राचा मेसेज', desc: 'अनिल जोशी: "कोणाला चांगला इलेक्ट्रिशियन माहिती आहे का?"', time: 'काल'),
      NotificationModel(id: 'b6', icon: Icons.campaign_outlined, color: Colors.deepOrange, title: 'AMOLE कडून सूचना', desc: 'नवीन Lucky Draw आजपासून सुरू — दररोज संध्याकाळी ४ वाजता निकाल', time: 'काल'),
      NotificationModel(id: 'b7', icon: Icons.business_outlined, color: Colors.brown, title: 'Franchise कडून मेसेज', desc: 'तुमच्या परिसरात नवीन दुकाने जोडली गेली आहेत', time: '2 दिवसांपूर्वी'),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(title: const Text('सूचना'), backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white),
      body: NotificationListView(notifications: notifications),
    );
  }
}
