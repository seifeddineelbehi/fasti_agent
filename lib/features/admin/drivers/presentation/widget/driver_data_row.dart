import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/router/router.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'driver_action_buttons.dart';
import 'driver_status_badge.dart';

DataRow buildDriverDataRow(
    BuildContext context, UserModel user, WidgetRef ref) {
  return DataRow(
    onSelectChanged: (_) => DriverPageRoute(driverId: user.id).go(context),
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
      DataCell(buildStatusBadge(user.driverInfo?.approvedStatus == 'approved',
          user.driverInfo?.approvedStatus ?? 'Unknown')),
      DataCell(buildStatusBadge(
          user.driverInfo?.availableStatus ?? false,
          user.driverInfo?.availableStatus == true
              ? 'Available'
              : 'Not Available')),
      DataCell(buildStatusBadge(!user.isBanned, user.isBanned ? 'Yes' : 'No')),
      DataCell(
          CommonText.textBoldWeight600(text: user.walletBalance.toString())),
      DataCell(DriverActionButtons(user: user, ref: ref)),
    ],
  );
}
