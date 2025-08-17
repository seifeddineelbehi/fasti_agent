import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/router/router.dart';
import 'package:fasti_dashboard/core/util/helper_functions.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/widget/build_trip_payment_method_badge.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/widget/trip_action_buttons.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/widget/trip_status_badge.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

DataRow buildTripDataRow(BuildContext context, TripModel trip, WidgetRef ref) {
  return DataRow(
    onSelectChanged: (_) => TripPageRoute(tripId: trip.id).go(context),
    cells: [
      DataCell(CommonText.textBoldWeight600(
          text: "${trip.user.firstName} ${trip.user.lastName}")),
      DataCell(CommonText.textBoldWeight600(
          text: "${trip.driver.firstName} ${trip.driver.lastName}")),
      DataCell(CommonText.textBoldWeight500(text: trip.originAddressName)),
      DataCell(CommonText.textBoldWeight500(
          text: trip.destinationAddressNames.isNotEmpty
              ? trip.destinationAddressNames.first
              : 'N/A')),
      DataCell(buildTripStatusBadge(trip.status)),
      DataCell(CommonText.textBoldWeight600(text: '${trip.fare} MRU')),
      DataCell(buildTripPaymentMethodeBadge(trip.paymentMethod)),
      DataCell(CommonText.textBoldWeight500(
          text: '${(trip.distance / 1000).toStringAsFixed(1)} km')),
      DataCell(CommonText.textBoldWeight500(text: formatDateOnly(trip.time))),
      DataCell(TripActionButtons(trip: trip, ref: ref)),
    ],
  );
}
