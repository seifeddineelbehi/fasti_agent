// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripModelImpl _$$TripModelImplFromJson(Map<String, dynamic> json) =>
    _$TripModelImpl(
      id: json['id'] as String? ?? '',
      isFromAdmin: json['isFromAdmin'] as bool? ?? true,
      userPickupLocation: DirectionsModel.fromJson(
          json['userPickupLocation'] as Map<String, dynamic>),
      userDropOffLocations: (json['userDropOffLocations'] as List<dynamic>)
          .map((e) => DirectionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      time: json['time'] as String,
      paymentMethod: json['paymentMethod'] as String,
      originAddressName: json['originAddressName'] as String,
      destinationAddressNames:
          (json['destinationAddressNames'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      driver: UserModel.fromJson(json['driver'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      isStopOver: json['isStopOver'] as bool,
      fare: (json['fare'] as num).toDouble(),
      status: json['status'] as String,
      distance: (json['distance'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
      cancellationReason: json['cancellationReason'] as String? ?? '',
    );

Map<String, dynamic> _$$TripModelImplToJson(_$TripModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isFromAdmin': instance.isFromAdmin,
      'userPickupLocation': instance.userPickupLocation,
      'userDropOffLocations': instance.userDropOffLocations,
      'time': instance.time,
      'paymentMethod': instance.paymentMethod,
      'originAddressName': instance.originAddressName,
      'destinationAddressNames': instance.destinationAddressNames,
      'driver': instance.driver,
      'user': instance.user,
      'isStopOver': instance.isStopOver,
      'fare': instance.fare,
      'status': instance.status,
      'distance': instance.distance,
      'duration': instance.duration,
      'cancellationReason': instance.cancellationReason,
    };
