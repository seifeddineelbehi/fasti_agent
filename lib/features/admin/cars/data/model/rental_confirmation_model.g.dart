// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rental_confirmation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RentalConfirmationModelImpl _$$RentalConfirmationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RentalConfirmationModelImpl(
      reservationId: json['reservationId'] as String,
      status: json['status'] as String,
      car: CarModel.fromJson(json['car'] as Map<String, dynamic>),
      reservationDateStart: json['reservationDateStart'] as String,
      reservationDateEnd: json['reservationDateEnd'] as String,
      rentTime: json['rentTime'] as String,
      numberOfDays: (json['numberOfDays'] as num).toInt(),
      withDriver: json['withDriver'] as bool,
      totalCost: (json['totalCost'] as num).toDouble(),
      submittedAt: json['submittedAt'] as String,
    );

Map<String, dynamic> _$$RentalConfirmationModelImplToJson(
        _$RentalConfirmationModelImpl instance) =>
    <String, dynamic>{
      'reservationId': instance.reservationId,
      'status': instance.status,
      'car': instance.car,
      'reservationDateStart': instance.reservationDateStart,
      'reservationDateEnd': instance.reservationDateEnd,
      'rentTime': instance.rentTime,
      'numberOfDays': instance.numberOfDays,
      'withDriver': instance.withDriver,
      'totalCost': instance.totalCost,
      'submittedAt': instance.submittedAt,
    };
