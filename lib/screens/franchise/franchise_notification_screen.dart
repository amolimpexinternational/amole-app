import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/notification_model.dart';
import '../../widgets/notification_list_view.dart';
import 'franchise_kyc_screen.dart';
import 'franchise_ad_screen.dart';
import 'franchise_wallet_screen.dart';

class FranchiseNotificationScreen extends StatelessWidget {
  const FranchiseNotificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final notifications = [
      NotificationModel(id: 'f1', icon: Icons.how_to_reg_outlined, color: Colors.orange, title: 'नवीन Seller KYC अर्ज', desc: 'रमेश किराणा मार्ट यांनी KYC साठी अर्ज केला आहे', time: '10 मिनिटांपूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseKycScreen()))),
      NotificationModel(id: 'f2', icon: Icons.campaign_outlined, color: Colors.blue, title: 'नवीन जाहिरात Approval साठी', desc: 'गणेश किराणा मार्ट यांची जाहिरात तपासणीसाठी आहे', time: '1 तासापूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseAdScreen()))),
      NotificationModel(id: 'f3', icon: Icons.currency_rupee_outlined, color: Colors.green, title: 'Commission जमा झाले', desc: '₹420 तुमच्या Wallet मध्ये जमा झाले', time: '3 तासांपूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FranchiseWalletScreen(franchiseName: 'हडपसर फ्रँचाइजी')))),
      NotificationModel(id: 'f4', icon: Icons.delivery_dining_outlined, color: Colors.teal, title: 'नवीन Delivery Partner अर्ज', desc: 'एक नवीन partner KYC साठी प्रतीक्षेत आहे', time: 'काल'),
      NotificationModel(id: 'f5', icon: Icons.warning_amber_outlined, color: Colors.red, title: 'KYC Deadline जवळ आली', desc: '2 sellers चं KYC उद्या expire होईल', time: 'काल', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseKycScreen()))),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('सूचना', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: NotificationListView(notifications: notifications),
    );
  }
}
