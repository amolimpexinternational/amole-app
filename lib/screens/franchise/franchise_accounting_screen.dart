
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FranchiseAccountingScreen extends StatefulWidget {
  const FranchiseAccountingScreen({super.key});

  @override
  State<FranchiseAccountingScreen> createState() =>
      _FranchiseAccountingScreenState();
}

class _FranchiseAccountingScreenState
    extends State<FranchiseAccountingScreen> {
  String _selectedFilter = 'Month';
  DateTimeRange? _customRange;

  late final List<Map<String, dynamic>> _transactions = _createDemoData();

  List<Map<String, dynamic>> _createDemoData() {
    final now = DateTime.now();

    return [
      {
        'title': 'Seller Revenue Share',
        'category': 'Seller Revenue',
        'type': 'income',
        'amount': 4200.0,
        'date': now,
        'status': 'Received',
        'reference': 'FR-INC-001',
        'description': 'नेटवर्कमधील Sellers कडून मिळालेला Revenue Share.',
      },
      {
        'title': 'Advertisement Income',
        'category': 'Advertisement',
        'type': 'income',
        'amount': 1800.0,
        'date': now.subtract(const Duration(days: 1)),
        'status': 'Received',
        'reference': 'FR-INC-002',
        'description': 'जाहिरातींमधून Franchise ला मिळालेले उत्पन्न.',
      },
      {
        'title': 'Subscription Income',
        'category': 'Subscription',
        'type': 'income',
        'amount': 1200.0,
        'date': now.subtract(const Duration(days: 3)),
        'status': 'Received',
        'reference': 'FR-INC-003',
        'description': 'Subscription मधून मिळालेले Demo उत्पन्न.',
      },
      {
        'title': 'Seller Revenue Share',
        'category': 'Seller Revenue',
        'type': 'income',
        'amount': 2600.0,
        'date': now.subtract(const Duration(days: 8)),
        'status': 'Received',
        'reference': 'FR-INC-004',
        'description': 'Seller विक्रीवरील Franchise Revenue Share.',
      },
      {
        'title': 'Advertisement Income',
        'category': 'Advertisement',
        'type': 'income',
        'amount': 950.0,
        'date': now.subtract(const Duration(days: 12)),
        'status': 'Pending',
        'reference': 'FR-INC-005',
        'description': 'जाहिरातींचे प्रलंबित उत्पन्न.',
      },
      {
        'title': 'Marketing Expense',
        'category': 'Marketing',
        'type': 'expense',
        'amount': 1500.0,
        'date': now.subtract(const Duration(days: 2)),
        'status': 'Paid',
        'reference': 'FR-EXP-001',
        'description': 'स्थानिक Marketing खर्च.',
      },
      {
        'title': 'Operational Expense',
        'category': 'Operations',
        'type': 'expense',
        'amount': 800.0,
        'date': now.subtract(const Duration(days: 5)),
        'status': 'Paid',
        'reference': 'FR-EXP-002',
        'description': 'Franchise कार्यालयाचा Operational खर्च.',
      },
      {
        'title': 'Promotion Expense',
        'category': 'Promotion',
        'type': 'expense',
        'amount': 600.0,
        'date': now.subtract(const Duration(days: 15)),
        'status': 'Pending',
        'reference': 'FR-EXP-003',
        'description': 'स्थानिक Promotion खर्च.',
      },
      {
        'title': 'Seller Revenue Share',
        'category': 'Seller Revenue',
        'type': 'income',
        'amount': 3100.0,
        'date': DateTime(now.year, now.month - 1, 15),
        'status': 'Received',
        'reference': 'FR-INC-006',
        'description': 'मागील महिन्याचा Seller Revenue Share.',
      },
    ];
  }

  List<Map<String, dynamic>> get _filteredTransactions {
    final now = DateTime.now();

    return _transactions.where((transaction) {
      final date = transaction['date'] as DateTime;

      switch (_selectedFilter) {
        case 'Today':
          return date.year == now.year &&
              date.month == now.month &&
              date.day == now.day;

        case 'Week':
          final start = DateTime(now.year, now.month, now.day)
              .subtract(const Duration(days: 6));
          return !date.isBefore(start) &&
              !date.isAfter(DateTime(now.year, now.month, now.day, 23, 59));

        case 'Month':
          return date.year == now.year && date.month == now.month;

        case 'Calendar':
          if (_customRange == null) return false;
          final start = DateTime(
            _customRange!.start.year,
            _customRange!.start.month,
            _customRange!.start.day,
          );
          final end = DateTime(
            _customRange!.end.year,
            _customRange!.end.month,
            _customRange!.end.day,
            23,
            59,
            59,
          );
          return !date.isBefore(start) && !date.isAfter(end);

        default:
          return true;
      }
    }).toList()
      ..sort(
        (a, b) =>
            (b['date'] as DateTime).compareTo(a['date'] as DateTime),
      );
  }

  double get _totalIncome {
    return _filteredTransactions
        .where((e) => e['type'] == 'income' && e['status'] == 'Received')
        .fold(0.0, (sum, e) => sum + (e['amount'] as double));
  }

  double get _totalExpense {
    return _filteredTransactions
        .where((e) => e['type'] == 'expense' && e['status'] == 'Paid')
        .fold(0.0, (sum, e) => sum + (e['amount'] as double));
  }

  double get _netIncome => _totalIncome - _totalExpense;

  Future<void> _pickCustomRange() async {
    final now = DateTime.now();

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 2),
      lastDate: now,
      initialDateRange: _customRange ??
          DateTimeRange(
            start: now.subtract(const Duration(days: 7)),
            end: now,
          ),
    );

    if (picked != null) {
      setState(() {
        _customRange = picked;
        _selectedFilter = 'Calendar';
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _formatAmount(double amount) {
    return '₹${amount.toStringAsFixed(0)}';
  }

  void _showTransactionDetails(Map<String, dynamic> transaction) {
    final isIncome = transaction['type'] == 'income';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Transaction Details',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              _detailRow('व्यवहार', transaction['title']),
              _detailRow('प्रकार', isIncome ? 'Income' : 'Expense'),
              _detailRow('Category', transaction['category']),
              _detailRow(
                'रक्कम',
                _formatAmount(transaction['amount'] as double),
              ),
              _detailRow(
                'तारीख',
                _formatDate(transaction['date'] as DateTime),
              ),
              _detailRow('Status', transaction['status']),
              _detailRow('Reference', transaction['reference']),
              const SizedBox(height: 10),
              const Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(transaction['description']),
            ],
          ),
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.textLight),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _showDemoExportMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Excel Export सुविधा Stage 3 मध्ये उपलब्ध होईल.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final transactions = _filteredTransactions;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text(
          'Franchise Accounting',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date filters
            const Text(
              'कालावधी निवडा',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _filterChip('Today'),
                _filterChip('Week'),
                _filterChip('Month'),
                _filterChip('Calendar'),
              ],
            ),

            if (_selectedFilter == 'Calendar') ...[
              const SizedBox(height: 12),
              InkWell(
                onTap: _pickCustomRange,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.primaryBlue.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.date_range,
                        color: AppColors.primaryBlue,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _customRange == null
                              ? 'तारीख निवडा'
                              : '${_formatDate(_customRange!.start)} ते ${_formatDate(_customRange!.end)}',
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Summary
            const Text(
              'आर्थिक आढावा',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _summaryCard(
                    'Total Income',
                    _formatAmount(_totalIncome),
                    Colors.green,
                    Icons.arrow_downward,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _summaryCard(
                    'Total Expense',
                    _formatAmount(_totalExpense),
                    Colors.red,
                    Icons.arrow_upward,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            _summaryCard(
              'Net Income',
              _formatAmount(_netIncome),
              AppColors.primaryBlue,
              Icons.account_balance_wallet_outlined,
              fullWidth: true,
            ),

            const SizedBox(height: 20),

            // Income categories
            _sectionCard(
              title: 'उत्पन्नाचे प्रकार',
              icon: Icons.trending_up,
              children: [
                _categoryRow(
                  'Seller Revenue Share',
                  _categoryTotal('Seller Revenue', 'income'),
                  Colors.green,
                ),
                _categoryRow(
                  'Advertisement Income',
                  _categoryTotal('Advertisement', 'income'),
                  Colors.purple,
                ),
                _categoryRow(
                  'Subscription Income',
                  _categoryTotal('Subscription', 'income'),
                  Colors.blue,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Expense categories
            _sectionCard(
              title: 'खर्चाचे प्रकार',
              icon: Icons.money_off,
              children: [
                _categoryRow(
                  'Marketing',
                  _categoryTotal('Marketing', 'expense'),
                  Colors.orange,
                ),
                _categoryRow(
                  'Operations',
                  _categoryTotal('Operations', 'expense'),
                  Colors.red,
                ),
                _categoryRow(
                  'Promotion',
                  _categoryTotal('Promotion', 'expense'),
                  Colors.deepPurple,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'व्यवहारांची यादी',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                TextButton.icon(
                  onPressed: _showDemoExportMessage,
                  icon: const Icon(Icons.download_outlined),
                  label: const Text('Excel'),
                ),
              ],
            ),

            const SizedBox(height: 8),

            if (transactions.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 36,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text('या कालावधीत व्यवहार उपलब्ध नाहीत.'),
                  ],
                ),
              )
            else
              ...transactions.map(_transactionTile),

            const SizedBox(height: 20),

            const Text(
              'टीप: ही सर्व माहिती Stage 2 Demo Data आहे. प्रत्यक्ष आर्थिक व्यवहार आणि अहवाल Stage 3 Backend जोडल्यावर उपलब्ध होतील.',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textLight,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String label) {
    final selected = _selectedFilter == label;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() {
          _selectedFilter = label;
        });
      },
      selectedColor: AppColors.primaryBlue,
      labelStyle: TextStyle(
        color: selected ? Colors.white : AppColors.textDark,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: Colors.white,
      side: BorderSide(
        color: selected ? AppColors.primaryBlue : Colors.grey.shade300,
      ),
    );
  }

  Widget _summaryCard(
    String title,
    String value,
    Color color,
    IconData icon, {
    bool fullWidth = false,
  }) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 25),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  Widget _categoryRow(String title, double amount, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 5,
                  backgroundColor: color,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatAmount(amount),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  double _categoryTotal(String category, String type) {
    return _filteredTransactions
        .where(
          (e) =>
              e['category'] == category &&
              e['type'] == type &&
              (type == 'income'
                  ? e['status'] == 'Received'
                  : e['status'] == 'Paid'),
        )
        .fold(0.0, (sum, e) => sum + (e['amount'] as double));
  }

  Widget _transactionTile(Map<String, dynamic> transaction) {
    final isIncome = transaction['type'] == 'income';
    final color = isIncome ? Colors.green : Colors.red;
    final amount = transaction['amount'] as double;

    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        onTap: () => _showTransactionDetails(transaction),
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.10),
          child: Icon(
            isIncome ? Icons.arrow_downward : Icons.arrow_upward,
            color: color,
          ),
        ),
        title: Text(
          transaction['title'],
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${transaction['category']} • ${_formatDate(transaction['date'] as DateTime)}\n${transaction['status']}',
          style: const TextStyle(fontSize: 11),
        ),
        isThreeLine: true,
        trailing: Text(
          '${isIncome ? '+' : '-'}${_formatAmount(amount)}',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
