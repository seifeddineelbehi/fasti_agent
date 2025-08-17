import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:fasti_dashboard/features/auth/data/model/admin_model.dart';

class DriversState {
  final bool isGettingAllDriversLoading;
  final bool isGettingDriverLoading;

  final List<UserModel>? drivers;
  final UserModel? driver;
  final Failure? failure;
  final AdminModel? adminModel;

  const DriversState({
    this.isGettingAllDriversLoading = false,
    this.isGettingDriverLoading = false,
    this.drivers = const [],
    this.driver,
    this.failure,
    this.adminModel,
  });

  DriversState copyWith({
    bool? isGettingAllDriversLoading,
    bool? isGettingDriverLoading,
    List<UserModel>? drivers,
    UserModel? driver,
    bool? driverCanBeNull,
    Failure? failure,
    AdminModel? adminModel,
  }) {
    return DriversState(
      isGettingAllDriversLoading:
          isGettingAllDriversLoading ?? this.isGettingAllDriversLoading,
      isGettingDriverLoading:
          isGettingDriverLoading ?? this.isGettingDriverLoading,
      drivers: drivers ?? this.drivers,
      adminModel: adminModel ?? this.adminModel,
      failure: failure ?? this.failure,
      driver: driverCanBeNull != null ? null : driver ?? this.driver,
    );
  }
}
