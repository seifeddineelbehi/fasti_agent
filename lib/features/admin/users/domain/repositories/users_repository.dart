import 'package:dartz/dartz.dart';
import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<UserModel>>> getAllUsers();
  Future<Either<Failure, UserModel>> getUserById({required String userId});
  Future<Either<Failure, UserModel>> banUser({required String userId});
  Future<Either<Failure, UserModel>> rechargeUserWallet({
    required String userId,
    required double amount,
  });
}
