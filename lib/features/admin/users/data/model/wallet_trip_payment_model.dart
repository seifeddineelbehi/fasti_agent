import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_trip_payment_model.freezed.dart';
part 'wallet_trip_payment_model.g.dart';

@freezed
class WalletTripPaymentModel with _$WalletTripPaymentModel {
  const factory WalletTripPaymentModel({
    required String userId,
    required String userFullName,
    required String tripId,
    required double amount,
    required String date, // yyyy-MM-dd
    @Default(false) bool isPaidByAdmin,
  }) = _WalletTripPaymentModel;

  factory WalletTripPaymentModel.fromJson(Map<String, dynamic> json) =>
      _$WalletTripPaymentModelFromJson(json);
}

extension WalletTripPaymentModelFirestore on WalletTripPaymentModel {
  Map<String, dynamic> toJsonForFirestore() {
    return {
      'userId': userId,
      'userFullName': userFullName,
      'tripId': tripId,
      'amount': amount,
      'date': date,
      'isPaidByAdmin': isPaidByAdmin,
    };
  }
}
