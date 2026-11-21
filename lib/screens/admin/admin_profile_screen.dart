import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../constants/app_colors.dart';
import 'admin_channel_partners_screen.dart';
import 'admin_subadmin_screen.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  // === Admin Info ===
  String _adminName = 'Amole Admin';
  String _adminMobile = '+91 98765 00001';
  String _adminEmail = 'admin@amole.in';
  String _adminCode = 'AM-ADMIN-000001';

  // === Company Info ===
  String _companyName = 'Amol Impex International';
  String _companyAddress = 'हडपसर, पुणे, महाराष्ट्र — 411028';
  String _companyGST = '27ABCDE1234F1Z5';
  String _companyWebsite = 'www.amole.in';
  String _companyTagline = 'माझा पैसा माझ्या खिशात, आपल्या लोकांचा आपला बाजार';

  // === Logo ===
  File? _logoFile;

  Future<void> _pickLogo(ImageSource source) async {
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 500,
      );
      if (picked != null) {
        setState(() => _logoFile = File(picked.path));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Logo अपडेट झाला'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logo निवडता आलं नाही: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showLogoOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined,
                  color: AppColors.primaryBlue),
              title: const Text('गॅलरीतून निवडा'),
              onTap: () {
                Navigator.pop(ctx);
                _pickLogo(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined,
                  color: AppColors.primaryBlue),
              title: const Text('कॅमेऱ्यातून निवडा'),
              onTap: () {
                Navigator.pop(ctx);
                _pickLogo(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editAdminInfo() {
    final nameCtrl = TextEditingController(text: _adminName);
    final mobileCtrl = TextEditingController(text: _adminMobile);
    final emailCtrl = TextEditingController(text: _adminEmail);
    final codeCtrl = TextEditingController(text: _adminCode);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.edit, color: AppColors.primaryBlue),
            SizedBox(width: 8),
            Text('Admin माहिती Edit'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _editField('नाव', nameCtrl),
              const SizedBox(height: 10),
              _editField('मोबाईल', mobileCtrl,
                  keyboard: TextInputType.phone),
              const SizedBox(height: 10),
              _editField('Email', emailCtrl,
                  keyboard: TextInputType.emailAddress),
              const SizedBox(height: 10),
              _editField('Admin Code', codeCtrl),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('रद्द')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _adminName = nameCtrl.text.trim();
                _adminMobile = mobileCtrl.text.trim();
                _adminEmail = emailCtrl.text.trim();
                _adminCode = codeCtrl.text.trim();
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('✅ Admin माहिती अपडेट झाली'),
                    backgroundColor: Colors.green),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue),
            child: const Text('जतन करा', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _editCompanyInfo() {
    final nameCtrl = TextEditingController(text: _companyName);
    final addressCtrl = TextEditingController(text: _companyAddress);
    final gstCtrl = TextEditingController(text: _companyGST);
    final webCtrl = TextEditingController(text: _companyWebsite);
    final taglineCtrl = TextEditingController(text: _companyTagline);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.business, color: AppColors.primaryBlue),
            SizedBox(width: 8),
            Text('कंपनी माहिती Edit'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _editField('कंपनीचे नाव', nameCtrl),
              const SizedBox(height: 10),
              _editField('पत्ता', addressCtrl, maxLines: 2),
              const SizedBox(height: 10),
              _editField('GST क्रमांक', gstCtrl),
              const SizedBox(height: 10),
              _editField('Website', webCtrl),
              const SizedBox(height: 10),
              _editField('Tagline', taglineCtrl, maxLines: 2),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('रद्द')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _companyName = nameCtrl.text.trim();
                _companyAddress = addressCtrl.text.trim();
                _companyGST = gstCtrl.text.trim();
                _companyWebsite = webCtrl.text.trim();
                _companyTagline = taglineCtrl.text.trim();
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('✅ कंपनी माहिती अपडेट झाली'),
                    backgroundColor: Colors.green),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue),
            child: const Text('जतन करा', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _editField(String label, TextEditingController ctrl,
      {TextInputType? keyboard, int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboard,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        isDense: true,
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('लॉगआउट करायचं?'),
        content: const Text('तुम्ही पुन्हा लॉगिन करू शकता.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('रद्द')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child:
                const Text('लॉगआउट', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Admin Profile',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // === Profile Header ===
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Column(
              children: [
                // Logo (editable)
                Stack(
                  children: [
                    GestureDetector(
                      onTap: _showLogoOptions,
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor:
                            AppColors.primaryBlue.withValues(alpha: 0.1),
                        backgroundImage: _logoFile != null
                            ? FileImage(_logoFile!)
                            : null,
                        child: _logoFile == null
                            ? const Icon(Icons.person,
                                size: 44, color: AppColors.primaryBlue)
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _showLogoOptions,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryBlue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt,
                              size: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_adminName,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark)),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: _editAdminInfo,
                      child: const Icon(Icons.edit,
                          size: 16, color: AppColors.primaryBlue),
                    ),
                  ],
                ),
                Text(_adminCode,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textLight)),
                const SizedBox(height: 4),
                Text(_adminMobile,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textLight)),
                Text(_adminEmail,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textLight)),
                const SizedBox(height: 14),
                // Stats
                Row(
                  children: [
                    _miniStat('8', 'CP', Colors.indigo),
                    _divider(),
                    _miniStat('85', 'Franchise', AppColors.primaryBlue),
                    _divider(),
                    _miniStat('1,420', 'Sellers', Colors.teal),
                    _divider(),
                    _miniStat('8,250', 'Buyers', Colors.purple),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // === Admin Information ===
          _sectionTitle('👤 Admin माहिती'),
          _menuTile(Icons.edit_outlined, 'Admin माहिती Edit',
              subtitle: 'नाव, मोबाईल, Email, कोड',
              onTap: _editAdminInfo),
          _menuTile(Icons.photo_camera_outlined, 'Logo / फोटो Edit',
              subtitle: 'प्रोफाइल फोटो बदला', onTap: _showLogoOptions),
          _menuTile(Icons.business_outlined, 'कंपनी माहिती',
              subtitle: 'नाव, पत्ता, GST, Website',
              onTap: _editCompanyInfo),

          const SizedBox(height: 16),
          _sectionTitle('🏢 व्यवस्थापन'),

          // Channel Partners
          _menuTile(
            Icons.hub_outlined,
            'Channel Partners व्यवस्थापन',
            subtitle: 'एकूण 8 CP — Add / ON-OFF / Edit',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const AdminChannelPartnersScreen()),
            ).then((_) => setState(() {})),
          ),

          // Sub Admin
          _menuTile(
            Icons.admin_panel_settings_outlined,
            'Sub-Admin व्यवस्थापन',
            subtitle: 'नवीन Sub-Admin जोडा + ON/OFF',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const AdminSubAdminScreen()),
            ).then((_) => setState(() {})),
          ),

          const SizedBox(height: 16),
          _sectionTitle('⚙️ सेटिंग्ज'),

          _menuTile(Icons.settings_outlined, 'ॲप सेटिंग्ज',
              subtitle: 'Notifications, Theme, Language',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('सेटिंग्ज — Stage 3 मध्ये'),
                      backgroundColor: AppColors.primaryBlue),
                );
              }),
          _menuTile(Icons.help_outline, 'मदत / सपोर्ट',
              subtitle: 'FAQ, Contact Support',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Support — Stage 3 मध्ये'),
                      backgroundColor: AppColors.primaryBlue),
                );
              }),
          _menuTile(Icons.info_outline, 'About Amole',
              subtitle: 'Version 1.0.0 · Amol Impex International',
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Amole',
                  applicationVersion: '1.0.0',
                  applicationLegalese: _companyName,
                  children: [
                    const SizedBox(height: 12),
                    Text(_companyTagline,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 13)),
                    const SizedBox(height: 8),
                    Text(_companyAddress,
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(_companyWebsite,
                        style: const TextStyle(fontSize: 12)),
                  ],
                );
              }),

          const SizedBox(height: 16),
          _menuTile(
            Icons.logout,
            'लॉगआउट',
            color: Colors.red,
            onTap: _showLogoutDialog,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _miniStat(String value, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          Text(label,
              style:
                  const TextStyle(fontSize: 10, color: AppColors.textLight)),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 24,
      color: Colors.grey.shade300,
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(title,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark)),
    );
  }

  Widget _menuTile(IconData icon, String title,
      {String? subtitle, Color? color, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 18,
          backgroundColor: (color ?? AppColors.primaryBlue).withValues(alpha: 0.12),
          child: Icon(icon, color: color ?? AppColors.primaryBlue, size: 20),
        ),
        title: Text(title,
            style: TextStyle(
                color: color ?? AppColors.textDark,
                fontWeight: FontWeight.w600,
                fontSize: 14)),
        subtitle: subtitle != null
            ? Text(subtitle,
                style: const TextStyle(fontSize: 11))
            : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}