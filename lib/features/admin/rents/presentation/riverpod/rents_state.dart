import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/features/admin/rents/data/model/rental_request_model.dart';

class RentsState {
  final bool isGettingAllRentsLoading;
  final bool isGettingRentLoading;

  final List<RentalRequestModel>? rents;
  final RentalRequestModel? rent;
  final Failure? failure;

  const RentsState({
    this.isGettingAllRentsLoading = false,
    this.isGettingRentLoading = false,
    this.rents = const [],
    this.rent,
    this.failure,
  });

  RentsState copyWith({
    bool? isGettingAllRentsLoading,
    bool? isGettingRentLoading,
    List<RentalRequestModel>? rents,
    RentalRequestModel? rent,
    bool? rentCanBeNull,
    Failure? failure,
  }) {
    return RentsState(
      isGettingAllRentsLoading:
          isGettingAllRentsLoading ?? this.isGettingAllRentsLoading,
      isGettingRentLoading: isGettingRentLoading ?? this.isGettingRentLoading,
      rents: rents ?? this.rents,
      failure: failure ?? this.failure,
      rent: rentCanBeNull != null ? null : rent ?? this.rent,
    );
  }
}
