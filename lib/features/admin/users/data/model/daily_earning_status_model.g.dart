// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_earning_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyEarningStatusModelImpl _$$DailyEarningStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyEarningStatusModelImpl(
      date: json['date'] as String,
      amount: (json['amount'] as num).toDouble(),
      isPaid: json['isPaid'] as bool? ?? false,
      payoutMethod: json['payoutMethod'] as String?,
      transactionReference: json['transactionReference'] as String?,
    );

Map<String, dynamic> _$$DailyEarningStatusModelImplToJson(
        _$DailyEarningStatusModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'amount': instance.amount,
      'isPaid': instance.isPaid,
      'payoutMethod': instance.payoutMethod,
      'transactionReference': instance.transactionReference,
    };
