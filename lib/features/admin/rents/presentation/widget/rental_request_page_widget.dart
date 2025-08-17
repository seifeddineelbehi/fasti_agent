import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/rents/data/model/rental_request_model.dart';
import 'package:fasti_dashboard/features/admin/rents/presentation/widget/rental_request_status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

Widget buildRentalRequestHeader(RentalRequestModel request) {
  return Container(
    padding: EdgeInsets.all(24.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Car Image
            Container(
              width: 120.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: request.car.imageUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(request.car.imageUrl.first),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: request.car.imageUrl.isEmpty ? Colors.grey[200] : null,
              ),
              child: request.car.imageUrl.isEmpty
                  ? Icon(Icons.directions_car,
                      size: 40.sp, color: Colors.grey[400])
                  : null,
            ),
            SizedBox(width: 20.w),

            // Request Basic Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText.textBoldWeight700(
                    text:
                        'Request #${request.id.substring(0, 8).toUpperCase()}',
                    fontSize: 24.sp,
                    color: Palette.blackColor,
                  ),
                  SizedBox(height: 8.h),
                  CommonText.textBoldWeight600(
                    text: '${request.car.brand} ${request.car.model}',
                    fontSize: 18.sp,
                    color: Palette.darkGreyColor,
                  ),
                  SizedBox(height: 4.h),
                  CommonText.textBoldWeight500(
                    text: request.car.type,
                    fontSize: 14.sp,
                    color: Palette.darkGreyColor,
                  ),
                  SizedBox(height: 12.h),
                  buildRentalRequestStatusBadge(request.status),
                ],
              ),
            ),

            // Cost and Duration
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CommonText.textBoldWeight700(
                  text: '${request.totalCost.toStringAsFixed(2)} MRU',
                  fontSize: 24.sp,
                  color: Colors.green[700],
                ),
                SizedBox(height: 4.h),
                CommonText.textBoldWeight500(
                  text:
                      '${request.numberOfDays} day${request.numberOfDays > 1 ? 's' : ''}',
                  fontSize: 14.sp,
                  color: Palette.darkGreyColor,
                ),
                SizedBox(height: 8.h),
                if (request.withDriver)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person, size: 14.sp, color: Colors.blue),
                        SizedBox(width: 4.w),
                        CommonText.textBoldWeight600(
                          text: 'With Driver',
                          fontSize: 12.sp,
                          color: Colors.blue[700],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildRequestDetailsCard(RentalRequestModel request) {
  return buildRequestCard(
    title: 'Request Details',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildRequestInfoRow('Request ID', request.id),
        buildRequestInfoRow('Status', request.status.toUpperCase()),
        buildRequestInfoRow(
            'Submitted Date', _formatDateTime(request.submittedAt)),
        buildRequestInfoRow(
            'Start Date', _formatDate(request.reservationDateStart)),
        buildRequestInfoRow(
            'End Date', _formatDate(request.reservationDateEnd)),
        buildRequestInfoRow('Duration',
            '${request.numberOfDays} day${request.numberOfDays > 1 ? 's' : ''}'),
        buildRequestInfoRow('With Driver', request.withDriver ? 'Yes' : 'No'),
        buildRequestInfoRow(
            'Total Cost', '${request.totalCost.toStringAsFixed(2)} MRU'),
        buildRequestInfoRow('Cost per Day',
            '${request.car.pricePerDay.toStringAsFixed(2)} MRU'),
      ],
    ),
  );
}

Widget buildCustomerDetailsCard(RentalRequestModel request) {
  return buildRequestCard(
    title: 'Customer Information',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Customer Avatar
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[300]!, width: 2),
                image: request.user.photoUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(request.user.photoUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: request.user.photoUrl.isEmpty
                  ? Icon(Icons.person, size: 30.sp, color: Colors.grey[400])
                  : null,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText.textBoldWeight700(
                    text: '${request.user.firstName} ${request.user.lastName}',
                    fontSize: 18.sp,
                    color: Palette.blackColor,
                  ),
                  SizedBox(height: 4.h),
                  CommonText.textBoldWeight500(
                    text: request.user.phone,
                    fontSize: 14.sp,
                    color: Palette.darkGreyColor,
                  ),
                  if (request.user.email?.isNotEmpty == true) ...[
                    SizedBox(height: 2.h),
                    CommonText.textBoldWeight500(
                      text: request.user.email!,
                      fontSize: 14.sp,
                      color: Palette.darkGreyColor,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        buildRequestInfoRow('Customer ID', request.user.id),
        buildRequestInfoRow('Phone Number', request.user.phone),
        buildRequestInfoRow(
            'Email',
            request.user.email?.isNotEmpty == true
                ? request.user.email!
                : 'Not provided'),
        buildRequestInfoRow('Wallet Balance',
            '${request.user.walletBalance.toStringAsFixed(2)} MRU'),
        buildRequestInfoRow('Loyalty Points', request.user.points.toString()),
        buildRequestInfoRow(
            'Account Status', request.user.isBanned ? 'Banned' : 'Active'),
      ],
    ),
  );
}

Widget buildCarDetailsCard(RentalRequestModel request) {
  return buildRequestCard(
    title: 'Car Information',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Car Images
        if (request.car.imageUrl.isNotEmpty) ...[
          SizedBox(
            height: 120.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: request.car.imageUrl.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 160.w,
                  margin: EdgeInsets.only(right: 12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: NetworkImage(request.car.imageUrl[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
        ],
        buildRequestInfoRow('Car ID', request.car.id),
        buildRequestInfoRow('Brand', request.car.brand),
        buildRequestInfoRow('Model', request.car.model),
        buildRequestInfoRow('Type', request.car.type),
        buildRequestInfoRow('Seats', request.car.seats.toString()),
        buildRequestInfoRow('Price per Day',
            '${request.car.pricePerDay.toStringAsFixed(2)} MRU'),
        buildRequestInfoRow('Availability',
            request.car.isAvailable ? 'Available' : 'Not Available'),
      ],
    ),
  );
}

Widget buildRequestTimelineCard(RentalRequestModel request) {
  return buildRequestCard(
    title: 'Request Timeline',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTimelineItem(
          'Request Submitted',
          _formatDateTime(request.submittedAt),
          Icons.send,
          Colors.blue,
          isCompleted: true,
        ),
        if (request.status.toLowerCase() == 'accepted') ...[
          SizedBox(height: 16.h),
          _buildTimelineItem(
            'Request Accepted',
            'By Admin',
            Icons.check_circle,
            Colors.green,
            isCompleted: true,
          ),
        ] else if (request.status.toLowerCase() == 'refused') ...[
          SizedBox(height: 16.h),
          _buildTimelineItem(
            'Request Refused',
            'By Admin',
            Icons.cancel,
            Colors.red,
            isCompleted: true,
          ),
        ] else if (request.status.toLowerCase() == 'pending') ...[
          SizedBox(height: 16.h),
          _buildTimelineItem(
            'Pending Review',
            'Awaiting admin action',
            Icons.schedule,
            Colors.orange,
            isCompleted: false,
          ),
        ],
        if (request.status.toLowerCase() == 'accepted') ...[
          SizedBox(height: 16.h),
          _buildTimelineItem(
            'Rental Period Start',
            _formatDate(request.reservationDateStart),
            Icons.directions_car,
            Colors.purple,
            isCompleted: DateTime.now()
                .isAfter(DateTime.parse(request.reservationDateStart)),
          ),
          SizedBox(height: 16.h),
          _buildTimelineItem(
            'Rental Period End',
            _formatDate(request.reservationDateEnd),
            Icons.flag,
            Colors.grey,
            isCompleted: DateTime.now()
                .isAfter(DateTime.parse(request.reservationDateEnd)),
          ),
        ],
      ],
    ),
  );
}

Widget buildRequestCard({required String title, required Widget child}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText.textBoldWeight700(
          text: title,
          fontSize: 18.sp,
          color: Palette.blackColor,
        ),
        SizedBox(height: 16.h),
        child,
      ],
    ),
  );
}

Widget buildRequestInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.w,
          child: CommonText.textBoldWeight600(
            text: label,
            fontSize: 14.sp,
            color: Palette.blackColor,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: CommonText.textBoldWeight500(
            text: value.isNotEmpty ? value : '-',
            fontSize: 14.sp,
            color: Palette.darkGreyColor,
          ),
        ),
      ],
    ),
  );
}

Widget _buildTimelineItem(
  String title,
  String subtitle,
  IconData icon,
  Color color, {
  required bool isCompleted,
}) {
  return Row(
    children: [
      Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isCompleted ? color : color.withOpacity(0.2),
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          color: isCompleted ? Colors.white : color,
          size: 20.sp,
        ),
      ),
      SizedBox(width: 16.w),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.textBoldWeight600(
              text: title,
              fontSize: 14.sp,
              color: isCompleted ? Palette.blackColor : Palette.darkGreyColor,
            ),
            CommonText.textBoldWeight400(
              text: subtitle,
              fontSize: 12.sp,
              color: Palette.darkGreyColor,
            ),
          ],
        ),
      ),
    ],
  );
}

String _formatDate(String dateString) {
  try {
    final date = DateTime.parse(dateString);
    return DateFormat('EEEE, MMM dd, yyyy').format(date);
  } catch (e) {
    return dateString;
  }
}

String _formatDateTime(String dateString) {
  try {
    final date = DateTime.parse(dateString);
    return DateFormat('MMM dd, yyyy at HH:mm').format(date);
  } catch (e) {
    return dateString;
  }
}
