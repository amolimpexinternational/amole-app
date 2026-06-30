import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerSubscriptionScreen extends StatelessWidget {
  const SellerSubscriptionScreen({super.key});

  Widget _buildPlanCard(BuildContext context, {required String name, required String price, required String period, required List<String> features, required bool isCurrent, required bool isPremium}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: isPremium ? const LinearGradient(colors: [AppColors.primaryBlue, AppColors.royalBlue], begin: Alignment.topLeft, end: Alignment.bottomRight) : null,
        color: isPremium ? null : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isCurrent ? AppColors.successGreen : AppColors.lightGrey, width: isCurrent ? 2 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isPremium ? AppColors.white : AppColors.textDark)),
            if (isCurrent)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.successGreen, borderRadius: BorderRadius.circular(20)),
                child: const Text('सध्याचा Plan', style: TextStyle(color: AppColors.white, fontSize: 11, fontWeight: FontWeight.w600)),
              ),
          ]),
          const SizedBox(height: 8),
          Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text(price, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: isPremium ? AppColors.white : AppColors.primaryBlue)),
            const SizedBox(width: 6),
            Text(period, style: TextStyle(fontSize: 13, color: isPremium ? AppColors.white.withOpacity(0.8) : AppColors.textLight)),
          ]),
          const SizedBox(height: 16),
          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(children: [
              Icon(Icons.check_circle, size: 18, color: isPremium ? AppColors.cyan : AppColors.successGreen),
              const SizedBox(width: 8),
              Expanded(child: Text(f, style: TextStyle(fontSize: 13, color: isPremium ? AppColors.white : AppColors.textDark))),
            ]),
          )),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isCurrent ? null : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$name Plan साठी Payment screen लवकरच येईल'), backgroundColor: AppColors.primaryBlue),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isCurrent ? AppColors.lightGrey : (isPremium ? AppColors.white : AppColors.primaryBlue),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                isCurrent ? 'सध्या वापरत आहात' : 'Upgrade करा',
                style: TextStyle(color: isCurrent ? AppColors.textLight : (isPremium ? AppColors.primaryBlue : AppColors.white), fontWeight: FontWeight.bold),
              ),
            ),
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
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Subscription Plans', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppColors.successGreen.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
              child: Row(children: const [
                Icon(Icons.info_outline, color: AppColors.successGreen),
                SizedBox(width: 10),
                Expanded(child: Text('तुमचा Free Plan 265 दिवसांत संपेल', style: TextStyle(fontSize: 13, color: AppColors.textDark))),
              ]),
            ),
            const SizedBox(height: 20),
            _buildPlanCard(context, name: 'Free Plan', price: '₹0', period: '/ वर्ष', isCurrent: true, isPremium: false,
              features: ['10 Products पर्यंत', 'Basic Analytics', '1 जाहिरात / महिना', 'Community Access']),
            _buildPlanCard(context, name: 'Premium Plan', price: '₹999', period: '/ वर्ष', isCurrent: false, isPremium: true,
              features: ['Unlimited Products', 'Advanced Analytics', 'Unlimited जाहिराती', 'Priority Support', 'Featured Listing', 'Loyalty Program Access']),
            _buildPlanCard(context, name: 'Business Plan', price: '₹2,499', period: '/ वर्ष', isCurrent: false, isPremium: false,
              features: ['सर्व Premium Features', 'Multi-location Support', 'Dedicated Manager', 'Custom Branding']),
          ],
        ),
      ),
    );
  }
}
