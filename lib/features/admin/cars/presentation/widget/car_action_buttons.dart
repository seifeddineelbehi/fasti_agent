import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/cars/data/model/car_model.dart';
import 'package:fasti_dashboard/features/admin/cars/presentation/widget/car_availability_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarActionButtons extends StatefulWidget {
  final CarModel car;
  final WidgetRef ref;
  const CarActionButtons({super.key, required this.car, required this.ref});

  @override
  State<CarActionButtons> createState() => _CarActionButtonsState();
}

class _CarActionButtonsState extends State<CarActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButtons.circularButtonWithIconAndTooltip(
          icon: widget.car.isAvailable ? Icons.block : Icons.check_circle,
          tooltip:
              widget.car.isAvailable ? 'Mark Unavailable' : 'Mark Available',
          color:
              widget.car.isAvailable ? Palette.redColor : Palette.mainDarkColor,
          onTap: () => showCarAvailabilityDialog(
              context, widget.ref, widget.car.id, widget.car.isAvailable),
        ),
        SizedBox(width: 4.w),
        // CustomButtons.circularButtonWithIconAndTooltip(
        //   icon: Icons.edit,
        //   tooltip: 'Edit Car',
        //   color: Palette.blueColor,
        //   onTap: () {
        //     // TODO: Navigate to edit car page
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(
        //         content: Text('Edit car functionality coming soon!'),
        //         backgroundColor: Colors.blue,
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}
