// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserRatingModelImpl _$$UserRatingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserRatingModelImpl(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      ratingGiven: (json['ratingGiven'] as num).toDouble(),
    );

Map<String, dynamic> _$$UserRatingModelImplToJson(
        _$UserRatingModelImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'ratingGiven': instance.ratingGiven,
    };
