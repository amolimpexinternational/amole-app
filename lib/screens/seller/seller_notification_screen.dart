import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import 'seller_orders_screen.dart';
import 'seller_revenue_detail_screen.dart';
import 'seller_products_screen.dart';
import 'seller_subscription_screen.dart';

class SellerNotificationScreen extends StatelessWidget {
  const SellerNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Notifications"),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [

          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.shopping_bag,color: Colors.white),
              ),
              title: const Text("New Order Received"),
              subtitle: const Text(
                  "Order #ORD101 has been placed."
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SellerOrdersScreen(),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.account_balance_wallet,
                    color: Colors.white),
              ),
              title: const Text("Payment Settled"),
              subtitle: const Text(
                  "Today's settlement has been credited."
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const SellerRevenueDetailScreen(),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(Icons.inventory,
                    color: Colors.white),
              ),
              title: const Text("Low Stock Alert"),
              subtitle: const Text(
                  "Some products are running low."
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const SellerProductsScreen(),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.workspace_premium,
                    color: Colors.white),
              ),
              title: const Text("Subscription Reminder"),
              subtitle: const Text(
                  "Upgrade to unlock premium features."
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const SellerSubscriptionScreen(),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
