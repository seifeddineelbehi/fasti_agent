import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:fasti_dashboard/features/admin/users/presentation/widget/ban_user_dialog.dart';
import 'package:fasti_dashboard/features/admin/users/presentation/widget/recharge_user_wallet_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserActionButtons extends StatefulWidget {
  final UserModel user;
  final WidgetRef ref;
  const UserActionButtons({super.key, required this.user, required this.ref});

  @override
  State<UserActionButtons> createState() => _UserActionButtonsState();
}

class _UserActionButtonsState extends State<UserActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButtons.circularButtonWithIconAndTooltip(
          icon: Icons.wallet,
          tooltip: 'Recharge Wallet',
          color: Palette.blueColor,
          onTap: () =>
              showRechargeUserWalletDialog(context, widget.ref, widget.user.id),
        ),
        SizedBox(width: 4.w),
        CustomButtons.circularButtonWithIconAndTooltip(
          icon: Icons.cancel_outlined,
          tooltip: widget.user.isBanned ? 'Unban' : 'Ban',
          color:
              widget.user.isBanned ? Palette.mainDarkColor : Palette.redColor,
          onTap: () => showBanUserDialog(
              context, widget.ref, widget.user.id, widget.user.isBanned),
        ),
      ],
    );
  }
}
