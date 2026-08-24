import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CpNotificationScreen extends StatelessWidget {
  const CpNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {'icon': Icons.business_outlined, 'title': 'नवीन Franchise जोडली', 'desc': 'शिवाजीनगर पिनकोडसाठी नवीन Franchise activate झाली', 'time': '20 मिनिटांपूर्वी', 'color': Colors.blue},
      {'icon': Icons.how_to_reg_outlined, 'title': 'Franchise कडून Verification विनंती', 'desc': 'कोथरूड Franchise ने नवीन Seller verify करण्यासाठी मदत मागितली', 'time': '1 तासापूर्वी', 'color': Colors.orange},
      {'icon': Icons.campaign_outlined, 'title': 'नवीन जाहिरात Approval साठी', 'desc': 'एका Franchise ने टाकलेली जाहिरात तपासणीसाठी प्रलंबित आहे', 'time': '2 तासांपूर्वी', 'color': Colors.purple},
      {'icon': Icons.currency_rupee_outlined, 'title': 'Revenue Share जमा झाले', 'desc': '₹1,250 तुमच्या खात्यात जमा झाले', 'time': '5 तासांपूर्वी', 'color': Colors.green},
      {'icon': Icons.warning_amber_outlined, 'title': 'Franchise Target जवळ आले', 'desc': '2 Franchise यांचे मासिक Seller Target अजून पूर्ण झालेले नाही', 'time': 'काल', 'color': Colors.red},
      {'icon': Icons.storefront_outlined, 'title': 'नवीन Seller ऑनबोर्ड', 'desc': 'तुमच्या जिल्ह्यात एकूण Seller संख्या 142 वर पोहोचली', 'time': 'काल', 'color': Colors.teal},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('सूचना', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final n = notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
            ),
            child: Row(
              children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(color: (n['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Icon(n['icon'] as IconData, color: n['color'] as Color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(n['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                      const SizedBox(height: 3),
                      Text(n['desc'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                      const SizedBox(height: 4),
                      Text(n['time'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
