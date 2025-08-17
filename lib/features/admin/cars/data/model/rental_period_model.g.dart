// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rental_period_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RentalPeriodModelImpl _$$RentalPeriodModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RentalPeriodModelImpl(
      start: json['start'] as String,
      end: json['end'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RentalPeriodModelImplToJson(
        _$RentalPeriodModelImpl instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'user': instance.user,
    };
