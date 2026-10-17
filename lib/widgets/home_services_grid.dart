import 'package:flutter/material.dart';
import '../screens/buyer/buyer_search_screen.dart';
import '../screens/buyer/coming_soon_screen.dart';
import '../screens/buyer/global_shopping_home_screen.dart';
import '../screens/buyer/pincode_shops_screen.dart';

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
            const Color(0xFFF9A825), () => _soon('Taxi / Rikshaw')),
        _GridItem('ZatPat', Icons.bolt_outlined, const Color(0xFFE53935),
            () => const PincodeShopsScreen()),
        _GridItem('Hotel Food', Icons.restaurant_outlined,
            const Color(0xFFEF6C00),
            () => const BuyerSearchScreen(initialFilter: 'services')),
        _GridItem('Services & Repair', Icons.build_outlined,
            const Color(0xFF546E7A), () => _soon('Services & Repair')),
        _GridItem('Parcel Cargo', Icons.local_shipping_outlined,
            const Color(0xFF6D4C41), () => _soon('Parcel Cargo')),
        _GridItem('Resale Or Rent', Icons.swap_horiz_outlined,
            const Color(0xFF8E24AA), () => _soon('Resale Or Rent')),
        _GridItem('Kirana Mart', Icons.shopping_basket_outlined,
            const Color(0xFF2E7D32),
            () => const PincodeShopsScreen(category: 'किराणा')),
        _GridItem('Jobs', Icons.work_outline, const Color(0xFF3949AB),
            () => _soon('Jobs')),
        _GridItem("Mom's Miracle", Icons.child_friendly_outlined,
            const Color(0xFFD81B60), () => _soon("Mom's Miracle")),
        _GridItem('Manufacturer', Icons.factory_outlined,
            const Color(0xFF00838F), () => _soon('Manufacturer')),
        _GridItem('Farmers & Vegetable', Icons.agriculture_outlined,
            const Color(0xFF558B2F),
            () => const PincodeShopsScreen(category: 'भाजीपाला')),
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
