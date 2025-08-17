import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/util/helper_functions.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/drivers/presentation/riverpod/drivers_provider.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/vehicle_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildDriverHeader(UserModel driver) {
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
    child: Row(
      children: [
        // Profile Photo
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[300]!, width: 2),
            image: driver.photoUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(driver.photoUrl),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: driver.photoUrl.isEmpty
              ? Icon(Icons.person, size: 40.sp, color: Colors.grey[400])
              : null,
        ),
        SizedBox(width: 20.w),

        // Driver Basic Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.textBoldWeight700(
                text: '${driver.firstName} ${driver.lastName}',
                fontSize: 24.sp,
                color: Palette.blackColor,
              ),
              SizedBox(height: 6.h),
              CommonText.textBoldWeight500(
                text: driver.phone,
                fontSize: 16.sp,
                color: Palette.darkGreyColor,
              ),
              if (driver.email != null) ...[
                SizedBox(height: 4.h),
                CommonText.textBoldWeight500(
                  text: driver.email ?? '-',
                  fontSize: 16.sp,
                  color: Palette.darkGreyColor,
                ),
              ],
              SizedBox(height: 8.h),
              // Fixed LayoutBuilder with proper constraints
              LayoutBuilder(
                builder: (context, constraints) {
                  // Use actual pixel values for consistent behavior
                  if (constraints.maxWidth > 1200) {
                    return Row(
                      children: [
                        buildStatusChip(
                          driver.driverInfo!.availableStatus
                              ? 'Available'
                              : 'Unavailable',
                          color: driver.driverInfo!.availableStatus
                              ? Colors.green
                              : Colors.orange,
                        ),
                        SizedBox(width: 8.w),
                        buildStatusChip(driver.driverInfo!.approvedStatus),
                      ],
                    );
                  } else if (constraints.maxWidth > 400) {
                    return Row(
                      children: [
                        Flexible(
                          child: buildStatusChip(
                            driver.driverInfo!.availableStatus
                                ? 'Available'
                                : 'Unavailable',
                            color: driver.driverInfo!.availableStatus
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Flexible(
                          child: buildStatusChip(
                              driver.driverInfo!.approvedStatus),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildStatusChip(
                          driver.driverInfo!.availableStatus
                              ? 'Available'
                              : 'Unavailable',
                          color: driver.driverInfo!.availableStatus
                              ? Colors.green
                              : Colors.orange,
                        ),
                        SizedBox(height: 8.h),
                        buildStatusChip(driver.driverInfo!.approvedStatus),
                      ],
                    );
                  }
                },
              ),
              SizedBox(height: 8.h),
              // Fixed wallet balance row
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CommonText.textBoldWeight600(
                    text: "Wallet Balance: ",
                    fontSize: 16.sp,
                  ),
                  CommonText.textBoldWeight500(
                    text: driver.walletBalance.toString(),
                    fontSize: 16.sp,
                    color: Palette.darkGreyColor,
                  ),
                ],
              ),
            ],
          ),
        ),

        // Rating Display - Fixed with proper null checking
        if (driver.driverInfo?.totalRatings != null &&
            driver.driverInfo!.totalRatings > 0)
          Column(
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 24.sp),
                  SizedBox(width: 4.w),
                  Text(
                    (driver.driverInfo!.ratingSum /
                            driver.driverInfo!.totalRatings)
                        .toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                '${driver.driverInfo!.totalRatings} ratings',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
      ],
    ),
  );
}

Widget buildStatusChip(String status, {Color? color}) {
  Color chipColor = color ?? getStatusColor(status);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: chipColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: chipColor.withOpacity(0.3)),
    ),
    child: CommonText.textBoldWeight600(
      text: status.toUpperCase(),
      fontSize: 12.sp,
      color: chipColor,
    ),
  );
}

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'online':
    case 'approved':
      return Colors.green;
    case 'offline':
      return Colors.grey;
    case 'pending':
      return Colors.orange;
    case 'rejected':
      return Colors.red;
    default:
      return Colors.blue;
  }
}

Widget buildDriverInfoCard(UserModel driver, BuildContext context) {
  final driverInfo = driver.driverInfo!;
  return buildCard(
    title: 'Driver Information',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInfoRow('Date of Birth', driverInfo.dateOfBirth),
        buildInfoRow('License Number', driverInfo.driverLicenseNumber),
        buildInfoRow('License Expiry', driverInfo.driverLicenseExpirationDate),
        buildInfoRow(
            'Wallet Balance', '${driver.walletBalance.toStringAsFixed(2)} MRU'),
        buildInfoRow('Points', driver.points.toString()),
        SizedBox(height: 16.h),
        buildDocumentSection(driver, context),
      ],
    ),
  );
}

Widget buildDocumentSection(UserModel driver, BuildContext context) {
  final driverInfo = driver.driverInfo!;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonText.textBoldWeight600(
        text: 'Documents',
        fontSize: 16.sp,
        color: Palette.blackColor,
      ),
      SizedBox(height: 12.h),
      Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: [
          buildImageThumbnail(
            label: 'ID License',
            imageUrl: driverInfo.idLicensePicture,
            context: context,
          ),
          buildImageThumbnail(
            label: 'License Front',
            imageUrl: driverInfo.driverLicenseFrontPicture,
            context: context,
          ),
          buildImageThumbnail(
            label: 'License Back',
            imageUrl: driverInfo.driverLicenseBackPicture,
            context: context,
          ),
        ],
      ),
    ],
  );
}

void showImageDialog(String imageUrl, BuildContext context) {
  showDialog(
    context: context,
    builder: (cont) => Dialog(
      backgroundColor: Colors.black.withOpacity(0.9),
      insetPadding: EdgeInsets.all(10.w),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          InteractiveViewer(
            panEnabled: true,
            scaleEnabled: true,
            boundaryMargin: const EdgeInsets.all(100),
            minScale: 0.5,
            maxScale: 4.0,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white, size: 24.sp),
            onPressed: () => Navigator.of(cont).pop(),
          ),
        ],
      ),
    ),
  );
}

Widget buildImageThumbnail(
    {required String label,
    required String imageUrl,
    required BuildContext context}) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          if (imageUrl.isNotEmpty) {
            showImageDialog(imageUrl, context);
          }
        },
        child: Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey[300]!),
            image: imageUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: imageUrl.isEmpty
              ? Icon(Icons.image, color: Colors.grey[400], size: 24.sp)
              : null,
        ),
      ),
      SizedBox(height: 4.h),
      CommonText.textBoldWeight400(
        text: label,
        fontSize: 10.sp,
        color: Palette.darkGreyColor,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget buildVehicleInfoCard(UserModel driver, BuildContext context) {
  final vehicleInfo = driver.driverInfo!.vehicleInfo;
  return buildCard(
    title: 'Vehicle Information',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInfoRow('Type', vehicleInfo.type),
        buildInfoRow('Color', vehicleInfo.color),
        buildInfoRow('Number Plate', vehicleInfo.numberPlate),
        if (vehicleInfo.travelClass != null)
          buildInfoRow('Travel Class', vehicleInfo.travelClass!),
        SizedBox(height: 16.h),
        buildVehicleDocuments(vehicleInfo, context),
      ],
    ),
  );
}

Widget buildVehicleDocuments(
    VehicleInfoModel vehicleInfo, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonText.textBoldWeight600(
        text: 'Vehicle Documents',
        fontSize: 16.sp,
        color: Palette.blackColor,
      ),
      SizedBox(height: 12.h),
      Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: [
          buildImageThumbnail(
            label: 'Vehicle Photos',
            imageUrl: vehicleInfo.vehiclePhotos,
            context: context,
          ),
          buildImageThumbnail(
            label: 'Registration Front',
            imageUrl: vehicleInfo.registrationCertificateFront,
            context: context,
          ),
          buildImageThumbnail(
            label: 'Registration Back',
            imageUrl: vehicleInfo.registrationCertificateBack,
            context: context,
          ),
          buildImageThumbnail(
            label: 'Insurance',
            imageUrl: vehicleInfo.insurancePhoto!,
            context: context,
          ),
        ],
      ),
    ],
  );
}

Widget buildEarningsCard(UserModel driver) {
  final driverInfo = driver.driverInfo!;
  return buildCard(
    title: 'Earnings & Payouts',
    child: Column(
      children: [
        buildInfoRow('Total Payouts', '${driverInfo.dailyEarnings.length}'),
        SizedBox(height: 16.h),
        if (driverInfo.dailyEarnings.isNotEmpty) ...[
          CommonText.textBoldWeight600(
            text: 'Recent Payouts',
            fontSize: 16.sp,
            color: Palette.blackColor,
          ),
          SizedBox(height: 8.h),
          ...driverInfo.dailyEarnings.reversed.take(10).map(
                (payout) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText.textBoldWeight500(
                            text: formatDateTimeWithTime(payout.date),
                            fontSize: 12.sp,
                            color: Palette.blackColor,
                          ),
                          CommonText.textBoldWeight400(
                            text: payout.method,
                            fontSize: 10.sp,
                            color: Palette.darkGreyColor,
                          ),
                        ],
                      ),
                      CommonText.textBoldWeight600(
                        text: '${payout.amount.toStringAsFixed(2)} MRU',
                        fontSize: 14.sp,
                        color: Palette.blackColor,
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ],
    ),
  );
}

Widget buildRatingsCard(UserModel driver) {
  final driverInfo = driver.driverInfo!;
  return buildCard(
    title: 'Ratings & Reviews',
    child: Column(
      children: [
        if (driverInfo.totalRatings > 0) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  CommonText.textBoldWeight700(
                    text: (driverInfo.ratingSum / driverInfo.totalRatings)
                        .toStringAsFixed(1),
                    fontSize: 28.sp,
                    color: Colors.amber[700],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      final avgRating =
                          driverInfo.ratingSum / driverInfo.totalRatings;
                      return Icon(
                        index < avgRating.floor()
                            ? Icons.star
                            : index < avgRating
                                ? Icons.star_half
                                : Icons.star_border,
                        color: Colors.amber,
                        size: 16.sp,
                      );
                    }),
                  ),
                ],
              ),
              Column(
                children: [
                  CommonText.textBoldWeight700(
                    text: driverInfo.totalRatings.toString(),
                    fontSize: 20.sp,
                    color: Colors.amber[700],
                  ),
                  CommonText.textBoldWeight400(
                    text: 'Total Reviews',
                    fontSize: 12.sp,
                    color: Palette.darkGreyColor,
                  ),
                ],
              ),
            ],
          ),
          if (driverInfo.ratings.isNotEmpty) ...[
            SizedBox(height: 16.h),
            CommonText.textBoldWeight600(
              text: 'Recent Reviews',
              fontSize: 16.sp,
              color: Palette.blackColor,
            ),
            SizedBox(height: 8.h),
            ...driverInfo.ratings.take(10).map(
                  (rating) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: CommonText.textBoldWeight500(
                            text:
                                '${rating.user.firstName} ${rating.user.lastName}',
                            fontSize: 12.sp,
                            color: Palette.darkGreyColor,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(5, (index) {
                            return Icon(
                              index < rating.ratingGiven
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 12.sp,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ] else ...[
          Padding(
            padding: EdgeInsets.all(32.w),
            child: CommonText.textBoldWeight500(
              text: 'No ratings yet',
              fontSize: 16.sp,
              color: Palette.darkGreyColor,
            ),
          ),
        ],
      ],
    ),
  );
}

// Widget buildTripsCard(UserModel driver) {
//   return buildCard(
//     title: 'Trip History (${driver.trips.length} trips)',
//     child: driver.trips.isEmpty
//         ? Center(
//             child: Padding(
//               padding: EdgeInsets.all(32.w),
//               child: CommonText.textBoldWeight500(
//                 text: 'No trips found',
//                 fontSize: 16.sp,
//                 color: Palette.darkGreyColor,
//               ),
//             ),
//           )
//         : Column(
//             children: driver.trips
//                 .take(5)
//                 .map((trip) => buildTripItem(trip))
//                 .toList(),
//           ),
//   );
// }

// Widget buildTripItem(TripModel trip) {
//   return Container(
//     margin: EdgeInsets.only(bottom: 12.h),
//     padding: EdgeInsets.all(16.w),
//     decoration: BoxDecoration(
//       color: Colors.grey[50],
//       borderRadius: BorderRadius.circular(12.r),
//       border: Border.all(color: Colors.grey[200]!),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             CommonText.textBoldWeight600(
//               text: trip.originAddressName,
//               fontSize: 14.sp,
//               color: Palette.darkGreyColor,
//               maxLine: 4,
//             ),
//             buildStatusChip(trip.status),
//           ],
//         ),
//         SizedBox(height: 4.h),
//         CommonText.textBoldWeight400(
//           text: 'To: ${trip.destinationAddressNames.join(', ')}',
//           fontSize: 12.sp,
//           color: Palette.darkGreyColor,
//           maxLine: 4,
//         ),
//         SizedBox(height: 8.h),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.access_time, size: 14.sp, color: Colors.grey[600]),
//                 SizedBox(width: 4.w),
//                 CommonText.textBoldWeight400(
//                   text: trip.time,
//                   fontSize: 12.sp,
//                   color: Palette.darkGreyColor,
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Icon(Icons.route, size: 14.sp, color: Colors.grey[600]),
//                 SizedBox(width: 4.w),
//                 CommonText.textBoldWeight400(
//                   text: '${(trip.distance / 1000).toStringAsFixed(1)} km',
//                   fontSize: 12.sp,
//                   color: Palette.darkGreyColor,
//                 ),
//               ],
//             ),
//             CommonText.textBoldWeight600(
//               text: '\$${trip.fare.toStringAsFixed(2)}',
//               fontSize: 14.sp,
//               color: Colors.green[700],
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

Widget buildCard({required String title, required Widget child}) {
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

Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140.w,
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

Widget buildWalletPaymentsCard(
    UserModel driver, BuildContext context, WidgetRef ref,
    {Function(String)? onPaySingle, Function()? onPayAll}) {
  final driverInfo = driver.driverInfo!;
  final admin = ref.read(driversNotifierProvider).adminModel!;

  // Filter unpaid wallet trip payments
  final unpaidPayments = driverInfo.walletTripPayments
      .where((payment) => !payment.isPaidByAdmin)
      .toList();

  // Calculate totals
  final totalUnpaidAmount =
      unpaidPayments.fold<double>(0.0, (sum, payment) => sum + payment.amount);

  // Calculate admin percentage (company + user points percentage)
  final adminPercentage = admin.companyPercentage + admin.userPointsPercentage;
  final adminTake = totalUnpaidAmount * (adminPercentage / 100);
  final driverPayout = totalUnpaidAmount - adminTake;

  return buildCard(
    title: 'Wallet Trip Payments',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (unpaidPayments.isEmpty) ...[
          Center(
            child: Padding(
              padding: EdgeInsets.all(32.w),
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 48.sp,
                    color: Colors.green,
                  ),
                  SizedBox(height: 12.h),
                  CommonText.textBoldWeight500(
                    text: 'All payments are up to date',
                    fontSize: 16.sp,
                    color: Palette.darkGreyColor,
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          // Summary Section
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.textBoldWeight600(
                      text: 'Total Unpaid Amount:',
                      fontSize: 16.sp,
                      color: Palette.blackColor,
                    ),
                    CommonText.textBoldWeight700(
                      text: '${totalUnpaidAmount.toStringAsFixed(2)} MRU',
                      fontSize: 18.sp,
                      color: Colors.red[700],
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.textBoldWeight500(
                      text: 'Admin Take (${adminPercentage}%):',
                      fontSize: 14.sp,
                      color: Palette.darkGreyColor,
                    ),
                    CommonText.textBoldWeight600(
                      text: '${adminTake.toStringAsFixed(2)} MRU',
                      fontSize: 14.sp,
                      color: Colors.green[700],
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.textBoldWeight500(
                      text: 'Driver Payout:',
                      fontSize: 14.sp,
                      color: Palette.darkGreyColor,
                    ),
                    CommonText.textBoldWeight600(
                      text: '${driverPayout.toStringAsFixed(2)} MRU',
                      fontSize: 14.sp,
                      color: Colors.blue[700],
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Pay All Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onPayAll,
              icon: Icon(Icons.payment, size: 18.sp),
              label: Text(
                'Pay All Outstanding (${unpaidPayments.length} payments)',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // Individual Payments List
          CommonText.textBoldWeight600(
            text: 'Outstanding Payments (${unpaidPayments.length})',
            fontSize: 16.sp,
            color: Palette.blackColor,
          ),
          SizedBox(height: 12.h),

          // Payment Items
          ...unpaidPayments.map((payment) {
            final adminTakeForPayment =
                payment.amount * (adminPercentage / 100);
            final driverPayoutForPayment = payment.amount - adminTakeForPayment;

            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.red[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textBoldWeight600(
                              text: payment.userFullName,
                              fontSize: 14.sp,
                              color: Palette.blackColor,
                            ),
                            SizedBox(height: 2.h),
                            CommonText.textBoldWeight400(
                              text: 'Trip ID: ${payment.tripId}',
                              fontSize: 12.sp,
                              color: Palette.darkGreyColor,
                            ),
                            CommonText.textBoldWeight400(
                              text: 'Date: ${payment.date}',
                              fontSize: 12.sp,
                              color: Palette.darkGreyColor,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CommonText.textBoldWeight700(
                            text: '${payment.amount.toStringAsFixed(2)} MRU',
                            fontSize: 16.sp,
                            color: Colors.red[700],
                          ),
                          CommonText.textBoldWeight500(
                            text:
                                'Pay: ${driverPayoutForPayment.toStringAsFixed(2)}MRU',
                            fontSize: 12.sp,
                            color: Colors.blue[700],
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Payment breakdown
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textBoldWeight500(
                              text: 'Admin Take',
                              fontSize: 10.sp,
                              color: Palette.darkGreyColor,
                            ),
                            CommonText.textBoldWeight600(
                              text:
                                  '${adminTakeForPayment.toStringAsFixed(2)} MRU',
                              fontSize: 12.sp,
                              color: Colors.green[600],
                            ),
                          ],
                        ),
                        Container(
                          height: 20.h,
                          width: 1,
                          color: Colors.grey[300],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textBoldWeight500(
                              text: 'Driver Gets',
                              fontSize: 10.sp,
                              color: Palette.darkGreyColor,
                            ),
                            CommonText.textBoldWeight600(
                              text:
                                  '${driverPayoutForPayment.toStringAsFixed(2)} MRU',
                              fontSize: 12.sp,
                              color: Colors.blue[600],
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () => onPaySingle?.call(payment.tripId),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            minimumSize: Size(0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          child: Text(
                            'Pay',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ],
    ),
  );
}
