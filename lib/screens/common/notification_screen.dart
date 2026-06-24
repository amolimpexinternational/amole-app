import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  void _goToHome(BuildContext context) {
    // Navigate to Home Screen (will be built next)
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
              const Icon(
                Icons.notifications_active_outlined,
                size: 100,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(height: 32),
              const Text(
                AppStrings.stayUpdated,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                AppStrings.notificationDesc,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: AppColors.textLight),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => _goToHome(context),
                child: const Text(AppStrings.allowNotifications),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => _goToHome(context),
                child: const Text(
                  AppStrings.notNow,
                  style: TextStyle(color: AppColors.textLight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
