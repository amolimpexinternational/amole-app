import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerSubscriptionScreen extends StatelessWidget {
  const SellerSubscriptionScreen({super.key});

  Widget _buildPlanCard(
    BuildContext context, {
    required String name,
    required String price,
    required String period,
    required List<String> features,
    required bool isCurrent,
    required bool isPremium,
    Color? badgeColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: isPremium
            ? const LinearGradient(
                colors: [AppColors.primaryBlue, AppColors.royalBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isPremium ? null : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrent ? AppColors.successGreen : AppColors.lightGrey,
          width: isCurrent ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isPremium ? AppColors.white : AppColors.textDark,
                    ),
                  ),
                  if (badgeColor != null) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Popular',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: isPremium ? AppColors.royalBlue : AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              if (isCurrent)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.successGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'सध्याचा Plan',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                price,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isPremium ? AppColors.white : AppColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                period,
                style: TextStyle(
                  fontSize: 13,
                  color: isPremium
                      ? AppColors.white.withOpacity(0.8)
                      : AppColors.textLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: isPremium ? AppColors.cyan : AppColors.successGreen,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        f,
                        style: TextStyle(
                          fontSize: 13,
                          color: isPremium ? AppColors.white : AppColors.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isCurrent
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$name Plan साठी Payment screen लवकरच येईल'),
                          backgroundColor: AppColors.primaryBlue,
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: isCurrent
                    ? AppColors.lightGrey
                    : (isPremium ? AppColors.white : AppColors.primaryBlue),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                isCurrent ? 'सध्या वापरत आहात' : 'Upgrade करा',
                style: TextStyle(
                  color: isCurrent
                      ? AppColors.textLight
                      : (isPremium ? AppColors.primaryBlue : AppColors.white),
                  fontWeight: FontWeight.bold,
                ),
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
        title: const Text(
          'Subscription Plans',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.successGreen.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.successGreen),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'तुमचा Free Plan 265 दिवसांत संपेल',
                      style: TextStyle(fontSize: 13, color: AppColors.textDark),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // === Plan 1: Free ===
            _buildPlanCard(
              context,
              name: 'Plan 1 — Free',
              price: '₹0',
              period: '/ कायम',
              isCurrent: true,
              isPremium: false,
              features: [
                '5 Products पर्यंत Listing',
                '1 जाहिरात Free',
                'Basic Analytics',
              ],
            ),

            // === Plan 2: ₹499 / 5 months ===
            _buildPlanCard(
              context,
              name: 'Plan 2 — Starter',
              price: '₹499',
              period: '/ 5 महिने',
              isCurrent: false,
              isPremium: false,
              features: [
                '10 Products पर्यंत Listing',
                '5 जाहिराती Free',
                'Basic Analytics',
                'Priority Support',
              ],
            ),

            // === Plan 3: ₹999 / 1 year (Popular) ===
            _buildPlanCard(
              context,
              name: 'Plan 3 — Premium',
              price: '₹999',
              period: '/ 1 वर्ष',
              isCurrent: false,
              isPremium: true,
              badgeColor: AppColors.cyan,
              features: [
                '20 Products पर्यंत Listing',
                'Advanced Analytics',
                'Priority Support',
                'Featured Listing',
                'Loyalty Program Access',
              ],
            ),

            // === Plan 4: ₹1500 / 1 year ===
            _buildPlanCard(
              context,
              name: 'Plan 4 — Business',
              price: '₹1,500',
              period: '/ 1 वर्ष',
              isCurrent: false,
              isPremium: false,
              features: [
                '100 Products पर्यंत Listing',
                'सर्व Premium Features',
                'Multi-location Support',
                'Dedicated Manager',
                'Custom Branding',
              ],
            ),
          ],
        ),
      ),
    );
  }
}