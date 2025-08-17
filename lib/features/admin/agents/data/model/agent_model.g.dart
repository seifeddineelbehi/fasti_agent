// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentModelImpl _$$AgentModelImplFromJson(Map<String, dynamic> json) =>
    _$AgentModelImpl(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      photoUrl: json['photoUrl'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? true,
      role: json['role'] as String,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
      createdByAdminId: json['createdByAdminId'] as String? ?? '',
      createdByAdminName: json['createdByAdminName'] as String? ?? '',
    );

Map<String, dynamic> _$$AgentModelImplToJson(_$AgentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'photoUrl': instance.photoUrl,
      'isActive': instance.isActive,
      'role': instance.role,
      'permissions': instance.permissions,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'createdByAdminId': instance.createdByAdminId,
      'createdByAdminName': instance.createdByAdminName,
    };
