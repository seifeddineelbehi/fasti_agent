// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      fromUserId: json['fromUserId'] as String,
      fromUserName: json['fromUserName'] as String?,
      fromUserPhone: json['fromUserPhone'] as String?,
      toUserId: json['toUserId'] as String,
      toUserName: json['toUserName'] as String?,
      toUserPhone: json['toUserPhone'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'amount': instance.amount,
      'timestamp': instance.timestamp.toIso8601String(),
      'fromUserId': instance.fromUserId,
      'fromUserName': instance.fromUserName,
      'fromUserPhone': instance.fromUserPhone,
      'toUserId': instance.toUserId,
      'toUserName': instance.toUserName,
      'toUserPhone': instance.toUserPhone,
      'note': instance.note,
    };
