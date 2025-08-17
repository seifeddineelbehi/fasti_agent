import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rental_period_model.freezed.dart';
part 'rental_period_model.g.dart';

@freezed
class RentalPeriodModel with _$RentalPeriodModel {
  const factory RentalPeriodModel({
    required String start,
    required String end,
    required UserModel user,
  }) = _RentalPeriodModel;

  factory RentalPeriodModel.fromJson(Map<String, dynamic> json) =>
      _$RentalPeriodModelFromJson(json);
}

extension RentalPeriodModelFirestore on RentalPeriodModel {
  Map<String, dynamic> toJsonForFirestore() {
    return {
      'start': start,
      'end': end,
      'user': user.toJsonForFirestore(includeRentedCars: false),
    };
  }
}
