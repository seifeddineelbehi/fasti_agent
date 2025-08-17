// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_trip_payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletTripPaymentModelImpl _$$WalletTripPaymentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WalletTripPaymentModelImpl(
      userId: json['userId'] as String,
      userFullName: json['userFullName'] as String,
      tripId: json['tripId'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: json['date'] as String,
      isPaidByAdmin: json['isPaidByAdmin'] as bool? ?? false,
    );

Map<String, dynamic> _$$WalletTripPaymentModelImplToJson(
        _$WalletTripPaymentModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userFullName': instance.userFullName,
      'tripId': instance.tripId,
      'amount': instance.amount,
      'date': instance.date,
      'isPaidByAdmin': instance.isPaidByAdmin,
    };
