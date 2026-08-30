import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/notification_model.dart';
import '../../widgets/notification_list_view.dart';
import 'cp_approvals_screen.dart';
import 'cp_franchise_screen.dart';
import 'cp_seller_revenue_screen.dart';

class CpNotificationScreen extends StatelessWidget {
  const CpNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      NotificationModel(id: 'c1', icon: Icons.business_outlined, color: Colors.blue, title: 'नवीन Franchise जोडली', desc: 'शिवाजीनगर पिनकोडसाठी नवीन Franchise activate झाली', time: '20 मिनिटांपूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CpFranchiseScreen()))),
      NotificationModel(id: 'c2', icon: Icons.how_to_reg_outlined, color: Colors.orange, title: 'Franchise कडून Verification विनंती', desc: 'कोथरूड Franchise ने नवीन Seller verify करण्यासाठी मदत मागितली', time: '1 तासापूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CpApprovalsScreen()))),
      NotificationModel(id: 'c3', icon: Icons.campaign_outlined, color: Colors.purple, title: 'नवीन जाहिरात Approval साठी', desc: 'एका Franchise ने टाकलेली जाहिरात तपासणीसाठी प्रलंबित आहे', time: '2 तासांपूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CpApprovalsScreen()))),
      NotificationModel(id: 'c4', icon: Icons.currency_rupee_outlined, color: Colors.green, title: 'Revenue Share जमा झाले', desc: '₹1,250 तुमच्या Reward Wallet मध्ये जमा झाले', time: '5 तासांपूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CpSellerRevenueScreen()))),
      NotificationModel(id: 'c5', icon: Icons.warning_amber_outlined, color: Colors.red, title: 'Franchise Target जवळ आले', desc: '2 Franchise यांचे मासिक Seller Target अजून पूर्ण झालेले नाही', time: 'काल', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CpFranchiseScreen()))),
      NotificationModel(id: 'c6', icon: Icons.storefront_outlined, color: Colors.teal, title: 'नवीन Seller ऑनबोर्ड', desc: 'तुमच्या जिल्ह्यात एकूण Seller संख्या 142 वर पोहोचली', time: 'काल'),
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
