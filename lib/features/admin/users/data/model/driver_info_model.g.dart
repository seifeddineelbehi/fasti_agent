// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverInfoModelImpl _$$DriverInfoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DriverInfoModelImpl(
      dateOfBirth: json['dateOfBirth'] as String,
      approvedStatus: json['approvedStatus'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      availableStatus: json['availableStatus'] as bool,
      idLicensePicture: json['idLicensePicture'] as String,
      driverLicenseNumber: json['driverLicenseNumber'] as String,
      driverLicenseFrontPicture: json['driverLicenseFrontPicture'] as String,
      driverLicenseBackPicture: json['driverLicenseBackPicture'] as String,
      driverLicenseExpirationDate:
          json['driverLicenseExpirationDate'] as String,
      vehicleInfo: VehicleInfoModel.fromJson(
          json['vehicleInfo'] as Map<String, dynamic>),
      totalRatings: (json['totalRatings'] as num?)?.toInt() ?? 0,
      ratingSum: (json['ratingSum'] as num?)?.toDouble() ?? 0.0,
      unpaidEarnings: (json['unpaidEarnings'] as num?)?.toDouble() ?? 0.0,
      dailyEarnings: (json['dailyEarnings'] as List<dynamic>?)
              ?.map(
                  (e) => DailyEarningModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      ratings: (json['ratings'] as List<dynamic>?)
              ?.map((e) => UserRatingModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      walletTripPayments: (json['walletTripPayments'] as List<dynamic>?)
              ?.map((e) =>
                  WalletTripPaymentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$DriverInfoModelImplToJson(
        _$DriverInfoModelImpl instance) =>
    <String, dynamic>{
      'dateOfBirth': instance.dateOfBirth,
      'approvedStatus': instance.approvedStatus,
      'rating': instance.rating,
      'availableStatus': instance.availableStatus,
      'idLicensePicture': instance.idLicensePicture,
      'driverLicenseNumber': instance.driverLicenseNumber,
      'driverLicenseFrontPicture': instance.driverLicenseFrontPicture,
      'driverLicenseBackPicture': instance.driverLicenseBackPicture,
      'driverLicenseExpirationDate': instance.driverLicenseExpirationDate,
      'vehicleInfo': instance.vehicleInfo,
      'totalRatings': instance.totalRatings,
      'ratingSum': instance.ratingSum,
      'unpaidEarnings': instance.unpaidEarnings,
      'dailyEarnings': instance.dailyEarnings,
      'ratings': instance.ratings,
      'walletTripPayments': instance.walletTripPayments,
    };

_$DailyEarningModelImpl _$$DailyEarningModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyEarningModelImpl(
      date: json['date'] as String,
      amount: (json['amount'] as num).toDouble(),
      method: json['method'] as String,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$DailyEarningModelImplToJson(
        _$DailyEarningModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'amount': instance.amount,
      'method': instance.method,
      'note': instance.note,
    };
