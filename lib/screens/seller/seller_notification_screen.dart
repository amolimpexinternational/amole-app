import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/notification_model.dart';
import '../../widgets/notification_list_view.dart';
import 'seller_orders_screen.dart';
import 'seller_revenue_detail_screen.dart';
import 'seller_products_screen.dart';
import 'seller_subscription_screen.dart';

class SellerNotificationScreen extends StatelessWidget {
  const SellerNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      NotificationModel(id: 's1', icon: Icons.shopping_bag, color: Colors.red, title: 'New Order Received', desc: 'Order #ORD101 has been placed.', time: '10 मिनिटांपूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerOrdersScreen()))),
      NotificationModel(id: 's2', icon: Icons.account_balance_wallet, color: Colors.green, title: 'Payment Settled', desc: "Today's settlement has been credited.", time: '1 तासापूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerRevenueDetailScreen()))),
      NotificationModel(id: 's3', icon: Icons.inventory, color: Colors.orange, title: 'Low Stock Alert', desc: 'Some products are running low.', time: '3 तासांपूर्वी', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerProductsScreen()))),
      NotificationModel(id: 's4', icon: Icons.workspace_premium, color: Colors.blue, title: 'Subscription Reminder', desc: 'Upgrade to unlock premium features.', time: 'काल', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerSubscriptionScreen()))),
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
        title: const Text('Notifications'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: NotificationListView(notifications: notifications),
    );
  }
}
