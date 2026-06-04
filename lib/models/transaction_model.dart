class TransactionModel {
  const TransactionModel({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
  });

  final String id;
  final String title;
  final String category;
  final DateTime date;

  /// Spend amount in INR (always positive; UI may prefix with minus).
  final double amount;
}
