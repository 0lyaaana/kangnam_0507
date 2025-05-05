import 'package:flutter/material.dart';

class Discount {
  final String title;
  final String description;
  final String expiryDate;
  final int discountAmount;
  final String conditions;
  final String category;
  final bool isPercentage;
  final Color cardColor;

  Discount({
    required this.title,
    required this.description,
    required this.expiryDate,
    required this.discountAmount,
    required this.conditions,
    required this.category,
    this.isPercentage = false,
    this.cardColor = Colors.red,
  });
}
