
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
    // Stage 2: Demo notifications.
    // Stage 3: Replace with Firestore collection (admin_notifications).

    final notifications = [
      NotificationModel(
        id: 'a1',
        icon: Icons.person_add_alt_1_outlined,
        color: Colors.blue,
        title: 'नवीन Joins',
        desc: 'नवीन Buyer, Seller, Franchise किंवा CP प्लॅटफॉर्मवर जोडले गेले आहेत.',
        time: '10 मिनिटांपूर्वी',
        onTap: () {
          _showNotificationDetails(
            context,
            'नवीन Joins',
            'नवीन सदस्यांची माहिती Stage 3 मध्ये येथे दिसेल.',
          );
        },
      ),
      NotificationModel(
        id: 'a2',
        icon: Icons.payments_outlined,
        color: Colors.green,
        title: 'Payment Requests',
        desc: 'काही Sellers, Franchise किंवा CP कडून Payment Requests आलेल्या आहेत.',
        time: '20 मिनिटांपूर्वी',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AdminSettlementScreen(),
            ),
          );
        },
      ),
      NotificationModel(
        id: 'a3',
        icon: Icons.fact_check_outlined,
        color: Colors.orange,
        title: 'Join Requests',
        desc: 'Franchise किंवा Channel Partner कडून नवीन Join Requests Approval साठी आल्या आहेत.',
        time: '35 मिनिटांपूर्वी',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AdminApprovalsScreen(),
            ),
          );
        },
      ),
      NotificationModel(
        id: 'a4',
        icon: Icons.event_busy_outlined,
        color: Colors.red,
        title: 'Expired Subscriptions',
        desc: 'काही Sellers आणि इतर सदस्यांचे Subscription संपले आहेत.',
        time: '1 तासापूर्वी',
        onTap: () {
          _showNotificationDetails(
            context,
            'Expired Subscriptions',
            'Subscription संपलेल्या सदस्यांची यादी Stage 3 मध्ये येथे दिसेल.',
          );
        },
      ),
      NotificationModel(
        id: 'a5',
        icon: Icons.warning_amber_rounded,
        color: Colors.deepOrange,
        title: 'Expiring Subscriptions',
        desc: 'काही सदस्यांचे Subscription लवकरच संपणार आहेत.',
        time: '2 तासांपूर्वी',
        onTap: () {
          _showNotificationDetails(
            context,
            'Expiring Subscriptions',
            'लवकरच Subscription संपणाऱ्या सदस्यांची यादी Stage 3 मध्ये येथे दिसेल.',
          );
        },
      ),
      NotificationModel(
        id: 'a6',
        icon: Icons.shopping_bag_outlined,
        color: Colors.indigo,
        title: 'आजचे Orders',
        desc: 'आज Buyer कडून आलेल्या Orders ची module-wise माहिती उपलब्ध आहे.',
        time: 'आज',
        onTap: () {
          _showNotificationDetails(
            context,
            'आजचे Orders',
            'आजचे Orders module-wise दाखवले जातील:\n\n'
                '• Amole Shopping\n'
                '• Weekly Market\n'
                '• इतर उपलब्ध Modules\n\n'
                'प्रत्यक्ष Order Details Stage 3 मध्ये जोडले जातील.',
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('नोटिफिकेशन'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: NotificationListView(
        notifications: notifications,
      ),
    );
  }

  void _showNotificationDetails(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('ठीक आहे'),
          ),
        ],
      ),
    );
  }
}
