import 'package:fasti_dashboard/core/providers/providers.dart';
import 'package:fasti_dashboard/features/admin/cars/data/model/car_model.dart';
import 'package:fasti_dashboard/features/admin/cars/presentation/riverpod/cars_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarsNotifier extends StateNotifier<CarsState> {
  final Ref ref;

  CarsNotifier(this.ref) : super(const CarsState());

  Future<void> getAllCars() async {
    state = state.copyWith(failure: null, isGettingAllCarsLoading: true);
    final result = await ref.read(carsRepositoryProvider).getAllCars();

    result.fold(
      (failure) {
        state = state.copyWith(
            failure: failure, isGettingAllCarsLoading: false, cars: []);
      },
      (cars) async {
        state = state.copyWith(cars: cars, isGettingAllCarsLoading: false);
      },
    );
  }

  Future<void> getCarById({required String carId}) async {
    state = state.copyWith(failure: null, isGettingCarLoading: true);
    final result =
        await ref.read(carsRepositoryProvider).getCarById(carId: carId);

    result.fold(
      (failure) {
        state = state
            .copyWith(failure: failure, isGettingCarLoading: false, cars: []);
      },
      (car) async {
        state = state.copyWith(car: car, isGettingCarLoading: false);
      },
    );
  }

  Future<void> createCar({required CarModel car}) async {
    state = state.copyWith(failure: null, isCreatingCarLoading: true);
    final result = await ref.read(carsRepositoryProvider).createCar(car: car);

    result.fold(
      (failure) {
        state = state.copyWith(failure: failure, isCreatingCarLoading: false);
      },
      (createdCar) async {
        // Add the new car to the existing list
        final currentCars = List<CarModel>.from(state.cars ?? []);
        currentCars.add(createdCar);
        state = state.copyWith(
          cars: currentCars,
          isCreatingCarLoading: false,
        );
      },
    );
  }

  Future<void> toggleCarAvailability({required String carId}) async {
    state = state.copyWith(failure: null);
    final result = await ref
        .read(carsRepositoryProvider)
        .toggleCarAvailability(carId: carId);

    result.fold(
      (failure) {
        state = state.copyWith(failure: failure);
      },
      (updatedCar) async {
        // Update the car in the list
        final currentCars = List<CarModel>.from(state.cars ?? []);
        final index = currentCars.indexWhere((car) => car.id == carId);
        if (index != -1) {
          currentCars[index] = updatedCar;
          state = state.copyWith(cars: currentCars);
        }
      },
    );
  }
}

final carsNotifierProvider =
    StateNotifierProvider<CarsNotifier, CarsState>((ref) {
  return CarsNotifier(ref);
});
