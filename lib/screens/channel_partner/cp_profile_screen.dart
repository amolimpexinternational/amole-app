import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CpProfileScreen extends StatelessWidget {
  const CpProfileScreen({super.key});

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppColors.primaryBlue.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: AppColors.primaryBlue, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            ]),
          ),
          const Icon(Icons.lock_outline, size: 16, color: AppColors.textLight),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
        ]),
      ),
    );
  }

  void _showChangePhotoDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Profile फोटो बदला', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined, color: AppColors.primaryBlue),
              title: const Text('कॅमेराने फोटो काढा'),
              onTap: () {
                // TODO: capture photo via camera and upload to Firebase Storage
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined, color: AppColors.primaryBlue),
              title: const Text('गॅलरीतून निवडा'),
              onTap: () {
                // TODO: pick photo from gallery and upload to Firebase Storage
                Navigator.pop(ctx);
              },
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
        backgroundColor: AppColors.primaryBlue,
        title: const Text('माझं Profile', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryBlue, AppColors.royalBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 42,
                      backgroundColor: AppColors.white,
                      child: Icon(Icons.person, color: AppColors.primaryBlue, size: 46),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => _showChangePhotoDialog(context),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(color: AppColors.primaryOrange, shape: BoxShape.circle),
                          child: const Icon(Icons.camera_alt, color: AppColors.white, size: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('राजेश कुलकर्णी', style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                  child: const Text('Channel Partner — पुणे जिल्हा', style: TextStyle(color: AppColors.white, fontSize: 13)),
                ),
                const SizedBox(height: 8),
                const Text('CP-PUN-2024-001', style: TextStyle(color: AppColors.cyan, fontSize: 13, fontWeight: FontWeight.w600)),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    _buildStatCard('Franchise', '8', AppColors.primaryBlue),
                    const SizedBox(width: 10),
                    _buildStatCard('Sellers', '142', AppColors.successGreen),
                    const SizedBox(width: 10),
                    _buildStatCard('Buyers', '3,250', AppColors.primaryOrange),
                  ]),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(10)),
                    child: const Row(children: [
                      Icon(Icons.info_outline, color: AppColors.primaryBlue, size: 18),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'खालील माहिती फक्त Admin किंवा Sub-Admin बदलू शकतात. बदल हवा असल्यास त्यांच्याशी संपर्क साधा. फक्त प्रोफाइल फोटो तुम्ही स्वतः बदलू शकता (वरील कॅमेरा आयकॉन).',
                          style: TextStyle(fontSize: 12, color: AppColors.textDark),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.lightGrey)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('वैयक्तिक माहिती', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                        const Divider(height: 20),
                        _buildInfoRow(Icons.phone_outlined, 'मोबाईल', '+91 98765 43210'),
                        _buildInfoRow(Icons.email_outlined, 'Email', 'rajesh@amole.in'),
                        _buildInfoRow(Icons.location_on_outlined, 'जिल्हा', 'पुणे जिल्हा, महाराष्ट्र'),
                        _buildInfoRow(Icons.calendar_today_outlined, 'Join Date', 'जानेवारी 2024'),
                        _buildInfoRow(Icons.verified_outlined, 'KYC Status', 'Verified ✅'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.lightGrey)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Revenue Summary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                        const Divider(height: 20),
                        _buildInfoRow(Icons.trending_up, 'या महिन्याचं Revenue', '₹38,400'),
                        _buildInfoRow(Icons.account_balance_wallet_outlined, 'Revenue Share (10%)', '₹3,840'),
                        _buildInfoRow(Icons.star_outline, 'एकूण Revenue (2024)', '₹1,92,000'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Logout'),
                            content: const Text('तुम्हाला खरंच logout करायचं आहे का?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('नाही')),
                              ElevatedButton(
                                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.errorRed),
                                child: const Text('Logout', style: TextStyle(color: AppColors.white)),
                              ),
                            ],
                          ),
                        );
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
