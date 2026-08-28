import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class LuckyDrawScreen extends StatefulWidget {
  const LuckyDrawScreen({super.key});

  @override
  State<LuckyDrawScreen> createState() => _LuckyDrawScreenState();
}

class _LuckyDrawScreenState extends State<LuckyDrawScreen> {
  bool _ticketBought = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Lucky Draw 🏆', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6A1B9A), Color(0xFF1565C0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text('🎰', style: TextStyle(fontSize: 60)),
                  const SizedBox(height: 12),
                  const Text('आजचा Lucky Draw', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('रात्री ८:०० वाजता', style: TextStyle(color: Colors.white70, fontSize: 15)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(30)),
                    child: const Text('🏆 पहिला बक्षीस: ₹10,000', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('बक्षीस यादी', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 12),
                  _buildPrizeRow('🥇', '1st', '₹10,000'),
                  _buildPrizeRow('🥈', '2nd', '₹5,000'),
                  _buildPrizeRow('🥉', '3rd', '₹2,000'),
                  _buildPrizeRow('🎁', '4th-10th', '₹500 प्रत्येकी'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('टिकीट माहिती', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('एका टिकीटाची किंमत', style: TextStyle(color: AppColors.textLight)),
                      const Text('₹5', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('तुमचे Loyalty Points', style: TextStyle(color: AppColors.textLight)),
                      const Text('245 pts', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (!_ticketBought)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A1B9A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => setState(() => _ticketBought = true),
                  child: const Text('₹5 मध्ये टिकीट घ्या 🎟️', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.green.shade300)),
                child: const Column(
                  children: [
                    Text('🎟️ टिकीट यशस्वीरित्या घेतलं!', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 4),
                    Text('रात्री ८:०० वाजता निकाल जाहीर होईल', style: TextStyle(color: Colors.green, fontSize: 13)),
                  ],
                ),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPrizeRow(String emoji, String rank, String prize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Text(rank, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const Spacer(),
          Text(prize, style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
