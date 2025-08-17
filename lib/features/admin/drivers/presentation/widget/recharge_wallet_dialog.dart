import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/drivers/presentation/riverpod/drivers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showRechargeWalletDialog(
  BuildContext context,
  WidgetRef ref,
  String driverId,
) {
  final TextEditingController amountController = TextEditingController();
  bool isLoading = false;

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: CommonText.textBoldWeight700(text: "Recharge Wallet"),
            content: TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Enter amount"),
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
                text: "Recharge",
                isLoading: isLoading,
                onPressed: isLoading
                    ? null
                    : () async {
                        final amount = double.tryParse(amountController.text);
                        if (amount == null) return;

                        setState(() => isLoading = true);
                        await ref
                            .read(driversNotifierProvider.notifier)
                            .rechargeDriverWallet(
                              driverId: driverId,
                              amount: amount,
                            );
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
