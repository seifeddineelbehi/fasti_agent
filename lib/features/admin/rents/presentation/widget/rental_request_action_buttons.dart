import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/rents/data/model/rental_request_model.dart';
import 'package:fasti_dashboard/features/admin/rents/presentation/widget/rental_request_action_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RentalRequestActionButtons extends StatefulWidget {
  final RentalRequestModel request;
  final String currentStatus;
  final WidgetRef ref;

  const RentalRequestActionButtons({
    super.key,
    required this.request,
    required this.currentStatus,
    required this.ref,
  });

  @override
  State<RentalRequestActionButtons> createState() =>
      _RentalRequestActionButtonsState();
}

class _RentalRequestActionButtonsState
    extends State<RentalRequestActionButtons> {
  @override
  Widget build(BuildContext context) {
    // Only show action buttons for pending requests
    if (widget.currentStatus.toLowerCase() != 'pending') {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: _getStatusColor(widget.currentStatus).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: _getStatusColor(widget.currentStatus).withOpacity(0.3),
          ),
        ),
        child: Text(
          widget.currentStatus.toUpperCase(),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: _getStatusColor(widget.currentStatus),
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomButtons.circularButtonWithIconAndTooltip(
          icon: Icons.check,
          tooltip: 'Accept Request',
          color: Palette.mainDarkColor,
          onTap: () => showRentalRequestActionDialog(
            context,
            widget.ref,
            widget.request,
            widget.currentStatus,
            'accept',
          ),
        ),
        SizedBox(width: 4.w),
        CustomButtons.circularButtonWithIconAndTooltip(
          icon: Icons.close,
          tooltip: 'Refuse Request',
          color: Palette.redColor,
          onTap: () => showRentalRequestActionDialog(
            context,
            widget.ref,
            widget.request,
            widget.currentStatus,
            'refuse',
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Colors.green;
      case 'refused':
      case 'cancelled':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
