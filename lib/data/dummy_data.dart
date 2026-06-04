import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/transaction_model.dart';

/// Mock spend summary values for the header card.
class SpendSummaryData {
  const SpendSummaryData({
    required this.monthLabel,
    required this.monthlySpend,
    required this.percentChange,
  });

  final String monthLabel;
  final double monthlySpend;

  /// Signed percentage vs previous month (positive = spend increased).
  final double percentChange;
}

class DummyData {
  DummyData._();

  static const SpendSummaryData summary = SpendSummaryData(
    monthLabel: 'June 2026',
    monthlySpend: 42850,
    percentChange: 12.4,
  );

  static const List<CategoryModel> categories = [
    CategoryModel(
      id: 'food',
      name: 'Food',
      icon: Icons.restaurant_rounded,
      amount: 12450,
    ),
    CategoryModel(
      id: 'travel',
      name: 'Travel',
      icon: Icons.flight_rounded,
      amount: 9800,
    ),
    CategoryModel(
      id: 'shopping',
      name: 'Shopping',
      icon: Icons.shopping_bag_rounded,
      amount: 7650,
    ),
    CategoryModel(
      id: 'bills',
      name: 'Bills',
      icon: Icons.receipt_long_rounded,
      amount: 6200,
    ),
    CategoryModel(
      id: 'entertainment',
      name: 'Fun',
      icon: Icons.movie_rounded,
      amount: 4150,
    ),
    CategoryModel(
      id: 'health',
      name: 'Health',
      icon: Icons.favorite_rounded,
      amount: 2600,
    ),
  ];

  /// Category with the highest spend (for insights card).
  static CategoryModel get topSpendingCategory {
    return categories.reduce(
      (current, next) => next.amount > current.amount ? next : current,
    );
  }

  /// Single largest recent transaction (for insights card).
  static TransactionModel get highestTransaction {
    return recentTransactions.reduce(
      (current, next) => next.amount > current.amount ? next : current,
    );
  }

  /// Normalized values (0–1) for header sparkline from category spends.
  static List<double> get spendTrendPoints {
    final amounts = categories.map((c) => c.amount).toList();
    final max = amounts.reduce((a, b) => a > b ? a : b);
    return amounts.map((a) => a / max).toList();
  }

  static final List<TransactionModel> recentTransactions = [
    TransactionModel(
      id: 'tx_1',
      title: 'Zomato',
      category: 'Food',
      date: DateTime(2026, 6, 3, 19, 42),
      amount: 485,
    ),
    TransactionModel(
      id: 'tx_2',
      title: 'Uber',
      category: 'Travel',
      date: DateTime(2026, 6, 3, 9, 15),
      amount: 320,
    ),
    TransactionModel(
      id: 'tx_3',
      title: 'Amazon',
      category: 'Shopping',
      date: DateTime(2026, 6, 2, 14, 8),
      amount: 2499,
    ),
    TransactionModel(
      id: 'tx_4',
      title: 'Airtel Postpaid',
      category: 'Bills',
      date: DateTime(2026, 6, 1, 11, 0),
      amount: 899,
    ),
    TransactionModel(
      id: 'tx_5',
      title: 'Netflix',
      category: 'Fun',
      date: DateTime(2026, 5, 31, 8, 30),
      amount: 649,
    ),
    TransactionModel(
      id: 'tx_6',
      title: 'Apollo Pharmacy',
      category: 'Health',
      date: DateTime(2026, 5, 30, 17, 55),
      amount: 780,
    ),
    TransactionModel(
      id: 'tx_7',
      title: 'Swiggy Instamart',
      category: 'Food',
      date: DateTime(2026, 5, 29, 21, 10),
      amount: 612,
    ),
  ];
}
