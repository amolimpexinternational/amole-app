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
                  const Text('निकाल: संध्याकाळी ४:०० वाजता', style: TextStyle(color: Colors.white70, fontSize: 15)),
                  const SizedBox(height: 4),
                  const Text('(तिकीट खरेदीची अंतिम वेळ: ३:५० वाजेपर्यंत)', style: TextStyle(color: Colors.white60, fontSize: 12)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(30)),
                    child: const Text('🏆 बक्षीस Reward Points स्वरूपात मिळते', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 🔴 FIX: Fixed prize list (₹10,000/₹5,000...) काढून dynamic %-सूत्र दाखवणारं कार्ड
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('बक्षीस कसे ठरते?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 4),
                  const Text(
                    'बक्षिसाची रक्कम रोज बदलते — ती त्या दिवशी विकल्या गेलेल्या एकूण तिकिटांवर अवलंबून असते.',
                    style: TextStyle(fontSize: 13, color: AppColors.textLight),
                  ),
                  const SizedBox(height: 14),
                  _buildFormulaRow('१', 'बक्षीस पूल', 'त्या दिवशीच्या एकूण तिकीट विक्रीच्या ५०%'),
                  _buildFormulaRow('२', 'विजेते', 'त्या दिवशीच्या सहभागींपैकी ५%'),
                  _buildFormulaRow('३', 'प्रत्येक विजेत्याला', 'बक्षीस पूल ÷ विजेत्यांची संख्या'),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'उदाहरण: आज २०० तिकिटं विकली गेली (₹१,०००) → बक्षीस पूल ₹५०० → १० विजेते → प्रत्येकी ₹५० इतके Reward Points',
                      style: TextStyle(fontSize: 12.5, color: AppColors.textDark, fontStyle: FontStyle.italic),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'विजेता निवड यादृच्छिक (random) नाही — मागील ९० दिवसांतील तुमची खरेदी, वेगवेगळी दुकानं, आणि सर्वात मोठी एकल खरेदी या निकषांवर प्राधान्य ठरते.',
                    style: TextStyle(fontSize: 12, color: AppColors.textLight),
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

  Widget _buildFormulaRow(String step, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 11,
            backgroundColor: const Color(0xFF6A1B9A),
            child: Text(step, style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                children: [
                  TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: value, style: const TextStyle(color: AppColors.textLight)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
