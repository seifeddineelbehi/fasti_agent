// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_agent_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateAgentRequestModelImpl _$$CreateAgentRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateAgentRequestModelImpl(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      photoUrl: json['photoUrl'] as String? ?? '',
    );

Map<String, dynamic> _$$CreateAgentRequestModelImplToJson(
        _$CreateAgentRequestModelImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'role': instance.role,
      'permissions': instance.permissions,
      'photoUrl': instance.photoUrl,
    };
