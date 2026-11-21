import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminWalletScreen extends StatefulWidget {
  const AdminWalletScreen({super.key});

  @override
  State<AdminWalletScreen> createState() => _AdminWalletScreenState();
}

class _AdminWalletScreenState extends State<AdminWalletScreen> {
  String _selectedPeriod = 'आज';
  DateTime? _selectedDate;

  // Stage 2: Demo / mock wallet data.
  // Stage 3 मध्ये Firestore / company_ledger जोडला जाईल.
  final List<Map<String, String>> _transactions = [
    {
      'title': 'Seller Commission जमा — पाटील किराणा स्टोअर',
      'amount': '+₹10.00',
      'time': 'आज, 11:42 AM',
      'type': 'credit',
    },
    {
      'title': 'Franchise Settlement — हडपसर फ्रँचाइजी',
      'amount': '-₹1,200.00',
      'time': 'आज, 9:00 AM',
      'type': 'debit',
    },
    {
      'title': 'Ad Revenue — CP जाहिरात',
      'amount': '+₹0.15',
      'time': 'काल, 6:20 PM',
      'type': 'credit',
    },
    {
      'title': 'Seller Daily Auto-Settlement',
      'amount': '-₹4,850.00',
      'time': 'काल, 12:00 AM',
      'type': 'debit',
    },
  ];

  void _selectPeriod(String period) {
    setState(() {
      _selectedPeriod = period;
      _selectedDate = null;
    });
  }

  Future<void> _selectCalendarDate() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: now,
      helpText: 'Wallet तारीख निवडा',
      cancelText: 'रद्द',
      confirmText: 'निवडा',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryBlue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.textDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _selectedPeriod = 'तारीख';
      });
    }
  }

  String _formatSelectedDate() {
    if (_selectedDate == null) {
      return 'तारीख निवडा';
    }

    final date = _selectedDate!;

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _displayBalance() {
    switch (_selectedPeriod) {
      case 'आठवडा':
        return '₹18,450.00';
      case 'महिना':
        return '₹1,42,680.00';
      case 'तारीख':
        return '₹8,250.00';
      case 'आज':
      default:
        return '₹12,450.00';
    }
  }

  String _displayCredit() {
    switch (_selectedPeriod) {
      case 'आठवडा':
        return '₹87,300';
      case 'महिना':
        return '₹3,42,600';
      case 'तारीख':
        return '₹8,250';
      case 'आज':
      default:
        return '₹12,450';
    }
  }

  String _displaySettlement() {
    switch (_selectedPeriod) {
      case 'आठवडा':
        return '₹68,850';
      case 'महिना':
        return '₹2,19,920';
      case 'तारीख':
        return '₹4,850';
      case 'आज':
      default:
        return '₹5,120';
    }
  }

  void _showWalletSummary() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: AppColors.primaryBlue,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Wallet Summary',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _summaryRow('कालावधी', _selectedPeriod),
                if (_selectedDate != null)
                  _summaryRow('तारीख', _formatSelectedDate()),
                _summaryRow('Wallet शिल्लक', _displayBalance()),
                _summaryRow('जमा', _displayCredit()),
                _summaryRow('Settlement', _displaySettlement()),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'ही माहिती Stage 2 मधील demo/mock data आहे. '
                    'वास्तविक ledger Stage 3 मध्ये जोडला जाईल.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textLight,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
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
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text(
          'Company Wallet',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Wallet Summary',
            onPressed: _showWalletSummary,
            icon: const Icon(Icons.summarize_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPeriodSelector(),
          const SizedBox(height: 14),
          _buildWalletCard(),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'अलीकडील व्यवहार',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: _showWalletSummary,
                icon: const Icon(
                  Icons.analytics_outlined,
                  size: 17,
                ),
                label: const Text(
                  'Summary',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ..._transactions.map(_transactionCard),
          const SizedBox(height: 20),
          _buildDemoNote(),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Expanded(
            child: _periodButton('आज'),
          ),
          Expanded(
            child: _periodButton('आठवडा'),
          ),
          Expanded(
            child: _periodButton('महिना'),
          ),
          Expanded(
            child: _calendarButton(),
          ),
        ],
      ),
    );
  }

  Widget _periodButton(String period) {
    final bool selected = _selectedPeriod == period;

    return GestureDetector(
      onTap: () => _selectPeriod(period),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 6,
        ),
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
            fontWeight:
                selected ? FontWeight.bold : FontWeight.w500,
            color: selected
                ? Colors.white
                : AppColors.textDark,
          ),
        ),
      ),
    );
  }

  Widget _calendarButton() {
    final bool selected = _selectedPeriod == 'तारीख';

    return GestureDetector(
      onTap: _selectCalendarDate,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 4,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryBlue
              : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: 18,
              color: selected
                  ? Colors.white
                  : AppColors.textDark,
            ),
            const SizedBox(height: 1),
            Text(
              selected && _selectedDate != null
                  ? _formatSelectedDate()
                  : 'Calendar',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                fontWeight:
                    selected ? FontWeight.bold : FontWeight.w500,
                color: selected
                    ? Colors.white
                    : AppColors.textDark,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.royalBlue,
            AppColors.primaryBlue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.22),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'सध्याची Wallet शिल्लक',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _selectedPeriod,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            _displayBalance(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (_selectedDate != null) ...[
            const SizedBox(height: 4),
            Text(
              _formatSelectedDate(),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
          ],
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _headerStat(
                  'जमा',
                  _displayCredit(),
                ),
              ),
              Container(
                width: 1,
                height: 34,
                color: Colors.white24,
              ),
              Expanded(
                child: _headerStat(
                  'Settlement',
                  _displaySettlement(),
                ),
              ),
              Container(
                width: 1,
                height: 34,
                color: Colors.white24,
              ),
              Expanded(
                child: _headerStat(
                  'Transactions',
                  _transactions.length.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _transactionCard(Map<String, String> transaction) {
    final bool isCredit = transaction['type'] == 'credit';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: (isCredit
                      ? AppColors.successGreen
                      : AppColors.errorRed)
                  .withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCredit
                  ? Icons.arrow_downward
                  : Icons.arrow_upward,
              color: isCredit
                  ? AppColors.successGreen
                  : AppColors.errorRed,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['title'] ?? '',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  transaction['time'] ?? '',
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
            transaction['amount'] ?? '',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isCredit
                  ? AppColors.successGreen
                  : AppColors.errorRed,
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
        color: AppColors.primaryBlue.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.primaryBlue.withValues(alpha: 0.12),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 19,
            color: AppColors.primaryBlue,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Wallet मधील सर्व रक्कम आणि व्यवहार सध्या demo/mock आहेत. '
              'Stage 3 मध्ये वास्तविक company ledger / Firestore जोडले जाईल.',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}