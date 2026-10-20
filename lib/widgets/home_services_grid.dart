import 'package:flutter/material.dart';
import '../screens/buyer/coming_soon_screen.dart';
import '../screens/buyer/global_shopping_home_screen.dart';
import '../screens/buyer/hotel_food_home_screen.dart';
import '../screens/buyer/listings_home_screen.dart';
import '../screens/buyer/moms_miracle_screen.dart';
import '../screens/buyer/parcel_booking_screen.dart';
import '../screens/buyer/ride_booking_screen.dart';
import '../screens/buyer/services_home_screen.dart';
import '../screens/buyer/zatpat_home_screen.dart';

class _GridItem {
  final String label;
  final IconData icon;
  final Color color;
  final Widget Function() page;
  const _GridItem(this.label, this.icon, this.color, this.page);
}

class HomeServicesGrid extends StatelessWidget {
  const HomeServicesGrid({super.key});

  static Widget _soon(String t) => ComingSoonScreen(title: t);

  List<_GridItem> get _items => [
        _GridItem('Global Shopping', Icons.shopping_cart_outlined,
            const Color(0xFF1565C0), () => const GlobalShoppingHomeScreen()),
        _GridItem('Taxi / Rikshaw', Icons.local_taxi_outlined,
            const Color(0xFFF9A825), () => const RideBookingScreen()),
        _GridItem('ZatPat', Icons.bolt_outlined, const Color(0xFFE53935),
            () => const ZatPatHomeScreen()),
        _GridItem('Hotel Food', Icons.restaurant_outlined,
            const Color(0xFFEF6C00), () => const HotelFoodHomeScreen()),
        _GridItem('Services & Repair', Icons.build_outlined,
            const Color(0xFF546E7A), () => const ServicesHomeScreen()),
        _GridItem('Parcel Cargo', Icons.local_shipping_outlined,
            const Color(0xFF6D4C41), () => const ParcelBookingScreen()),
        _GridItem('Resale Or Rent', Icons.swap_horiz_outlined,
            const Color(0xFF8E24AA),
            () => const ListingsHomeScreen(module: 'resalerent')),
        _GridItem('Kirana Mart', Icons.shopping_basket_outlined,
            const Color(0xFF2E7D32),
            () => const ZatPatHomeScreen(
                initialCategory: 'किराणा', title: 'Kirana Mart')),
        _GridItem('Jobs', Icons.work_outline, const Color(0xFF3949AB),
            () => const ListingsHomeScreen(module: 'jobs')),
        _GridItem("Mom's Miracle", Icons.child_friendly_outlined,
            const Color(0xFFD81B60), () => const MomsMiracleScreen()),
        _GridItem('Manufacturer', Icons.factory_outlined,
            const Color(0xFF00838F), () => _soon('Manufacturer')),
        _GridItem('Farmers & Vegetable', Icons.agriculture_outlined,
            const Color(0xFF558B2F), () => _soon('Farmers & Vegetable')),
      ];

  @override
  Widget build(BuildContext context) {
    final items = _items;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 100,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final it = items[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => it.page()),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: it.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(it.icon, color: it.color, size: 44),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      it.label,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
