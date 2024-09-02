import 'package:flutter/material.dart';

class AppStrings {
  static const String last60DaysReposTitle =
      'Click here to see the most starred GitHub repos that were created in the last 60 days.';
  static const String last30DaysReposTitle =
      'Click here to see the most starred GitHub repos that were created in the last 30 days.';
}

const kBodyContainerDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color(0xFFE36731),
      Color(0xFFDABE5D)
    ], // Custom gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
);