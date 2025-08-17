import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/core/providers/providers.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';
import 'package:fasti_dashboard/features/auth/data/data_source/auth_cached_data_source.dart';
import 'package:fasti_dashboard/features/auth/presentation/riverpod/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;

  AuthNotifier(this.ref) : super(const AuthState());

  // Agent login
  Future<bool> loginAgent(
      {required String email, required String password}) async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await ref
        .read(authRepositoryProvider)
        .loginAgent(email: email, password: password);

    return result.fold(
      (failure) {
        print('DEBUG: agent login failed: $failure');
        state = state.copyWith(isLoading: false, failure: failure);
        return false;
      },
      (agent) {
        if (agent != null && agent.isActive) {
          state = state.copyWith(
            isLoading: false,
            agent: agent,
            failure: null,
          );
          return true;
        } else {
          state = state.copyWith(
            isLoading: false,
            failure:
                const Failure.user('Agent login failed or account inactive'),
          );
          return false;
        }
      },
    );
  }

  Future<bool> checkAuthStatus() async {
    // Check if agent is logged in
    final isAgentLoggedIn =
        await ref.read(authRepositoryProvider).isAgentLoggedIn();

    if (isAgentLoggedIn) {
      final result = await ref.read(authRepositoryProvider).getCurrentAgent();

      return result.fold(
        (failure) {
          state = state.copyWith(failure: failure);
          return false;
        },
        (agent) {
          if (agent != null && agent.isActive) {
            state = state.copyWith(agent: agent);
            return true;
          }
          return false;
        },
      );
    }

    return false;
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);

    final result = await ref.read(authRepositoryProvider).signOutAgent();
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (_) => state = const AuthState(),
    );
  }

  Future<void> getAgentCached() async {
    // Check for cached agent
    final AgentModel? cachedAgent =
        await AuthCachedDataSource.getCachedAgentStatic();
    if (cachedAgent != null && cachedAgent.isActive) {
      state = state.copyWith(agent: cachedAgent);
    }
  }

  void saveAgent(AgentModel agent) {
    state = state.copyWith(agent: agent);
  }

  void clearError() {
    state = state.copyWith(failure: null);
  }

  // Update agent permissions (useful when permissions change)
  Future<void> refreshAgentPermissions() async {
    if (state.agent != null) {
      final result = await ref
          .read(agentsRepositoryProvider)
          .getAgentById(agentId: state.agent!.id);

      result.fold(
        (failure) => state = state.copyWith(failure: failure),
        (updatedAgent) {
          if (updatedAgent != null) {
            state = state.copyWith(agent: updatedAgent);
            // Update cache
            AuthCachedDataSource.staticCacheAgent(updatedAgent);
          }
        },
      );
    }
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});
