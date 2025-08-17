// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return _TransactionModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionModel {
  String get id => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // "sent", "received", "topup", etc.
  double get amount => throw _privateConstructorUsedError;
  DateTime get timestamp =>
      throw _privateConstructorUsedError; // Who initiated the transaction (could be the user or 'admin')
  String get fromUserId => throw _privateConstructorUsedError;
  String? get fromUserName => throw _privateConstructorUsedError;
  String? get fromUserPhone =>
      throw _privateConstructorUsedError; // Who received the transaction
  String get toUserId => throw _privateConstructorUsedError;
  String? get toUserName => throw _privateConstructorUsedError;
  String? get toUserPhone => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionModelCopyWith<TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionModelCopyWith<$Res> {
  factory $TransactionModelCopyWith(
          TransactionModel value, $Res Function(TransactionModel) then) =
      _$TransactionModelCopyWithImpl<$Res, TransactionModel>;
  @useResult
  $Res call(
      {String id,
      String type,
      double amount,
      DateTime timestamp,
      String fromUserId,
      String? fromUserName,
      String? fromUserPhone,
      String toUserId,
      String? toUserName,
      String? toUserPhone,
      String? note});
}

/// @nodoc
class _$TransactionModelCopyWithImpl<$Res, $Val extends TransactionModel>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? amount = null,
    Object? timestamp = null,
    Object? fromUserId = null,
    Object? fromUserName = freezed,
    Object? fromUserPhone = freezed,
    Object? toUserId = null,
    Object? toUserName = freezed,
    Object? toUserPhone = freezed,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fromUserId: null == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String,
      fromUserName: freezed == fromUserName
          ? _value.fromUserName
          : fromUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      fromUserPhone: freezed == fromUserPhone
          ? _value.fromUserPhone
          : fromUserPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      toUserId: null == toUserId
          ? _value.toUserId
          : toUserId // ignore: cast_nullable_to_non_nullable
              as String,
      toUserName: freezed == toUserName
          ? _value.toUserName
          : toUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      toUserPhone: freezed == toUserPhone
          ? _value.toUserPhone
          : toUserPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionModelImplCopyWith<$Res>
    implements $TransactionModelCopyWith<$Res> {
  factory _$$TransactionModelImplCopyWith(_$TransactionModelImpl value,
          $Res Function(_$TransactionModelImpl) then) =
      __$$TransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      double amount,
      DateTime timestamp,
      String fromUserId,
      String? fromUserName,
      String? fromUserPhone,
      String toUserId,
      String? toUserName,
      String? toUserPhone,
      String? note});
}

/// @nodoc
class __$$TransactionModelImplCopyWithImpl<$Res>
    extends _$TransactionModelCopyWithImpl<$Res, _$TransactionModelImpl>
    implements _$$TransactionModelImplCopyWith<$Res> {
  __$$TransactionModelImplCopyWithImpl(_$TransactionModelImpl _value,
      $Res Function(_$TransactionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? amount = null,
    Object? timestamp = null,
    Object? fromUserId = null,
    Object? fromUserName = freezed,
    Object? fromUserPhone = freezed,
    Object? toUserId = null,
    Object? toUserName = freezed,
    Object? toUserPhone = freezed,
    Object? note = freezed,
  }) {
    return _then(_$TransactionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fromUserId: null == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String,
      fromUserName: freezed == fromUserName
          ? _value.fromUserName
          : fromUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      fromUserPhone: freezed == fromUserPhone
          ? _value.fromUserPhone
          : fromUserPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      toUserId: null == toUserId
          ? _value.toUserId
          : toUserId // ignore: cast_nullable_to_non_nullable
              as String,
      toUserName: freezed == toUserName
          ? _value.toUserName
          : toUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      toUserPhone: freezed == toUserPhone
          ? _value.toUserPhone
          : toUserPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionModelImpl implements _TransactionModel {
  const _$TransactionModelImpl(
      {required this.id,
      required this.type,
      required this.amount,
      required this.timestamp,
      required this.fromUserId,
      this.fromUserName,
      this.fromUserPhone,
      required this.toUserId,
      this.toUserName,
      this.toUserPhone,
      this.note});

  factory _$TransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
// "sent", "received", "topup", etc.
  @override
  final double amount;
  @override
  final DateTime timestamp;
// Who initiated the transaction (could be the user or 'admin')
  @override
  final String fromUserId;
  @override
  final String? fromUserName;
  @override
  final String? fromUserPhone;
// Who received the transaction
  @override
  final String toUserId;
  @override
  final String? toUserName;
  @override
  final String? toUserPhone;
  @override
  final String? note;

  @override
  String toString() {
    return 'TransactionModel(id: $id, type: $type, amount: $amount, timestamp: $timestamp, fromUserId: $fromUserId, fromUserName: $fromUserName, fromUserPhone: $fromUserPhone, toUserId: $toUserId, toUserName: $toUserName, toUserPhone: $toUserPhone, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.fromUserId, fromUserId) ||
                other.fromUserId == fromUserId) &&
            (identical(other.fromUserName, fromUserName) ||
                other.fromUserName == fromUserName) &&
            (identical(other.fromUserPhone, fromUserPhone) ||
                other.fromUserPhone == fromUserPhone) &&
            (identical(other.toUserId, toUserId) ||
                other.toUserId == toUserId) &&
            (identical(other.toUserName, toUserName) ||
                other.toUserName == toUserName) &&
            (identical(other.toUserPhone, toUserPhone) ||
                other.toUserPhone == toUserPhone) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      amount,
      timestamp,
      fromUserId,
      fromUserName,
      fromUserPhone,
      toUserId,
      toUserName,
      toUserPhone,
      note);

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      __$$TransactionModelImplCopyWithImpl<_$TransactionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionModelImplToJson(
      this,
    );
  }
}

abstract class _TransactionModel implements TransactionModel {
  const factory _TransactionModel(
      {required final String id,
      required final String type,
      required final double amount,
      required final DateTime timestamp,
      required final String fromUserId,
      final String? fromUserName,
      final String? fromUserPhone,
      required final String toUserId,
      final String? toUserName,
      final String? toUserPhone,
      final String? note}) = _$TransactionModelImpl;

  factory _TransactionModel.fromJson(Map<String, dynamic> json) =
      _$TransactionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get type; // "sent", "received", "topup", etc.
  @override
  double get amount;
  @override
  DateTime
      get timestamp; // Who initiated the transaction (could be the user or 'admin')
  @override
  String get fromUserId;
  @override
  String? get fromUserName;
  @override
  String? get fromUserPhone; // Who received the transaction
  @override
  String get toUserId;
  @override
  String? get toUserName;
  @override
  String? get toUserPhone;
  @override
  String? get note;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
