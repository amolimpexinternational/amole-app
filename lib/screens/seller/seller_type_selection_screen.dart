import 'seller_home_screen.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerTypeSelectionScreen extends StatefulWidget {
  const SellerTypeSelectionScreen({super.key});

  @override
  State<SellerTypeSelectionScreen> createState() => _SellerTypeSelectionScreenState();
}

class _SellerTypeSelectionScreenState extends State<SellerTypeSelectionScreen> {
  String _selectedType = 'local'; // default

  void _continue() {
    // TODO: पुढील टप्प्यात निवडलेल्या प्रकारानुसार (_selectedType) वेगवेगळ्या स्क्रीनवर पाठवा.
    // उदा. Local साठी LocalSellerDashboard, Global साठी GlobalSellerDashboard इत्यादी.
    // सध्या आपण सर्वांना SellerHomeScreen वर पाठवत आहोत.

    // निवडलेला प्रकार (उदा. 'local', 'global') SharedPreferences मध्ये सेव्ह करा
    // जेणेकरून पुढे KYC किंवा Dashboard मध्ये तो वापरता येईल.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SellerHomeScreen()),
    );
  }

  Widget _typeCard({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = _selectedType == id;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withValues(alpha: 0.15),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isSelected ? color : AppColors.textDark)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                ],
              ),
            ),
            Radio<String>(
              value: id,
              groupValue: _selectedType,
              activeColor: color,
              onChanged: (v) => setState(() => _selectedType = v!),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('तुमचा व्यवसाय निवडा'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'तुम्ही प्लॅटफॉर्मवर कोणत्या प्रकारे सेलर म्हणून काम करू इच्छिता?',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark),
          ),
          const SizedBox(height: 16),

          _typeCard(
            id: 'local',
            title: 'लोकल दुकानदार (ZatPat Supplier)',
            subtitle: 'फक्त स्थानिक परिसरात वस्तू विक्री करणारा विक्रेता. (आपल्या गावातील दुकाने आणि ZatPat मध्ये दिसेल)',
            icon: Icons.storefront,
            color: Colors.orange,
          ),
          _typeCard(
            id: 'global',
            title: 'ग्लोबल शॉपिंग (Global Seller)',
            subtitle: 'देशभर वस्तू विक्री करणारा विक्रेता. (Global Shopping मध्ये सर्व ग्राहकांना दिसेल)',
            icon: Icons.language,
            color: Colors.blue,
          ),
          _typeCard(
            id: 'service',
            title: 'सर्व्हिस प्रोव्हायडर',
            subtitle: 'रायडर, डिलिव्हरी बॉय, कार्गो, प्लंबर इत्यादी सेवा देणारा. (एकापेक्षा जास्त सेवा निवडू शकता)',
            icon: Icons.handyman,
            color: Colors.purple,
          ),
          _typeCard(
            id: 'hotel',
            title: 'हॉटेल व्यावसायिक',
            subtitle: 'हॉटेलची उत्पादने ऑनलाइन विकण्यासाठी. (Hotel Food मध्ये दिसेल)',
            icon: Icons.restaurant,
            color: Colors.red,
          ),
          _typeCard(
            id: 'cargo',
            title: 'पार्सल कार्गो',
            subtitle: 'पार्सल कार्गो सेवा पुरवण्यासाठी. (Parcel Cargo मध्ये दिसेल)',
            icon: Icons.local_shipping,
            color: Colors.brown,
          ),

          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _continue,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('पुढे जा (Continue)', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}