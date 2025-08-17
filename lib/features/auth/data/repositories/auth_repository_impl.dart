import 'package:dartz/dartz.dart';
import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/core/network/network_info.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';
import 'package:fasti_dashboard/features/auth/data/data_source/auth_cached_data_source.dart';
import 'package:fasti_dashboard/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:fasti_dashboard/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthCachedDataSource localCachedSource;
  final NetworkInfoImpl networkInfoImpl;
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localCachedSource,
    required this.networkInfoImpl,
  });
  @override
  Future<Either<Failure, AgentModel?>> loginAgent({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in with Firebase Auth
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // Get agent data from Firestore
        final agent = await remoteDataSource.getAgentById(credential.user!.uid);

        if (agent != null && agent.isActive) {
          // Cache the agent
          await localCachedSource.cacheAgent(agent);

          // Update last login
          await remoteDataSource.updateAgentLastLogin(agent.id);

          return Right(agent);
        } else {
          await FirebaseAuth.instance.signOut();
          return const Left(Failure.user('Agent not found or inactive'));
        }
      }

      return const Left(Failure.user('Login failed'));
    } on FirebaseAuthException catch (e) {
      String message = 'Login failed';
      switch (e.code) {
        case 'user-not-found':
          message = 'No account found with this email';
          break;
        case 'wrong-password':
          message = 'Incorrect password';
          break;
        case 'user-disabled':
          message = 'This account has been disabled';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        default:
          message = e.message ?? 'Login failed';
      }
      return Left(Failure.user(message));
    } catch (e) {
      return Left(Failure.user('Login failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> signOutAgent() async {
    try {
      await FirebaseAuth.instance.signOut();
      await localCachedSource.clearAgentCache();
      return const Right(null);
    } catch (e) {
      return Left(Failure.user('Sign out failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AgentModel?>> getCurrentAgent() async {
    try {
      // Try to get from cache first
      final cachedAgent = await localCachedSource.getCachedAgent();
      if (cachedAgent != null) {
        return Right(cachedAgent);
      }

      // If not in cache, check if user is signed in and get from Firestore
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final agent = await remoteDataSource.getAgentById(currentUser.uid);
        if (agent != null && agent.isActive) {
          await localCachedSource.cacheAgent(agent);
          return Right(agent);
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(Failure.user('Failed to get current agent: ${e.toString()}'));
    }
  }

  @override
  Future<bool> isAgentLoggedIn() async {
    try {
      // Check cache first
      final isLoggedInFromCache = await localCachedSource.isAgentLoggedIn();
      if (!isLoggedInFromCache) return false;

      // Verify with Firebase Auth
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        // Clear cache if Firebase user is null
        await localCachedSource.clearAgentCache();
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
