// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String? ?? '',
      deviceToken: json['deviceToken'] as String? ?? '',
      role: json['role'] as String? ?? 'client',
      isBanned: json['isBanned'] as bool? ?? false,
      walletBalance: (json['walletBalance'] as num?)?.toDouble() ?? 0.0,
      points: (json['points'] as num?)?.toInt() ?? 0,
      favorites: (json['favorites'] as List<dynamic>?)
              ?.map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      status: json['status'] as String? ?? 'offline',
      trips:
          (json['trips'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      notifications: (json['notifications'] as List<dynamic>?)
              ?.map(
                  (e) => NotificationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      driverInfo: json['driverInfo'] == null
          ? null
          : DriverInfoModel.fromJson(
              json['driverInfo'] as Map<String, dynamic>),
      rentalCars: (json['rentalCars'] as List<dynamic>?)
              ?.map((e) =>
                  RentalConfirmationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'deviceToken': instance.deviceToken,
      'role': instance.role,
      'isBanned': instance.isBanned,
      'walletBalance': instance.walletBalance,
      'points': instance.points,
      'favorites': instance.favorites,
      'location': instance.location,
      'status': instance.status,
      'trips': instance.trips,
      'notifications': instance.notifications,
      'transactions': instance.transactions,
      'driverInfo': instance.driverInfo,
      'rentalCars': instance.rentalCars,
    };
