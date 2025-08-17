import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:flutter/material.dart';

Widget buildCarStatusBadge(bool isAvailable) {
  Color backgroundColor;
  Color textColor;
  String text;

  if (isAvailable) {
    backgroundColor = Colors.green.shade50;
    textColor = Colors.green;
    text = 'Available';
  } else {
    backgroundColor = Colors.red.shade50;
    textColor = Colors.red;
    text = 'Unavailable';
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(45),
      color: backgroundColor,
    ),
    child: CommonText.textBoldWeight600(
      text: text,
      color: textColor,
    ),
  );
}
