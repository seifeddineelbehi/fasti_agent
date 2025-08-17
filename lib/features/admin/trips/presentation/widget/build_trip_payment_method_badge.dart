import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:flutter/material.dart';

Widget buildTripPaymentMethodeBadge(String method) {
  Color backgroundColor;
  Color textColor;

  switch (method.toLowerCase()) {
    case 'cash':
      backgroundColor = Colors.orange.shade50;
      textColor = Colors.orange;
      break;
    case 'wallet':
      backgroundColor = Colors.green.shade50;
      textColor = Colors.green;
      break;
    default:
      // Any other status defaults to "on trip" styling
      backgroundColor = Colors.blue.shade50;
      textColor = Colors.blue;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(45),
      color: backgroundColor,
    ),
    child: CommonText.textBoldWeight600(
      text: method.toUpperCase(),
      color: textColor,
    ),
  );
}
