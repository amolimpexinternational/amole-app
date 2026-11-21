import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FranchiseEcosystemScreen extends StatefulWidget {
  const FranchiseEcosystemScreen({super.key});

  @override
  State<FranchiseEcosystemScreen> createState() =>
      _FranchiseEcosystemScreenState();
}

class _FranchiseEcosystemScreenState
    extends State<FranchiseEcosystemScreen> {
  String _selectedFilter = 'सर्व';

  final List<String> _filters = [
    'सर्व',
    'जिल्हा',
    'तालुका',
    'Buyer',
    'Seller',
    'Promoter',
  ];

  final List<Map<String, dynamic>> _globalStats = [
    {
      'title': 'Total Buyers',
      'value': '48,650',
      'subtitle': 'संपूर्ण Amole Platform',
      'icon': Icons.people_alt_outlined,
    },
    {
      'title': 'Total Sellers',
      'value': '2,840',
      'subtitle': 'संपूर्ण Amole Platform',
      'icon': Icons.storefront_outlined,
    },
    {
      'title': 'Total Promoters',
      'value': '12,480',
      'subtitle': 'संपूर्ण Amole Platform',
      'icon': Icons.campaign_outlined,
    },
    {
      'title': 'Total Franchises',
      'value': '86',
      'subtitle': 'संपूर्ण Amole Platform',
      'icon': Icons.account_tree_outlined,
    },
    {
      'title': 'Channel Partners',
      'value': '24',
      'subtitle': 'संपूर्ण Amole Platform',
      'icon': Icons.hub_outlined,
    },
    {
      'title': 'Products',
      'value': '18,920',
      'subtitle': 'संपूर्ण Amole Platform',
      'icon': Icons.inventory_2_outlined,
    },
  ];

  final List<Map<String, dynamic>> _networkStats = [
    {
      'title': 'My Buyers',
      'value': '850',
      'subtitle': 'माझ्या Franchise Network मध्ये',
      'icon': Icons.people_outline,
    },
    {
      'title': 'My Sellers',
      'value': '24',
      'subtitle': 'माझ्या Franchise Network मध्ये',
      'icon': Icons.store_outlined,
    },
    {
      'title': 'My Promoters',
      'value': '118',
      'subtitle': 'माझ्या Franchise Network मध्ये',
      'icon': Icons.person_add_alt_1_outlined,
    },
    {
      'title': 'My Products',
      'value': '1,240',
      'subtitle': 'माझ्या Network मधील',
      'icon': Icons.shopping_bag_outlined,
    },
  ];

  final List<Map<String, dynamic>> _districtData = [
    {
      'district': 'Pune',
      'buyers': '420',
      'sellers': '12',
      'promoters': '58',
      'products': '620',
    },
    {
      'district': 'Nashik',
      'buyers': '250',
      'sellers': '7',
      'promoters': '34',
      'products': '390',
    },
    {
      'district': 'Ahmednagar',
      'buyers': '180',
      'sellers': '5',
      'promoters': '26',
      'products': '230',
    },
  ];

  final List<Map<String, dynamic>> _topProducts = [
    {
      'name': 'Daily Grocery Combo',
      'seller': 'Ganesh Kirana Mart',
      'sales': '186',
      'amount': '₹18,600',
    },
    {
      'name': 'Mobile Accessories',
      'seller': 'Raj Electronics',
      'sales': '142',
      'amount': '₹14,200',
    },
    {
      'name': 'Health & Wellness Pack',
      'seller': 'Shri Medical',
      'sales': '98',
      'amount': '₹9,800',
    },
    {
      'name': 'Home Utility Kit',
      'seller': 'Pune Home Store',
      'sales': '76',
      'amount': '₹7,600',
    },
  ];

  void _showComingSoon(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title — Stage 3 मध्ये पूर्ण केले जाईल.'),
      ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> item) {
    return Container(
      width: 175,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: primaryBlue.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: primaryBlue.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item['icon'],
              color: primaryBlue,
              size: 23,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            item['title'],
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textLight,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item['value'],
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item['subtitle'],
            style: const TextStyle(
              fontSize: 10,
              color: textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: textLight,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _buildNetworkSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryBlue,
            royalBlue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.account_tree_outlined,
                color: white,
                size: 28,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'माझे Franchise Network',
                  style: TextStyle(
                    color: white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'तुमच्या Franchise अंतर्गत असलेल्या network ची एकूण व्याप्ती',
            style: TextStyle(
              color: white,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _networkMiniStat(
                  '850',
                  'Buyers',
                ),
              ),
              Expanded(
                child: _networkMiniStat(
                  '24',
                  'Sellers',
                ),
              ),
              Expanded(
                child: _networkMiniStat(
                  '118',
                  'Promoters',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _networkMiniStat(String value, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          title,
          style: const TextStyle(
            color: white,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildDistrictTable() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: primaryBlue.withValues(alpha: 0.10),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: lightGrey.withValues(alpha: 0.55),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'जिल्हा',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Buyer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Seller',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Promoter',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Products',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ..._districtData.map(
            (item) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 13,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: lightGrey.withValues(alpha: 0.7),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      item['district'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textDark,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item['buyers'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item['sellers'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item['promoters'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item['products'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: lightGrey,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: primaryOrange.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              color: primaryOrange,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item['seller'],
                  style: const TextStyle(
                    fontSize: 11,
                    color: textLight,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${item['sales']} sales',
                  style: const TextStyle(
                    fontSize: 10,
                    color: textLight,
                  ),
                ),
              ],
            ),
          ),
          Text(
            item['amount'],
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: successGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String filter) {
    final bool selected = _selectedFilter == filter;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = filter;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: selected ? primaryBlue : white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? primaryBlue : lightGrey,
          ),
        ),
        child: Text(
          filter,
          style: TextStyle(
            color: selected ? white : textDark,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildIncomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: successGreen.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.trending_up,
                color: successGreen,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                'Network Business Overview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _incomeItem(
                  'This Month',
                  '₹3,84,500',
                ),
              ),
              Expanded(
                child: _incomeItem(
                  'This Week',
                  '₹92,450',
                ),
              ),
              Expanded(
                child: _incomeItem(
                  'Today',
                  '₹14,280',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _incomeItem(String title, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            color: textLight,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: successGreen,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: const Text(
          'Amole Ecosystem',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryBlue,
        foregroundColor: white,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Excel',
            onPressed: () {
              _showComingSoon('Excel Download');
            },
            icon: const Icon(Icons.file_download_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              title: 'AMOLE PLATFORM OVERVIEW',
              subtitle:
                  'संपूर्ण Amole Platform ची एकूण व्याप्ती',
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 205,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _globalStats.length,
                itemBuilder: (context, index) {
                  return _buildStatCard(_globalStats[index]);
                },
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionHeader(
              title: 'माझे Franchise Network',
              subtitle:
                  'तुमच्या Franchise अंतर्गत असलेल्या network ची माहिती',
            ),
            const SizedBox(height: 12),

            _buildNetworkSummaryCard(),

            const SizedBox(height: 14),

            SizedBox(
              height: 205,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _networkStats.length,
                itemBuilder: (context, index) {
                  return _buildStatCard(_networkStats[index]);
                },
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionHeader(
              title: 'Network Filters',
              subtitle: 'तुमच्या network ची माहिती फिल्टर करा',
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  return _buildFilterChip(_filters[index]);
                },
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionHeader(
              title: 'District-wise Network',
              subtitle: 'तुमच्या Franchise network ची जिल्हानुसार व्याप्ती',
            ),
            const SizedBox(height: 12),

            _buildDistrictTable(),

            const SizedBox(height: 24),

            _buildSectionHeader(
              title: 'Business Overview',
              subtitle: 'तुमच्या network मधील Demo business summary',
            ),
            const SizedBox(height: 12),

            _buildIncomeCard(),

            const SizedBox(height: 24),

            _buildSectionHeader(
              title: 'Top Selling Products',
              subtitle: 'तुमच्या network मधील प्रमुख products',
            ),
            const SizedBox(height: 12),

            ..._topProducts.map(_buildProductCard),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _showComingSoon('Excel Download');
                },
                icon: const Icon(Icons.table_chart_outlined),
                label: const Text('Download Excel'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryBlue,
                  side: const BorderSide(
                    color: primaryBlue,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 13,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}