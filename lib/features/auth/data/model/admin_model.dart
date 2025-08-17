import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_model.freezed.dart';
part 'admin_model.g.dart';

@freezed
class AdminModel with _$AdminModel {
  const factory AdminModel({
    required String id,
    required double kmPrice,
    required double stopOverMinPrice,
    required int luxuryPricePercentage,
    required int luxurySuvPricePercentage,
    required int companyPercentage,
    required int userPointsPercentage,
    required int pointValueInMru,
    required double lessThenTwoKPrice,
    required String userName,
  }) = _AdminModel;

  factory AdminModel.fromJson(Map<String, dynamic> json) =>
      _$AdminModelFromJson(json);
}
