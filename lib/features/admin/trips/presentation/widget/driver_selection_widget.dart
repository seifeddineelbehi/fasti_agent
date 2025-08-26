import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/util/helper_functions.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverSelectionWidget extends ConsumerWidget {
  final List<UserModel> nearbyDrivers;
  final UserModel? selectedDriver;
  final Function(UserModel) onDriverSelected;
  final bool isStopoverEnabled;
  final Function(bool) onStopoverChanged;
  final String selectedPaymentMethod;
  final Function(String) onPaymentMethodChanged;
  final double estimatedFare;
  final int totalDistanceMeters;
  final double kmPrice;
  final double lessKmPrice;
  final int luxuryPercentage;
  final int luxurySuvPercentage;

  const DriverSelectionWidget({
    super.key,
    required this.nearbyDrivers,
    required this.selectedDriver,
    required this.onDriverSelected,
    required this.isStopoverEnabled,
    required this.onStopoverChanged,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodChanged,
    required this.estimatedFare,
    required this.totalDistanceMeters,
    required this.kmPrice,
    required this.lessKmPrice,
    required this.luxuryPercentage,
    required this.luxurySuvPercentage,
  });

  List<UserModel> _getEconomicDrivers() {
    return nearbyDrivers
        .where((driver) =>
            driver.driverInfo?.vehicleInfo.travelClass?.toLowerCase() ==
            'economic')
        .toList();
  }

  List<UserModel> _getLuxuryDrivers() {
    return nearbyDrivers
        .where((driver) =>
            driver.driverInfo?.vehicleInfo.travelClass?.toLowerCase() !=
            'economic')
        .toList();
  }

  double _calculateDriverFare(UserModel driver) {
    if (driver.driverInfo?.vehicleInfo.travelClass == null ||
        totalDistanceMeters == 0) {
      return 0.0;
    }

    final travelClass =
        driver.driverInfo!.vehicleInfo.travelClass.toLowerCase();

    if (travelClass == 'economic') {
      return calculateEconomicDisplayedPrice(
          totalDistanceMeters, kmPrice, lessKmPrice);
    } else if (travelClass == 'luxury suv') {
      return calculateLuxurySuvPrice(
        distanceMeters: totalDistanceMeters,
        kmPrice: kmPrice,
        luxurySuvPercentage: luxurySuvPercentage,
        lessKmPrice: lessKmPrice,
      );
    } else {
      return calculateLuxuryPrice(
        distanceMeters: totalDistanceMeters,
        kmPrice: kmPrice,
        luxuryPercentage: luxuryPercentage,
        lessKmPrice: lessKmPrice,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final economicDrivers = _getEconomicDrivers();
    final luxuryDrivers = _getLuxuryDrivers();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText.textBoldWeight600(
          text: "Available Drivers",
          fontSize: 18.sp,
          color: Colors.black,
        ),
        SizedBox(height: 16.sp),

        // Drivers List Container
        Container(
          constraints: BoxConstraints(maxHeight: 400.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.sp),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: nearbyDrivers.isEmpty
              ? _buildEmptyDriversState()
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Economic Drivers Section
                      if (economicDrivers.isNotEmpty) ...[
                        CommonText.textBoldWeight600(
                          text: "Economic Cars",
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                        SizedBox(height: 12.sp),
                        ...economicDrivers.map((driver) =>
                            _buildDriverCard(driver, isEconomic: true)),
                        SizedBox(height: 20.sp),
                      ],

                      // Luxury Drivers Section
                      if (luxuryDrivers.isNotEmpty) ...[
                        CommonText.textBoldWeight600(
                          text: "Luxury Cars",
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                        SizedBox(height: 12.sp),
                        ...luxuryDrivers.map((driver) =>
                            _buildDriverCard(driver, isEconomic: false)),
                      ],
                    ],
                  ),
                ),
        ),

        SizedBox(height: 20.sp),

        // Trip Options
        _buildTripOptions(),

        SizedBox(height: 16.sp),

        // Payment Method Selection
        _buildPaymentMethodSelection(),

        if (selectedDriver != null) ...[
          SizedBox(height: 16.sp),
          _buildFareDisplay(),
        ],
      ],
    );
  }

  Widget _buildDriverCard(UserModel driver, {required bool isEconomic}) {
    final isSelected = selectedDriver?.id == driver.id;
    final driverFare = _calculateDriverFare(driver);

    return Container(
      margin: EdgeInsets.only(bottom: 12.sp),
      child: InkWell(
        onTap: () => onDriverSelected(driver),
        child: Container(
          padding: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue[50] : Colors.grey[50],
            borderRadius: BorderRadius.circular(8.sp),
            border: Border.all(
              color: isSelected ? Colors.blue[300]! : Colors.grey[200]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              // Car Icon
              Container(
                width: 50.sp,
                height: 50.sp,
                decoration: BoxDecoration(
                  color: isEconomic ? Colors.green[100] : Colors.purple[100],
                  borderRadius: BorderRadius.circular(25.sp),
                ),
                child: Icon(
                  isEconomic ? Icons.directions_car : Icons.car_rental,
                  color: isEconomic ? Colors.green[600] : Colors.purple[600],
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.sp),

              // Driver Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.textBoldWeight600(
                      text: "${driver.firstName} ${driver.lastName}",
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                    SizedBox(height: 4.sp),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14.sp,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 4.sp),
                        CommonText.textBoldWeight500(
                          text: driver.driverInfo?.rating.toStringAsFixed(1) ??
                              "5.0",
                          fontSize: 12.sp,
                          color: Colors.grey[600]!,
                        ),
                        SizedBox(width: 12.sp),
                        CommonText.textBoldWeight400(
                          text:
                              "${driver.driverInfo?.vehicleInfo.color} ${driver.driverInfo?.vehicleInfo.type}",
                          fontSize: 12.sp,
                          color: Colors.grey[600]!,
                        ),
                      ],
                    ),
                    if (driver.driverInfo?.vehicleInfo.numberPlate != null) ...[
                      SizedBox(height: 2.sp),
                      CommonText.textBoldWeight400(
                        text: driver.driverInfo!.vehicleInfo.numberPlate,
                        fontSize: 11.sp,
                        color: Colors.grey[500]!,
                      ),
                    ],
                  ],
                ),
              ),

              // Fare and Selection
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonText.textBoldWeight700(
                    text: "${driverFare.toStringAsFixed(0)} MRU",
                    fontSize: 16.sp,
                    color: isSelected ? Colors.blue[600]! : Colors.black,
                  ),
                  SizedBox(height: 4.sp),
                  if (isSelected)
                    Container(
                      padding: EdgeInsets.all(4.sp),
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyDriversState() {
    return Container(
      padding: EdgeInsets.all(24.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_car_outlined,
            size: 48.sp,
            color: Colors.grey[400],
          ),
          SizedBox(height: 12.sp),
          CommonText.textBoldWeight500(
            text: "No drivers available",
            fontSize: 16.sp,
            color: Colors.grey[600]!,
          ),
          SizedBox(height: 8.sp),
          CommonText.textBoldWeight400(
            text: "There are no available drivers in this area at the moment",
            fontSize: 12.sp,
            color: Colors.grey[500]!,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTripOptions() {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.sp),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.textBoldWeight600(
            text: "Trip Options",
            fontSize: 16.sp,
            color: Colors.black,
          ),
          SizedBox(height: 12.sp),

          // Stopover Option
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CommonText.textBoldWeight500(
                    text: "Enable Stopover",
                    fontSize: 14.sp,
                    color: Colors.grey[700]!,
                  ),
                  SizedBox(width: 8.sp),
                  Tooltip(
                    message: "Allow stops during the trip for additional fare",
                    child: Icon(
                      Icons.info_outline,
                      size: 16.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              Switch(
                value: isStopoverEnabled,
                onChanged: onStopoverChanged,
                activeColor: Colors.blue[600],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSelection() {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.sp),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.textBoldWeight600(
            text: "Payment Method",
            fontSize: 16.sp,
            color: Colors.black,
          ),
          SizedBox(height: 12.sp),
          Row(
            children: [
              // Cash Option
              Expanded(
                child: InkWell(
                  onTap: () => onPaymentMethodChanged('cash'),
                  child: Container(
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      color: selectedPaymentMethod == 'cash'
                          ? Colors.blue[50]
                          : Colors.grey[50],
                      borderRadius: BorderRadius.circular(8.sp),
                      border: Border.all(
                        color: selectedPaymentMethod == 'cash'
                            ? Colors.blue[300]!
                            : Colors.grey[300]!,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.money,
                          size: 20.sp,
                          color: selectedPaymentMethod == 'cash'
                              ? Colors.blue[600]
                              : Colors.grey[600],
                        ),
                        SizedBox(width: 8.sp),
                        CommonText.textBoldWeight500(
                          text: "Cash",
                          fontSize: 14.sp,
                          color: selectedPaymentMethod == 'cash'
                              ? Colors.blue[600]!
                              : Colors.grey[600]!,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFareDisplay() {
    final selectedDriverFare = selectedDriver != null
        ? _calculateDriverFare(selectedDriver!)
        : estimatedFare;

    if (selectedDriverFare == 0 || totalDistanceMeters == 0) {
      return Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: Colors.orange[50],
          borderRadius: BorderRadius.circular(8.sp),
          border: Border.all(color: Colors.orange[200]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.orange[600],
              size: 20.sp,
            ),
            SizedBox(width: 8.sp),
            CommonText.textBoldWeight500(
              text: "Select destination to calculate fare",
              fontSize: 14.sp,
              color: Colors.orange[700]!,
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8.sp),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.textBoldWeight600(
                text: "Trip Fare:",
                fontSize: 16.sp,
                color: Colors.green[700]!,
              ),
              if (selectedDriver != null) ...[
                SizedBox(height: 4.sp),
                CommonText.textBoldWeight400(
                  text:
                      "${selectedDriver!.firstName} ${selectedDriver!.lastName}",
                  fontSize: 12.sp,
                  color: Colors.green[600]!,
                ),
              ],
            ],
          ),
          CommonText.textBoldWeight700(
            text: "${selectedDriverFare.toStringAsFixed(0)} MRU",
            fontSize: 20.sp,
            color: Colors.green[700]!,
          ),
        ],
      ),
    );
  }
}
