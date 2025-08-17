// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_role_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentRoleModelImpl _$$AgentRoleModelImplFromJson(Map<String, dynamic> json) =>
    _$AgentRoleModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AgentRoleModelImplToJson(
        _$AgentRoleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'permissions': instance.permissions,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
    };
