import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../buyer/buyer_home_screen.dart';
import '../seller/seller_home_screen.dart';
import '../franchise/franchise_home_screen.dart';
import '../channel_partner/channel_partner_home_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  Future<void> _goToHome(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('selected_role') ?? 'buyer';

    if (!context.mounted) return;

    Widget homeScreen;
    switch (role) {
      case 'seller':
        homeScreen = const SellerHomeScreen();
        break;
      case 'franchise':
        homeScreen = const FranchiseHomeScreen();
        break;
      case 'channel_partner':
        homeScreen = const ChannelPartnerHomeScreen();
        break;
      default:
        homeScreen = const BuyerHomeScreen();
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => homeScreen),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.notifications_active_outlined, size: 100, color: AppColors.primaryBlue),
              const SizedBox(height: 32),
              const Text(AppStrings.stayUpdated, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              const SizedBox(height: 12),
              const Text(AppStrings.notificationDesc, textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: AppColors.textLight)),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => _goToHome(context),
                child: const Text(AppStrings.allowNotifications),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => _goToHome(context),
                child: const Text(AppStrings.notNow, style: TextStyle(color: AppColors.textLight)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
