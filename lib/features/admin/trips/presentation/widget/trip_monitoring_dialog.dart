import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TripMonitoringDialog extends StatefulWidget {
  final TripModel initialTrip;
  final bool showCloseButton;
  final VoidCallback? onClose;

  const TripMonitoringDialog({
    super.key,
    required this.initialTrip,
    this.showCloseButton = true,
    this.onClose,
  });

  @override
  State<TripMonitoringDialog> createState() => _TripMonitoringDialogState();
}

class _TripMonitoringDialogState extends State<TripMonitoringDialog> {
  late TripModel currentTrip;
  StreamSubscription<DocumentSnapshot>? _tripSubscription;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    currentTrip = widget.initialTrip;
    _startMonitoring();
  }

  void _startMonitoring() {
    _tripSubscription = FirebaseFirestore.instance
        .collection('trip_requests')
        .doc(currentTrip.id)
        .snapshots()
        .listen(
      (DocumentSnapshot doc) {
        if (_isDisposed) return;

        try {
          final data = doc.data() as Map<String, dynamic>?;
          if (data != null) {
            final updatedTrip = TripModel.fromJson(data);
            if (mounted) {
              setState(() {
                currentTrip = updatedTrip;
              });
            }

            // Auto-close dialog when trip is completed or cancelled
            if (updatedTrip.status == "ended" ||
                updatedTrip.status == "cancelled" ||
                updatedTrip.status == "DriverCancelled" ||
                updatedTrip.status == "not accepted") {
              _showCompletionMessage(updatedTrip.status);
            }
          }
        } catch (e) {
          print("Error processing trip status update: $e");
        }
      },
      onError: (error) {
        print("Error listening to trip status: $error");
      },
    );
  }

  void _showCompletionMessage(String finalStatus) {
    if (!mounted) return;

    String message;
    Color messageColor;
    bool shouldResetForm = true;

    switch (finalStatus) {
      case "ended":
        message = "Trip completed successfully!";
        messageColor = Colors.green;
        break;
      case "cancelled":
        message = "Trip was cancelled.";
        messageColor = Colors.orange;
        break;
      case "DriverCancelled":
        message = "Driver cancelled the trip.";
        messageColor = Colors.red;
        break;
      case "not accepted":
        message =
            "Driver declined the trip. You can select another driver and try again.";
        messageColor = Colors.orange;
        shouldResetForm = false; // Don't reset form for rejected trips
        break;
      default:
        message = "Trip status updated.";
        messageColor = Colors.blue;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: messageColor,
        duration: const Duration(seconds: 4),
      ),
    );

    // Auto-close dialog after a short delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pop();

        // Only call onClose (which triggers _resetForm) if we should reset the form
        if (shouldResetForm) {
          widget.onClose?.call();
        }
        // For rejected trips, we don't call widget.onClose() to preserve form data
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _tripSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        width: 600.w,
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.textBoldWeight700(
                      text: "Trip Monitoring",
                      fontSize: 20.sp,
                      color: Colors.black,
                    ),
                    SizedBox(height: 4.h),
                    CommonText.textBoldWeight400(
                      text: "Real-time trip status updates",
                      fontSize: 14.sp,
                      color: Colors.grey[600]!,
                    ),
                  ],
                ),
                if (widget.showCloseButton)
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onClose?.call();
                    },
                    icon: const Icon(Icons.close),
                  ),
              ],
            ),

            SizedBox(height: 24.h),

            // Trip Info Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.trip_origin, color: Palette.mainDarkColor),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: CommonText.textBoldWeight600(
                          text: "Trip ID: ${currentTrip.id}",
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Route Info
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 12.w,
                            height: 12.w,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 2.w,
                            height: 20.h,
                            color: Colors.grey[400],
                          ),
                          Container(
                            width: 12.w,
                            height: 12.w,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textBoldWeight500(
                              text: "From: ${currentTrip.originAddressName}",
                              fontSize: 13.sp,
                              color: Colors.black,
                            ),
                            SizedBox(height: 16.h),
                            CommonText.textBoldWeight500(
                              text:
                                  "To: ${currentTrip.destinationAddressNames.join(', ')}",
                              fontSize: 13.sp,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Driver and User Info
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textBoldWeight500(
                              text: "Driver:",
                              fontSize: 12.sp,
                              color: Colors.grey[600]!,
                            ),
                            CommonText.textBoldWeight600(
                              text:
                                  "${currentTrip.driver.firstName} ${currentTrip.driver.lastName}",
                              fontSize: 13.sp,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textBoldWeight500(
                              text: "Customer:",
                              fontSize: 12.sp,
                              color: Colors.grey[600]!,
                            ),
                            CommonText.textBoldWeight600(
                              text:
                                  "${currentTrip.user.firstName} ${currentTrip.user.lastName}",
                              fontSize: 13.sp,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Status Timeline
            CommonText.textBoldWeight600(
              text: "Trip Status",
              fontSize: 16.sp,
              color: Colors.black,
            ),
            SizedBox(height: 16.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                children: [
                  // Current Status
                  Row(
                    children: [
                      _buildStatusIndicator(currentTrip.status),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textBoldWeight600(
                              text: _getStatusDisplayText(currentTrip.status),
                              fontSize: 16.sp,
                              color: _getStatusColor(currentTrip.status),
                            ),
                            CommonText.textBoldWeight400(
                              text: _getStatusDescription(currentTrip.status),
                              fontSize: 12.sp,
                              color: Colors.grey[600]!,
                            ),
                          ],
                        ),
                      ),
                      CommonText.textBoldWeight400(
                        text: DateFormat('HH:mm:ss').format(DateTime.now()),
                        fontSize: 12.sp,
                        color: Colors.grey[500]!,
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Progress Indicator
                  _buildProgressIndicator(currentTrip.status),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Trip Details
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    "Fare",
                    "${currentTrip.fare.toStringAsFixed(2)} MRU",
                    Icons.payments_outlined,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildInfoCard(
                    "Payment",
                    currentTrip.paymentMethod.toUpperCase(),
                    Icons.credit_card_outlined,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildInfoCard(
                    "Distance",
                    "${(currentTrip.distance / 1000).toStringAsFixed(1)} km",
                    Icons.straighten_outlined,
                  ),
                ),
              ],
            ),

            if (widget.showCloseButton) ...[
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButtons.simpleButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      // Only call onClose (which triggers _resetForm) for completed/cancelled trips
                      if (currentTrip.status.toLowerCase() != "not accepted") {
                        widget.onClose?.call();
                      }
                      // For rejected trips, we don't call widget.onClose() to preserve form data
                    },
                    text: "Close",
                    width: 100.w,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    final color = _getStatusColor(status);
    final isActive = _isStatusActive(status);

    return Container(
      width: 16.w,
      height: 16.w,
      decoration: BoxDecoration(
        color: isActive ? color : Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: isActive
          ? Icon(
              Icons.circle,
              size: 8.sp,
              color: Colors.white,
            )
          : null,
    );
  }

  Widget _buildProgressIndicator(String status) {
    final progress = _getStatusProgress(status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText.textBoldWeight500(
              text: "Progress",
              fontSize: 12.sp,
              color: Colors.grey[600]!,
            ),
            CommonText.textBoldWeight500(
              text: "${(progress * 100).toInt()}%",
              fontSize: 12.sp,
              color: _getStatusColor(status),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(status)),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Icon(icon, size: 18.sp, color: Palette.mainDarkColor),
          SizedBox(height: 4.h),
          CommonText.textBoldWeight400(
            text: title,
            fontSize: 10.sp,
            color: Colors.grey[600]!,
          ),
          CommonText.textBoldWeight600(
            text: value,
            fontSize: 12.sp,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  String _getStatusDisplayText(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return "Waiting for Driver";
      case "accepted":
        return "Driver Accepted";
      case "not accepted":
        return "Trip Declined";
      case "driverarrived":
        return "Driver Arrived";
      case "ontrip":
        return "Trip in Progress";
      case "startstopover":
        return "Stopover Started";
      case "pausestopover":
        return "Stopover Paused";
      case "resumestopover":
        return "Stopover Resumed";
      case "awaiting_customer_confirmation":
        return "Awaiting Payment";
      case "ended":
        return "Trip Completed";
      case "cancelled":
        return "Trip Cancelled";
      case "drivercancelled":
        return "Driver Cancelled";
      default:
        return status.toUpperCase();
    }
  }

  String _getStatusDescription(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return "Looking for an available driver...";
      case "accepted":
        return "Driver is on the way to pickup location";
      case "not accepted":
        return "No driver accepted the trip request";
      case "driverarrived":
        return "Driver has arrived at pickup location";
      case "ontrip":
        return "Trip is currently in progress";
      case "startstopover":
        return "Vehicle stopped for a break";
      case "pausestopover":
        return "Stopover break is paused";
      case "resumestopover":
        return "Continuing the trip after stopover";
      case "awaiting_customer_confirmation":
        return "Waiting for customer to confirm and pay";
      case "ended":
        return "Trip has been completed successfully";
      case "cancelled":
        return "Trip was cancelled by customer";
      case "drivercancelled":
        return "Trip was cancelled by the driver";
      default:
        return "Status updated";
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange;
      case "accepted":
      case "driverarrived":
        return Colors.blue;
      case "ontrip":
      case "startstopover":
      case "resumestopover":
        return Colors.green;
      case "pausestopover":
        return Colors.amber;
      case "awaiting_customer_confirmation":
        return Colors.purple;
      case "ended":
        return Colors.green;
      case "not accepted":
      case "cancelled":
      case "drivercancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  bool _isStatusActive(String status) {
    final inactiveStatuses = ["not accepted", "cancelled", "drivercancelled"];
    return !inactiveStatuses.contains(status.toLowerCase());
  }

  double _getStatusProgress(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return 0.1;
      case "accepted":
        return 0.25;
      case "driverarrived":
        return 0.4;
      case "ontrip":
        return 0.7;
      case "startstopover":
      case "pausestopover":
      case "resumestopover":
        return 0.8;
      case "awaiting_customer_confirmation":
        return 0.9;
      case "ended":
        return 1.0;
      case "not accepted":
      case "cancelled":
      case "drivercancelled":
        return 0.0;
      default:
        return 0.5;
    }
  }
}
