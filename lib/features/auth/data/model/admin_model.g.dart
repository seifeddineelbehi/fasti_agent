// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminModelImpl _$$AdminModelImplFromJson(Map<String, dynamic> json) =>
    _$AdminModelImpl(
      id: json['id'] as String,
      kmPrice: (json['kmPrice'] as num).toDouble(),
      stopOverMinPrice: (json['stopOverMinPrice'] as num).toDouble(),
      luxuryPricePercentage: (json['luxuryPricePercentage'] as num).toInt(),
      luxurySuvPricePercentage:
          (json['luxurySuvPricePercentage'] as num).toInt(),
      companyPercentage: (json['companyPercentage'] as num).toInt(),
      userPointsPercentage: (json['userPointsPercentage'] as num).toInt(),
      pointValueInMru: (json['pointValueInMru'] as num).toInt(),
      lessThenTwoKPrice: (json['lessThenTwoKPrice'] as num).toDouble(),
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$$AdminModelImplToJson(_$AdminModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kmPrice': instance.kmPrice,
      'stopOverMinPrice': instance.stopOverMinPrice,
      'luxuryPricePercentage': instance.luxuryPricePercentage,
      'luxurySuvPricePercentage': instance.luxurySuvPricePercentage,
      'companyPercentage': instance.companyPercentage,
      'userPointsPercentage': instance.userPointsPercentage,
      'pointValueInMru': instance.pointValueInMru,
      'lessThenTwoKPrice': instance.lessThenTwoKPrice,
      'userName': instance.userName,
    };
