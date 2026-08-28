import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import 'terms_screen.dart';
import 'contact_screen.dart';
import '../admin/admin_home_screen.dart';
import '../franchise/franchise_home_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;

  Future<void> _showSellerNoticeAndProceed() async {
    final proceed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('सूचना'),
        content: const Text('हे फक्त विक्रेते व दुकानदारांसाठी आहे.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('रद्द करा'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('पुढे चला'),
          ),
        ],
      ),
    );
    if (proceed == true) {
      await _confirmRoleAndGoToTerms();
    }
  }

  Future<void> _confirmRoleAndGoToTerms() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_role', _selectedRole!);
    if (mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsScreen()));
    }
  }

  void _goToInquiry(String role) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ContactScreen(role: role)),
    );
  }

  void _onContinue() {
    if (_selectedRole == null) return;

    switch (_selectedRole) {
      case 'seller':
        _showSellerNoticeAndProceed();
        break;
      case 'franchise':
        _goToInquiry('franchise');
        break;
      case 'channel_partner':
        _goToInquiry('channel_partner');
        break;
      default: // buyer
        _confirmRoleAndGoToTerms();
    }
  }

  Widget _buildRoleCard(String code, String title, String subtitle, IconData icon) {
    final isSelected = _selectedRole == code;
    final isInquiryOnly = code == 'franchise' || code == 'channel_partner';
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = code),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue.withValues(alpha: 0.08) : AppColors.white,
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.lightGrey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: isSelected ? AppColors.primaryBlue : AppColors.lightGrey,
              child: Icon(icon, color: isSelected ? AppColors.white : AppColors.textLight),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 14, color: AppColors.textLight)),
                ],
              ),
            ),
            if (isInquiryOnly)
              const Icon(Icons.mail_outline, color: AppColors.textLight, size: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(AppStrings.selectRole, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              const SizedBox(height: 8),
              const Text('Franchise व Channel Partner साठी जॉईन होण्यासाठी संपर्क करावा लागेल ✉️', style: TextStyle(fontSize: 13, color: AppColors.textLight)),
              const SizedBox(height: 28),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildRoleCard('buyer', AppStrings.buyer, AppStrings.buyerSub, Icons.shopping_bag_outlined),
                      _buildRoleCard('seller', AppStrings.seller, AppStrings.sellerSub, Icons.storefront_outlined),
                      _buildRoleCard('franchise', AppStrings.franchise, AppStrings.franchiseSub, Icons.business_outlined),
                      _buildRoleCard('channel_partner', AppStrings.channelPartner, AppStrings.channelPartnerSub, Icons.handshake_outlined),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _selectedRole == null ? null : _onContinue,
                child: const Text(AppStrings.continueText),
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminHomeScreen())),
                  icon: const Icon(Icons.admin_panel_settings_outlined, size: 18, color: AppColors.textLight),
                  label: const Text('Admin Login (Testing Only)', style: TextStyle(color: AppColors.textLight, fontSize: 12)),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: TextButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseHomeScreen())),
                  icon: const Icon(Icons.business_outlined, size: 18, color: AppColors.textLight),
                  label: const Text('Franchise Login (Testing Only)', style: TextStyle(color: AppColors.textLight, fontSize: 12)),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
