import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  Widget buildStep(String title, String subtitle, bool completed) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: completed ? AppColors.successGreen : AppColors.lightGrey,
        child: Icon(
          completed ? Icons.check : Icons.access_time,
          color: completed ? AppColors.white : AppColors.textLight,
        ),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }

  void _confirmCancel(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('ऑर्डर रद्द करायची आहे का?'),
        content: const Text('रद्द केल्यास कदाचित काही दंड लागू शकतो (सेलरने आधीच तयारी सुरू केली असल्यास).'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('नको')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.errorRed),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ऑर्डर रद्द करण्याची विनंती पाठवली'), backgroundColor: Colors.red),
              );
            },
            child: const Text('हो, रद्द करा', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('ऑर्डर ट्रॅकिंग'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ऑर्डर आयडी', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('#AM123456'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('अंदाजित डिलिव्हरी', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('30 Jun 2026'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildStep('ऑर्डर कन्फर्म झाली', 'तुमची ऑर्डर कन्फर्म झाली आहे', true),
                  buildStep('पॅक झाली', 'विक्रेत्याने तुमची ऑर्डर पॅक केली', true),
                  buildStep('पाठवली', 'ऑर्डर यशस्वीरित्या पाठवली', true),
                  buildStep('डिलिव्हरीसाठी निघाली', 'तुमची ऑर्डर वाटेत आहे', false),
                  buildStep('डिलिव्हर झाली', 'डिलिव्हरी प्रलंबित', false),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _confirmCancel(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.errorRed),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('ऑर्डर रद्द करा', style: TextStyle(color: AppColors.errorRed)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
