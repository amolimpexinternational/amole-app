
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CpAccountingScreen extends StatefulWidget {
  const CpAccountingScreen({super.key});

  @override
  State<CpAccountingScreen> createState() => _CpAccountingScreenState();
}

class _CpAccountingScreenState extends State<CpAccountingScreen> {
  String _selectedPeriod = 'महिना';
  DateTime _selectedDate = DateTime.now();

  late final List<Map<String, dynamic>> _transactions;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();

    _transactions = [
      {
        'title': 'हडपसर Franchise Revenue Share',
        'category': 'Franchise Income',
        'type': 'income',
        'amount': 12400.0,
        'date': now.subtract(const Duration(days: 1)),
        'status': 'पूर्ण',
        'reference': 'CP-TXN-001',
      },
      {
        'title': 'कोथरूड Franchise Revenue Share',
        'category': 'Franchise Income',
        'type': 'income',
        'amount': 9800.0,
        'date': now.subtract(const Duration(days: 3)),
        'status': 'पूर्ण',
        'reference': 'CP-TXN-002',
      },
      {
        'title': 'Seller Revenue Share',
        'category': 'Seller Income',
        'type': 'income',
        'amount': 6500.0,
        'date': now.subtract(const Duration(days: 5)),
        'status': 'पूर्ण',
        'reference': 'CP-TXN-003',
      },
      {
        'title': 'Advertisement Income',
        'category': 'Advertisement',
        'type': 'income',
        'amount': 3500.0,
        'date': now.subtract(const Duration(days: 8)),
        'status': 'पूर्ण',
        'reference': 'CP-TXN-004',
      },
      {
        'title': 'Subscription Income',
        'category': 'Subscription',
        'type': 'income',
        'amount': 2200.0,
        'date': now.subtract(const Duration(days: 12)),
        'status': 'पूर्ण',
        'reference': 'CP-TXN-005',
      },
      {
        'title': 'Marketing खर्च',
        'category': 'Marketing',
        'type': 'expense',
        'amount': 2500.0,
        'date': now.subtract(const Duration(days: 2)),
        'status': 'पूर्ण',
        'reference': 'CP-EXP-001',
      },
      {
        'title': 'Operational खर्च',
        'category': 'Operations',
        'type': 'expense',
        'amount': 1200.0,
        'date': now.subtract(const Duration(days: 7)),
        'status': 'पूर्ण',
        'reference': 'CP-EXP-002',
      },
      {
        'title': 'प्रमोशन खर्च',
        'category': 'Marketing',
        'type': 'expense',
        'amount': 800.0,
        'date': now.subtract(const Duration(days: 15)),
        'status': 'पूर्ण',
        'reference': 'CP-EXP-003',
      },
    ];
  }

  List<Map<String, dynamic>> get _filteredTransactions {
    final now = DateTime.now();

    return _transactions.where((transaction) {
      final date = transaction['date'] as DateTime;

      if (_selectedPeriod == 'आज') {
        return date.year == now.year &&
            date.month == now.month &&
            date.day == now.day;
      }

      if (_selectedPeriod == 'आठवडा') {
        final start = now.subtract(const Duration(days: 6));
        return !date.isBefore(
          DateTime(start.year, start.month, start.day),
        );
      }

      if (_selectedPeriod == 'महिना') {
        return date.year == now.year && date.month == now.month;
      }

      return date.year == _selectedDate.year &&
          date.month == _selectedDate.month &&
          date.day == _selectedDate.day;
    }).toList()
      ..sort(
        (a, b) =>
            (b['date'] as DateTime).compareTo(a['date'] as DateTime),
      );
  }

  double get _totalIncome {
    return _filteredTransactions
        .where((t) => t['type'] == 'income')
        .fold(0.0, (sum, t) => sum + (t['amount'] as double));
  }

  double get _totalExpense {
    return _filteredTransactions
        .where((t) => t['type'] == 'expense')
        .fold(0.0, (sum, t) => sum + (t['amount'] as double));
  }

  double get _netIncome => _totalIncome - _totalExpense;

  String _formatAmount(double amount) {
    return '₹${amount.toStringAsFixed(0)}';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      helpText: 'हिशोबासाठी तारीख निवडा',
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _selectedPeriod = 'Calendar';
      });
    }
  }

  void _showTransactionDetails(Map<String, dynamic> transaction) {
    final isIncome = transaction['type'] == 'income';

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'व्यवहाराचा तपशील',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            _detailRow('व्यवहार', transaction['title']),
            _detailRow('प्रकार', transaction['category']),
            _detailRow('Reference', transaction['reference']),
            _detailRow('तारीख', _formatDate(transaction['date'])),
            _detailRow('स्थिती', transaction['status']),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'रक्कम',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${isIncome ? '+' : '-'}${_formatAmount(transaction['amount'])}',
                  style: TextStyle(
                    color: isIncome ? Colors.green : Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textLight),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(
    String title,
    double amount,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                _formatAmount(amount),
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _periodButton(String title) {
    final selected = _selectedPeriod == title;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPeriod = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.primaryBlue : AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? AppColors.primaryBlue : AppColors.lightGrey,
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: selected ? Colors.white : AppColors.textDark,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  Widget _franchiseRow(
    String name,
    String area,
    String amount,
    String percentage,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
            child: const Icon(
              Icons.store_outlined,
              color: AppColors.primaryBlue,
              size: 19,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  area,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.successGreen,
                ),
              ),
              Text(
                percentage,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _monthlyBar(String month, double amount, double maximum) {
    final percent = maximum == 0 ? 0.0 : amount / maximum;

    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          SizedBox(
            width: 42,
            child: Text(
              month,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textLight,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: percent.clamp(0.0, 1.0),
                minHeight: 15,
                backgroundColor: AppColors.lightGrey,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primaryBlue,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 75,
            child: Text(
              _formatAmount(amount),
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionCard(Map<String, dynamic> transaction) {
    final isIncome = transaction['type'] == 'income';

    return InkWell(
      onTap: () => _showTransactionDetails(transaction),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: isIncome
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              child: Icon(
                isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                color: isIncome ? Colors.green : Colors.red,
                size: 19,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${transaction['category']} • ${_formatDate(transaction['date'])}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${isIncome ? '+' : '-'}${_formatAmount(transaction['amount'])}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: isIncome ? Colors.green : Colors.red,
              ),
            ),
          ],
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
          'CP Accounting',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Excel Download',
            icon: const Icon(Icons.download_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Excel Export सुविधा Stage 3 मध्ये सुरू होईल.',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange.withOpacity(0.4)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'ही Demo Accounting माहिती आहे. प्रत्यक्ष व्यवहार Stage 3 मध्ये जोडले जातील.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            _sectionTitle('कालावधी निवडा'),
            Row(
              children: [
                _periodButton('आज'),
                const SizedBox(width: 7),
                _periodButton('आठवडा'),
                const SizedBox(width: 7),
                _periodButton('महिना'),
                const SizedBox(width: 7),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _selectDate,
                    icon: const Icon(Icons.calendar_month, size: 16),
                    label: const Text(
                      'Calendar',
                      style: TextStyle(fontSize: 11),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
            if (_selectedPeriod == 'Calendar')
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'निवडलेली तारीख: ${_formatDate(_selectedDate)}',
                  style: const TextStyle(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(height: 18),

            _sectionTitle('आर्थिक सारांश'),
            Row(
              children: [
                _summaryCard(
                  'Total Income',
                  _totalIncome,
                  Icons.trending_up,
                  Colors.green,
                ),
                const SizedBox(width: 10),
                _summaryCard(
                  'Total Expense',
                  _totalExpense,
                  Icons.trending_down,
                  Colors.red,
                ),
                const SizedBox(width: 10),
                _summaryCard(
                  'Net Income',
                  _netIncome,
                  Icons.account_balance_wallet_outlined,
                  AppColors.primaryBlue,
                ),
              ],
            ),
            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.lightGrey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CP Revenue Share',
                    style: TextStyle(
                      color: AppColors.textLight,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatAmount(_totalIncome),
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'वरील Demo उत्पन्न नोंदींची एकत्रित रक्कम',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            _sectionTitle('उत्पन्नाचे प्रकार'),
            _franchiseRow(
              'Franchise Revenue Share',
              'Franchise Network',
              '₹22,200',
              'मुख्य उत्पन्न',
            ),
            _franchiseRow(
              'Seller Revenue Share',
              'Seller Network',
              '₹6,500',
              'Seller उत्पन्न',
            ),
            _franchiseRow(
              'Advertisement Income',
              'जाहिराती',
              '₹3,500',
              'Ad उत्पन्न',
            ),
            _franchiseRow(
              'Subscription Income',
              'सदस्यत्व',
              '₹2,200',
              'Subscription',
            ),
            const SizedBox(height: 12),

            _sectionTitle('Franchise-wise Revenue'),
            _franchiseRow(
              'हडपसर फ्रँचायजी',
              'पुणे — हडपसर',
              '₹12,400',
              '32%',
            ),
            _franchiseRow(
              'कोथरूड फ्रँचायजी',
              'पुणे — कोथरूड',
              '₹9,800',
              '26%',
            ),
            _franchiseRow(
              'वडगाव फ्रँचायजी',
              'पुणे — वडगाव',
              '₹8,600',
              '22%',
            ),
            _franchiseRow(
              'भोसरी फ्रँचायजी',
              'पुणे — भोसरी',
              '₹7,600',
              '20%',
            ),
            const SizedBox(height: 12),

            _sectionTitle('महिनानिहाय Revenue'),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.lightGrey),
              ),
              child: Column(
                children: [
                  _monthlyBar('जाने', 19200, 38400),
                  _monthlyBar('फेब्रु', 23000, 38400),
                  _monthlyBar('मार्च', 26800, 38400),
                  _monthlyBar('एप्रिल', 24960, 38400),
                  _monthlyBar('मे', 30720, 38400),
                  _monthlyBar('जून', 38400, 38400),
                ],
              ),
            ),
            const SizedBox(height: 22),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _sectionTitle('व्यवहारांची यादी')),
                Text(
                  '${transactions.length} व्यवहार',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
            if (transactions.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'या कालावधीत कोणतेही व्यवहार नाहीत.',
                    style: TextStyle(color: AppColors.textLight),
                  ),
                ),
              )
            else
              ...transactions.map(_transactionCard),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
