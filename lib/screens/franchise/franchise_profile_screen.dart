import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FranchiseProfileScreen extends StatefulWidget {
  const FranchiseProfileScreen({super.key});

  @override
  State<FranchiseProfileScreen> createState() => _FranchiseProfileScreenState();
}

class _FranchiseProfileScreenState extends State<FranchiseProfileScreen> {
  // TODO (Stage 3 - Backend): replace with real photo upload via
  // Firebase Storage. For now, franchise can pick a demo avatar color/icon.
  Color _avatarColor = AppColors.primaryBlue;
  IconData _avatarIcon = Icons.business;

  final List<Map<String, dynamic>> _avatarOptions = [
    {'color': AppColors.primaryBlue, 'icon': Icons.business},
    {'color': Colors.teal, 'icon': Icons.store},
    {'color': Colors.deepOrange, 'icon': Icons.storefront},
    {'color': Colors.purple, 'icon': Icons.apartment},
    {'color': Colors.green, 'icon': Icons.location_city},
  ];

  void _changePhoto() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Photo निवडा', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('(खरा फोटो अपलोड Stage 3 मध्ये जोडला जाईल)',
                style: TextStyle(fontSize: 11, color: AppColors.textLight)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: _avatarOptions.map((opt) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _avatarColor = opt['color'];
                      _avatarIcon = opt['icon'];
                    });
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: (opt['color'] as Color).withOpacity(0.15),
                    child: Icon(opt['icon'], color: opt['color'], size: 28),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primaryBlue),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('माझं प्रोफाइल', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: _avatarColor,
                  child: Icon(_avatarIcon, color: Colors.white, size: 44),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _changePhoto,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryOrange,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('AMOLE Franchise — हडपसर', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const Text('AM-IN-MH-PN-F-000001', style: TextStyle(fontSize: 13, color: AppColors.textLight)),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoTile(Icons.person_outlined, 'मालकाचं नाव', 'विशाल जाधव'),
                  _infoTile(Icons.phone_outlined, 'मोबाईल नंबर', '+91 9999999999'),
                  _infoTile(Icons.location_on_outlined, 'क्षेत्र', 'पुणे — हडपसर तालुका'),
                  _infoTile(Icons.calendar_today_outlined, 'सामील झाले', '१५ जानेवारी २०२५'),
                  _infoTile(Icons.storefront_outlined, 'एकूण Sellers', '48'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 18, color: Colors.blue.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'नाव, मोबाईल नंबर व इतर माहिती फक्त Channel Partner किंवा Admin बदलू शकतात. Photo मात्र तुम्ही स्वतः वरील कॅमेरा आयकॉनने बदलू शकता.',
                      style: TextStyle(fontSize: 11.5, color: Colors.blue.shade900),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
                onPressed: () {},
                icon: const Icon(Icons.logout_outlined),
                label: const Text('Logout करा'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
