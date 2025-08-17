import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/router/router.dart';
import 'package:fasti_dashboard/features/admin/cars/data/model/car_model.dart';
import 'package:fasti_dashboard/features/admin/cars/presentation/widget/car_action_buttons.dart';
import 'package:fasti_dashboard/features/admin/cars/presentation/widget/car_status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

DataRow buildCarDataRow(BuildContext context, CarModel car, WidgetRef ref) {
  return DataRow(
    onSelectChanged: (_) => CarPageRoute(carId: car.id).go(context),
    cells: [
      DataCell(
        Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200],
          ),
          child: car.imageUrl.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    car.imageUrl.first,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.directions_car,
                      color: Colors.grey[600],
                    ),
                  ),
                )
              : Icon(
                  Icons.directions_car,
                  color: Colors.grey[600],
                ),
        ),
      ),
      DataCell(CommonText.textBoldWeight600(text: "${car.brand} ${car.model}")),
      DataCell(CommonText.textBoldWeight600(text: car.type)),
      DataCell(CommonText.textBoldWeight500(text: "${car.seats} seats")),
      DataCell(CommonText.textBoldWeight600(
          text: "${car.pricePerDay.toStringAsFixed(2)} MRU/day")),
      DataCell(buildCarStatusBadge(car.isAvailable)),
      DataCell(CommonText.textBoldWeight500(
          text: "${car.rentalPeriods.length} active rentals")),
      DataCell(CarActionButtons(car: car, ref: ref)),
    ],
  );
}
