import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/app_colors.dart';
import 'screens/common/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AmoleApp());
}

class AmoleApp extends StatelessWidget {
  const AmoleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AMOLE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryBlue,
          primary: AppColors.primaryBlue,
          secondary: AppColors.primaryOrange,
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: AppColors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
