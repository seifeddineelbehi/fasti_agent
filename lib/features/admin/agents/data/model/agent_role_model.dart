import 'package:freezed_annotation/freezed_annotation.dart';

part 'agent_role_model.freezed.dart';
part 'agent_role_model.g.dart';

@freezed
class AgentRoleModel with _$AgentRoleModel {
  const factory AgentRoleModel({
    required String id,
    required String name,
    required String description,
    required List<String> permissions,
    @Default(true) bool isActive,
    required DateTime createdAt,
  }) = _AgentRoleModel;

  factory AgentRoleModel.fromJson(Map<String, dynamic> json) =>
      _$AgentRoleModelFromJson(json);
}
