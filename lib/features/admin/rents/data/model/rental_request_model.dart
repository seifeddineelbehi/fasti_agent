import 'package:fasti_dashboard/features/admin/cars/data/model/car_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rental_request_model.freezed.dart';
part 'rental_request_model.g.dart';

@freezed
class RentalRequestModel with _$RentalRequestModel {
  const factory RentalRequestModel({
    required String id,
    required CarModel car,
    required UserModel user,
    required String reservationDateStart,
    required String reservationDateEnd,
    required int numberOfDays,
    required String rentTime,
    required double totalCost,
    required String submittedAt,
    @Default(false) bool withDriver,
    required String status,
  }) = _RentalRequestModel;

  factory RentalRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RentalRequestModelFromJson(json);
}

extension RentalRequestModelFirestore on RentalRequestModel {
  Map<String, dynamic> toJsonForFirestore() {
    return {
      'id': id,
      'car': car.toJsonForFirestore(),
      'user': user.toJsonForFirestore(),
      'reservationDateStart': reservationDateStart,
      'reservationDateEnd': reservationDateEnd,
      'rentTime': rentTime,
      'numberOfDays': numberOfDays,
      'submittedAt': submittedAt,
      'withDriver': withDriver,
      'status': status
    };
  }
}
