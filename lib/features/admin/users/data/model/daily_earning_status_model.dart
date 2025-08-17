import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_earning_status_model.freezed.dart';
part 'daily_earning_status_model.g.dart';

@freezed
class DailyEarningStatusModel with _$DailyEarningStatusModel {
  const factory DailyEarningStatusModel({
    required String date, // yyyy-MM-dd
    required double amount,
    @Default(false) bool isPaid, // whether admin has been paid
    String? payoutMethod, // if paid, how (bank, cash, etc.)
    String? transactionReference,
  }) = _DailyEarningStatusModel;

  factory DailyEarningStatusModel.fromJson(Map<String, dynamic> json) =>
      _$DailyEarningStatusModelFromJson(json);
}

extension DriverInfoModelFirestore on DailyEarningStatusModel {
  Map<String, dynamic> toJsonForFirestore() {
    return {
      'date': date,
      'amount': amount,
      'isPaid': isPaid,
      'payoutMethod': payoutMethod,
      'transactionReference': transactionReference,
    };
  }
}
