// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CarModelImpl _$$CarModelImplFromJson(Map<String, dynamic> json) =>
    _$CarModelImpl(
      id: json['id'] as String,
      brand: json['brand'] as String,
      model: json['model'] as String,
      type: json['type'] as String,
      seats: (json['seats'] as num).toInt(),
      imageUrl:
          (json['imageUrl'] as List<dynamic>).map((e) => e as String).toList(),
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
      isAvailable: json['isAvailable'] as bool? ?? true,
      rentalPeriods: (json['rentalPeriods'] as List<dynamic>?)
              ?.map(
                  (e) => RentalPeriodModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CarModelImplToJson(_$CarModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brand': instance.brand,
      'model': instance.model,
      'type': instance.type,
      'seats': instance.seats,
      'imageUrl': instance.imageUrl,
      'pricePerDay': instance.pricePerDay,
      'isAvailable': instance.isAvailable,
      'rentalPeriods': instance.rentalPeriods,
    };
