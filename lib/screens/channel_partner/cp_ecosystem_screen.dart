
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CpEcosystemScreen extends StatelessWidget {
  const CpEcosystemScreen({super.key});

  // संपूर्ण Amole App ची Demo आकडेवारी.
  // Stage 3 मध्ये वास्तविक डेटा जोडला जाईल.
  static const Map<String, int> _globalData = {
    'Buyers': 25000,
    'Sellers': 1250,
    'Promoters': 5000,
    'Channel Partners': 50,
    'Franchise': 200,
  };

  // या Channel Partner च्या नेटवर्कची Demo आकडेवारी.
  // सर्व Franchise ची बेरीज Dashboard वरील आकड्यांशी जुळते.
  static const List<Map<String, dynamic>> _franchises = [
    {
      'name': 'हडपसर फ्रँचायझी',
      'code': 'FR-001',
      'sellers': 22,
      'buyers': 520,
      'promoters': 1,
      'active': true,
    },
    {
      'name': 'कोथरूड फ्रँचायझी',
      'code': 'FR-002',
      'sellers': 20,
      'buyers': 480,
      'promoters': 1,
      'active': true,
    },
    {
      'name': 'वडगाव फ्रँचायझी',
      'code': 'FR-003',
      'sellers': 19,
      'buyers': 430,
      'promoters': 1,
      'active': true,
    },
    {
      'name': 'भोसरी फ्रँचायझी',
      'code': 'FR-004',
      'sellers': 18,
      'buyers': 420,
      'promoters': 0,
      'active': true,
    },
    {
      'name': 'पिंपरी फ्रँचायझी',
      'code': 'FR-005',
      'sellers': 17,
      'buyers': 390,
      'promoters': 0,
      'active': true,
    },
    {
      'name': 'चिंचवड फ्रँचायझी',
      'code': 'FR-006',
      'sellers': 16,
      'buyers': 370,
      'promoters': 0,
      'active': true,
    },
    {
      'name': 'नाशिक रोड फ्रँचायझी',
      'code': 'FR-007',
      'sellers': 15,
      'buyers': 340,
      'promoters': 0,
      'active': true,
    },
    {
      'name': 'सातपूर फ्रँचायझी',
      'code': 'FR-008',
      'sellers': 15,
      'buyers': 300,
      'promoters': 0,
      'active': true,
    },
  ];

  int get _totalSellers => _franchises.fold(
        0,
        (sum, item) => sum + (item['sellers'] as int),
      );

  int get _totalBuyers => _franchises.fold(
        0,
        (sum, item) => sum + (item['buyers'] as int),
      );

  int get _totalPromoters => _franchises.fold(
        0,
        (sum, item) => sum + (item['promoters'] as int),
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: AppBar(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: AppColors.white,
          title: const Text(
            'Amole Ecosystem',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            indicatorColor: AppColors.cyan,
            indicatorWeight: 3,
            labelColor: AppColors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(
                icon: Icon(Icons.public),
                text: 'Global Overview',
              ),
              Tab(
                icon: Icon(Icons.account_tree_outlined),
                text: 'My Network',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildGlobalOverview(),
            _buildMyNetwork(context),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // GLOBAL OVERVIEW
  // =========================================================

  Widget _buildGlobalOverview() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeading(
          'संपूर्ण Amole App',
          'संपूर्ण Ecosystem मधील एकूण सदस्य',
          Icons.public,
        ),
        const SizedBox(height: 14),

        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.55,
          children: [
            _buildMetricCard(
              'Buyers',
              _globalData['Buyers']!,
              Icons.people_outline,
              AppColors.primaryBlue,
            ),
            _buildMetricCard(
              'Sellers',
              _globalData['Sellers']!,
              Icons.storefront_outlined,
              AppColors.successGreen,
            ),
            _buildMetricCard(
              'Promoters',
              _globalData['Promoters']!,
              Icons.campaign_outlined,
              AppColors.primaryOrange,
            ),
            _buildMetricCard(
              'Channel Partners',
              _globalData['Channel Partners']!,
              Icons.hub_outlined,
              Colors.deepPurple,
            ),
            _buildMetricCard(
              'Franchise',
              _globalData['Franchise']!,
              Icons.business_outlined,
              Colors.teal,
            ),
          ],
        ),

        const SizedBox(height: 18),

        _buildInfoCard(
          icon: Icons.security_outlined,
          title: 'Global Data Privacy',
          message:
              'या विभागात संपूर्ण Amole App ची फक्त एकूण आकडेवारी दिसते. '
              'इतर Channel Partners, Franchise किंवा सदस्यांची वैयक्तिक माहिती येथे दिसणार नाही.',
        ),

        const SizedBox(height: 12),

        _buildDemoNote(),
      ],
    );
  }

  // =========================================================
  // MY NETWORK
  // =========================================================

  Widget _buildMyNetwork(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeading(
          'माझे Network',
          'या Channel Partner च्या अंतर्गत असलेली आकडेवारी',
          Icons.account_tree_outlined,
        ),

        const SizedBox(height: 14),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.primaryBlue,
                AppColors.royalBlue,
              ],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'माझे Channel Partner Network',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pune District',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _buildHeaderStat(
                    'Franchise',
                    '${_franchises.length}',
                  ),
                  _buildHeaderStat(
                    'Sellers',
                    '$_totalSellers',
                  ),
                  _buildHeaderStat(
                    'Buyers',
                    '$_totalBuyers',
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.55,
          children: [
            _buildMetricCard(
              'Franchise',
              _franchises.length,
              Icons.business_outlined,
              Colors.teal,
            ),
            _buildMetricCard(
              'Sellers',
              _totalSellers,
              Icons.storefront_outlined,
              AppColors.successGreen,
            ),
            _buildMetricCard(
              'Buyers',
              _totalBuyers,
              Icons.people_outline,
              AppColors.primaryBlue,
            ),
            _buildMetricCard(
              'Promoters',
              _totalPromoters,
              Icons.campaign_outlined,
              AppColors.primaryOrange,
            ),
          ],
        ),

        const SizedBox(height: 20),

        _buildSectionHeading(
          'Franchise नुसार माहिती',
          'प्रत्येक Franchise चा तपशील पाहण्यासाठी निवडा',
          Icons.business_outlined,
        ),

        const SizedBox(height: 12),

        ..._franchises.map(
          (franchise) => _buildFranchiseCard(
            context,
            franchise,
          ),
        ),

        const SizedBox(height: 12),

        _buildDemoNote(),
      ],
    );
  }

  // =========================================================
  // FRANCHISE CARD
  // =========================================================

  Widget _buildFranchiseCard(
    BuildContext context,
    Map<String, dynamic> franchise,
  ) {
    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showFranchiseDetails(
          context,
          franchise,
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        AppColors.primaryBlue.withValues(alpha: 0.1),
                    child: const Icon(
                      Icons.business_outlined,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          franchise['name'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          franchise['code'] as String,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: AppColors.textLight,
                  ),
                ],
              ),
              const Divider(height: 20),
              Row(
                children: [
                  _buildSmallStat(
                    'Sellers',
                    franchise['sellers'].toString(),
                    AppColors.successGreen,
                  ),
                  _buildSmallStat(
                    'Buyers',
                    franchise['buyers'].toString(),
                    AppColors.primaryBlue,
                  ),
                  _buildSmallStat(
                    'Promoters',
                    franchise['promoters'].toString(),
                    AppColors.primaryOrange,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // FRANCHISE DETAILS
  // =========================================================

  void _showFranchiseDetails(
    BuildContext context,
    Map<String, dynamic> franchise,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  franchise['name'] as String,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Franchise ID: ${franchise['code']}',
                  style: const TextStyle(
                    color: AppColors.textLight,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 18),
                _buildDetailRow(
                  Icons.storefront_outlined,
                  'एकूण Sellers',
                  franchise['sellers'].toString(),
                  AppColors.successGreen,
                ),
                _buildDetailRow(
                  Icons.people_outline,
                  'एकूण Buyers',
                  franchise['buyers'].toString(),
                  AppColors.primaryBlue,
                ),
                _buildDetailRow(
                  Icons.campaign_outlined,
                  'एकूण Promoters',
                  franchise['promoters'].toString(),
                  AppColors.primaryOrange,
                ),
                _buildDetailRow(
                  Icons.verified_outlined,
                  'Franchise Status',
                  franchise['active'] == true ? 'Active' : 'Inactive',
                  AppColors.successGreen,
                ),
                const SizedBox(height: 12),
                const Text(
                  'ही आकडेवारी Demo आहे. प्रत्यक्ष सदस्यांची यादी आणि वैयक्तिक माहिती पुढील टप्प्यात योग्य परवानग्यांनुसार जोडली जाईल.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                    child: const Text('बंद करा'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // REUSABLE WIDGETS
  // =========================================================

  Widget _buildSectionHeading(
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primaryBlue,
          size: 25,
        ),
        const SizedBox(width: 10),
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
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    int value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: color.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 23,
          ),
          const SizedBox(height: 8),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(
    String label,
    String value,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallStat(
    String label,
    String value,
    Color color,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textLight,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 21,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textDark,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.primaryBlue,
            size: 21,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textDark,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoNote() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.orange.shade100,
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.primaryOrange,
            size: 19,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Demo Data: हे आकडे केवळ स्क्रीन तपासण्यासाठी आहेत. Stage 3 मध्ये Firebase मधून Global आणि My Network ची वास्तविक आकडेवारी योग्य परवानग्यांनुसार आणली जाईल.',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textDark,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
