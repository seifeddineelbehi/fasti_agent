import 'package:fasti_dashboard/features/auth/data/model/admin_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

@freezed
class AuthUserModel with _$AuthUserModel {
  const factory AuthUserModel({
    required String uid,
    required String email,
    required bool isVerified,
    AdminModel? admin,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);

  factory AuthUserModel.fromFirebaseUser(User user, {AdminModel? admin}) {
    return AuthUserModel(
      uid: user.uid,
      email: user.email ?? '',
      isVerified: user.emailVerified,
      admin: admin,
    );
  }
}
