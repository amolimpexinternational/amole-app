import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_colors.dart';
import 'seller_home_screen.dart';

class SellerTypeSelectionScreen extends StatefulWidget {
  const SellerTypeSelectionScreen({super.key});

  @override
  State<SellerTypeSelectionScreen> createState() => _SellerTypeSelectionScreenState();
}

class _SellerTypeSelectionScreenState extends State<SellerTypeSelectionScreen> {
  final Set<String> _selectedTypes = {'local'};

  Future<void> _continue() async {
    if (_selectedTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('किमान एक प्रकार निवडा'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // === निवडलेले प्रकार SharedPreferences मध्ये सेव्ह ===
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('sellerTypes', _selectedTypes.toList());

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SellerHomeScreen()),
    );
  }

  void _toggleType(String id) {
    setState(() {
      if (_selectedTypes.contains(id)) {
        // किमान १ ठेवा
        if (_selectedTypes.length > 1) {
          _selectedTypes.remove(id);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('किमान एक प्रकार निवडलेला असणे आवश्यक'),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 1),
            ),
          );
        }
      } else {
        _selectedTypes.add(id);
      }
    });
  }

  Widget _typeCard({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = _selectedTypes.contains(id);
    return GestureDetector(
      onTap: () => _toggleType(id),
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
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: isSelected ? color : AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: AppColors.textLight),
                  ),
                ],
              ),
            ),
            // ✅ Checkbox — multiple selection
            Checkbox(
              value: isSelected,
              activeColor: color,
              onChanged: (_) => _toggleType(id),
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue.shade800, size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'एकापेक्षा जास्त प्रकार निवडू शकता. निवडलेले प्रकार तुमच्या डॅशबोर्डमध्ये दिसतील.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'तुम्ही प्लॅटफॉर्मवर कोणत्या प्रकारे सेलर म्हणून काम करू इच्छिता?',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark),
          ),
          const SizedBox(height: 16),

          _typeCard(
            id: 'local',
            title: 'लोकल दुकानदार (ZatPat Supplier)',
            subtitle: 'फक्त स्थानिक परिसरात वस्तू विक्री. (गावातील दुकाने + ZatPat)',
            icon: Icons.storefront,
            color: Colors.orange,
          ),
          _typeCard(
            id: 'global',
            title: 'ग्लोबल शॉपिंग (Global Seller)',
            subtitle: 'देशभर वस्तू विक्री. (Global Shopping मध्ये सर्व ग्राहकांना)',
            icon: Icons.language,
            color: Colors.blue,
          ),
          _typeCard(
            id: 'service',
            title: 'सर्व्हिस प्रोव्हायडर',
            subtitle: 'रायडर, डिलिव्हरी बॉय, कार्गो, प्लंबर इ. (एकापेक्षा जास्त सेवा)',
            icon: Icons.handyman,
            color: Colors.purple,
          ),
          _typeCard(
            id: 'hotel',
            title: 'हॉटेल व्यावसायिक',
            subtitle: 'हॉटेलची उत्पादने ऑनलाइन विकण्यासाठी. (Hotel Food)',
            icon: Icons.restaurant,
            color: Colors.red,
          ),
          _typeCard(
            id: 'cargo',
            title: 'पार्सल कार्गो',
            subtitle: 'पार्सल कार्गो सेवा. (Parcel Cargo मध्ये दिसेल)',
            icon: Icons.local_shipping,
            color: Colors.brown,
          ),

          const SizedBox(height: 16),
          // === निवडलेल्या प्रकारांची संख्या ===
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, color: AppColors.primaryBlue, size: 18),
                const SizedBox(width: 6),
                Text(
                  '${_selectedTypes.length} प्रकार निवडले',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _continue,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'पुढे जा (Continue)',
                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
