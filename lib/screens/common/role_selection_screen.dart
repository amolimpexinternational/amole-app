import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import 'terms_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;

  Widget _buildRoleCard(String code, String title, String subtitle, IconData icon) {
    final bool isSelected = _selectedRole == code;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = code;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue.withOpacity(0.08) : AppColors.white,
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
              backgroundColor: isSelected
                  ? AppColors.primaryBlue
                  : AppColors.lightGrey,
              child: Icon(
                icon,
                color: isSelected ? AppColors.white : AppColors.textLight,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToTerms() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TermsScreen()),
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
              const Text(
                AppStrings.selectRole,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 28),
              _buildRoleCard('buyer', AppStrings.buyer, AppStrings.buyerSub, Icons.shopping_bag_outlined),
              _buildRoleCard('seller', AppStrings.seller, AppStrings.sellerSub, Icons.storefront_outlined),
              _buildRoleCard('franchise', AppStrings.franchise, AppStrings.franchiseSub, Icons.business_outlined),
              _buildRoleCard('channel_partner', AppStrings.channelPartner, AppStrings.channelPartnerSub, Icons.handshake_outlined),
              const Spacer(),
              ElevatedButton(
                onPressed: _selectedRole == null ? null : _goToTerms,
                child: const Text(AppStrings.continueText),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
