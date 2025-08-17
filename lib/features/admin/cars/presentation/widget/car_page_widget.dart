import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/util/helper_functions.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/cars/data/model/car_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildCarHeader(CarModel car) {
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
        // Car Image with additional images indicator
        Stack(
          children: [
            Container(
              width: 120.w,
              height: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey[300]!, width: 2),
                image: car.imageUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(car.imageUrl.first),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: car.imageUrl.isEmpty
                  ? Icon(Icons.directions_car,
                      size: 40.sp, color: Colors.grey[400])
                  : null,
            ),
            if (car.imageUrl.length > 1)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: CommonText.textBoldWeight600(
                    text: '+${car.imageUrl.length - 1}',
                    fontSize: 10.sp,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(width: 20.w),

        // Car Basic Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CommonText.textBoldWeight700(
                      text: '${car.brand} ${car.model}',
                      fontSize: 24.sp,
                      color: Palette.blackColor,
                    ),
                  ),
                  // Availability status indicator
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: car.isAvailable
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: car.isAvailable ? Colors.green : Colors.red,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          car.isAvailable ? Icons.check_circle : Icons.block,
                          size: 12.sp,
                          color: car.isAvailable ? Colors.green : Colors.red,
                        ),
                        SizedBox(width: 4.w),
                        CommonText.textBoldWeight600(
                          text: car.isAvailable ? 'AVAILABLE' : 'UNAVAILABLE',
                          fontSize: 10.sp,
                          color: car.isAvailable ? Colors.green : Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              CommonText.textBoldWeight500(
                text: car.type.toUpperCase(),
                fontSize: 16.sp,
                color: Palette.darkGreyColor,
              ),
              SizedBox(height: 8.h),

              // Car specs in a more detailed layout
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  buildCarSpecChip(Icons.airline_seat_recline_normal,
                      '${car.seats} Seats', Colors.blue),
                  buildCarSpecChip(
                      Icons.directions_car, car.type, Colors.purple),
                  if (car.rentalPeriods.isNotEmpty)
                    buildCarSpecChip(Icons.schedule,
                        '${car.rentalPeriods.length} Rentals', Colors.orange),
                ],
              ),
              SizedBox(height: 12.h),

              // Price and earnings info
              Row(
                children: [
                  Icon(Icons.attach_money, size: 18.sp, color: Colors.green),
                  SizedBox(width: 4.w),
                  CommonText.textBoldWeight700(
                    text: "${car.pricePerDay.toStringAsFixed(2)} MRU",
                    fontSize: 18.sp,
                    color: Colors.green[700],
                  ),
                  CommonText.textBoldWeight500(
                    text: " per day",
                    fontSize: 14.sp,
                    color: Palette.darkGreyColor,
                  ),
                  SizedBox(width: 16.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: CommonText.textBoldWeight600(
                      text:
                          "Est. Monthly: ${(car.pricePerDay * 30).toStringAsFixed(0)} MRU",
                      fontSize: 12.sp,
                      color: Colors.blue[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCarSpecChip(IconData icon, String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12.sp, color: color),
        SizedBox(width: 4.w),
        CommonText.textBoldWeight600(
          text: text,
          fontSize: 11.sp,
          color: color,
        ),
      ],
    ),
  );
}

Widget buildCarInfoCard(CarModel car) {
  return buildCarCard(
    title: 'Vehicle Information',
    icon: Icons.info_outline,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCarInfoSection('Basic Details', [
          buildCarInfoRow('Vehicle ID', car.id),
          buildCarInfoRow('Brand', car.brand),
          buildCarInfoRow('Model', car.model),
          buildCarInfoRow('Vehicle Type', car.type),
        ]),
        SizedBox(height: 16.h),
        buildCarInfoSection('Specifications', [
          buildCarInfoRow('Seating Capacity', '${car.seats} passengers'),
          buildCarInfoRow(
              'Availability Status',
              car.isAvailable
                  ? 'Available for rental'
                  : 'Currently unavailable'),
          buildCarInfoRow('Total Images', '${car.imageUrl.length} photos'),
        ]),
        SizedBox(height: 16.h),
        buildCarInfoSection('Pricing', [
          buildCarInfoRow(
              'Daily Rate', '${car.pricePerDay.toStringAsFixed(2)} MRU'),
          buildCarInfoRow('Weekly Rate',
              '${(car.pricePerDay * 7 * 0.9).toStringAsFixed(2)} MRU (10% discount)'),
          buildCarInfoRow('Monthly Rate',
              '${(car.pricePerDay * 30 * 0.8).toStringAsFixed(2)} MRU (20% discount)'),
        ]),
      ],
    ),
  );
}

Widget buildCarInfoSection(String title, List<Widget> children) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonText.textBoldWeight600(
        text: title,
        fontSize: 14.sp,
        color: Palette.blackColor,
      ),
      SizedBox(height: 8.h),
      ...children,
    ],
  );
}

Widget buildCarRentalsCard(CarModel car) {
  return buildCarCard(
    title: 'Current Rentals & Bookings',
    icon: Icons.event_note,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rental statistics
        if (car.rentalPeriods.isNotEmpty) ...[
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[50]!, Colors.blue[100]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.trending_up, color: Colors.blue[700], size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText.textBoldWeight600(
                        text: 'Rental Performance',
                        fontSize: 14.sp,
                        color: Colors.blue[700],
                      ),
                      CommonText.textBoldWeight500(
                        text:
                            '${car.rentalPeriods.length} active bookings • High demand vehicle',
                        fontSize: 12.sp,
                        color: Colors.blue[600],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
        ],

        if (car.rentalPeriods.isEmpty) ...[
          Center(
            child: Padding(
              padding: EdgeInsets.all(32.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.event_available,
                      size: 32.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CommonText.textBoldWeight600(
                    text: 'No Active Rentals',
                    fontSize: 16.sp,
                    color: Palette.blackColor,
                  ),
                  SizedBox(height: 4.h),
                  CommonText.textBoldWeight500(
                    text:
                        'This vehicle is currently available for new bookings',
                    fontSize: 14.sp,
                    color: Palette.darkGreyColor,
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          CommonText.textBoldWeight600(
            text: 'Active Rental Periods (${car.rentalPeriods.length})',
            fontSize: 16.sp,
            color: Palette.blackColor,
          ),
          SizedBox(height: 12.h),
          ...car.rentalPeriods.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final rental = entry.value;
              return Container(
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.blue[200]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.05),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rental header
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.blue,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText.textBoldWeight600(
                                text:
                                    '${rental.user.firstName} ${rental.user.lastName}',
                                fontSize: 15.sp,
                                color: Palette.blackColor,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.phone,
                                      size: 12.sp, color: Colors.grey[600]),
                                  SizedBox(width: 4.w),
                                  CommonText.textBoldWeight400(
                                    text: rental.user.phone,
                                    fontSize: 12.sp,
                                    color: Palette.darkGreyColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: CommonText.textBoldWeight600(
                            text: 'Booking #${index + 1}',
                            fontSize: 10.sp,
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    // Rental period details
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  size: 16.sp, color: Colors.green),
                              SizedBox(width: 8.w),
                              CommonText.textBoldWeight600(
                                text: 'Start Date',
                                fontSize: 12.sp,
                                color: Palette.blackColor,
                              ),
                              Spacer(),
                              CommonText.textBoldWeight500(
                                text: formatDateOnly(rental.start),
                                fontSize: 12.sp,
                                color: Palette.darkGreyColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(Icons.event, size: 16.sp, color: Colors.red),
                              SizedBox(width: 8.w),
                              CommonText.textBoldWeight600(
                                text: 'End Date',
                                fontSize: 12.sp,
                                color: Palette.blackColor,
                              ),
                              Spacer(),
                              CommonText.textBoldWeight500(
                                text: formatDateOnly(rental.end),
                                fontSize: 12.sp,
                                color: Palette.darkGreyColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Divider(height: 1, color: Colors.grey[300]),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  size: 16.sp, color: Colors.orange),
                              SizedBox(width: 8.w),
                              CommonText.textBoldWeight600(
                                text: 'Duration',
                                fontSize: 12.sp,
                                color: Palette.blackColor,
                              ),
                              Spacer(),
                              CommonText.textBoldWeight500(
                                text: _calculateRentalDuration(
                                    rental.start, rental.end),
                                fontSize: 12.sp,
                                color: Colors.orange[700],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        ],
      ],
    ),
  );
}

Widget buildCarImagesCard(CarModel car) {
  return buildCarCard(
    title: 'Vehicle Gallery',
    icon: Icons.photo_library,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (car.imageUrl.isEmpty) ...[
          Center(
            child: Padding(
              padding: EdgeInsets.all(32.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add_photo_alternate,
                      size: 32.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CommonText.textBoldWeight600(
                    text: 'No Images Available',
                    fontSize: 16.sp,
                    color: Palette.blackColor,
                  ),
                  SizedBox(height: 4.h),
                  CommonText.textBoldWeight500(
                    text:
                        'Add vehicle photos to showcase this car to customers',
                    fontSize: 14.sp,
                    color: Palette.darkGreyColor,
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText.textBoldWeight600(
                text: 'Photos (${car.imageUrl.length})',
                fontSize: 16.sp,
                color: Palette.blackColor,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: CommonText.textBoldWeight600(
                  text: 'High Quality',
                  fontSize: 10.sp,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: car.imageUrl.length >= 4 ? 3 : 2,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.h,
              childAspectRatio: 1.3,
            ),
            itemCount: car.imageUrl.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[300]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        car.imageUrl[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.grey[400],
                            size: 24.sp,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: CommonText.textBoldWeight600(
                            text: '${index + 1}',
                            fontSize: 10.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ],
    ),
  );
}

Widget buildCarStatisticsCard(CarModel car) {
  return buildCarCard(
    title: 'Performance Analytics',
    icon: Icons.analytics,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Revenue metrics
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[50]!, Colors.green[100]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.monetization_on,
                      color: Colors.green[700], size: 20.sp),
                  SizedBox(width: 8.w),
                  CommonText.textBoldWeight600(
                    text: 'Revenue Potential',
                    fontSize: 14.sp,
                    color: Colors.green[700],
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              CommonText.textBoldWeight700(
                text: '${(car.pricePerDay * 30).toStringAsFixed(0)} MRU/month',
                fontSize: 18.sp,
                color: Colors.green[800],
              ),
              CommonText.textBoldWeight500(
                text: 'Estimated monthly earnings at current rate',
                fontSize: 12.sp,
                color: Colors.green[600],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Performance metrics grid
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  children: [
                    Icon(Icons.event, color: Colors.blue, size: 24.sp),
                    SizedBox(height: 8.h),
                    CommonText.textBoldWeight700(
                      text: car.rentalPeriods.length.toString(),
                      fontSize: 20.sp,
                      color: Colors.blue[700],
                    ),
                    CommonText.textBoldWeight500(
                      text: 'Active Bookings',
                      fontSize: 12.sp,
                      color: Palette.darkGreyColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.purple[200]!),
                ),
                child: Column(
                  children: [
                    Icon(Icons.airline_seat_recline_normal,
                        color: Colors.purple, size: 24.sp),
                    SizedBox(height: 8.h),
                    CommonText.textBoldWeight700(
                      text: car.seats.toString(),
                      fontSize: 20.sp,
                      color: Colors.purple[700],
                    ),
                    CommonText.textBoldWeight500(
                      text: 'Passenger Capacity',
                      fontSize: 12.sp,
                      color: Palette.darkGreyColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.w),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: car.isAvailable ? Colors.green[50] : Colors.red[50],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color:
                        car.isAvailable ? Colors.green[200]! : Colors.red[200]!,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      car.isAvailable ? Icons.check_circle : Icons.block,
                      color: car.isAvailable ? Colors.green : Colors.red,
                      size: 24.sp,
                    ),
                    SizedBox(height: 8.h),
                    CommonText.textBoldWeight700(
                      text: car.isAvailable ? 'AVAILABLE' : 'UNAVAILABLE',
                      fontSize: 14.sp,
                      color:
                          car.isAvailable ? Colors.green[700] : Colors.red[700],
                    ),
                    CommonText.textBoldWeight500(
                      text: 'Rental Status',
                      fontSize: 12.sp,
                      color: Palette.darkGreyColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Column(
                  children: [
                    Icon(Icons.photo_library,
                        color: Colors.orange, size: 24.sp),
                    SizedBox(height: 8.h),
                    CommonText.textBoldWeight700(
                      text: car.imageUrl.length.toString(),
                      fontSize: 20.sp,
                      color: Colors.orange[700],
                    ),
                    CommonText.textBoldWeight500(
                      text: 'Photos Available',
                      fontSize: 12.sp,
                      color: Palette.darkGreyColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildCarMaintenanceCard(CarModel car) {
  return buildCarCard(
    title: 'Maintenance & Status',
    icon: Icons.build,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Maintenance status
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.green[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.verified, color: Colors.green, size: 24.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.textBoldWeight600(
                      text: 'Vehicle Status: Excellent',
                      fontSize: 14.sp,
                      color: Colors.green[700],
                    ),
                    CommonText.textBoldWeight500(
                      text: 'Last maintenance: 2 weeks ago',
                      fontSize: 12.sp,
                      color: Colors.green[600],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Maintenance checklist
        CommonText.textBoldWeight600(
          text: 'System Checks',
          fontSize: 14.sp,
          color: Palette.blackColor,
        ),
        SizedBox(height: 8.h),
        ...buildMaintenanceChecks(),
      ],
    ),
  );
}

List<Widget> buildMaintenanceChecks() {
  final checks = [
    {'label': 'Engine Performance', 'status': true},
    {'label': 'Brake System', 'status': true},
    {'label': 'Tire Condition', 'status': true},
    {'label': 'Interior Cleanliness', 'status': true},
    {'label': 'Exterior Condition', 'status': false},
  ];

  return checks
      .map((check) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              children: [
                Icon(
                  check['status'] as bool ? Icons.check_circle : Icons.warning,
                  color: check['status'] as bool ? Colors.green : Colors.orange,
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                CommonText.textBoldWeight500(
                  text: check['label'] as String,
                  fontSize: 13.sp,
                  color: Palette.darkGreyColor,
                ),
              ],
            ),
          ))
      .toList();
}

Widget buildCarCard(
    {required String title, required IconData icon, required Widget child}) {
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
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Palette.mainDarkColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: Palette.mainDarkColor,
              ),
            ),
            SizedBox(width: 12.w),
            CommonText.textBoldWeight700(
              text: title,
              fontSize: 18.sp,
              color: Palette.blackColor,
            ),
          ],
        ),
        SizedBox(height: 16.h),
        child,
      ],
    ),
  );
}

Widget buildCarInfoRow(String label, String value) {
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

Widget buildCarActionCard(CarModel car,
    {required VoidCallback onAvailabilityToggle,
    required VoidCallback onEdit}) {
  return buildCarCard(
    title: 'Quick Actions',
    icon: Icons.settings,
    child: Column(
      children: [
        // Availability toggle
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: car.isAvailable ? Colors.red[50] : Colors.green[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: car.isAvailable ? Colors.red[200]! : Colors.green[200]!,
            ),
          ),
          child: InkWell(
            onTap: onAvailabilityToggle,
            child: Row(
              children: [
                Icon(
                  car.isAvailable ? Icons.block : Icons.check_circle,
                  color: car.isAvailable ? Colors.red : Colors.green,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText.textBoldWeight600(
                        text: car.isAvailable
                            ? 'Mark as Unavailable'
                            : 'Mark as Available',
                        fontSize: 14.sp,
                        color: car.isAvailable
                            ? Colors.red[700]
                            : Colors.green[700],
                      ),
                      CommonText.textBoldWeight500(
                        text: car.isAvailable
                            ? 'Remove from rental listings'
                            : 'Make available for bookings',
                        fontSize: 12.sp,
                        color: car.isAvailable
                            ? Colors.red[600]
                            : Colors.green[600],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: car.isAvailable ? Colors.red[400] : Colors.green[400],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h),

        // Edit car details
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: InkWell(
            onTap: onEdit,
            child: Row(
              children: [
                Icon(Icons.edit, color: Colors.blue, size: 24.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText.textBoldWeight600(
                        text: 'Edit Vehicle Details',
                        fontSize: 14.sp,
                        color: Colors.blue[700],
                      ),
                      CommonText.textBoldWeight500(
                        text: 'Update pricing, images, and specifications',
                        fontSize: 12.sp,
                        color: Colors.blue[600],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: Colors.blue[400],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h),

        // Additional actions
        // Row(
        //   children: [
        //     Expanded(
        //       child: Container(
        //         padding: EdgeInsets.all(12.w),
        //         decoration: BoxDecoration(
        //           color: Colors.purple[50],
        //           borderRadius: BorderRadius.circular(8.r),
        //           border: Border.all(color: Colors.purple[200]!),
        //         ),
        //         child: Column(
        //           children: [
        //             Icon(Icons.history, color: Colors.purple, size: 20.sp),
        //             SizedBox(height: 4.h),
        //             CommonText.textBoldWeight600(
        //               text: 'History',
        //               fontSize: 12.sp,
        //               color: Colors.purple[700],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     SizedBox(width: 8.w),
        //     Expanded(
        //       child: Container(
        //         padding: EdgeInsets.all(12.w),
        //         decoration: BoxDecoration(
        //           color: Colors.orange[50],
        //           borderRadius: BorderRadius.circular(8.r),
        //           border: Border.all(color: Colors.orange[200]!),
        //         ),
        //         child: Column(
        //           children: [
        //             Icon(Icons.report, color: Colors.orange, size: 20.sp),
        //             SizedBox(height: 4.h),
        //             CommonText.textBoldWeight600(
        //               text: 'Reports',
        //               fontSize: 12.sp,
        //               color: Colors.orange[700],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     SizedBox(width: 8.w),
        //     Expanded(
        //       child: Container(
        //         padding: EdgeInsets.all(12.w),
        //         decoration: BoxDecoration(
        //           color: Colors.teal[50],
        //           borderRadius: BorderRadius.circular(8.r),
        //           border: Border.all(color: Colors.teal[200]!),
        //         ),
        //         child: Column(
        //           children: [
        //             Icon(Icons.share, color: Colors.teal, size: 20.sp),
        //             SizedBox(height: 4.h),
        //             CommonText.textBoldWeight600(
        //               text: 'Share',
        //               fontSize: 12.sp,
        //               color: Colors.teal[700],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    ),
  );
}

Widget buildCarBookingHistoryCard(CarModel car) {
  return buildCarCard(
    title: 'Booking History',
    icon: Icons.history,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary stats
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo[50]!, Colors.indigo[100]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CommonText.textBoldWeight700(
                      text:
                          '${car.rentalPeriods.length + 15}', // Mock historical data
                      fontSize: 24.sp,
                      color: Colors.indigo[700],
                    ),
                    CommonText.textBoldWeight500(
                      text: 'Total Bookings',
                      fontSize: 12.sp,
                      color: Colors.indigo[600],
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: Colors.indigo[300],
              ),
              Expanded(
                child: Column(
                  children: [
                    CommonText.textBoldWeight700(
                      text: '98%',
                      fontSize: 24.sp,
                      color: Colors.indigo[700],
                    ),
                    CommonText.textBoldWeight500(
                      text: 'Satisfaction Rate',
                      fontSize: 12.sp,
                      color: Colors.indigo[600],
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: Colors.indigo[300],
              ),
              Expanded(
                child: Column(
                  children: [
                    CommonText.textBoldWeight700(
                      text: '4.8',
                      fontSize: 24.sp,
                      color: Colors.indigo[700],
                    ),
                    CommonText.textBoldWeight500(
                      text: 'Avg Rating',
                      fontSize: 12.sp,
                      color: Colors.indigo[600],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Recent completed bookings (mock data)
        CommonText.textBoldWeight600(
          text: 'Recent Completed Rentals',
          fontSize: 14.sp,
          color: Palette.blackColor,
        ),
        SizedBox(height: 8.h),
        ...List.generate(
            3,
            (index) => Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child:
                            Icon(Icons.check, color: Colors.green, size: 14.sp),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textBoldWeight600(
                              text: 'Customer ${index + 1}',
                              fontSize: 13.sp,
                              color: Palette.blackColor,
                            ),
                            CommonText.textBoldWeight400(
                              text: '${3 - index} days ago • 5 stars',
                              fontSize: 11.sp,
                              color: Palette.darkGreyColor,
                            ),
                          ],
                        ),
                      ),
                      CommonText.textBoldWeight600(
                        text:
                            '${(car.pricePerDay * (index + 2)).toStringAsFixed(0)} MRU',
                        fontSize: 12.sp,
                        color: Colors.green[700],
                      ),
                    ],
                  ),
                )),
      ],
    ),
  );
}

// Helper function to calculate rental duration
String _calculateRentalDuration(String startDate, String endDate) {
  try {
    // This is a simple implementation - you might want to use proper date parsing
    return 'Multiple days'; // Placeholder
  } catch (e) {
    return 'Duration unknown';
  }
}
