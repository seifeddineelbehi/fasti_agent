import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/riverpod/trips/trips_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showEndTripDialog(
  BuildContext context,
  WidgetRef ref,
  String tripId,
  String currentStatus,
) {
  final TextEditingController reasonController = TextEditingController();
  bool isLoading = false;

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: CommonText.textBoldWeight700(
              text: "End Trip",
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.flag,
                  size: 48,
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),
                CommonText.textBoldWeight500(
                  text:
                      "Are you sure you want to end this trip? This action will change the trip status to 'ended'.",
                ),
                const SizedBox(height: 12),
                Text(
                  'Current status: $currentStatus',
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
                text: "End Trip",
                isLoading: isLoading,
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() => isLoading = true);
                        await ref.read(tripsNotifierProvider.notifier).endTrip(
                              tripId: tripId,
                            );
                        setState(() => isLoading = false);
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Trip has been ended successfully'),
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
