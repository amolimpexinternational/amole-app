import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/notification_model.dart';
import '../../widgets/notification_list_view.dart';
import 'admin_approvals_screen.dart';
import 'admin_settlement_screen.dart';
import 'admin_channel_partners_screen.dart';

class AdminNotificationScreen extends StatelessWidget {
  const AdminNotificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: replace with real data from Firestore (collection: admin_notifications)
    final notifications = [
      NotificationModel(id: 'a1', icon: Icons.fact_check_outlined, color: Colors.orange, title: 'नवीन Approval प्रतीक्षेत', desc: 'Franchise/CP कडून एक विनंती Approval साठी आली आहे', time: '15 मिनिटांपूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminApprovalsScreen()))),
      NotificationModel(id: 'a2', icon: Icons.account_balance_outlined, color: Colors.green, title: 'आजचं Settlement पूर्ण झालं', desc: 'सर्व Sellers/Franchise/CP ना रात्रीचं Auto-Settlement झालं', time: '1 तासापूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminSettlementScreen()))),
      NotificationModel(id: 'a3', icon: Icons.hub_outlined, color: Colors.indigo, title: 'नवीन Channel Partner', desc: 'एक नवीन CP प्लॅटफॉर्मवर जोडला गेला', time: 'काल', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminChannelPartnersScreen()))),
    ];
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(title: const Text('नोटिफिकेशन'), backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white),
      body: NotificationListView(notifications: notifications),
    );
  }
}
