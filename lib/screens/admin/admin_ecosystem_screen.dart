
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminEcosystemScreen extends StatefulWidget {
  const AdminEcosystemScreen({super.key});

  @override
  State<AdminEcosystemScreen> createState() =>
      _AdminEcosystemScreenState();
}

class _AdminEcosystemScreenState extends State<AdminEcosystemScreen> {
  String _selectedPeriod = 'आज';
  DateTime? _selectedDate;

  final List<Map<String, dynamic>> _kpis = [
    {
      'title': 'Buyers',
      'count': '12,450',
      'income': '₹0',
      'icon': Icons.people_alt,
      'color': Colors.blue,
      'details': [
        {'name': 'एकूण Buyers', 'count': '12,450', 'income': '₹0'},
        {'name': 'Active Buyers', 'count': '10,250', 'income': '₹0'},
        {'name': 'New Buyers', 'count': '125', 'income': '₹0'},
        {'name': 'Promoter झालेले Buyers', 'count': '450', 'income': '₹0'},
      ],
    },
    {
      'title': 'Sellers',
      'count': '1,250',
      'income': '₹2,45,000',
      'icon': Icons.store,
      'color': Colors.orange,
      'details': [
        {'name': 'एकूण Sellers', 'count': '1,250', 'income': '₹2,45,000'},
        {'name': 'Active Sellers', 'count': '980', 'income': '₹1,85,000'},
        {'name': 'New Sellers', 'count': '45', 'income': '₹25,000'},
        {'name': 'Inactive Sellers', 'count': '225', 'income': '₹35,000'},
      ],
    },
    {
      'title': 'Franchise',
      'count': '85',
      'income': '₹1,25,000',
      'icon': Icons.business,
      'color': Colors.purple,
      'details': [
        {'name': 'एकूण Franchise', 'count': '85', 'income': '₹1,25,000'},
        {'name': 'Active Franchise', 'count': '72', 'income': '₹1,05,000'},
        {'name': 'New Franchise', 'count': '8', 'income': '₹12,000'},
        {'name': 'Inactive Franchise', 'count': '5', 'income': '₹8,000'},
      ],
    },
    {
      'title': 'Channel Partners',
      'count': '25',
      'income': '₹85,000',
      'icon': Icons.handshake,
      'color': Colors.teal,
      'details': [
        {'name': 'एकूण CP', 'count': '25', 'income': '₹85,000'},
        {'name': 'Active CP', 'count': '22', 'income': '₹75,000'},
        {'name': 'New CP', 'count': '3', 'income': '₹10,000'},
      ],
    },
    {
      'title': 'Promoters',
      'count': '2,450',
      'income': '₹65,000',
      'icon': Icons.campaign,
      'color': Colors.green,
      'details': [
        {'name': 'एकूण Promoters', 'count': '2,450', 'income': '₹65,000'},
        {'name': 'Active Promoters', 'count': '1,850', 'income': '₹52,000'},
        {'name': 'New Promoters', 'count': '150', 'income': '₹8,000'},
        {'name': 'Inactive Promoters', 'count': '450', 'income': '₹5,000'},
      ],
    },
  ];

  final List<Map<String, dynamic>> _incomeSources = [
    {'name': 'Product Sales Income', 'amount': '₹2,45,000', 'icon': Icons.shopping_bag},
    {'name': 'Subscription Income', 'amount': '₹75,000', 'icon': Icons.card_membership},
    {'name': 'Advertisement Income', 'amount': '₹45,000', 'icon': Icons.ads_click},
    {'name': 'Services Income', 'amount': '₹35,000', 'icon': Icons.miscellaneous_services},
  ];

  String get _periodLabel {
    if (_selectedPeriod == 'Calendar' && _selectedDate != null) {
      return '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
    }
    return _selectedPeriod;
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _selectedPeriod = 'Calendar';
      });
    }
  }

  void _showKpiDetails(Map<String, dynamic> kpi) {
    final details = kpi['details'] as List<Map<String, String>>;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Icon(kpi['icon'], color: kpi['color'], size: 28),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${kpi['title']} Details',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: details.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = details[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item['name']!,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text('संख्या: ${item['count']}'),
                      trailing: Text(
                        item['income']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text(
          'Amole Ecosystem',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPeriodFilter(),
            const SizedBox(height: 18),
            _buildSectionTitle('Ecosystem Overview'),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _kpis.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.35,
              ),
              itemBuilder: (context, index) {
                final kpi = _kpis[index];
                return _buildKpiCard(kpi);
              },
            ),
            const SizedBox(height: 22),
            _buildSectionTitle('Total Income'),
            const SizedBox(height: 12),
            _buildTotalIncomeCard(),
            const SizedBox(height: 22),
            _buildSectionTitle('Income Sources'),
            const SizedBox(height: 12),
            _buildIncomeSources(),
            const SizedBox(height: 22),
            _buildSectionTitle('Ecosystem Hierarchy'),
            const SizedBox(height: 12),
            _buildHierarchy(),
            const SizedBox(height: 22),
            _buildExcelButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodFilter() {
    final periods = ['आज', 'Week', 'Month', 'Calendar'];

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: periods.map((period) {
                final selected = _selectedPeriod == period;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(9),
                      onTap: () {
                        if (period == 'Calendar') {
                          _selectDate();
                        } else {
                          setState(() {
                            _selectedPeriod = period;
                            _selectedDate = null;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.primaryBlue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text(
                          period,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: selected
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            if (_selectedPeriod == 'Calendar' && _selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('Selected Date: $_periodLabel'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard(Map<String, dynamic> kpi) {
    return InkWell(
      onTap: () => _showKpiDetails(kpi),
      borderRadius: BorderRadius.circular(15),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundColor:
                        (kpi['color'] as Color).withValues(alpha: 0.12),
                    child: Icon(
                      kpi['icon'],
                      color: kpi['color'],
                      size: 19,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.open_in_new, size: 15, color: Colors.grey),
                ],
              ),
              Text(
                kpi['title'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                kpi['count'],
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Income: ${kpi['income']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalIncomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryBlue,
            AppColors.primaryBlue.withValues(alpha: 0.75),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Ecosystem Income',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 8),
          const Text(
            '₹4,00,000',
            style: TextStyle(
              color: Colors.white,
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Period: $_periodLabel',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeSources() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: _incomeSources.map((source) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
              child: Icon(
                source['icon'],
                color: AppColors.primaryBlue,
                size: 20,
              ),
            ),
            title: Text(
              source['name'],
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Text(
              source['amount'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHierarchy() {
    final hierarchy = [
      {
        'title': 'Admin',
        'subtitle': 'Amole Company',
        'icon': Icons.admin_panel_settings,
        'color': Colors.blue,
        'indent': 0.0,
      },
      {
        'title': 'Channel Partners',
        'subtitle': '25 CP',
        'icon': Icons.handshake,
        'color': Colors.teal,
        'indent': 18.0,
      },
      {
        'title': 'Franchise',
        'subtitle': '85 Franchise',
        'icon': Icons.business,
        'color': Colors.purple,
        'indent': 36.0,
      },
      {
        'title': 'Sellers',
        'subtitle': '1,250 Sellers',
        'icon': Icons.store,
        'color': Colors.orange,
        'indent': 54.0,
      },
      {
        'title': 'Buyers / Promoters',
        'subtitle': '12,450 Buyers / 2,450 Promoters',
        'icon': Icons.people,
        'color': Colors.green,
        'indent': 72.0,
      },
    ];

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: hierarchy.map((item) {
            return Padding(
              padding: EdgeInsets.only(
                left: item['indent'] as double,
                right: 12,
              ),
              child: ListTile(
                dense: true,
                leading: Icon(
                  item['icon'] as IconData,
                  color: item['color'] as Color,
                ),
                title: Text(
                  item['title'] as String,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(item['subtitle'] as String),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildExcelButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Excel Download सुविधा Stage 3 मध्ये सुरू होईल.',
              ),
            ),
          );
        },
        icon: const Icon(Icons.file_download),
        label: const Text('Download Excel Report'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryBlue,
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: BorderSide(color: AppColors.primaryBlue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
