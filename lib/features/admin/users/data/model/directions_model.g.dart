// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DirectionsModelImpl _$$DirectionsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DirectionsModelImpl(
      humanReadableAddress: json['humanReadableAddress'] as String?,
      locationName: json['locationName'] as String?,
      locationId: json['locationId'] as String?,
      locationLatitude: (json['locationLatitude'] as num?)?.toDouble(),
      locationLongitude: (json['locationLongitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$DirectionsModelImplToJson(
        _$DirectionsModelImpl instance) =>
    <String, dynamic>{
      'humanReadableAddress': instance.humanReadableAddress,
      'locationName': instance.locationName,
      'locationId': instance.locationId,
      'locationLatitude': instance.locationLatitude,
      'locationLongitude': instance.locationLongitude,
    };
