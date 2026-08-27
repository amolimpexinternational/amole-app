import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class RewardWalletScreen extends StatefulWidget {
  const RewardWalletScreen({super.key});

  @override
  State<RewardWalletScreen> createState() => _RewardWalletScreenState();
}

class _RewardWalletScreenState extends State<RewardWalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _transactions = [
    {
      'type': 'earn',
      'title': 'श्री गणेश किराणा खरेदी',
      'subtitle': '₹500 खरेदीवर 2% = 10 pts',
      'points': '+10',
      'date': 'आज, सकाळी 10:30',
      'expiry': '26 Nov 2026',
      'category': 'purchase',
    },
    {
      'type': 'earn',
      'title': 'Referral Bonus — अनिल जोशी',
      'subtitle': 'अनिल च्या ₹200 खरेदीवर 0.25%',
      'points': '+0.5',
      'date': 'काल, दुपारी 2:15',
      'expiry': '25 Nov 2026',
      'category': 'referral',
    },
    {
      'type': 'earn',
      'title': 'राज इलेक्ट्रॉनिक्स खरेदी',
      'subtitle': '₹1200 खरेदीवर 2% = 24 pts',
      'points': '+24',
      'date': '24 Aug, सायं 6:00',
      'expiry': '24 Nov 2026',
      'category': 'purchase',
    },
    {
      'type': 'spend',
      'title': 'स्वाद हॉटेल — Points वापरले',
      'subtitle': 'ऑर्डर #AM-ORD-009 मध्ये',
      'points': '-15',
      'date': '23 Aug, सकाळी 1:00',
      'expiry': '',
      'category': 'spent',
    },
    {
      'type': 'earn',
      'title': 'Referral Bonus — संगीता राणे',
      'subtitle': 'संगीता च्या ₹800 खरेदीवर 0.25%',
      'points': '+2',
      'date': '22 Aug, दुपारी 3:45',
      'expiry': '22 Nov 2026',
      'category': 'referral',
    },
    {
      'type': 'expired',
      'title': 'Points Expired',
      'subtitle': 'May 2026 चे points expire झाले',
      'points': '-8',
      'date': '26 May 2026',
      'expiry': '',
      'category': 'expired',
    },
  ];

  final List<Map<String, dynamic>> _expiringPoints = [
    {'points': 10, 'expiry': '26 Nov 2026', 'daysLeft': 92},
    {'points': 24, 'expiry': '24 Nov 2026', 'daysLeft': 90},
    {'points': 2, 'expiry': '22 Nov 2026', 'daysLeft': 88},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _earnHistory =>
      _transactions.where((t) => t['type'] == 'earn').toList();

  List<Map<String, dynamic>> get _spendHistory =>
      _transactions.where((t) => t['type'] == 'spend' || t['type'] == 'expired').toList();

  Widget _buildTransactionTile(Map<String, dynamic> t) {
    final isEarn = t['type'] == 'earn';
    final isExpired = t['type'] == 'expired';
    Color pointColor = isEarn ? AppColors.successGreen : AppColors.errorRed;
    IconData icon;
    Color iconBg;

    switch (t['category']) {
      case 'purchase':
        icon = Icons.shopping_bag_outlined;
        iconBg = AppColors.primaryBlue;
        break;
      case 'referral':
        icon = Icons.people_outlined;
        iconBg = Colors.purple;
        break;
      case 'spent':
        icon = Icons.payment_outlined;
        iconBg = AppColors.primaryOrange;
        break;
      case 'expired':
        icon = Icons.timer_off_outlined;
        iconBg = Colors.grey;
        break;
      default:
        icon = Icons.stars_outlined;
        iconBg = AppColors.primaryBlue;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconBg, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t['title'],
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark)),
                const SizedBox(height: 3),
                Text(t['subtitle'],
                    style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                const SizedBox(height: 3),
                Text(t['date'],
                    style: const TextStyle(fontSize: 10, color: AppColors.textLight)),
                if (t['expiry'].isNotEmpty && isEarn)
                  Text('Expiry: ${t['expiry']}',
                      style: const TextStyle(
                          fontSize: 10, color: Colors.orange, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Text(
            '${t['points']} pts',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isExpired ? Colors.grey : pointColor),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryAlert() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.timer_outlined, color: Colors.orange, size: 18),
              SizedBox(width: 8),
              Text('Expiry येत आहे!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.orange)),
            ],
          ),
          const SizedBox(height: 10),
          ..._expiringPoints.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${e['points']} pts',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 13)),
                    Text('${e['daysLeft']} दिवसांत expire',
                        style: const TextStyle(
                            fontSize: 12, color: Colors.orange)),
                    Text(e['expiry'],
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.textLight)),
                  ],
                ),
              )),
          const SizedBox(height: 8),
          const Text(
            '⚠️ Points 3 महिन्यांत वापरले नाहीत तर Expire होतात!',
            style: TextStyle(fontSize: 11, color: Colors.orange),
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
        title: const Text('Reward Points Wallet'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.cyan,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'कमाई'),
            Tab(text: 'वापर'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1 — Overview
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Balance Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryBlue, AppColors.royalBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.primaryBlue.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8))
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.stars, color: AppColors.primaryOrange, size: 40),
                      const SizedBox(height: 8),
                      const Text('एकूण Reward Points',
                          style: TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 4),
                      const Text('245',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold)),
                      const Text('= ₹245 किंमत',
                          style: TextStyle(color: AppColors.cyan, fontSize: 14)),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatChip(Icons.add_circle_outline,
                              'एकूण कमाई', '284 pts', Colors.green),
                          _buildStatChip(Icons.remove_circle_outline,
                              'एकूण वापर', '31 pts', Colors.orange),
                          _buildStatChip(Icons.timer_off_outlined,
                              'Expired', '8 pts', Colors.grey),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // How to Earn Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Points कसे मिळतात?',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark)),
                      const SizedBox(height: 12),
                      _buildEarnRow(Icons.shopping_bag_outlined,
                          'खरेदीवर', '2% प्रत्येक खरेदीवर', AppColors.primaryBlue),
                      _buildEarnRow(Icons.people_outlined,
                          'Referral Bonus', '0.25% refer केलेल्याच्या खरेदीवर', Colors.purple),
                      _buildEarnRow(Icons.campaign_outlined,
                          'Poll उत्तर', 'जाहिरातीतील Poll ला उत्तर द्या', Colors.teal),
                      _buildEarnRow(Icons.card_giftcard_outlined,
                          'Lucky Draw', '₹5 ticket खरेदी करा', AppColors.primaryOrange),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Expiry Alert
                _buildExpiryAlert(),

                // Use Points
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Points कुठे वापरता येतात?',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark)),
                      const SizedBox(height: 12),
                      _buildEarnRow(Icons.payment, 'खरेदी Payment मध्ये',
                          'Cart मध्ये points toggle ON करा', AppColors.successGreen),
                      _buildEarnRow(Icons.qr_code, 'QR Payment मध्ये',
                          'Seller ला pay करताना toggle ON करा', AppColors.primaryBlue),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab 2 — कमाई History
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _earnHistory.length,
            itemBuilder: (context, index) =>
                _buildTransactionTile(_earnHistory[index]),
          ),

          // Tab 3 — वापर History
          _spendHistory.isEmpty
              ? const Center(
                  child: Text('अजून कोणतेही points वापरलेले नाहीत',
                      style: TextStyle(color: AppColors.textLight)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _spendHistory.length,
                  itemBuilder: (context, index) =>
                      _buildTransactionTile(_spendHistory[index]),
                ),
        ],
      ),
    );
  }

  Widget _buildStatChip(
      IconData icon, String label, String value, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(color: Colors.white60, fontSize: 10)),
        Text(value,
            style: TextStyle(
                color: color, fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }

  Widget _buildEarnRow(
      IconData icon, String title, String subtitle, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.textDark)),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textLight)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
