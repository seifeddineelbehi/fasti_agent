import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:flutter/material.dart';

Widget buildStatusBadge(bool positive, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(45),
      color: positive ? Colors.green.shade50 : Colors.red.shade50,
    ),
    child: CommonText.textBoldWeight600(
      text: text,
      color: positive ? Colors.green : Colors.red,
    ),
  );
}
