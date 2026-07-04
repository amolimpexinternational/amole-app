import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'seller_advertisement_screen.dart';

class SellerAdvertisementsScreen extends StatefulWidget {
  const SellerAdvertisementsScreen({super.key});

  @override
  State<SellerAdvertisementsScreen> createState() =>
      _SellerAdvertisementsScreenState();
}

class _SellerAdvertisementsScreenState
    extends State<SellerAdvertisementsScreen> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _companyAds = [
    {
      'title': '🎉 AMOLE Festival Offer',
      'desc': 'या महिन्यात Join केल्यास 500 Free Views मिळतील',
      'validity': '31 July 2026 पर्यंत',
      'badge': 'FREE',
      'badgeColor': Colors.green,
      'joined': false,
    },
    {
      'title': '📢 New Seller Boost',
      'desc': 'नवीन Sellers साठी — पहिले 30 दिवस Top Placement',
      'validity': 'नेहमीसाठी',
      'badge': 'HOT',
      'badgeColor': Colors.red,
      'joined': false,
    },
    {
      'title': '🏆 Premium Spotlight',
      'desc': 'Buyer Home Screen वर Top 10 मध्ये तुमचं दुकान',
      'validity': '₹500/महिना',
      'badge': 'PAID',
      'badgeColor': AppColors.primaryBlue,
      'joined': false,
    },
    {
      'title': '🎯 Category Leader',
      'desc': 'तुमच्या Category मध्ये #1 Position मिळवा',
      'validity': '₹300/महिना',
      'badge': 'PAID',
      'badgeColor': AppColors.primaryBlue,
      'joined': false,
    },
  ];

  final List<Map<String, dynamic>> _myAds = [
    {
      'title': 'दिवाळी ऑफर — 20% सूट',
      'views': '1,240',
      'clicks': '86',
      'status': 'Active',
      'budget': '₹500',
      'days': '5 दिवस उरले',
    },
    {
      'title': 'नवीन Stock आला!',
      'views': '890',
      'clicks': '52',
      'status': 'Active',
      'budget': '₹300',
      'days': '2 दिवस उरले',
    },
    {
      'title': 'Weekend Special',
      'views': '2,100',
      'clicks': '140',
      'status': 'Ended',
      'budget': '₹400',
      'days': 'संपलं',
    },
  ];

  Widget _buildCompanyAdCard(Map<String, dynamic> ad, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(ad['title'],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: (ad['badgeColor'] as Color).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(ad['badge'],
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: ad['badgeColor'] as Color)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(ad['desc'], style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 13, color: AppColors.textLight),
                const SizedBox(width: 4),
                Text(ad['validity'], style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ad['joined']
                  ? OutlinedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.check_circle, color: Colors.green, size: 18),
                      label: const Text('Joined!', style: TextStyle(color: Colors.green)),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        setState(() => _companyAds[index]['joined'] = true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${ad['title']} मध्ये Joined!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Participate करा', style: TextStyle(color: Colors.white)),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyAdCard(Map<String, dynamic> ad) {
    final isActive = ad['status'] == 'Active';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isActive ? Colors.green.shade200 : AppColors.lightGrey),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(ad['title'],
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isActive ? Colors.green.shade50 : AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(ad['status'],
                    style: TextStyle(fontSize: 11, color: isActive ? Colors.green : AppColors.textLight, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _statChip(Icons.visibility_outlined, '${ad['views']} Views', Colors.blue),
              const SizedBox(width: 10),
              _statChip(Icons.touch_app_outlined, '${ad['clicks']} Clicks', Colors.orange),
              const SizedBox(width: 10),
              _statChip(Icons.account_balance_wallet_outlined, ad['budget'], Colors.green),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.access_time, size: 13, color: AppColors.textLight),
              const SizedBox(width: 4),
              Text(ad['days'], style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statChip(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 3),
        Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('जाहिराती'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(46),
          child: Container(
            color: AppColors.primaryBlue,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedTab == 0 ? AppColors.cyan : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text('📢 AMOLE Offers',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _selectedTab == 0 ? Colors.white : Colors.white60,
                            fontWeight: _selectedTab == 0 ? FontWeight.bold : FontWeight.normal,
                            fontSize: 13,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedTab == 1 ? AppColors.cyan : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text('🎯 माझ्या जाहिराती',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _selectedTab == 1 ? Colors.white : Colors.white60,
                            fontWeight: _selectedTab == 1 ? FontWeight.bold : FontWeight.normal,
                            fontSize: 13,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _selectedTab == 1
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SellerAdvertisementScreen()),
              ),
              backgroundColor: AppColors.primaryBlue,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('नवीन Ad', style: TextStyle(color: Colors.white)),
            )
          : null,
      body: _selectedTab == 0
          ? ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _companyAds.length,
              itemBuilder: (context, index) => _buildCompanyAdCard(_companyAds[index], index),
            )
          : _myAds.isEmpty
              ? const Center(
                  child: Text('अजून कोणतीही जाहिरात नाही', style: TextStyle(color: AppColors.textLight)),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _myAds.length,
                  itemBuilder: (context, index) => _buildMyAdCard(_myAds[index]),
                ),
    );
  }
}
