import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/users/presentation/riverpod/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showBanUserDialog(
  BuildContext context,
  WidgetRef ref,
  String userId,
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
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isBanned ? Icons.check_circle : Icons.warning,
                  size: 48,
                  color: isBanned ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 16),
                CommonText.textBoldWeight500(
                  text: isBanned
                      ? "Are you sure you want to unban this user? They will regain access to the platform."
                      : "Are you sure you want to ban this user? They will lose access to the platform.",
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
                text: isBanned ? "Unban" : "Ban",
                isLoading: isLoading,
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() => isLoading = true);
                        await ref
                            .read(usersNotifierProvider.notifier)
                            .banUser(userId: userId);
                        setState(() => isLoading = false);
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isBanned
                                ? 'User has been unbanned successfully'
                                : 'User has been banned successfully'),
                            backgroundColor:
                                isBanned ? Colors.green : Colors.orange,
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
