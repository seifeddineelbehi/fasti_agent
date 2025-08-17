import 'package:dartz/dartz.dart';
import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/core/network/network_info.dart';
import 'package:fasti_dashboard/features/admin/cars/data/data_source/cars_remote_data_source.dart';
import 'package:fasti_dashboard/features/admin/cars/data/model/car_model.dart';
import 'package:fasti_dashboard/features/admin/cars/domain/repositories/cars_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class CarsRepositoryImpl implements CarsRepository {
  final CarsRemoteDataSource remoteDataSource;
  final NetworkInfoImpl networkInfoImpl;
  CarsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfoImpl,
  });

  @override
  Future<Either<Failure, List<CarModel>>> getAllCars() async {
    try {
      final user = await remoteDataSource.getAllCars();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Get all users failed'));
    } catch (e, s) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CarModel>> getCarById({required String carId}) async {
    try {
      final user = await remoteDataSource.getCarById(carId: carId);
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
  Future<Either<Failure, CarModel>> createCar({required CarModel car}) async {
    try {
      final createdCar = await remoteDataSource.createCar(car: car);
      return Right(createdCar);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Create car failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CarModel>> toggleCarAvailability(
      {required String carId}) async {
    try {
      final updatedCar =
          await remoteDataSource.toggleCarAvailability(carId: carId);
      if (updatedCar == null) {
        return Left(Failure.auth('Toggle car availability failed'));
      } else {
        return Right(updatedCar);
      }
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Toggle car availability failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }
}
