import 'package:dartz/dartz.dart';
import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/core/network/network_info.dart';
import 'package:fasti_dashboard/features/admin/users/data/data_source/users_remote_data_source.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:fasti_dashboard/features/admin/users/domain/repositories/users_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;
  final NetworkInfoImpl networkInfoImpl;
  UsersRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfoImpl,
  });

  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    try {
      final user = await remoteDataSource.getAllUsers();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Get all users failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserById(
      {required String userId}) async {
    try {
      final user = await remoteDataSource.getUserById(userId: userId);
      if (user == null) {
        return Left(Failure.auth('Get driver failed'));
      } else {
        return Right(user);
      }
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Get driver failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> rechargeUserWallet({
    required String userId,
    required double amount,
  }) async {
    try {
      final user = await remoteDataSource.rechargeUserWallet(
          userId: userId, amount: amount);
      if (user == null) {
        return Left(Failure.auth('Get driver failed'));
      } else {
        return Right(user);
      }
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Get driver failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> banUser({
    required String userId,
  }) async {
    try {
      final user = await remoteDataSource.banUser(userId: userId);
      if (user == null) {
        return Left(Failure.auth('Get driver failed'));
      } else {
        return Right(user);
      }
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Get driver failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }
}
