// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rental_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RentalRequestModelImpl _$$RentalRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RentalRequestModelImpl(
      id: json['id'] as String,
      car: CarModel.fromJson(json['car'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      reservationDateStart: json['reservationDateStart'] as String,
      reservationDateEnd: json['reservationDateEnd'] as String,
      numberOfDays: (json['numberOfDays'] as num).toInt(),
      rentTime: json['rentTime'] as String,
      totalCost: (json['totalCost'] as num).toDouble(),
      submittedAt: json['submittedAt'] as String,
      withDriver: json['withDriver'] as bool? ?? false,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$RentalRequestModelImplToJson(
        _$RentalRequestModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'car': instance.car,
      'user': instance.user,
      'reservationDateStart': instance.reservationDateStart,
      'reservationDateEnd': instance.reservationDateEnd,
      'numberOfDays': instance.numberOfDays,
      'rentTime': instance.rentTime,
      'totalCost': instance.totalCost,
      'submittedAt': instance.submittedAt,
      'withDriver': instance.withDriver,
      'status': instance.status,
    };
