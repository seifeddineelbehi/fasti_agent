import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_rating_model.freezed.dart';
part 'user_rating_model.g.dart';

@freezed
class UserRatingModel with _$UserRatingModel {
  const factory UserRatingModel({
    required UserModel user,
    required double ratingGiven,
  }) = _UserRatingModel;

  factory UserRatingModel.fromJson(Map<String, dynamic> json) =>
      _$UserRatingModelFromJson(json);
}

extension UserRatingModelFirestore on UserRatingModel {
  Map<String, dynamic> toJsonForFirestore() {
    final json = <String, dynamic>{
      'ratingGiven': ratingGiven,
    };

    json['user'] = user.toJsonForFirestore();

    return json;
  }
}
