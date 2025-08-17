import 'package:dartz/dartz.dart';
import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/features/admin/cars/data/model/car_model.dart';

abstract class CarsRepository {
  Future<Either<Failure, List<CarModel>>> getAllCars();
  Future<Either<Failure, CarModel>> getCarById({required String carId});
  Future<Either<Failure, CarModel>> createCar({required CarModel car});
  Future<Either<Failure, CarModel>> toggleCarAvailability(
      {required String carId});
}
