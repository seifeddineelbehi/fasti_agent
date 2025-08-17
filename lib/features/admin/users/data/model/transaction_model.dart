import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required String type, // "sent", "received", "topup", etc.
    required double amount,
    required DateTime timestamp,

    // Who initiated the transaction (could be the user or 'admin')
    required String fromUserId,
    String? fromUserName,
    String? fromUserPhone,

    // Who received the transaction
    required String toUserId,
    String? toUserName,
    String? toUserPhone,
    String? note, // Optional note for reference
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}

extension TransactionModelFirestore on TransactionModel {
  Map<String, dynamic> toJsonForFirestore() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
      'fromUserId': fromUserId,
      'fromUserName': fromUserName,
      'fromUserPhone': fromUserPhone,
      'toUserId': toUserId,
      'toUserName': toUserName,
      'toUserPhone': toUserPhone,
      'note': note,
    };
  }
}
