
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminSettlementScreen extends StatefulWidget {
  const AdminSettlementScreen({super.key});

  @override
  State<AdminSettlementScreen> createState() =>
      _AdminSettlementScreenState();
}

class _AdminSettlementScreenState extends State<AdminSettlementScreen> {
  String _selectedPeriod = 'आज';
  DateTime _selectedDate = DateTime.now();

  late final List<_AccountingEntry> _entries;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();

    // Stage 2: Demo / Mock Accounting Data.
    // Stage 3: Replace with actual Firestore accounting records.
    _entries = [
      _entry(
        now,
        'Product Sales',
        'पाटील किराणा स्टोअर',
        12500,
        true,
        'Product Sales मधून मिळालेले उत्पन्न',
      ),
      _entry(
        now,
        'Subscription',
        'Seller Subscription',
        4500,
        true,
        'Seller Subscription मधून मिळालेले उत्पन्न',
      ),
      _entry(
        now,
        'Seller Payment',
        'पाटील किराणा स्टोअर',
        3200,
        false,
        'Seller ला केलेले Payment',
      ),
      _entry(
        now,
        'Franchise Payment',
        'हडपसर फ्रँचाइजी',
        1800,
        false,
        'Franchise Settlement',
      ),
      _entry(
        now,
        'CP Payment',
        'पुणे Channel Partner',
        1200,
        false,
        'Channel Partner Commission',
      ),
      _entry(
        now,
        'Promoter Payment',
        'अमोल प्रमोटर',
        500,
        false,
        'Promoter Commission',
      ),
      _entry(
        now,
        'Advertisement Budget',
        'Advertising Department',
        800,
        false,
        'Advertisement खर्च',
      ),
      _entry(
        now,
        'Lucky Draw',
        'Lucky Draw Rewards',
        1000,
        false,
        'Lucky Draw खर्च',
      ),
      _entry(
        now,
        'Rewards',
        'Buyer Rewards',
        350,
        false,
        'Buyer Rewards खर्च',
      ),
      _entry(
        now.subtract(const Duration(days: 1)),
        'Product Sales',
        'जोशी किराणा',
        8500,
        true,
        'Product Sales मधून मिळालेले उत्पन्न',
      ),
      _entry(
        now.subtract(const Duration(days: 1)),
        'Seller Payment',
        'जोशी किराणा',
        2500,
        false,
        'Seller Settlement',
      ),
      _entry(
        now.subtract(const Duration(days: 2)),
        'Subscription',
        'Franchise Subscription',
        3000,
        true,
        'Franchise Subscription मधून उत्पन्न',
      ),
      _entry(
        now.subtract(const Duration(days: 3)),
        'CP Payment',
        'नागपूर Channel Partner',
        900,
        false,
        'Channel Partner Payment',
      ),
      _entry(
        now.subtract(const Duration(days: 5)),
        'Product Sales',
        'श्री साई मेडिकल',
        6500,
        true,
        'Product Sales मधून मिळालेले उत्पन्न',
      ),
      _entry(
        now.subtract(const Duration(days: 8)),
        'Seller Payment',
        'श्री साई मेडिकल',
        2200,
        false,
        'Seller Settlement',
      ),
      _entry(
        now.subtract(const Duration(days: 12)),
        'Subscription',
        'Seller Subscription',
        2500,
        true,
        'Subscription उत्पन्न',
      ),
      _entry(
        now.subtract(const Duration(days: 18)),
        'Rewards',
        'Buyer Rewards',
        600,
        false,
        'Rewards खर्च',
      ),
    ];
  }

  _AccountingEntry _entry(
    DateTime date,
    String category,
    String name,
    double amount,
    bool isIncome,
    String description,
  ) {
    return _AccountingEntry(
      date: date,
      category: category,
      name: name,
      amount: amount,
      isIncome: isIncome,
      description: description,
    );
  }

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  List<_AccountingEntry> get _filteredEntries {
    final now = DateTime.now();
    final today = _dateOnly(now);

    return _entries.where((entry) {
      final entryDate = _dateOnly(entry.date);

      switch (_selectedPeriod) {
        case 'आज':
          return entryDate == today;

        case 'आठवडा':
          final start = today.subtract(
            Duration(days: today.weekday - 1),
          );
          return !entryDate.isBefore(start) &&
              !entryDate.isAfter(today);

        case 'महिना':
          return entry.date.year == now.year &&
              entry.date.month == now.month;

        case 'Calendar':
          return entryDate == _dateOnly(_selectedDate);

        default:
          return true;
      }
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  double get _totalIncome {
    return _filteredEntries
        .where((entry) => entry.isIncome)
        .fold(0.0, (sum, entry) => sum + entry.amount);
  }

  double get _totalExpense {
    return _filteredEntries
        .where((entry) => !entry.isIncome)
        .fold(0.0, (sum, entry) => sum + entry.amount);
  }

  double get _netIncome {
    return _totalIncome - _totalExpense;
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatAmount(double amount) {
    return '₹${amount.toStringAsFixed(0)}';
  }

  Future<void> _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      helpText: 'तारीख निवडा',
    );

    if (selected != null) {
      setState(() {
        _selectedDate = selected;
        _selectedPeriod = 'Calendar';
      });
    }
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'Product Sales':
        return Icons.shopping_bag_outlined;
      case 'Subscription':
        return Icons.card_membership_outlined;
      case 'Seller Payment':
        return Icons.store_outlined;
      case 'Franchise Payment':
        return Icons.business_outlined;
      case 'CP Payment':
        return Icons.hub_outlined;
      case 'Promoter Payment':
        return Icons.campaign_outlined;
      case 'Advertisement Budget':
        return Icons.ads_click_outlined;
      case 'Lucky Draw':
        return Icons.emoji_events_outlined;
      case 'Rewards':
        return Icons.card_giftcard_outlined;
      default:
        return Icons.account_balance_wallet_outlined;
    }
  }

  Widget _buildPeriodSelector() {
    final periods = ['आज', 'आठवडा', 'महिना', 'Calendar'];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: periods.map((period) {
          final selected = _selectedPeriod == period;

          return ChoiceChip(
            label: Text(
              period == 'Calendar'
                  ? '📅 ${period == _selectedPeriod ? _formatDate(_selectedDate) : 'Calendar'}'
                  : period,
            ),
            selected: selected,
            selectedColor: AppColors.primaryBlue,
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: selected ? Colors.white : AppColors.textDark,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            onSelected: (_) {
              if (period == 'Calendar') {
                _pickDate();
              } else {
                setState(() {
                  _selectedPeriod = period;
                });
              }
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.royalBlue,
            AppColors.primaryBlue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Net Company Income',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _formatAmount(_netIncome),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white30),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _summaryItem(
                  'एकूण जमा',
                  _formatAmount(_totalIncome),
                  Icons.arrow_downward,
                  Colors.greenAccent,
                ),
              ),
              Expanded(
                child: _summaryItem(
                  'एकूण खर्च',
                  _formatAmount(_totalExpense),
                  Icons.arrow_upward,
                  Colors.orangeAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'एकूण ${_filteredEntries.length} व्यवहार',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(
    String title,
    String amount,
    IconData icon,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 15),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionList() {
    final entries = _filteredEntries;

    if (entries.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(35),
        child: Column(
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 55,
              color: Colors.grey,
            ),
            SizedBox(height: 12),
            Text(
              'या कालावधीमध्ये कोणतेही व्यवहार नाहीत.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textLight,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      itemCount: entries.length,
      separatorBuilder: (_, __) => const SizedBox(height: 9),
      itemBuilder: (context, index) {
        final entry = entries[index];

        return InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => _AccountingDetailScreen(
                  entry: entry,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: entry.isIncome
                      ? Colors.green.withValues(alpha: 0.1)
                      : Colors.orange.withValues(alpha: 0.1),
                  child: Icon(
                    _categoryIcon(entry.category),
                    color: entry.isIncome
                        ? Colors.green
                        : Colors.orange,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        entry.category,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textLight,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _formatDate(entry.date),
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${entry.isIncome ? '+' : '-'}${_formatAmount(entry.amount)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: entry.isIncome
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Details →',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('Accounting (हिशोब)'),
      ),
      body: ListView(
        children: [
          _buildPeriodSelector(),
          _buildSummaryCard(),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              'व्यवहारांची माहिती',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ),
          _buildTransactionList(),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Text(
              'टीप: ही माहिती Demo / Mock Data आहे. '
              'प्रत्यक्ष Accounting आणि Firestore जोडणी Stage 3 मध्ये होईल.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountingEntry {
  final DateTime date;
  final String category;
  final String name;
  final double amount;
  final bool isIncome;
  final String description;

  const _AccountingEntry({
    required this.date,
    required this.category,
    required this.name,
    required this.amount,
    required this.isIncome,
    required this.description,
  });
}

class _AccountingDetailScreen extends StatelessWidget {
  final _AccountingEntry entry;

  const _AccountingDetailScreen({
    super.key,
    required this.entry,
  });

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final color = entry.isIncome ? Colors.green : Colors.red;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('Transaction Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: color.withValues(alpha: 0.1),
                  child: Icon(
                    entry.isIncome
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                    color: color,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  '${entry.isIncome ? '+' : '-'}₹${entry.amount.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              const Divider(),
              _detailRow('व्यवहाराचा प्रकार', entry.category),
              _detailRow('नाव', entry.name),
              _detailRow('तारीख', _formatDate(entry.date)),
              _detailRow(
                'प्रकार',
                entry.isIncome ? 'जमा / Income' : 'खर्च / Expense',
              ),
              const SizedBox(height: 12),
              const Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                entry.description,
                style: const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.textLight,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
