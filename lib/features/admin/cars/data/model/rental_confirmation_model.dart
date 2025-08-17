import 'package:fasti_dashboard/features/admin/cars/data/model/car_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rental_confirmation_model.freezed.dart';
part 'rental_confirmation_model.g.dart';

@freezed
class RentalConfirmationModel with _$RentalConfirmationModel {
  const factory RentalConfirmationModel({
    required String reservationId,
    required String status,
    required CarModel car,
    required String reservationDateStart,
    required String reservationDateEnd,
    required String rentTime,
    required int numberOfDays,
    required bool withDriver,
    required double totalCost,
    required String submittedAt,
  }) = _RentalConfirmationModel;

  factory RentalConfirmationModel.fromJson(Map<String, dynamic> json) =>
      _$RentalConfirmationModelFromJson(json);
}

extension RentalConfirmationModelFirestore on RentalConfirmationModel {
  Map<String, dynamic> toJsonForFirestore() {
    return {
      'reservationId': reservationId,
      'status': status,
      'car': car.toJsonForFirestore(),
      'reservationDateStart': reservationDateStart,
      'reservationDateEnd': reservationDateEnd,
      'rentTime': rentTime,
      'numberOfDays': numberOfDays,
      'withDriver': withDriver,
      'totalCost': totalCost,
      'submittedAt': submittedAt,
    };
  }
}
