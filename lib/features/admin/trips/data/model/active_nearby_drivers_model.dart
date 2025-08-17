import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_nearby_drivers_model.freezed.dart';
part 'active_nearby_drivers_model.g.dart';

@freezed
class ActiveNearByDriversModel with _$ActiveNearByDriversModel {
  const factory ActiveNearByDriversModel({
    String? driverId,
    double? latitude,
    double? longitude,
    @Default(0.0) double distanceFromUser,
  }) = _ActiveNearByDriversModel;

  factory ActiveNearByDriversModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveNearByDriversModelFromJson(json);
}
