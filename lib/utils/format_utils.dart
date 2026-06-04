import 'package:flutter/material.dart';

class FormatUtils {
  FormatUtils._();

  static String currency(double amount) {
    final value = amount.round();
    final digits = value.abs().toString();
    if (digits.length <= 3) return '₹$value';

    final buffer = StringBuffer('₹');
    final remainder = digits.length % 3;
    if (remainder > 0) {
      buffer.write(digits.substring(0, remainder));
      if (digits.length > remainder) buffer.write(',');
    }
    for (var i = remainder; i < digits.length; i += 3) {
      if (i > remainder) buffer.write(',');
      buffer.write(digits.substring(i, i + 3));
    }
    return buffer.toString();
  }

  static String compactCurrency(double amount) {
    if (amount >= 100000) {
      return '₹${(amount / 100000).toStringAsFixed(1)}L';
    }
    if (amount >= 1000) {
      return '₹${(amount / 1000).toStringAsFixed(1)}K';
    }
    return currency(amount);
  }

  static String transactionDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final period = date.hour >= 12 ? 'PM' : 'AM';
    final minute = date.minute.toString().padLeft(2, '0');
    return '${date.day} ${months[date.month - 1]}, $hour:$minute $period';
  }

  static IconData iconForCategory(String category) {
    return switch (category.toLowerCase()) {
      'food' => Icons.restaurant_rounded,
      'travel' => Icons.flight_rounded,
      'shopping' => Icons.shopping_bag_rounded,
      'bills' => Icons.receipt_long_rounded,
      'fun' => Icons.movie_rounded,
      'health' => Icons.favorite_rounded,
      _ => Icons.payments_rounded,
    };
  }
}
