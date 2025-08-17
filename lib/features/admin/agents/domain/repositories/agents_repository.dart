import 'package:dartz/dartz.dart';
import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/create_agent_request_model.dart';

abstract class AgentsRepository {
  Future<Either<Failure, List<AgentModel>>> getAllAgents();
  Future<Either<Failure, AgentModel>> getAgentById({required String agentId});
  Future<Either<Failure, AgentModel>> createAgent({
    required CreateAgentRequestModel request,
  });
  Future<Either<Failure, AgentModel>> updateAgent({
    required String agentId,
    required Map<String, dynamic> updates,
  });
  Future<Either<Failure, AgentModel>> toggleAgentStatus({
    required String agentId,
  });
  Future<Either<Failure, bool>> deleteAgent({required String agentId});
  Future<Either<Failure, AgentModel>> updateAgentPermissions({
    required String agentId,
    required List<String> permissions,
  });
}