import 'package:freezed_annotation/freezed_annotation.dart';

part 'directions_model.freezed.dart';
part 'directions_model.g.dart';

@freezed
class DirectionsModel with _$DirectionsModel {
  const factory DirectionsModel({
    String? humanReadableAddress,
    String? locationName,
    String? locationId,
    double? locationLatitude,
    double? locationLongitude,
  }) = _DirectionsModel;

  factory DirectionsModel.fromJson(Map<String, dynamic> json) =>
      _$DirectionsModelFromJson(json);
}
