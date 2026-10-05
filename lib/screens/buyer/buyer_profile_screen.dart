import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'reward_wallet_screen.dart';
import 'lucky_draw_screen.dart';
import 'order_tracking_screen.dart';
import 'buyer_notification_screen.dart';
import 'referred_users_screen.dart';
import 'buyer_social_profile_screen.dart';

class BuyerProfileScreen extends StatefulWidget {
  const BuyerProfileScreen({super.key});

  @override
  State<BuyerProfileScreen> createState() => _BuyerProfileScreenState();
}

class _BuyerProfileScreenState extends State<BuyerProfileScreen> {
  String? _profession;
  DateTime? _dob;
  String? _gender;

  String _profileName = 'राहुल शर्मा';
  IconData _profileIcon = Icons.person;

  final TextEditingController _pincodeController = TextEditingController(text: '411028');
  final TextEditingController _addressController = TextEditingController(text: 'हडपसर');
  final TextEditingController _talukaController = TextEditingController(text: 'हवेली');
  final TextEditingController _districtController = TextEditingController(text: 'पुणे');
  final TextEditingController _stateController = TextEditingController(text: 'महाराष्ट्र');

  static const List<Map<String, dynamic>> _professionOptions = [
    {'label': 'विद्यार्थी', 'icon': Icons.school_outlined},
    {'label': 'शेतकरी', 'icon': Icons.agriculture_outlined},
    {'label': 'खाजगी नोकरी', 'icon': Icons.badge_outlined},
    {'label': 'सरकारी नोकरी', 'icon': Icons.account_balance_outlined},
    {'label': 'स्वयंरोजगार / व्यवसाय', 'icon': Icons.storefront_outlined},
    {'label': 'गृहिणी', 'icon': Icons.home_outlined},
    {'label': 'निवृत्त', 'icon': Icons.elderly_outlined},
    {'label': 'इतर', 'icon': Icons.more_horiz_outlined},
  ];

  static const List<String> _genderOptions = ['पुरुष', 'स्त्री', 'इतर'];

  @override
  void dispose() {
    _pincodeController.dispose();
    _addressController.dispose();
    _talukaController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  void _editProfileName() {
    final controller = TextEditingController(text: _profileName);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('नाव बदला'),
        content: TextField(
          controller: controller,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'पूर्ण नाव',
            hintText: 'तुमचे नाव टाका',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.dispose();
              Navigator.pop(context);
            },
            child: const Text('रद्द करा'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() => _profileName = controller.text.trim());
              }
              controller.dispose();
              Navigator.pop(context);
            },
            child: const Text('जतन करा'),
          ),
        ],
      ),
    );
  }

  void _editProfilePhoto() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'प्रोफाइल फोटो बदला',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('कॅमेरा — Demo'),
              onTap: () {
                setState(() => _profileIcon = Icons.account_circle);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Demo प्रोफाइल फोटो निवडला')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('गॅलरी — Demo'),
              onTap: () {
                setState(() => _profileIcon = Icons.account_circle);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Demo प्रोफाइल फोटो निवडला')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Default फोटो'),
              onTap: () {
                setState(() => _profileIcon = Icons.person);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editAddress() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('माझा पत्ता'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _addressController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'संपूर्ण पत्ता',
                  hintText: 'घर क्रमांक, रस्ता, परिसर',
                  prefixIcon: Icon(Icons.home_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _talukaController,
                decoration: const InputDecoration(
                  labelText: 'तालुका',
                  prefixIcon: Icon(Icons.location_city_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _districtController,
                decoration: const InputDecoration(
                  labelText: 'जिल्हा',
                  prefixIcon: Icon(Icons.map_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _stateController,
                decoration: const InputDecoration(
                  labelText: 'राज्य',
                  prefixIcon: Icon(Icons.public_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _pincodeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: 'पिनकोड',
                  hintText: '६ अंकी पिनकोड टाका',
                  prefixIcon: Icon(Icons.pin_drop_outlined),
                  counterText: '',
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _addressController.text = 'हडपसर, पुणे';
                      _talukaController.text = 'हवेली';
                      _districtController.text = 'पुणे';
                      _stateController.text = 'महाराष्ट्र';
                      _pincodeController.text = '411028';
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Demo GPS location निवडली'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.my_location),
                  label: const Text('GPS नुसार लोकेशन निवडा'),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('रद्द करा'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('पत्ता जतन करा'),
          ),
        ],
      ),
    );
  }

  void _showProfessionPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('तुमचा व्यवसाय/प्रोफेशन निवडा', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 16),
            ..._professionOptions.map((p) => ListTile(
                  leading: Icon(p['icon'] as IconData, color: AppColors.primaryBlue),
                  title: Text(p['label'] as String),
                  trailing: _profession == p['label'] ? const Icon(Icons.check_circle, color: AppColors.successGreen) : null,
                  onTap: () {
                    setState(() => _profession = p['label'] as String);
                    Navigator.pop(context);
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showGenderPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('लिंग निवडा', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 16),
            ..._genderOptions.map((g) => ListTile(
                  title: Text(g),
                  trailing: _gender == g ? const Icon(Icons.check_circle, color: AppColors.successGreen) : null,
                  onTap: () {
                    setState(() => _gender = g);
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _dob = picked);
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, String subtitle, Color iconColor, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textDark)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textLight),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dobText = _dob == null ? 'निवडलेली नाही — टॅप करून निवडा' : '${_dob!.day}/${_dob!.month}/${_dob!.year}';
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primaryBlue,
            iconTheme: const IconThemeData(color: AppColors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primaryBlue, AppColors.royalBlue],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: _editProfilePhoto,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: AppColors.white,
                              child: Icon(_profileIcon, size: 45, color: AppColors.primaryBlue),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _editProfilePhoto,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryOrange,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.edit, size: 14, color: AppColors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _editProfileName,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _profileName,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.edit,
                              size: 16,
                              color: AppColors.white,
                            ),
                          ],
                        ),
                      ),
                      const Text('+91 98765 43210', style: TextStyle(color: AppColors.white, fontSize: 13)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryOrange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('245 Loyalty Points', style: TextStyle(color: AppColors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('माझे खाते', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 10),
                  _buildMenuItem(context, Icons.shopping_bag_outlined, 'माझे ऑर्डर', 'सर्व orders बघा', AppColors.primaryBlue, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderTrackingScreen()))),
                  _buildMenuItem(context, Icons.star_outline, 'Loyalty Points', '245 points शिल्लक', AppColors.primaryOrange, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardWalletScreen()))),
                  _buildMenuItem(context, Icons.card_giftcard_outlined, 'Lucky Draw', 'आजचा draw संध्याकाळी 4 PM', AppColors.successGreen, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LuckyDrawScreen()))),
                  _buildMenuItem(context, Icons.people_outline, 'Referral', 'मित्रांना invite करा', AppColors.cyan, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReferredUsersScreen()))),
                  _buildMenuItem(
                    context,
                    Icons.public,
                    'माझा सोशल प्रोफाईल',
                    'Preview / माझे प्रोफाईल कसे दिसेल',
                    AppColors.primaryBlue,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BuyerSocialProfileScreen(),
                      ),
                    ),
                  ),
                  _buildMenuItem(context, Icons.work_outline, 'व्यवसाय / प्रोफेशन', _profession ?? 'निवडलेले नाही — टॅप करून निवडा', Colors.brown, _showProfessionPicker),
                  _buildMenuItem(context, Icons.cake_outlined, 'जन्मतारीख', dobText, Colors.pink, _pickDob),
                  _buildMenuItem(context, Icons.wc_outlined, 'लिंग', _gender ?? 'निवडलेले नाही — टॅप करून निवडा', Colors.deepPurple, _showGenderPicker),
                  const SizedBox(height: 16),
                  const Text('सेटिंग्ज', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 10),
                  _buildMenuItem(
                    context,
                    Icons.location_on_outlined,
                    'माझा पत्ता',
                    '${_addressController.text}, ${_talukaController.text}, ${_districtController.text}, ${_stateController.text} — ${_pincodeController.text}',
                    AppColors.primaryBlue,
                    _editAddress,
                  ),
                  _buildMenuItem(context, Icons.language_outlined, 'भाषा', 'मराठी', AppColors.primaryOrange, () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('भाषा बदल — लवकरच येणार!')))),
                  _buildMenuItem(context, Icons.notifications_outlined, 'Notifications', 'चालू आहे', AppColors.successGreen, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BuyerNotificationScreen()))),
                  _buildMenuItem(context, Icons.help_outline, 'Help & Support', 'आम्हाला संपर्क करा', AppColors.textLight, () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Support: support@amole.in | amole.in')))),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      icon: const Icon(Icons.logout, color: AppColors.errorRed),
                      label: const Text('Logout', style: TextStyle(color: AppColors.errorRed, fontSize: 16)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.errorRed),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      children: const [
                        Text('AMOLE v1.0.0', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                        Text('amole.in', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
