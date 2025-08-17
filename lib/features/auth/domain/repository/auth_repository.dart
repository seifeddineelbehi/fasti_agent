import 'package:dartz/dartz.dart';
import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';

// Add these methods to your existing AgentsRepositoryImpl
abstract class AuthRepository {
  // ... existing methods ...

  // Agent authentication methods
  Future<Either<Failure, AgentModel?>> loginAgent({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signOutAgent();

  Future<Either<Failure, AgentModel?>> getCurrentAgent();

  Future<bool> isAgentLoggedIn();
}
