import 'package:fasti_dashboard/features/admin/users/data/model/user_rating_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/wallet_trip_payment_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'vehicle_info_model.dart';

part 'driver_info_model.freezed.dart';
part 'driver_info_model.g.dart';

@freezed
class DriverInfoModel with _$DriverInfoModel {
  const factory DriverInfoModel({
    required String dateOfBirth,
    required String approvedStatus,
    @Default(5.0) double rating,
    required bool availableStatus,
    required String idLicensePicture,
    required String driverLicenseNumber,
    required String driverLicenseFrontPicture,
    required String driverLicenseBackPicture,
    required String driverLicenseExpirationDate,
    required VehicleInfoModel vehicleInfo,
    @Default(0) int totalRatings,
    @Default(0.0) double ratingSum,
    @Default(0.0) double unpaidEarnings,
    @Default([]) List<DailyEarningModel> dailyEarnings,
    @Default([]) List<UserRatingModel> ratings,
    @Default([]) List<WalletTripPaymentModel> walletTripPayments,
  }) = _DriverInfoModel;

  factory DriverInfoModel.fromJson(Map<String, dynamic> json) =>
      _$DriverInfoModelFromJson(json);
}

@freezed
class DailyEarningModel with _$DailyEarningModel {
  const factory DailyEarningModel({
    required String date, // format: yyyy-MM-dd
    required double amount,
    required String method,
    String? note, // e.g., "bank", "cash", "mobile"
  }) = _DailyEarningModel;

  factory DailyEarningModel.fromJson(Map<String, dynamic> json) =>
      _$DailyEarningModelFromJson(json);
}

extension DriverInfoModelFirestore on DriverInfoModel {
  Map<String, dynamic> toJsonForFirestore() {
    return {
      'dateOfBirth': dateOfBirth,
      'approvedStatus': approvedStatus,
      'ratingSum': ratingSum,
      'totalRatings': totalRatings,
      'availableStatus': availableStatus,
      'idLicensePicture': idLicensePicture,
      'driverLicenseNumber': driverLicenseNumber,
      'rating': rating,
      'driverLicenseFrontPicture': driverLicenseFrontPicture,
      'driverLicenseBackPicture': driverLicenseBackPicture,
      'driverLicenseExpirationDate': driverLicenseExpirationDate,
      'vehicleInfo': vehicleInfo.toJsonForFirestore(),
      'unpaidEarnings': unpaidEarnings,
      'dailyEarnings': dailyEarnings.map((p) => p.toJson()).toList(),
      'ratings': ratings.map((p) => p.toJsonForFirestore()).toList(),
      'walletTripPayments':
          walletTripPayments.map((p) => p.toJsonForFirestore()).toList(),
    };
  }
}
