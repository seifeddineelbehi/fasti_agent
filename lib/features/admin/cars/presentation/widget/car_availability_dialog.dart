import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/cars/presentation/riverpod/cars_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showCarAvailabilityDialog(
  BuildContext context,
  WidgetRef ref,
  String carId,
  bool isAvailable,
) {
  bool isLoading = false;

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: CommonText.textBoldWeight700(
              text: isAvailable
                  ? "Mark Car as Unavailable"
                  : "Mark Car as Available",
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isAvailable ? Icons.block : Icons.check_circle,
                  size: 48,
                  color: isAvailable ? Colors.orange : Colors.green,
                ),
                const SizedBox(height: 16),
                CommonText.textBoldWeight500(
                  text: isAvailable
                      ? "Are you sure you want to mark this car as unavailable? It will not be available for rental bookings."
                      : "Are you sure you want to mark this car as available? It will be available for rental bookings.",
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
                width: 220,
                text: isAvailable ? "Make Unavailable" : "Make Available",
                isLoading: isLoading,
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() => isLoading = true);
                        await ref
                            .read(carsNotifierProvider.notifier)
                            .toggleCarAvailability(carId: carId);
                        setState(() => isLoading = false);
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isAvailable
                                ? 'Car has been marked as unavailable'
                                : 'Car has been marked as available'),
                            backgroundColor:
                                isAvailable ? Colors.orange : Colors.green,
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
