import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_agent_request_model.freezed.dart';
part 'create_agent_request_model.g.dart';

@freezed
class CreateAgentRequestModel with _$CreateAgentRequestModel {
  const factory CreateAgentRequestModel({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String role,
    required List<String> permissions,
    @Default('') String photoUrl,
  }) = _CreateAgentRequestModel;

  factory CreateAgentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateAgentRequestModelFromJson(json);
}
