import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FranchiseNotificationScreen extends StatelessWidget {
  const FranchiseNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {'icon': Icons.how_to_reg_outlined, 'title': 'नवीन Seller KYC अर्ज', 'desc': 'रमेश किराणा मार्ट यांनी KYC साठी अर्ज केला आहे', 'time': '10 मिनिटांपूर्वी', 'color': Colors.orange},
      {'icon': Icons.campaign_outlined, 'title': 'नवीन जाहिरात Approval साठी', 'desc': 'गणेश किराणा मार्ट यांची जाहिरात तपासणीसाठी आहे', 'time': '1 तासापूर्वी', 'color': Colors.blue},
      {'icon': Icons.currency_rupee_outlined, 'title': 'Commission जमा झाले', 'desc': '₹420 तुमच्या खात्यात जमा झाले', 'time': '3 तासांपूर्वी', 'color': Colors.green},
      {'icon': Icons.delivery_dining_outlined, 'title': 'नवीन Delivery Partner अर्ज', 'desc': 'एक नवीन partner KYC साठी प्रतीक्षेत आहे', 'time': 'काल', 'color': Colors.teal},
      {'icon': Icons.warning_amber_outlined, 'title': 'KYC Deadline जवळ आली', 'desc': '2 sellers चं KYC उद्या expire होईल', 'time': 'काल', 'color': Colors.red},
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
