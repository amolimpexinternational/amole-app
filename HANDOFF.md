# HANDOFF: मोबाईलवर केलेले काम आणि लॅपटॉपवर करायच्या कृती

तारीख: ऑक्टोबर 2026. आधी `PROJECT_STATUS.md` चे नियम वाचा. ते इथेही लागू आहेत.

## 0. महत्त्वाचे वाचा
- खालील सर्व नवीन files मोबाईलवर GitHub app मधून जोडल्या आहेत. **`flutter analyze` चालवलेला नाही**, म्हणजे चुका निघू शकतात. हे सगळे **Demo/dummy डेटा** आहे, Stage 3 नाही.
- `git add .` वापरू नका. फक्त बदललेल्या files add करा.
- मोबाईलवर जोडलेली एखादी file राहिली असेल तर `flutter analyze` मध्ये `uri_does_not_exist` error येईल. ती file खालच्या यादीत शोधून जोडा किंवा अडचण सांगा.

## 1. सुरुवातीला (क्रमाने)
```
git status
git pull
flutter pub get
flutter analyze
```
- `warning` आणि `info` सोडा. फक्त **error** दुरुस्त करा.
- सामान्य अपेक्षित error: एखादा icon तुमच्या Flutter आवृत्तीत नसणे. उदा. `Icons.electric_rickshaw`, `plumbing`, `carpenter`, `pest_control`, `car_repair`, `handyman_outlined`, `local_taxi_outlined`, `child_friendly_outlined`, `factory_outlined`, `airport_shuttle`. नसेल तर जवळचा icon वापरा (उदा. `Icons.local_taxi`).
- error शून्य झाल्यावर पुढे जा.

## 2. मोबाईलवर जोडलेल्या नवीन files (module नुसार)
- डेटा: `lib/data/zatpat_data.dart`, `delivery_rates.dart`, `ride_rates.dart`, `services_data.dart`, `listings_data.dart`, `parcel_data.dart`, `kids_demo_products.dart`
- ZatPat (buyer): `lib/screens/buyer/zatpat_home_screen.dart`, `zatpat_order_status_screen.dart`, `zatpat_feedback_screen.dart`
- Hotel Food: `lib/screens/buyer/hotel_food_home_screen.dart` (त्यातच HotelMenuScreen), `lib/screens/seller/hotel_orders_screen.dart`
- ZatPat दुकानदार: `lib/screens/seller/zatpat_delivery_screen.dart`
- डिलिव्हरी बॉय: `lib/screens/delivery/delivery_boy_home_screen.dart`
- Taxi/Rikshaw: `lib/screens/buyer/ride_booking_screen.dart`, `ride_status_screen.dart`, `ride_feedback_screen.dart`, रायडर: `lib/screens/seller/rider_home_screen.dart`
- Services & Repair: `lib/screens/buyer/services_home_screen.dart`, `service_requirement_screen.dart`, `service_request_status_screen.dart`, प्रोव्हायडर: `lib/screens/seller/service_provider_screen.dart`
- Resale/Rent/Jobs: `lib/screens/buyer/listings_home_screen.dart`, `listing_post_screen.dart`, `my_listings_screen.dart`
- Parcel Cargo: `lib/screens/buyer/parcel_booking_screen.dart`, `parcel_status_screen.dart`, कार्गो सेलर: `lib/screens/seller/parcel_provider_screen.dart`
- Mom's Miracle: `lib/screens/buyer/moms_miracle_screen.dart`
- Seller होमची बटणे: `lib/widgets/seller_delivery_tiles.dart`

## 3. जुन्या files मधले मोबाईलवर झालेले बदल
- `lib/screens/seller/seller_home_screen.dart`: import `../../widgets/seller_delivery_tiles.dart` आणि 'जाहिराती' च्या वर `const SellerDeliveryTiles(),`.
- `lib/screens/seller/registration/seller_registration_screen.dart`: category यादीत `{'name': 'लोकल डिलिव्हरी सेवा / Delivery Boy', 'code': 'DB'}` जोडली.

## 4. लॅपटॉपवर करायचे बदल (क्रमाने)

### A. `lib/screens/buyer/zatpat_home_screen.dart`: Kirana Mart साठी चार बदल
1. `const ZatPatHomeScreen({super.key});` या ओळीच्या जागी:
```
  final String? initialCategory;
  final String? title;
  const ZatPatHomeScreen({super.key, this.initialCategory, this.title});
```
2. `String _category = 'सर्व';` च्या जागी `late String _category = widget.initialCategory ?? 'सर्व';`
3. AppBar मध्ये `title: const Column(` च्या जागी `title: Column(`
4. त्याच Column मधील `Text('⚡ ZatPat',` च्या जागी `Text(widget.title ?? '⚡ ZatPat',`

### B. त्याच file मध्ये: दुकानदाराचा ON/OFF जोडणे
1. वर imports मध्ये जोडा: `import '../../data/zatpat_data.dart';` आणि `import '../../data/delivery_rates.dart';`
2. `_visible` मध्ये `if (p['zatpat'] != true) return false;` च्या जागी:
   `if (!ZatPatData.isOn(p['seller'] as String, p['zatpat'] == true)) return false;`
3. `_deliveryCharge` मध्ये `p['zatpat'] == true` ची अट `ZatPatData.isOn(p['seller'] as String, p['zatpat'] == true)` ने बदला.
4. `return _chargeForKm(maxKm);` च्या जागी `return DeliveryRates.chargeForKm(maxKm);` (जुना `_chargeForKm` function काढला तरी चालेल).

### C. `lib/widgets/home_services_grid.dart`: पूर्ण बदला
फाईलचा सगळा मजकूर काढून **या file च्या शेवटच्या परिशिष्टातील** (§8) कोड paste करा. हे **बदल A केल्यानंतरच** करा, कारण Kirana Mart चे icon त्या नवीन parameters वर अवलंबून आहे.

### D. `seller_registration_screen.dart`: आणखी category
`'DB'` च्या खाली जोडा: `{'name': 'रिक्षा / टॅक्सी सेवा', 'code': 'RT'}`, `{'name': 'लहान मुले (Baby Care)', 'code': 'KD'}`. रिक्षा सेलरसाठी वाहन आणि ड्रायव्हिंग लायसन्सची माहिती घेणारे फील्ड अजून बाकी.

### E. Cart आणि ऑर्डरचा शेवट
- Cart screen मध्ये ZatPat/Hotel Food च्या वस्तूंसाठी डिलिव्हरी चार्ज (`DeliveryRates.chargeForKm`) दाखवणे.
- ऑर्डर confirm केल्यावर `ZatPatOrderStatusScreen` उघडणे. ती "ZatPat ऑर्डर" असे नाव दाखवते, Hotel Food साठी नाव बदलता येईल असे करा.
- जुन्या `order_tracking_screen.dart` शी तुलना करून एकत्र करायचे का ते ठरवा.

### F. `_testMode`
`rider_home_screen.dart`, `delivery_boy_home_screen.dart`, `parcel_provider_screen.dart` मध्ये `static const bool _testMode = false;` असल्याची खात्री करा (चाचणीसाठी `true` केल्यास 15 मिनिटांची सूचना 10 सेकंदांत येते).

## 5. तपासणी (app चालवून)
```
flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0 --release
```
- Buyer Home: Search icon header मध्ये, offers सरकतात, 4x3 grid, प्रत्येक icon योग्य screen उघडतो.
- ZatPat: 10 km मधले प्रॉडक्ट, ADD, खाली cart bar आणि डिलिव्हरी चार्ज (₹30/45/60/100).
- Hotel Food: हॉटेल यादी, menu, शोधात पदार्थाचे नाव, शेअर्ड cart.
- Taxi/Rikshaw: बाईक 7 km = ₹94. SUV "दर लवकरच". Demo बटणांनी ड्रायव्हर मिळाला आणि 15 मिनिटांनंतरचा फीडबॅक.
- Services: सेवा निवडल्यावर फक्त सशुल्क प्रोव्हायडर, Requirement फॉर्म, पोस्ट नंतर Demo बटणांनी रिपोर्ट, बिल, कोड 7359.
- Resale/Rent/Jobs: पोस्ट फी ₹50 खिडकी, "माझ्या पोस्ट" मध्ये Edit/Delete, 30 दिवस जुनी पोस्ट दिसत नाही.
- Parcel Cargo: Three Wheeler 30 km = ₹465. मोठ्या वाहनांवर "तात्पुरते दर".
- Mom's Miracle: 5 Demo प्रॉडक्ट, chips, शोध.
- Seller होम: "डिलिव्हरी, राईड आणि सर्व्हिस" च्या सहा बटणांची रांग, प्रत्येक screen उघडते.
- सर्व पॅनलमध्ये: Demo कोड ZatPat/डिलिव्हरी 4821, Services 7359.

## 6. शेवटी
```
python3 tools/make_map.py
```
`PROJECT_STATUS.md` मध्ये नवीन modules ची नोंद करा. मग फक्त बदललेल्या files `git add <file>` ने घ्या आणि commit आणि push करा.

## 7. नंतर (Stage 3, आत्ता करू नका)
- खरे लोकेशन आणि 250 मीटर हालचाल: tracelet (त्याच्या अधिकृत माहितीवरून, अंदाजाने नाही). `_onMovedFar()` हे function त्याला जोडा आणि Demo बटणे काढा.
- Firebase: खरी नोंदणी, ऑर्डर, सूचना, पहिला Accept करणारा जिंकणे, wallet चे खरे रिचार्ज आणि कपात, 15 मिनिटांचे आणि 30 दिवसांचे timer सर्व्हरवर.
- पेमेंट (Cashfree): ZatPat/Hotel 100% online, 24 तासांनी वाटप (कंपनी 10%, डिलिव्हरी चार्ज बॉयला), पोस्ट फी ₹50.
- फ्रँचाईजी, चॅनल पार्टनर आणि Admin साठी शहरानुसार दर बदलण्याच्या screens (`RideRates.setRates`, `ParcelData.setRates`).
- Parcel Cargo चे 2 टन पिकअप ते कंटेनर यांचे खरे दर.
- Manufacturer आणि Farmers & Vegetable modules (अजून माहिती नाही).
- `kids_demo_products.dart` खरे प्रॉडक्ट आल्यावर काढणे.

## 8. परिशिष्ट: नवीन `lib/widgets/home_services_grid.dart`
```dart
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
```