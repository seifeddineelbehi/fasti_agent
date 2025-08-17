import 'package:dartz/dartz.dart';
import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:fasti_dashboard/features/auth/data/model/admin_model.dart';

abstract class DriversRepository {
  Future<Either<Failure, List<UserModel>>> getAllDrivers();
  Future<Either<Failure, UserModel>> getDriverById({required String driverId});
  Future<Either<Failure, UserModel>> approveDriver({required String driverId});
  Future<Either<Failure, UserModel>> banDriver({required String driverId});
  Future<Either<Failure, UserModel>> payAllWalletTrips(
      {required UserModel driver});
  Future<Either<Failure, UserModel>> rechargeDriverWallet({
    required String driverId,
    required double amount,
  });

  Future<Either<Failure, AdminModel?>> getAdmin();
}
