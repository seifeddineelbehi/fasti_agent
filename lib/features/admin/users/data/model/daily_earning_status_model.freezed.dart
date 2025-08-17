// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_earning_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyEarningStatusModel _$DailyEarningStatusModelFromJson(
    Map<String, dynamic> json) {
  return _DailyEarningStatusModel.fromJson(json);
}

/// @nodoc
mixin _$DailyEarningStatusModel {
  String get date => throw _privateConstructorUsedError; // yyyy-MM-dd
  double get amount => throw _privateConstructorUsedError;
  bool get isPaid =>
      throw _privateConstructorUsedError; // whether admin has been paid
  String? get payoutMethod =>
      throw _privateConstructorUsedError; // if paid, how (bank, cash, etc.)
  String? get transactionReference => throw _privateConstructorUsedError;

  /// Serializes this DailyEarningStatusModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyEarningStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyEarningStatusModelCopyWith<DailyEarningStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyEarningStatusModelCopyWith<$Res> {
  factory $DailyEarningStatusModelCopyWith(DailyEarningStatusModel value,
          $Res Function(DailyEarningStatusModel) then) =
      _$DailyEarningStatusModelCopyWithImpl<$Res, DailyEarningStatusModel>;
  @useResult
  $Res call(
      {String date,
      double amount,
      bool isPaid,
      String? payoutMethod,
      String? transactionReference});
}

/// @nodoc
class _$DailyEarningStatusModelCopyWithImpl<$Res,
        $Val extends DailyEarningStatusModel>
    implements $DailyEarningStatusModelCopyWith<$Res> {
  _$DailyEarningStatusModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyEarningStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? amount = null,
    Object? isPaid = null,
    Object? payoutMethod = freezed,
    Object? transactionReference = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      payoutMethod: freezed == payoutMethod
          ? _value.payoutMethod
          : payoutMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionReference: freezed == transactionReference
          ? _value.transactionReference
          : transactionReference // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyEarningStatusModelImplCopyWith<$Res>
    implements $DailyEarningStatusModelCopyWith<$Res> {
  factory _$$DailyEarningStatusModelImplCopyWith(
          _$DailyEarningStatusModelImpl value,
          $Res Function(_$DailyEarningStatusModelImpl) then) =
      __$$DailyEarningStatusModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      double amount,
      bool isPaid,
      String? payoutMethod,
      String? transactionReference});
}

/// @nodoc
class __$$DailyEarningStatusModelImplCopyWithImpl<$Res>
    extends _$DailyEarningStatusModelCopyWithImpl<$Res,
        _$DailyEarningStatusModelImpl>
    implements _$$DailyEarningStatusModelImplCopyWith<$Res> {
  __$$DailyEarningStatusModelImplCopyWithImpl(
      _$DailyEarningStatusModelImpl _value,
      $Res Function(_$DailyEarningStatusModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyEarningStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? amount = null,
    Object? isPaid = null,
    Object? payoutMethod = freezed,
    Object? transactionReference = freezed,
  }) {
    return _then(_$DailyEarningStatusModelImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      payoutMethod: freezed == payoutMethod
          ? _value.payoutMethod
          : payoutMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionReference: freezed == transactionReference
          ? _value.transactionReference
          : transactionReference // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyEarningStatusModelImpl implements _DailyEarningStatusModel {
  const _$DailyEarningStatusModelImpl(
      {required this.date,
      required this.amount,
      this.isPaid = false,
      this.payoutMethod,
      this.transactionReference});

  factory _$DailyEarningStatusModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyEarningStatusModelImplFromJson(json);

  @override
  final String date;
// yyyy-MM-dd
  @override
  final double amount;
  @override
  @JsonKey()
  final bool isPaid;
// whether admin has been paid
  @override
  final String? payoutMethod;
// if paid, how (bank, cash, etc.)
  @override
  final String? transactionReference;

  @override
  String toString() {
    return 'DailyEarningStatusModel(date: $date, amount: $amount, isPaid: $isPaid, payoutMethod: $payoutMethod, transactionReference: $transactionReference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyEarningStatusModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
            (identical(other.payoutMethod, payoutMethod) ||
                other.payoutMethod == payoutMethod) &&
            (identical(other.transactionReference, transactionReference) ||
                other.transactionReference == transactionReference));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, date, amount, isPaid, payoutMethod, transactionReference);

  /// Create a copy of DailyEarningStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyEarningStatusModelImplCopyWith<_$DailyEarningStatusModelImpl>
      get copyWith => __$$DailyEarningStatusModelImplCopyWithImpl<
          _$DailyEarningStatusModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyEarningStatusModelImplToJson(
      this,
    );
  }
}

abstract class _DailyEarningStatusModel implements DailyEarningStatusModel {
  const factory _DailyEarningStatusModel(
      {required final String date,
      required final double amount,
      final bool isPaid,
      final String? payoutMethod,
      final String? transactionReference}) = _$DailyEarningStatusModelImpl;

  factory _DailyEarningStatusModel.fromJson(Map<String, dynamic> json) =
      _$DailyEarningStatusModelImpl.fromJson;

  @override
  String get date; // yyyy-MM-dd
  @override
  double get amount;
  @override
  bool get isPaid; // whether admin has been paid
  @override
  String? get payoutMethod; // if paid, how (bank, cash, etc.)
  @override
  String? get transactionReference;

  /// Create a copy of DailyEarningStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyEarningStatusModelImplCopyWith<_$DailyEarningStatusModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
