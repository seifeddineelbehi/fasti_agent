// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_trip_payment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WalletTripPaymentModel _$WalletTripPaymentModelFromJson(
    Map<String, dynamic> json) {
  return _WalletTripPaymentModel.fromJson(json);
}

/// @nodoc
mixin _$WalletTripPaymentModel {
  String get userId => throw _privateConstructorUsedError;
  String get userFullName => throw _privateConstructorUsedError;
  String get tripId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError; // yyyy-MM-dd
  bool get isPaidByAdmin => throw _privateConstructorUsedError;

  /// Serializes this WalletTripPaymentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletTripPaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletTripPaymentModelCopyWith<WalletTripPaymentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletTripPaymentModelCopyWith<$Res> {
  factory $WalletTripPaymentModelCopyWith(WalletTripPaymentModel value,
          $Res Function(WalletTripPaymentModel) then) =
      _$WalletTripPaymentModelCopyWithImpl<$Res, WalletTripPaymentModel>;
  @useResult
  $Res call(
      {String userId,
      String userFullName,
      String tripId,
      double amount,
      String date,
      bool isPaidByAdmin});
}

/// @nodoc
class _$WalletTripPaymentModelCopyWithImpl<$Res,
        $Val extends WalletTripPaymentModel>
    implements $WalletTripPaymentModelCopyWith<$Res> {
  _$WalletTripPaymentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletTripPaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userFullName = null,
    Object? tripId = null,
    Object? amount = null,
    Object? date = null,
    Object? isPaidByAdmin = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userFullName: null == userFullName
          ? _value.userFullName
          : userFullName // ignore: cast_nullable_to_non_nullable
              as String,
      tripId: null == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      isPaidByAdmin: null == isPaidByAdmin
          ? _value.isPaidByAdmin
          : isPaidByAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletTripPaymentModelImplCopyWith<$Res>
    implements $WalletTripPaymentModelCopyWith<$Res> {
  factory _$$WalletTripPaymentModelImplCopyWith(
          _$WalletTripPaymentModelImpl value,
          $Res Function(_$WalletTripPaymentModelImpl) then) =
      __$$WalletTripPaymentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String userFullName,
      String tripId,
      double amount,
      String date,
      bool isPaidByAdmin});
}

/// @nodoc
class __$$WalletTripPaymentModelImplCopyWithImpl<$Res>
    extends _$WalletTripPaymentModelCopyWithImpl<$Res,
        _$WalletTripPaymentModelImpl>
    implements _$$WalletTripPaymentModelImplCopyWith<$Res> {
  __$$WalletTripPaymentModelImplCopyWithImpl(
      _$WalletTripPaymentModelImpl _value,
      $Res Function(_$WalletTripPaymentModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletTripPaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userFullName = null,
    Object? tripId = null,
    Object? amount = null,
    Object? date = null,
    Object? isPaidByAdmin = null,
  }) {
    return _then(_$WalletTripPaymentModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userFullName: null == userFullName
          ? _value.userFullName
          : userFullName // ignore: cast_nullable_to_non_nullable
              as String,
      tripId: null == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      isPaidByAdmin: null == isPaidByAdmin
          ? _value.isPaidByAdmin
          : isPaidByAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletTripPaymentModelImpl implements _WalletTripPaymentModel {
  const _$WalletTripPaymentModelImpl(
      {required this.userId,
      required this.userFullName,
      required this.tripId,
      required this.amount,
      required this.date,
      this.isPaidByAdmin = false});

  factory _$WalletTripPaymentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletTripPaymentModelImplFromJson(json);

  @override
  final String userId;
  @override
  final String userFullName;
  @override
  final String tripId;
  @override
  final double amount;
  @override
  final String date;
// yyyy-MM-dd
  @override
  @JsonKey()
  final bool isPaidByAdmin;

  @override
  String toString() {
    return 'WalletTripPaymentModel(userId: $userId, userFullName: $userFullName, tripId: $tripId, amount: $amount, date: $date, isPaidByAdmin: $isPaidByAdmin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletTripPaymentModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userFullName, userFullName) ||
                other.userFullName == userFullName) &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isPaidByAdmin, isPaidByAdmin) ||
                other.isPaidByAdmin == isPaidByAdmin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, userId, userFullName, tripId, amount, date, isPaidByAdmin);

  /// Create a copy of WalletTripPaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletTripPaymentModelImplCopyWith<_$WalletTripPaymentModelImpl>
      get copyWith => __$$WalletTripPaymentModelImplCopyWithImpl<
          _$WalletTripPaymentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletTripPaymentModelImplToJson(
      this,
    );
  }
}

abstract class _WalletTripPaymentModel implements WalletTripPaymentModel {
  const factory _WalletTripPaymentModel(
      {required final String userId,
      required final String userFullName,
      required final String tripId,
      required final double amount,
      required final String date,
      final bool isPaidByAdmin}) = _$WalletTripPaymentModelImpl;

  factory _WalletTripPaymentModel.fromJson(Map<String, dynamic> json) =
      _$WalletTripPaymentModelImpl.fromJson;

  @override
  String get userId;
  @override
  String get userFullName;
  @override
  String get tripId;
  @override
  double get amount;
  @override
  String get date; // yyyy-MM-dd
  @override
  bool get isPaidByAdmin;

  /// Create a copy of WalletTripPaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletTripPaymentModelImplCopyWith<_$WalletTripPaymentModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
