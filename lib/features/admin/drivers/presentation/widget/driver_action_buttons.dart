import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/drivers/presentation/widget/approve_driver_dialog.dart';
import 'package:fasti_dashboard/features/admin/drivers/presentation/widget/ban_driver_dialog.dart';
import 'package:fasti_dashboard/features/admin/drivers/presentation/widget/recharge_wallet_dialog.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverActionButtons extends StatefulWidget {
  final UserModel user;
  final WidgetRef ref;
  const DriverActionButtons({super.key, required this.user, required this.ref});

  @override
  State<DriverActionButtons> createState() => _DriverActionButtonsState();
}

class _DriverActionButtonsState extends State<DriverActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButtons.circularButtonWithIconAndTooltip(
          icon: Icons.wallet,
          tooltip: 'Recharge Wallet',
          color: Palette.blueColor,
          onTap: () =>
              showRechargeWalletDialog(context, widget.ref, widget.user.id),
        ),
        SizedBox(width: 4.w),
        if (widget.user.driverInfo?.approvedStatus != 'approved')
          CustomButtons.circularButtonWithIconAndTooltip(
            icon: Icons.approval,
            tooltip: 'Approve',
            color: Palette.mainDarkColor,
            onTap: () =>
                showApproveDriverDialog(context, widget.ref, widget.user.id),
          ),
        SizedBox(width: 4.w),
        CustomButtons.circularButtonWithIconAndTooltip(
          icon: Icons.cancel_outlined,
          tooltip: widget.user.isBanned ? 'Unban' : 'Ban',
          color:
              widget.user.isBanned ? Palette.mainDarkColor : Palette.redColor,
          onTap: () => showBanDriverDialog(
              context, widget.ref, widget.user.id, widget.user.isBanned),
        ),
      ],
    );
  }
}
