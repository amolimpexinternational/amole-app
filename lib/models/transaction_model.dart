enum TxnType { credit, debit }

class TransactionModel {
  final String id;
  final String entityName;
  final String entityRole; // Seller | Buyer | Franchise | Channel Partner
  final String title;
  final double amount;
  final TxnType type;
  final DateTime date;
  final String category; // purchase | settlement | commission | order | reward

  TransactionModel({
    required this.id,
    required this.entityName,
    required this.entityRole,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    required this.category,
  });

  String get dateKey =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  String get dateLabel {
    const months = ['जाने', 'फेब्रु', 'मार्च', 'एप्रिल', 'मे', 'जून', 'जुलै', 'ऑग', 'सप्टें', 'ऑक्टो', 'नोव्हें', 'डिसें'];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
