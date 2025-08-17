import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/features/auth/data/model/auth_user_model.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';

class AuthState {
  final bool isLoading;
  final bool isOtpSent;
  final AuthUserModel? authUser;
  final AgentModel? agent;
  final Failure? failure;
  final String? verificationId;

  const AuthState({
    this.isLoading = false,
    this.isOtpSent = false,
    this.authUser,
    this.agent,
    this.failure,
    this.verificationId,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isOtpSent,
    AuthUserModel? authUser,
    AgentModel? agent,
    Failure? failure,
    String? verificationId,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isOtpSent: isOtpSent ?? this.isOtpSent,
      authUser: authUser ?? this.authUser,
      agent: agent ?? this.agent,
      failure: failure ?? this.failure,
      verificationId: verificationId ?? this.verificationId,
    );
  }

  // Helper methods
  bool get isLoggedIn => agent != null && agent!.isActive;

  // Get current agent permissions
  List<String> get currentUserPermissions => agent?.permissions ?? [];

  // Check if current agent has a specific permission
  bool hasPermission(String permission) {
    return currentUserPermissions.contains(permission);
  }

  // Check if agent has any of the provided permissions
  bool hasAnyPermission(List<String> permissions) {
    return permissions.any((permission) => hasPermission(permission));
  }

  // Check if agent has all of the provided permissions
  bool hasAllPermissions(List<String> permissions) {
    return permissions.every((permission) => hasPermission(permission));
  }

  // Get agent's role
  String get agentRole => agent?.role ?? '';

  // Get agent's full name
  String get agentFullName => agent != null
      ? '${agent!.firstName} ${agent!.lastName}'
      : '';
}