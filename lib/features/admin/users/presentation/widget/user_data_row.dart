import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/router/router.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:fasti_dashboard/features/admin/users/presentation/widget/user_action_buttons.dart';
import 'package:fasti_dashboard/features/admin/users/presentation/widget/user_status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

DataRow buildUserDataRow(BuildContext context, UserModel user, WidgetRef ref) {
  return DataRow(
    onSelectChanged: (_) => UserPageRoute(userId: user.id).go(context),
    cells: [
      DataCell(CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey[200],
        backgroundImage:
            user.photoUrl.isNotEmpty ? NetworkImage(user.photoUrl) : null,
        child: user.photoUrl.isEmpty
            ? Icon(Icons.person, size: 24, color: Colors.grey[600])
            : null,
      )),
      DataCell(CommonText.textBoldWeight600(
          text: "${user.firstName} ${user.lastName}")),
      DataCell(CommonText.textBoldWeight600(text: user.phone)),
      DataCell(CommonText.textBoldWeight500(
          text: user.email?.isNotEmpty == true ? user.email! : '-')),
      DataCell(
          buildUserStatusBadge(!user.isBanned, user.isBanned ? 'Yes' : 'No')),
      DataCell(CommonText.textBoldWeight600(text: '${user.walletBalance}')),
      DataCell(CommonText.textBoldWeight600(text: user.points.toString())),
      DataCell(UserActionButtons(user: user, ref: ref)),
    ],
  );
}
