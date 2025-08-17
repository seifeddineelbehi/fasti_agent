// agents_state.dart
import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';

class AgentsState {
  final bool isGettingAllAgentsLoading;
  final bool isGettingAgentLoading;
  final bool isCreatingAgentLoading;
  final bool isUpdatingAgentLoading;
  final bool isDeletingAgentLoading;
  final List<AgentModel>? agents;
  final AgentModel? agent;
  final Failure? failure;

  const AgentsState({
    this.isGettingAllAgentsLoading = false,
    this.isGettingAgentLoading = false,
    this.isCreatingAgentLoading = false,
    this.isUpdatingAgentLoading = false,
    this.isDeletingAgentLoading = false,
    this.agents = const [],
    this.failure,
    this.agent,
  });

  AgentsState copyWith({
    bool? isGettingAllAgentsLoading,
    bool? isGettingAgentLoading,
    bool? isCreatingAgentLoading,
    bool? isUpdatingAgentLoading,
    bool? isDeletingAgentLoading,
    List<AgentModel>? agents,
    AgentModel? agent,
    Failure? failure,
  }) {
    return AgentsState(
      isGettingAllAgentsLoading:
          isGettingAllAgentsLoading ?? this.isGettingAllAgentsLoading,
      isGettingAgentLoading:
          isGettingAgentLoading ?? this.isGettingAgentLoading,
      isCreatingAgentLoading:
          isCreatingAgentLoading ?? this.isCreatingAgentLoading,
      isUpdatingAgentLoading:
          isUpdatingAgentLoading ?? this.isUpdatingAgentLoading,
      isDeletingAgentLoading:
          isDeletingAgentLoading ?? this.isDeletingAgentLoading,
      agents: agents ?? this.agents,
      failure: failure ?? this.failure,
      agent: agent ?? this.agent,
    );
  }
}