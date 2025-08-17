import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/util/helper_functions.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/widget/trip_status_badge.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTripHeader(TripModel trip) {
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
            Icon(Icons.directions_car, size: 32.sp, color: Palette.blueColor),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText.textBoldWeight700(
                    text: 'Trip ID: ${trip.id}',
                    fontSize: 20.sp,
                    color: Palette.blackColor,
                  ),
                  SizedBox(height: 4.h),
                  CommonText.textBoldWeight500(
                    text: formatDateTimeWithTime(trip.time),
                    fontSize: 14.sp,
                    color: Palette.darkGreyColor,
                  ),
                ],
              ),
            ),
            buildTripStatusBadge(trip.status),
          ],
        ),
        SizedBox(height: 16.h),

        // Trip route information
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.my_location, color: Colors.green, size: 20.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: CommonText.textBoldWeight600(
                      text: trip.originAddressName,
                      fontSize: 14.sp,
                      color: Palette.blackColor,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                height: 2.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.red],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              ...trip.destinationAddressNames.map(
                (destination) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red, size: 20.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: CommonText.textBoldWeight600(
                          text: destination,
                          fontSize: 14.sp,
                          color: Palette.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16.h),

        // Trip stats
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.attach_money,
                title: 'Fare',
                value: '${trip.fare.toStringAsFixed(2)} MRU',
                color: Colors.green,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatCard(
                icon: Icons.straighten,
                title: 'Distance',
                value: '${(trip.distance / 1000).toStringAsFixed(1)} km',
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatCard(
                icon: Icons.access_time,
                title: 'Duration',
                value: '${trip.duration ~/ 60} min',
                color: Colors.orange,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatCard(
                icon: Icons.payment,
                title: 'Payment',
                value: trip.paymentMethod,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildStatCard({
  required IconData icon,
  required String title,
  required String value,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 20.sp),
        SizedBox(height: 4.h),
        CommonText.textBoldWeight600(
          text: value,
          fontSize: 12.sp,
          color: color,
        ),
        CommonText.textBoldWeight400(
          text: title,
          fontSize: 10.sp,
          color: Palette.darkGreyColor,
        ),
      ],
    ),
  );
}

Widget buildTripDetailsCard(TripModel trip) {
  return buildTripCard(
    title: 'Trip Details',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTripInfoRow('Trip ID', trip.id),
        buildTripInfoRow('Status', trip.status),
        buildTripInfoRow('Fare', '${trip.fare.toStringAsFixed(2)} MRU'),
        buildTripInfoRow('Payment Method', trip.paymentMethod),
        buildTripInfoRow(
            'Distance', '${(trip.distance / 1000).toStringAsFixed(1)} km'),
        buildTripInfoRow('Duration', '${trip.duration} minutes'),
        buildTripInfoRow('Stop Over', trip.isStopOver ? 'Yes' : 'No'),
        if (trip.cancellationReason.isNotEmpty)
          buildTripInfoRow('Cancellation Reason', trip.cancellationReason),
      ],
    ),
  );
}

Widget buildUserInfoCard(TripModel trip) {
  return buildTripCard(
    title: 'User Information',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: Colors.grey[200],
              backgroundImage: trip.user.photoUrl.isNotEmpty
                  ? NetworkImage(trip.user.photoUrl)
                  : null,
              child: trip.user.photoUrl.isEmpty
                  ? Icon(Icons.person, size: 20.sp, color: Colors.grey[600])
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText.textBoldWeight600(
                    text: '${trip.user.firstName} ${trip.user.lastName}',
                    fontSize: 16.sp,
                    color: Palette.blackColor,
                  ),
                  CommonText.textBoldWeight500(
                    text: trip.user.phone,
                    fontSize: 14.sp,
                    color: Palette.darkGreyColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        buildTripInfoRow('User ID', trip.user.id),
        buildTripInfoRow('Phone', trip.user.phone),
        buildTripInfoRow('Email', trip.user.email ?? 'Not provided'),
        buildTripInfoRow('Wallet Balance', '${trip.user.walletBalance} MRU'),
        buildTripInfoRow('Points', trip.user.points.toString()),
      ],
    ),
  );
}

Widget buildDriverInfoCard(TripModel trip) {
  return buildTripCard(
    title: 'Driver Information',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: Colors.grey[200],
              backgroundImage: trip.driver.photoUrl.isNotEmpty
                  ? NetworkImage(trip.driver.photoUrl)
                  : null,
              child: trip.driver.photoUrl.isEmpty
                  ? Icon(Icons.person, size: 20.sp, color: Colors.grey[600])
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText.textBoldWeight600(
                    text: '${trip.driver.firstName} ${trip.driver.lastName}',
                    fontSize: 16.sp,
                    color: Palette.blackColor,
                  ),
                  CommonText.textBoldWeight500(
                    text: trip.driver.phone,
                    fontSize: 14.sp,
                    color: Palette.darkGreyColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        buildTripInfoRow('Driver ID', trip.driver.id),
        buildTripInfoRow('Phone', trip.driver.phone),
        buildTripInfoRow('Email', trip.driver.email ?? 'Not provided'),
      ],
    ),
  );
}

Widget buildRouteInfoCard(TripModel trip) {
  return buildTripCard(
    title: 'Route Information',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Origin
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.green[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.my_location, color: Colors.green, size: 20.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.textBoldWeight600(
                      text: 'Pickup Location',
                      fontSize: 12.sp,
                      color: Colors.green[700],
                    ),
                    CommonText.textBoldWeight500(
                      text: trip.originAddressName,
                      fontSize: 14.sp,
                      color: Palette.blackColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        // Destinations
        ...trip.destinationAddressNames.asMap().entries.map((entry) {
          final index = entry.key;
          final destination = entry.value;
          return Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.red[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: Colors.red, size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText.textBoldWeight600(
                        text: 'Drop-off ${index + 1}',
                        fontSize: 12.sp,
                        color: Colors.red[700],
                      ),
                      CommonText.textBoldWeight500(
                          text: destination,
                          fontSize: 14.sp,
                          color: Palette.blackColor,
                          maxLine: 2),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    ),
  );
}

Widget buildTripCard({required String title, required Widget child}) {
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

Widget buildTripInfoRow(String label, String value) {
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
