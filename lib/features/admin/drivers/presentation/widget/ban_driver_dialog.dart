import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/drivers/presentation/riverpod/drivers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showBanDriverDialog(
  BuildContext context,
  WidgetRef ref,
  String driverId,
  bool isBanned,
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
              text: isBanned ? "Unban User" : "Ban User",
            ),
            content: CommonText.textBoldWeight500(
              text: isBanned
                  ? "Are you sure you want to unban this user?"
                  : "Are you sure you want to ban this user?",
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
                text: isBanned ? "Unban" : "Ban",
                isLoading: isLoading,
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() => isLoading = true);
                        await ref
                            .read(driversNotifierProvider.notifier)
                            .banDriver(driverId: driverId);
                        setState(() => isLoading = false);
                        Navigator.pop(context);
                      },
              ),
            ],
          );
        },
      );
    },
  );
}
