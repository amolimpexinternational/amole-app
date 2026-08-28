import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class ReferredUsersScreen extends StatefulWidget {
  const ReferredUsersScreen({super.key});

  @override
  State<ReferredUsersScreen> createState() => _ReferredUsersScreenState();
}

class _ReferredUsersScreenState extends State<ReferredUsersScreen> {
  final String _myReferralCode = 'AMOLE-RAJ-4821';
  final String _myReferralLink = 'amole.in/ref/AMOLE-RAJ-4821';

  final List<Map<String, dynamic>> _referredUsers = [
    {'name': 'अनिल जोशी', 'role': 'Buyer', 'joinDate': '15 Aug 2026', 'totalPurchase': '1200', 'myEarning': '3.00', 'isActive': true, 'avatar': 'A', 'avatarColor': 0xFF1565C0},
    {'name': 'संगीता राणे', 'role': 'Buyer', 'joinDate': '10 Aug 2026', 'totalPurchase': '3500', 'myEarning': '8.75', 'isActive': true, 'avatar': 'S', 'avatarColor': 0xFFE91E63},
    {'name': 'रमेश पाटील', 'role': 'Seller', 'joinDate': '2 Aug 2026', 'totalPurchase': '850', 'myEarning': '2.13', 'isActive': true, 'avatar': 'R', 'avatarColor': 0xFF43A047},
    {'name': 'प्रिया देशमुख', 'role': 'Buyer', 'joinDate': '28 Jul 2026', 'totalPurchase': '0', 'myEarning': '0.00', 'isActive': false, 'avatar': 'P', 'avatarColor': 0xFFFF8F00},
  ];

  void _shareReferral() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Referral Share करा", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(child: Text(_myReferralLink, style: const TextStyle(fontSize: 14, color: AppColors.primaryBlue))),
                  IconButton(
                    onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Link Copy झाली!"), backgroundColor: Colors.green)); },
                    icon: const Icon(Icons.copy, color: AppColors.primaryBlue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: ElevatedButton.icon(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("WhatsApp वर Share होत आहे..."))); }, icon: const Icon(Icons.chat, color: Colors.white), label: const Text("WhatsApp", style: TextStyle(color: Colors.white)), style: ElevatedButton.styleFrom(backgroundColor: Colors.green))),
                const SizedBox(width: 12),
                Expanded(child: ElevatedButton.icon(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("SMS पाठवत आहे..."))); }, icon: const Icon(Icons.sms, color: Colors.white), label: const Text("SMS", style: TextStyle(color: Colors.white)), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalEarning = _referredUsers.fold<double>(0, (sum, u) => sum + (double.tryParse(u["myEarning"].toString()) ?? 0));
    final activeCount = _referredUsers.where((u) => u["isActive"] == true).length;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text("माझे Referrals"),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
        actions: [IconButton(onPressed: _shareReferral, icon: const Icon(Icons.share, color: Colors.white))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppColors.primaryBlue, AppColors.royalBlue], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text("माझा Referral Code", style: TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 8),
                  Text(_myReferralCode, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat("एकूण Referrals", "${_referredUsers.length}", Colors.white),
                      _buildStat("Active", "$activeCount", Colors.greenAccent),
                      _buildStat("एकूण कमाई", "₹${totalEarning.toStringAsFixed(2)}", AppColors.primaryOrange),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _shareReferral,
                      icon: const Icon(Icons.share, color: AppColors.primaryBlue),
                      label: const Text("Referral Link Share करा", style: TextStyle(color: AppColors.primaryBlue)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Referral कसे काम करते?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                  const SizedBox(height: 10),
                  _buildHowRow("1", "तुमची Referral Link मित्रांना शेअर करा"),
                  _buildHowRow("2", "मित्र त्या Link वरून AMOLE Join होतो"),
                  _buildHowRow("3", "त्याच्या प्रत्येक खरेदीवर तुम्हाला 0.25% Reward Points"),
                  _buildHowRow("4", "हे Reward Points कायमस्वरूपी मिळत राहतात"),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text("Referred युजर्स", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const Spacer(),
                  Text("${_referredUsers.length} जण", style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ..._referredUsers.map((user) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: user["isActive"] == true ? Colors.green.shade100 : AppColors.lightGrey),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Color(user["avatarColor"] as int).withOpacity(0.15),
                    child: Text(user['avatar'], style: TextStyle(color: Color(user["avatarColor"] as int), fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(user['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                            child: Text(user['role'], style: const TextStyle(fontSize: 10, color: AppColors.primaryBlue)),
                          ),
                        ]),
                        const SizedBox(height: 3),
                        Text("Joined: ${user['joinDate']}", style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                        Text("एकूण खरेदी: ₹${user['totalPurchase']}", style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: user["isActive"] == true ? Colors.green.shade50 : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(user['isActive'] == true ? 'Active' : 'Inactive', style: TextStyle(fontSize: 10, color: user['isActive'] == true ? Colors.green : Colors.grey, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 6),
                      Text("कमाई: ₹${user['myEarning']}", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.successGreen)),
                    ],
                  ),
                ],
              ),
            )),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
      ],
    );
  }

  Widget _buildHowRow(String step, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(width: 24, height: 24, decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle), child: Center(child: Text(step, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)))),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textDark))),
        ],
      ),
    );
  }
}
