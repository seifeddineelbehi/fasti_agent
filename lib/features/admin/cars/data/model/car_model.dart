import 'package:fasti_dashboard/features/admin/cars/data/model/rental_period_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'car_model.freezed.dart';
part 'car_model.g.dart';

@freezed
class CarModel with _$CarModel {
  const factory CarModel({
    required String id,
    required String brand,
    required String model,
    required String type,
    required int seats,
    required List<String> imageUrl,
    required double pricePerDay,
    @Default(true) bool isAvailable,
    @Default([]) List<RentalPeriodModel> rentalPeriods,
  }) = _CarModel;

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
}

extension TripModelFirestore on CarModel {
  Map<String, dynamic> toJsonForFirestore() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'type': type,
      'seats': seats,
      'imageUrl': imageUrl,
      'pricePerDay': pricePerDay,
      'isAvailable': isAvailable,
      'rentalPeriods':
          rentalPeriods.map((t) => t.toJsonForFirestore()).toList(),
    };
  }
}
