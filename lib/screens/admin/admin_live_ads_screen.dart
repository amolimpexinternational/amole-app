import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/ads_data.dart';
import 'admin_edit_ad_screen.dart';

class AdminLiveAdsScreen extends StatefulWidget {
  const AdminLiveAdsScreen({super.key});

  @override
  State<AdminLiveAdsScreen> createState() => _AdminLiveAdsScreenState();
}

class _AdminLiveAdsScreenState extends State<AdminLiveAdsScreen> {
  @override
  Widget build(BuildContext context) {
    final ads = AdsData.liveAds;
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('Live असणाऱ्या जाहिराती'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(child: Column(children: [
                  Text('${ads.length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                  const Text('एकूण Live जाहिराती', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                ])),
                Expanded(child: Column(children: [
                  Text('₹${AdsData.totalLiveIncome.toStringAsFixed(0)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.successGreen)),
                  const Text('एकूण Income', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                ])),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: ads.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (ctx, i) {
                final ad = ads[i];
                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (_) => AdminEditAdScreen(ad: ad)));
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 22, backgroundColor: ad.avatarColor.withValues(alpha: 0.15), child: Text(ad.avatar, style: TextStyle(color: ad.avatarColor, fontWeight: FontWeight.bold))),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(ad.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                          Text('${ad.sellerName} • ${ad.location}', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                          const SizedBox(height: 4),
                          Text('Income: ₹${ad.incomeGenerated.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12, color: AppColors.successGreen, fontWeight: FontWeight.w600)),
                        ])),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
                          child: const Text('Live', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
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
