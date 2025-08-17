import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:flutter/material.dart';

Widget buildUserStatusBadge(bool positive, String text) {
  Color backgroundColor;
  Color textColor;

  if (text.toLowerCase() == 'online') {
    backgroundColor = Colors.green.shade50;
    textColor = Colors.green;
  } else if (text.toLowerCase() == 'offline') {
    backgroundColor = Colors.grey.shade50;
    textColor = Colors.grey;
  } else if (text.toLowerCase() == 'yes' && !positive) {
    // This is for banned status
    backgroundColor = Colors.red.shade50;
    textColor = Colors.red;
  } else if (text.toLowerCase() == 'no' && positive) {
    // This is for not banned status
    backgroundColor = Colors.green.shade50;
    textColor = Colors.green;
  } else {
    backgroundColor = positive ? Colors.green.shade50 : Colors.red.shade50;
    textColor = positive ? Colors.green : Colors.red;
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
