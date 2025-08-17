// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthUserModelImpl _$$AuthUserModelImplFromJson(Map<String, dynamic> json) =>
    _$AuthUserModelImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      isVerified: json['isVerified'] as bool,
      admin: json['admin'] == null
          ? null
          : AdminModel.fromJson(json['admin'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthUserModelImplToJson(_$AuthUserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'isVerified': instance.isVerified,
      'admin': instance.admin,
    };
