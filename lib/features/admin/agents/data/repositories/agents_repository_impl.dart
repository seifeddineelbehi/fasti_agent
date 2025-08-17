import 'package:dartz/dartz.dart';
import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/core/network/network_info.dart';
import 'package:fasti_dashboard/features/admin/agents/data/data_source/agents_remote_data_source.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/create_agent_request_model.dart';
import 'package:fasti_dashboard/features/admin/agents/domain/repositories/agents_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class AgentsRepositoryImpl implements AgentsRepository {
  final AgentsRemoteDataSource remoteDataSource;
  final NetworkInfoImpl networkInfoImpl;

  AgentsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfoImpl,
  });

  @override
  Future<Either<Failure, List<AgentModel>>> getAllAgents() async {
    try {
      final agents = await remoteDataSource.getAllAgents();
      return Right(agents);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Get all agents failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AgentModel>> getAgentById({
    required String agentId,
  }) async {
    try {
      final agent = await remoteDataSource.getAgentById(agentId: agentId);
      if (agent == null) {
        return Left(Failure.auth('Agent not found'));
      } else {
        return Right(agent);
      }
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Get agent failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AgentModel>> createAgent({
    required CreateAgentRequestModel request,
  }) async {
    try {
      final agent = await remoteDataSource.createAgent(request: request);
      return Right(agent);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Create agent failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AgentModel>> updateAgent({
    required String agentId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      final agent = await remoteDataSource.updateAgent(
          agentId: agentId, updates: updates);
      if (agent == null) {
        return Left(Failure.auth('Update agent failed'));
      } else {
        return Right(agent);
      }
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Update agent failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AgentModel>> toggleAgentStatus({
    required String agentId,
  }) async {
    try {
      final agent = await remoteDataSource.toggleAgentStatus(agentId: agentId);
      if (agent == null) {
        return Left(Failure.auth('Toggle agent status failed'));
      } else {
        return Right(agent);
      }
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Toggle agent status failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAgent({required String agentId}) async {
    try {
      final success = await remoteDataSource.deleteAgent(agentId: agentId);
      return Right(success);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Delete agent failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AgentModel>> updateAgentPermissions({
    required String agentId,
    required List<String> permissions,
  }) async {
    try {
      final agent = await remoteDataSource.updateAgentPermissions(
          agentId: agentId, permissions: permissions);
      if (agent == null) {
        return Left(Failure.auth('Update agent permissions failed'));
      } else {
        return Right(agent);
      }
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Update agent permissions failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }
}
