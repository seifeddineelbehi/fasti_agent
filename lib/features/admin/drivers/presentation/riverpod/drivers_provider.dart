import 'package:fasti_dashboard/core/providers/providers.dart';
import 'package:fasti_dashboard/features/admin/drivers/presentation/riverpod/drivers_state.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DriversNotifier extends StateNotifier<DriversState> {
  final Ref ref;

  DriversNotifier(this.ref) : super(const DriversState());

  Future<void> getAllDrivers() async {
    state = state.copyWith(failure: null, isGettingAllDriversLoading: true);
    final result = await ref.read(driversRepositoryProvider).getAllDrivers();

    result.fold(
      (failure) {
        state = state.copyWith(
            failure: failure, isGettingAllDriversLoading: false, drivers: []);
      },
      (drivers) async {
        state =
            state.copyWith(drivers: drivers, isGettingAllDriversLoading: false);
      },
    );
  }

  Future<void> getDriverById({required String driverId}) async {
    state = state.copyWith(failure: null, isGettingDriverLoading: true);
    final result = await ref
        .read(driversRepositoryProvider)
        .getDriverById(driverId: driverId);

    result.fold(
      (failure) {
        state = state.copyWith(
            failure: failure, isGettingDriverLoading: false, drivers: []);
      },
      (driver) async {
        state = state.copyWith(driver: driver, isGettingDriverLoading: false);
      },
    );
  }

  Future<void> rechargeDriverWallet({
    required String driverId,
    required double amount,
  }) async {
    state = state.copyWith(failure: null, isGettingDriverLoading: true);
    final result = await ref
        .read(driversRepositoryProvider)
        .rechargeDriverWallet(driverId: driverId, amount: amount);

    result.fold(
      (failure) {
        state = state.copyWith(
            failure: failure, isGettingDriverLoading: false, drivers: []);
      },
      (driver) async {
        List<UserModel> drivers = state.drivers!;

        final index = drivers.indexWhere((element) => element.id == driver.id);
        if (index != -1) {
          drivers[index] = driver;
        }

        state = state.copyWith(drivers: drivers, isGettingDriverLoading: false);
      },
    );
  }

  Future<void> approveDriver({
    required String driverId,
  }) async {
    state = state.copyWith(failure: null, isGettingDriverLoading: true);
    final result = await ref
        .read(driversRepositoryProvider)
        .approveDriver(driverId: driverId);

    result.fold(
      (failure) {
        state = state.copyWith(
            failure: failure, isGettingDriverLoading: false, drivers: []);
      },
      (driver) async {
        List<UserModel> drivers = state.drivers!;

        final index = drivers.indexWhere((element) => element.id == driver.id);
        if (index != -1) {
          drivers[index] = driver;
        }

        state = state.copyWith(drivers: drivers, isGettingDriverLoading: false);
      },
    );
  }

  Future<void> banDriver({
    required String driverId,
  }) async {
    state = state.copyWith(failure: null, isGettingDriverLoading: true);
    final result =
        await ref.read(driversRepositoryProvider).banDriver(driverId: driverId);

    result.fold(
      (failure) {
        state = state.copyWith(
            failure: failure, isGettingDriverLoading: false, drivers: []);
      },
      (driver) async {
        List<UserModel> drivers = state.drivers!;

        final index = drivers.indexWhere((element) => element.id == driver.id);
        if (index != -1) {
          drivers[index] = driver;
        }

        state = state.copyWith(drivers: drivers, isGettingDriverLoading: false);
      },
    );
  }

  Future<void> payAllWalletTrips() async {
    state = state.copyWith(failure: null, isGettingDriverLoading: true);
    final updatedPayments =
        state.driver!.driverInfo!.walletTripPayments.map((payment) {
      if (!payment.isPaidByAdmin) {
        return payment.copyWith(isPaidByAdmin: true);
      }
      return payment;
    }).toList();

    final driver = state.driver!.copyWith(
      driverInfo: state.driver!.driverInfo!.copyWith(
        walletTripPayments: updatedPayments,
      ),
    );
    final result = await ref
        .read(driversRepositoryProvider)
        .payAllWalletTrips(driver: driver);

    result.fold(
      (failure) {
        state = state.copyWith(
            failure: failure, isGettingDriverLoading: false, drivers: []);
      },
      (driver) async {
        state = state.copyWith(driver: driver, isGettingDriverLoading: false);
      },
    );
  }

  Future<void> payWalletTrip(String tripId) async {
    state = state.copyWith(failure: null, isGettingDriverLoading: true);
    final updatedPayments =
        state.driver!.driverInfo!.walletTripPayments.map((payment) {
      if (payment.tripId == tripId) {
        return payment.copyWith(isPaidByAdmin: true);
      }
      return payment;
    }).toList();

    final driver = state.driver!.copyWith(
      driverInfo: state.driver!.driverInfo!.copyWith(
        walletTripPayments: updatedPayments,
      ),
    );
    final result = await ref
        .read(driversRepositoryProvider)
        .payAllWalletTrips(driver: driver);

    result.fold(
      (failure) {
        state = state.copyWith(
            failure: failure, isGettingDriverLoading: false, drivers: []);
      },
      (driver) async {
        state = state.copyWith(driver: driver, isGettingDriverLoading: false);
      },
    );
  }

  Future<void> fetchAdminData() async {
    final result = await ref.read(driversRepositoryProvider).getAdmin();

    await result.fold(
      (failure) {
        state = state.copyWith(failure: failure);
      },
      (data) async {
        if (data != null) {
          state = state.copyWith(adminModel: data);
        }
      },
    );
  }
}

final driversNotifierProvider =
    StateNotifierProvider<DriversNotifier, DriversState>((ref) {
  return DriversNotifier(ref);
});
