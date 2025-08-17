import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/rents/data/model/rental_request_model.dart';
import 'package:fasti_dashboard/features/admin/rents/presentation/riverpod/rents_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showRentalRequestActionDialog(
  BuildContext context,
  WidgetRef ref,
  RentalRequestModel request,
  String currentStatus,
  String action, // 'accept' or 'refuse'
) {
  final TextEditingController noteController = TextEditingController();
  bool isLoading = false;

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          final isAccept = action.toLowerCase() == 'accept';
          return AlertDialog(
            title: CommonText.textBoldWeight700(
              text:
                  isAccept ? "Accept Rental Request" : "Refuse Rental Request",
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isAccept ? Icons.check_circle : Icons.cancel,
                  size: 48,
                  color: isAccept ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 16),
                CommonText.textBoldWeight500(
                  text: isAccept
                      ? "Are you sure you want to accept this rental request? The customer will be notified and the car will be reserved for the specified period."
                      : "Are you sure you want to refuse this rental request? The customer will be notified and they can submit a new request.",
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
                text: isAccept ? "Accept" : "Refuse",
                isLoading: isLoading,
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() => isLoading = true);

                        await ref
                            .read(rentsNotifierProvider.notifier)
                            .confirmUnConfirmRent(
                              rent: request,
                              isAccept: isAccept,
                            );

                        setState(() => isLoading = false);
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isAccept
                                ? 'Rental request has been accepted successfully'
                                : 'Rental request has been refused'),
                            backgroundColor:
                                isAccept ? Colors.green : Colors.orange,
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
