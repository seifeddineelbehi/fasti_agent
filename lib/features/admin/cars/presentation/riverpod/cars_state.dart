import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/features/admin/cars/data/model/car_model.dart';

class CarsState {
  final bool isGettingAllCarsLoading;
  final bool isGettingCarLoading;
  final bool isCreatingCarLoading;

  final List<CarModel>? cars;
  final CarModel? car;
  final Failure? failure;

  const CarsState({
    this.isGettingAllCarsLoading = false,
    this.isGettingCarLoading = false,
    this.isCreatingCarLoading = false,
    this.cars = const [],
    this.car,
    this.failure,
  });

  CarsState copyWith({
    bool? isGettingAllCarsLoading,
    bool? isGettingCarLoading,
    bool? isCreatingCarLoading,
    List<CarModel>? cars,
    CarModel? car,
    bool? carCanBeNull,
    Failure? failure,
  }) {
    return CarsState(
      isGettingAllCarsLoading:
          isGettingAllCarsLoading ?? this.isGettingAllCarsLoading,
      isGettingCarLoading: isGettingCarLoading ?? this.isGettingCarLoading,
      isCreatingCarLoading: isCreatingCarLoading ?? this.isCreatingCarLoading,
      cars: cars ?? this.cars,
      failure: failure ?? this.failure,
      car: carCanBeNull != null ? null : car ?? this.car,
    );
  }
}
