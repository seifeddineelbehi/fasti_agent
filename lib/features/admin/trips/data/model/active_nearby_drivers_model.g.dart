// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_nearby_drivers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActiveNearByDriversModelImpl _$$ActiveNearByDriversModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ActiveNearByDriversModelImpl(
      driverId: json['driverId'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      distanceFromUser: (json['distanceFromUser'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$ActiveNearByDriversModelImplToJson(
        _$ActiveNearByDriversModelImpl instance) =>
    <String, dynamic>{
      'driverId': instance.driverId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'distanceFromUser': instance.distanceFromUser,
    };
