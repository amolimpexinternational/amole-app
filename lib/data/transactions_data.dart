import '../models/transaction_model.dart';

/// सर्व प्लॅटफॉर्म व्यवहारांचा शेअर्ड डेटा.
/// TODO (Stage 3 - Backend): Firestore collection 'transactions' मधून आणणे.
class TransactionsData {
  static final List<TransactionModel> all = [
    TransactionModel(id: 't1', entityName: 'पाटील किराणा स्टोअर', entityRole: 'Seller', title: 'ऑर्डर विक्री — ग्राहक: अजय कदम', amount: 480, type: TxnType.credit, date: DateTime.now().subtract(const Duration(hours: 3)), category: 'order'),
    TransactionModel(id: 't2', entityName: 'पाटील किराणा स्टोअर', entityRole: 'Seller', title: 'कंपनी कमिशन कापले (10%)', amount: 48, type: TxnType.debit, date: DateTime.now().subtract(const Duration(hours: 3)), category: 'commission'),
    TransactionModel(id: 't3', entityName: 'पाटील किराणा स्टोअर', entityRole: 'Seller', title: 'Daily Auto-Settlement — बँक खात्यावर पाठवले', amount: 4850, type: TxnType.debit, date: DateTime.now().subtract(const Duration(days: 1)), category: 'settlement'),
    TransactionModel(id: 't4', entityName: 'पाटील किराणा स्टोअर', entityRole: 'Seller', title: 'Daily Auto-Settlement — बँक खात्यावर पाठवले', amount: 3920, type: TxnType.debit, date: DateTime.now().subtract(const Duration(days: 2)), category: 'settlement'),
    TransactionModel(id: 't5', entityName: 'श्री साई मेडिकल', entityRole: 'Seller', title: 'ऑर्डर विक्री — ग्राहक: स्नेहा भोसले', amount: 620, type: TxnType.credit, date: DateTime.now().subtract(const Duration(hours: 6)), category: 'order'),
    TransactionModel(id: 't6', entityName: 'श्री साई मेडिकल', entityRole: 'Seller', title: 'Daily Auto-Settlement — बँक खात्यावर पाठवले', amount: 2650, type: TxnType.debit, date: DateTime.now().subtract(const Duration(days: 1)), category: 'settlement'),
    TransactionModel(id: 't7', entityName: 'न्यू फॅशन पॉइंट', entityRole: 'Seller', title: 'Daily Auto-Settlement — बँक खात्यावर पाठवले', amount: 1180, type: TxnType.debit, date: DateTime.now().subtract(const Duration(days: 1)), category: 'settlement'),
    TransactionModel(id: 't8', entityName: 'न्यू फॅशन पॉइंट', entityRole: 'Seller', title: 'Daily Auto-Settlement — बँक खात्यावर पाठवले', amount: 990, type: TxnType.debit, date: DateTime.now().subtract(const Duration(days: 2)), category: 'settlement'),
    TransactionModel(id: 't9', entityName: 'अजय कदम', entityRole: 'Buyer', title: 'खरेदी — पाटील किराणा स्टोअर', amount: 480, type: TxnType.debit, date: DateTime.now().subtract(const Duration(hours: 3)), category: 'purchase'),
    TransactionModel(id: 't10', entityName: 'अजय कदम', entityRole: 'Buyer', title: 'Reward Points जमा (2%)', amount: 10, type: TxnType.credit, date: DateTime.now().subtract(const Duration(hours: 3)), category: 'reward'),
    TransactionModel(id: 't11', entityName: 'स्नेहा भोसले', entityRole: 'Buyer', title: 'खरेदी — श्री साई मेडिकल', amount: 620, type: TxnType.debit, date: DateTime.now().subtract(const Duration(hours: 6)), category: 'purchase'),
    TransactionModel(id: 't12', entityName: 'हडपसर फ्रँचाइजी', entityRole: 'Franchise', title: 'Revenue Share (1%) जमा', amount: 480, type: TxnType.credit, date: DateTime.now().subtract(const Duration(days: 1)), category: 'commission'),
    TransactionModel(id: 't13', entityName: 'हडपसर फ्रँचाइजी', entityRole: 'Franchise', title: 'Monthly Settlement — बँक खात्यावर पाठवले', amount: 1200, type: TxnType.debit, date: DateTime.now().subtract(const Duration(days: 5)), category: 'settlement'),
    TransactionModel(id: 't14', entityName: 'राजेश कुलकर्णी', entityRole: 'Channel Partner', title: 'Revenue Share (0.25%) जमा', amount: 120, type: TxnType.credit, date: DateTime.now().subtract(const Duration(days: 1)), category: 'commission'),
  ];

  static List<TransactionModel> forEntity(String entityName) {
    final list = all.where((t) => t.entityName == entityName).toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  static Map<String, List<TransactionModel>> get settlementsByDate {
    final settlements = all.where((t) => t.category == 'settlement' && t.entityRole == 'Seller').toList();
    final map = <String, List<TransactionModel>>{};
    for (final t in settlements) {
      map.putIfAbsent(t.dateKey, () => []).add(t);
    }
    return map;
  }

  static double totalForDate(String dateKey) {
    final list = settlementsByDate[dateKey] ?? [];
    return list.fold(0.0, (sum, t) => sum + t.amount);
  }
}
