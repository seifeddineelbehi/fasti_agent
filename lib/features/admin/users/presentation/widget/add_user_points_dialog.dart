import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showAddUserPointsDialog(
  BuildContext context,
  WidgetRef ref,
  String userId,
) {
  final TextEditingController pointsController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  bool isLoading = false;
  bool isDeduction = false;

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: CommonText.textBoldWeight700(
              text: isDeduction ? "Deduct User Points" : "Add User Points",
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<bool>(
                        title: const Text('Add Points'),
                        value: false,
                        groupValue: isDeduction,
                        onChanged: (value) {
                          setState(() => isDeduction = value ?? false);
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<bool>(
                        title: const Text('Deduct Points'),
                        value: true,
                        groupValue: isDeduction,
                        onChanged: (value) {
                          setState(() => isDeduction = value ?? false);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: pointsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter points amount",
                    labelText:
                        isDeduction ? "Points to deduct" : "Points to add",
                    prefixIcon: const Icon(Icons.stars),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: reasonController,
                  decoration: const InputDecoration(
                    hintText: "Enter reason (optional)",
                    labelText: "Reason",
                    prefixIcon: Icon(Icons.note),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                Text(
                  isDeduction
                      ? 'This will deduct the specified points from the user\'s account.'
                      : 'This will add the specified points to the user\'s account.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Palette.redColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomButtons.simpleButton(
                width: 120,
                text: isDeduction ? "Deduct" : "Add",
                isLoading: isLoading,
                onPressed: isLoading
                    ? null
                    : () async {
                        final points = int.tryParse(pointsController.text);
                        if (points == null || points <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Please enter a valid points amount'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        setState(() => isLoading = true);
                        // await ref
                        //     .read(usersNotifierProvider.notifier)
                        //     .updateUserPoints(
                        //   userId: userId,
                        //   points: isDeduction ? -points : points,
                        //   reason: reasonController.text.isNotEmpty
                        //       ? reasonController.text
                        //       : (isDeduction ? 'Points deducted by admin' : 'Points added by admin'),
                        // );
                        setState(() => isLoading = false);
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isDeduction
                                ? '$points points deducted successfully'
                                : '$points points added successfully'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
              ),
            ],
          );
        },
      );
    },
  );
}
