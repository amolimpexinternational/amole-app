import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../constants/app_colors.dart';
import '../seller/expenses_wallet_screen.dart';
import 'promoter_catalog_screen.dart';
import 'promoter_kyc_screen.dart';
import '../seller/registration/seller_registration_screen.dart';
import '../delivery/delivery_boy_home_screen.dart';
import '../seller/seller_advertisement_screen.dart';
import '../shared/weekly_market_catalog_screen.dart';

class PromoterDashboardScreen extends StatefulWidget {
  const PromoterDashboardScreen({super.key});

  @override
  State<PromoterDashboardScreen> createState() => _PromoterDashboardScreenState();
}

class _PromoterDashboardScreenState extends State<PromoterDashboardScreen> {
  bool _isPromoter = false;
  bool _isDeliveryBoy = false;
  bool _isJoinedAathwadiBazar = false;
  bool _isLoading = true;
  bool _standLoading = false;

  String _standLocation = '';

  // === डमी: मी जोडलेले buyer ===
  final List<Map<String, String>> _referredBuyers = [
    {'name': 'अनिल जोशी', 'phone': '9876543210', 'date': '10 Nov 2026', 'purchases': '₹1,200'},
    {'name': 'संगीता राणे', 'phone': '9876543211', 'date': '08 Nov 2026', 'purchases': '₹3,500'},
    {'name': 'रमेश पाटील', 'phone': '9876543212', 'date': '05 Nov 2026', 'purchases': '₹850'},
  ];

  final List<Map<String, String>> _registeredSellers = [
    {'name': 'श्री गणेश किराणा', 'phone': '9876543210', 'status': 'Approved'},
    {'name': 'स्वाद हॉटेल', 'phone': '9876543211', 'status': 'Pending'},
  ];

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPromoter = prefs.getBool('isPromoter') ?? false;
      _isDeliveryBoy = prefs.getBool('isDeliveryBoy') ?? false;
      _isJoinedAathwadiBazar = prefs.getBool('isJoinedAathwadiBazar') ?? false;
      _standLocation = prefs.getString('standLocation') ?? '';
      _isLoading = false;
    });
  }

  Future<void> _becomePromoter() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PromoterKycScreen()),
    );
    if (result == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isPromoter', true);
      setState(() => _isPromoter = true);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('अभिनंदन! तुमची KYC सबमिट झाली. फ्रॅंचाईजी व्हेरिफिकेशननंतर तुम्ही प्रमोटर व्हाल 🎉'),
            backgroundColor: AppColors.successGreen,
          ),
        );
      }
    }
  }

  // === GPS लोकेशन घेणे ===
  Future<void> _selectMyStand() async {
    setState(() => _standLoading = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('GPS परवानगी नाकारली'), backgroundColor: Colors.red),
          );
          setState(() => _standLoading = false);
          return;
        }
      }
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );
      String areaName = 'माझं स्टँड';
      try {
        final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          final parts = [p.subLocality, p.locality, p.administrativeArea]
              .where((e) => e != null && e!.isNotEmpty)
              .toList();
          if (parts.isNotEmpty) areaName = parts.join(', ');
        }
      } catch (_) {}

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('standLocation', areaName);
      setState(() {
        _standLocation = areaName;
        _standLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('स्टँड सेट झालं: $areaName'), backgroundColor: AppColors.successGreen),
        );
      }
    } catch (e) {
      setState(() => _standLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('लोकेशन मिळालं नाही: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _toggleDeliveryBoy(bool value) async {
    if (value && _standLocation.isEmpty) {
      // आधी स्टँड निवडा
      await _selectMyStand();
      if (_standLocation.isEmpty) return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDeliveryBoy', value);
    setState(() => _isDeliveryBoy = value);
    if (value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const DeliveryBoyHomeScreen()));
    }
  }

  // === आठवडी बाजार ON/OFF ===
  Future<void> _toggleAathwadiBazar(bool value) async {
    if (value && !_isJoinedAathwadiBazar) {
      // ON केल्यावर → ₹50 फी dialog
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('शनिवारच्या आठवडी बाजारात सहभागी व्हा'),
          content: const Text(
            'सहभागासाठी ₹50 फी लागेल. फी तुमच्या Expenses Wallet मधून कापली जाईल.\n\n'
            'फी भरल्यावर तुमचा कॅटलॉग शनिवारच्या बाजारात प्रसिद्ध होईल. '
            'बाजार संपल्यावर कॅटलॉग आपोआप डिलीट होईल.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('रद्द'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(ctx);
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isJoinedAathwadiBazar', true);
                setState(() => _isJoinedAathwadiBazar = true);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('₹50 कपात. तुम्ही आठवडी बाजारात सहभागी झालात! कॅटलॉग बनवा.'),
                      backgroundColor: AppColors.successGreen,
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const WeeklyMarketCatalogScreen()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text('₹50 भरा आणि कॅटलॉग बनवा'),
            ),
          ],
        ),
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isJoinedAathwadiBazar', value);
      setState(() => _isJoinedAathwadiBazar = value);
    }
  }

  // === App refer dialog ===
  void _showReferDialog() {
    const referCode = 'AMOLE-P123';
    const referLink = 'https://amole.in/ref/AMOLE-P123';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.share, color: Colors.green, size: 28),
                SizedBox(width: 10),
                Text('App refer करा आणि पैसे कमवा', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'तुमचा unique refer code आणि link खाली आहे. हे शेअर करा आणि प्रत्येक खरेदीवर रिवॉर्ड पॉइंट कमवा.',
              style: TextStyle(fontSize: 13, color: AppColors.textLight),
            ),
            const SizedBox(height: 16),
            // Refer Code
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.qr_code, color: Colors.green),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('तुमचा Refer Code', style: TextStyle(fontSize: 11, color: AppColors.textLight)),
                        Text(referCode, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.green),
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(text: referCode));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Refer Code कॉपी झाला!')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Refer Link
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.link, color: AppColors.primaryBlue),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SelectableText(
                      referLink,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: AppColors.primaryBlue),
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(text: referLink));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Link कॉपी झाली!')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('शेअर करा:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 10),
            // Share options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _shareIcon(Icons.message, 'SMS', Colors.blue),
                _shareIcon(Icons.chat, 'WhatsApp', Colors.green),
                _shareIcon(Icons.share, 'Instagram', Colors.purple),
                _shareIcon(Icons.facebook, 'Facebook', Colors.blue.shade800),
                _shareIcon(Icons.more_horiz, 'इतर', Colors.grey),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _shareIcon(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label वर शेअर करा (Stage 3)')),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  // === मी जोडलेले buyer dialog ===
  void _showReferredBuyers() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (ctx, scrollController) => Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.people, color: AppColors.primaryBlue),
                  SizedBox(width: 10),
                  Text('मी जोडलेले Buyer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: _referredBuyers.isEmpty
                  ? const Center(child: Text('अजून कोणीही refer केलेलं नाही'))
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: _referredBuyers.length,
                      itemBuilder: (context, index) {
                        final b = _referredBuyers[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                            child: Text(b['name']![0], style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                          ),
                          title: Text(b['name']!, style: const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text('${b['phone']} • ${b['date']}'),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(b['purchases']!, style: const TextStyle(color: AppColors.successGreen, fontWeight: FontWeight.bold)),
                              const Text('खरेदी', style: TextStyle(fontSize: 10, color: AppColors.textLight)),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRegisteredSellers() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('मी रजिस्टर केलेले सेलर', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ..._registeredSellers.map((s) => ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.store)),
                  title: Text(s['name']!),
                  subtitle: Text(s['phone']!),
                  trailing: Text(s['status']!, style: TextStyle(
                    color: s['status'] == 'Approved' ? AppColors.successGreen : AppColors.primaryOrange,
                    fontWeight: FontWeight.bold,
                  )),
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (!_isPromoter) return _buildJoinPromoter();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('प्रमोटर डॅशबोर्ड'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // === Earnings Card (Blue gradient) ===
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryBlue, AppColors.royalBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('प्रमोटर कोड', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Icon(Icons.verified, color: Colors.white, size: 20),
                  ],
                ),
                const Text('AMOLE-P123', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _statBox('एकूण कमाई', '₹450', AppColors.successGreen)),
                    const SizedBox(width: 12),
                    Expanded(child: _statBox('या महिन्याची', '₹150', AppColors.primaryOrange)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // === Expenses Wallet ===
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ExpensesWalletScreen())),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet, color: AppColors.primaryBlue, size: 32),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Expenses Wallet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text('जाहिराती व आठवडी बाजार फीसाठी', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                      ],
                    ),
                  ),
                  Text('₹250', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // === Delivery Boy सेवा ===
          _sectionCard(
            icon: Icons.two_wheeler,
            color: AppColors.primaryOrange,
            title: 'डिलिव्हरी बॉय सेवा',
            subtitle: _isDeliveryBoy
                ? 'सेवा ON - ${_standLocation.isNotEmpty ? _standLocation : "स्टँड सेट करा"}'
                : 'KYC करून डिलिव्हरी बॉय व्हा',
            trailing: Switch(
              value: _isDeliveryBoy,
              onChanged: _toggleDeliveryBoy,
              activeThumbColor: AppColors.primaryOrange,
            ),
            onTap: () {
              if (_standLocation.isEmpty) {
                _selectMyStand();
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const DeliveryBoyHomeScreen()));
              }
            },
          ),

          // === Stand location (Delivery Boy ON असेल तेव्हा) ===
          if (_isDeliveryBoy)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: OutlinedButton.icon(
                onPressed: _standLoading ? null : _selectMyStand,
                icon: _standLoading
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.my_location, color: AppColors.primaryOrange),
                label: Text(
                  _standLoading
                      ? 'लोकेशन घेत आहे...'
                      : (_standLocation.isEmpty ? 'माझं स्टँड सेट करा (GPS)' : 'स्टँड बदला: $_standLocation'),
                  style: const TextStyle(color: AppColors.primaryOrange),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: const BorderSide(color: AppColors.primaryOrange),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),

          // === आठवडी बाजार ON/OFF ===
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0x1A00897B),
                  child: Icon(Icons.storefront, color: Colors.teal),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('शनिवारच्या आठवडी बाजारात सहभागी व्हा', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text(
                        _isJoinedAathwadiBazar ? '₹50 भरले ✓ - बाजारात प्रसिद्ध' : '₹50 फी - ON केल्यावर कॅटलॉग बनवा',
                        style: const TextStyle(fontSize: 11, color: AppColors.textLight),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _isJoinedAathwadiBazar,
                  onChanged: _toggleAathwadiBazar,
                  activeThumbColor: Colors.teal,
                ),
              ],
            ),
          ),

          // === प्रमोशन कॅटलॉग ===
          _sectionCard(
            icon: Icons.inventory_2,
            color: AppColors.primaryBlue,
            title: 'प्रमोशन कॅटलॉग',
            subtitle: 'प्रॉडक्ट्स जोडा आणि प्रमोट करा',
            trailing: const Icon(Icons.arrow_forward, color: AppColors.primaryBlue),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PromoterCatalogScreen())),
          ),

          // === जाहिरात बनवा ===
          _sectionCard(
            icon: Icons.campaign,
            color: Colors.deepOrange,
            title: 'जाहिरात बनवा',
            subtitle: 'पेड जाहिराती तयार करा',
            trailing: const Icon(Icons.arrow_forward, color: Colors.deepOrange),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerAdvertisementScreen())),
          ),

          // === App refer करा ===
          _sectionCard(
            icon: Icons.share,
            color: AppColors.successGreen,
            title: 'App refer करा आणि पैसे कमवा',
            subtitle: 'Unique link + Refer code शेअर करा',
            trailing: const Icon(Icons.arrow_forward, color: AppColors.successGreen),
            onTap: _showReferDialog,
          ),

          // === मी जोडलेले buyer ===
          _sectionCard(
            icon: Icons.people_alt,
            color: Colors.purple,
            title: 'मी जोडलेले buyer',
            subtitle: '${_referredBuyers.length} buyers refer केले',
            trailing: const Icon(Icons.arrow_forward, color: Colors.purple),
            onTap: _showReferredBuyers,
          ),

          // === नवीन सेलर/सर्व्हिस प्रोव्हायडर जोडा ===
          _sectionCard(
            icon: Icons.person_add,
            color: Colors.indigo,
            title: 'नवीन सेलर/सर्व्हिस प्रोव्हायडर जोडा',
            subtitle: 'नवीन सेलर जोडा आणि कमवा',
            trailing: const Icon(Icons.arrow_forward, color: Colors.indigo),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerRegistrationScreen())),
          ),

          // === मी रजिस्टर केलेले सेलर ===
          _sectionCard(
            icon: Icons.people,
            color: Colors.brown,
            title: 'मी रजिस्टर केलेले सेलर',
            subtitle: 'तुम्ही जोडलेल्या सेलर्सची यादी',
            trailing: const Icon(Icons.arrow_forward, color: Colors.brown),
            onTap: _showRegisteredSellers,
          ),
        ],
      ),
    );
  }

  Widget _buildJoinPromoter() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('प्रमोटर'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.campaign, size: 80, color: AppColors.primaryBlue),
              const SizedBox(height: 20),
              const Text('प्रमोटर व्हा आणि कमवा', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text(
                'इतर सेलर्सची प्रॉडक्ट्स शेअर करा, आठवडी बाजारात सहभागी व्हा आणि ५% कमिशन कमवा.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: AppColors.textLight),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _becomePromoter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('प्रमोटर व्हा', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statBox(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
          Text(value, style: TextStyle(color: color == AppColors.successGreen ? Colors.greenAccent : Colors.orangeAccent, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)],
        ),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: color.withValues(alpha: 0.15), child: Icon(icon, color: color)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}