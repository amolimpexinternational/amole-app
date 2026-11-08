import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_colors.dart';
import '../seller/expenses_wallet_screen.dart';
import 'promoter_catalog_screen.dart';
import 'promoter_kyc_screen.dart';
import '../seller/registration/seller_registration_screen.dart';
import '../delivery/delivery_boy_home_screen.dart';
import '../seller/seller_advertisement_screen.dart';

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
      _isLoading = false;
    });
  }

  // === KYC स्क्रीन उघडणे ===
  Future<void> _becomePromoter() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const PromoterKycScreen()),
    );

    if (result == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isPromoter', true);
      setState(() => _isPromoter = true);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('अभिनंदन! तुमची KYC सबमिट झाली. फ्रॅंचाईजी व्हेरिफिकेशननंतर तुम्ही प्रमोटर व्हाल 🎉'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _toggleDeliveryBoy(bool value) async {
    if (value && !_isDeliveryBoy) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('डिलिव्हरी बॉय KYC'),
          content: const Text('डिलिव्हरी बॉय म्हणून सुरुवात करण्यासाठी KYC प्रक्रिया पूर्ण करावी लागेल.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द')),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(ctx);
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isDeliveryBoy', true);
                setState(() => _isDeliveryBoy = true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('डिलिव्हरी बॉय सेवा सक्रिय झाली!'), backgroundColor: Colors.green),
                );
                Navigator.push(context, MaterialPageRoute(builder: (_) => const DeliveryBoyHomeScreen()));
              },
              child: const Text('KYC सुरू करा'),
            ),
          ],
        ),
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDeliveryBoy', value);
      setState(() => _isDeliveryBoy = value);
    }
  }

  Future<void> _joinAathwadiBazar() async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('आठवडी बाजारात सहभागी व्हा'),
        content: const Text('सहभागासाठी ₹50 फी लागेल. फी तुमच्या Expenses Wallet मधून कापली जाईल.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isJoinedAathwadiBazar', true);
              setState(() => _isJoinedAathwadiBazar = true);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('₹50 कपात. तुम्ही आठवडी बाजारात सहभागी झालात!'), backgroundColor: Colors.green),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: const Text('₹50 भरा'),
          ),
        ],
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
                    color: s['status'] == 'Approved' ? Colors.green : Colors.orange,
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
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        title: const Text('प्रमोटर डॅशबोर्ड'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Earnings Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.purple, Colors.purpleAccent]),
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
                    Expanded(child: _statBox('एकूण कमाई', '₹450')),
                    const SizedBox(width: 12),
                    Expanded(child: _statBox('या महिन्याची', '₹150')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Expenses Wallet
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ExpensesWalletScreen())),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet, color: Colors.purple.shade400, size: 32),
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
                  Text('₹250', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple.shade400)),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Delivery Boy
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DeliveryBoyHomeScreen())),
            child: _sectionCard(
              icon: Icons.two_wheeler,
              color: Colors.orange,
              title: 'डिलिव्हरी बॉय सेवा',
              subtitle: _isDeliveryBoy ? 'सेवा ON - काम करत आहात' : 'KYC करून डिलिव्हरी बॉय व्हा',
              trailing: Switch(
                value: _isDeliveryBoy,
                onChanged: _toggleDeliveryBoy,
                activeThumbColor: Colors.orange,
              ),
            ),
          ),

          // आठवडी बाजार
          GestureDetector(
            onTap: _isJoinedAathwadiBazar ? null : _joinAathwadiBazar,
            child: _sectionCard(
              icon: Icons.storefront,
              color: Colors.teal,
              title: 'आठवडी बाजार',
              subtitle: _isJoinedAathwadiBazar ? 'सहभाग नोंदवला ✓' : '₹50 फी - सहभागी व्हा',
              trailing: Icon(
                _isJoinedAathwadiBazar ? Icons.check_circle : Icons.arrow_forward,
                color: _isJoinedAathwadiBazar ? Colors.green : Colors.teal,
              ),
            ),
          ),

          // Catalog
          _sectionCard(
            icon: Icons.inventory_2,
            color: Colors.blue,
            title: 'माझा कॅटलॉग',
            subtitle: 'प्रॉडक्ट्स जोडा आणि प्रमोट करा',
            trailing: const Icon(Icons.arrow_forward, color: Colors.blue),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PromoterCatalogScreen())),
          ),

          // Ads
          _sectionCard(
            icon: Icons.campaign,
            color: Colors.purple,
            title: 'जाहिराती',
            subtitle: 'पेड जाहिराती तयार करा',
            trailing: const Icon(Icons.arrow_forward, color: Colors.purple),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerAdvertisementScreen())),
          ),

          // Seller Onboarding
          _sectionCard(
            icon: Icons.person_add,
            color: Colors.indigo,
            title: 'ऑनबोर्ड न्यू सेलर',
            subtitle: 'नवीन सेलर जोडा आणि कमवा',
            trailing: const Icon(Icons.arrow_forward, color: Colors.indigo),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerRegistrationScreen())),
          ),
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
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.campaign, size: 80, color: Colors.purple),
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
                    backgroundColor: Colors.purple,
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

  Widget _statBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
