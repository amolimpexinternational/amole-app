import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class LuckyDrawScreen extends StatefulWidget {
  const LuckyDrawScreen({super.key});

  @override
  State<LuckyDrawScreen> createState() => _LuckyDrawScreenState();
}

class _LuckyDrawScreenState extends State<LuckyDrawScreen> {
  bool _ticketBought = false;

  // TODO (Stage 3 - Backend): आजचे प्रत्यक्ष तिकीट-विक्री आकडे Firestore मधून येतील
  final int _ticketsSoldToday = 240;

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textLight, fontSize: 13)),
          Text(value, style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double totalPool = _ticketsSoldToday * 5 * 0.5; // ५०% पूल (Blueprint ११.२)
    final int winnersCount = (_ticketsSoldToday * 0.05).round().clamp(1, 999); // ५% विजेते
    final double perWinner = totalPool / winnersCount;

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
                  const Text('निकाल — संध्याकाळी ४:०० वाजता', style: TextStyle(color: Colors.white70, fontSize: 15)),
                  const Text('(तिकीट घेण्याची शेवटची वेळ: ३:५०)', style: TextStyle(color: Colors.white60, fontSize: 12)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(30)),
                    child: Text('🏆 आजचा अंदाजित बक्षीस Pool: ${totalPool.toStringAsFixed(0)} Points',
                        style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
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
                  const Text('बक्षीस कसं ठरतं?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 12),
                  _buildInfoRow('आज विकलेली तिकिटं', '$_ticketsSoldToday'),
                  _buildInfoRow('बक्षीस Pool (विक्रीच्या ५०%)', '${totalPool.toStringAsFixed(0)} Points'),
                  _buildInfoRow('अंदाजित विजेते (सहभागींपैकी ५%)', '$winnersCount'),
                  _buildInfoRow('प्रत्येक विजेत्याला अंदाजे', '${perWinner.toStringAsFixed(1)} Points'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(10)),
                    child: const Row(children: [
                      Icon(Icons.info_outline, color: AppColors.primaryBlue, size: 18),
                      SizedBox(width: 8),
                      Expanded(child: Text('बक्षीस रोख रकमेत नाही — तुमच्या Reward Wallet मध्ये Points स्वरूपात जमा होतं.', style: TextStyle(fontSize: 12, color: AppColors.textDark))),
                    ]),
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
                    Text('संध्याकाळी ४:०० वाजता निकाल जाहीर होईल', style: TextStyle(color: Colors.green, fontSize: 13)),
                  ],
                ),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
