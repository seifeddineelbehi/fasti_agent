import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:flutter/material.dart';

Widget buildTripStatusBadge(String status) {
  Color backgroundColor;
  Color textColor;

  switch (status.toLowerCase()) {
    case 'pending':
      backgroundColor = Colors.orange.shade50;
      textColor = Colors.orange;
      break;
    case 'accepted':
      backgroundColor = Colors.green.shade50;
      textColor = Colors.green;
      break;
    case 'not accepted':
      backgroundColor = Colors.red.shade50;
      textColor = Colors.red;
      break;
    case 'driverarrived':
      backgroundColor = Colors.purple.shade50;
      textColor = Colors.purple;
      break;
    case 'ontrip':
      backgroundColor = Colors.blue.shade50;
      textColor = Colors.blue;
      break;
    case 'awaiting_customer_confirmation':
      backgroundColor = Colors.amber.shade50;
      textColor = Colors.amber.shade700;
      break;
    case 'ended':
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
      text: status.toUpperCase(),
      color: textColor,
    ),
  );
}
