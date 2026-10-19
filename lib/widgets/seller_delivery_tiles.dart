import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../screens/delivery/delivery_boy_home_screen.dart';
import '../screens/seller/hotel_orders_screen.dart';
import '../screens/seller/parcel_provider_screen.dart';
import '../screens/seller/rider_home_screen.dart';
import '../screens/seller/service_provider_screen.dart';
import '../screens/seller/zatpat_delivery_screen.dart';

class SellerDeliveryTiles extends StatelessWidget {
  const SellerDeliveryTiles({super.key});

  Widget _tile(BuildContext context, double width, String title,
      IconData icon, Color color, Widget Function() page) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page()),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const gap = 6.0;
    final width = (MediaQuery.of(context).size.width - 32 - gap * 3) / 4;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'डिलिव्हरी, राईड आणि सर्व्हिस',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              _tile(context, width, 'ZatPat\nऑर्डर', Icons.bolt_outlined,
                  const Color(0xFFE53935),
                  () => const ZatPatDeliveryScreen()),
              _tile(context, width, 'हॉटेल\nऑर्डर', Icons.restaurant_outlined,
                  const Color(0xFFEF6C00),
                  () => const HotelOrdersScreen()),
              _tile(context, width, 'डिलिव्हरी\nबॉय', Icons.two_wheeler_outlined,
                  const Color(0xFF2E7D32),
                  () => const DeliveryBoyHomeScreen()),
              _tile(context, width, 'रायडर\nपॅनल', Icons.local_taxi_outlined,
                  const Color(0xFF3949AB),
                  () => const RiderHomeScreen()),
              _tile(context, width, 'सर्व्हिस\nपॅनल', Icons.handyman_outlined,
                  const Color(0xFF00838F),
                  () => const ServiceProviderScreen()),
              _tile(context, width, 'कार्गो\nपॅनल', Icons.local_shipping_outlined,
                  const Color(0xFF6D4C41),
                  () => const ParcelProviderScreen()),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Demo: Category नुसार योग्य बटण दिसणे पुढे येईल.',
            style: TextStyle(fontSize: 10.5, color: AppColors.textLight),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}