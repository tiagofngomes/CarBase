import 'package:flutter/material.dart';

class ExpenseCategory {
  const ExpenseCategory({
    required this.label,
    required this.amount,
    required this.icon,
    required this.color,
  });

  final String label;
  final double amount;
  final IconData icon;
  final Color color;
}
