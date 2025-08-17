import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:flutter/material.dart';

Widget buildRentalRequestStatusBadge(String status) {
  Color backgroundColor;
  Color textColor;
  IconData icon;

  switch (status.toLowerCase()) {
    case 'accepted':
      backgroundColor = Colors.green.shade50;
      textColor = Colors.green;
      icon = Icons.check_circle;
      break;
    case 'refused':
    case 'cancelled':
      backgroundColor = Colors.red.shade50;
      textColor = Colors.red;
      icon = Icons.cancel;
      break;
    case 'pending':
      backgroundColor = Colors.orange.shade50;
      textColor = Colors.orange;
      icon = Icons.schedule;
      break;
    case 'completed':
      backgroundColor = Colors.blue.shade50;
      textColor = Colors.blue;
      icon = Icons.done_all;
      break;
    case 'active':
    case 'ongoing':
      backgroundColor = Colors.purple.shade50;
      textColor = Colors.purple;
      icon = Icons.directions_car;
      break;
    default:
      backgroundColor = Colors.grey.shade50;
      textColor = Colors.grey;
      icon = Icons.help_outline;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: backgroundColor,
      border: Border.all(color: textColor.withOpacity(0.3)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: textColor,
        ),
        const SizedBox(width: 4),
        CommonText.textBoldWeight600(
          text: status.toUpperCase(),
          color: textColor,
          fontSize: 12,
        ),
      ],
    ),
  );
}
