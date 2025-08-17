// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleInfoModelImpl _$$VehicleInfoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VehicleInfoModelImpl(
      type: json['type'] as String,
      color: json['color'] as String,
      numberPlate: json['numberPlate'] as String,
      vehiclePhotos: json['vehiclePhotos'] as String,
      registrationCertificateFront:
          json['registrationCertificateFront'] as String,
      registrationCertificateBack:
          json['registrationCertificateBack'] as String,
      insurancePhoto: json['insurancePhoto'] as String,
      travelClass: json['travelClass'] as String? ?? '',
    );

Map<String, dynamic> _$$VehicleInfoModelImplToJson(
        _$VehicleInfoModelImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'color': instance.color,
      'numberPlate': instance.numberPlate,
      'vehiclePhotos': instance.vehiclePhotos,
      'registrationCertificateFront': instance.registrationCertificateFront,
      'registrationCertificateBack': instance.registrationCertificateBack,
      'insurancePhoto': instance.insurancePhoto,
      'travelClass': instance.travelClass,
    };
