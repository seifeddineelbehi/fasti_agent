// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rental_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RentalRequestModel _$RentalRequestModelFromJson(Map<String, dynamic> json) {
  return _RentalRequestModel.fromJson(json);
}

/// @nodoc
mixin _$RentalRequestModel {
  String get id => throw _privateConstructorUsedError;
  CarModel get car => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;
  String get reservationDateStart => throw _privateConstructorUsedError;
  String get reservationDateEnd => throw _privateConstructorUsedError;
  int get numberOfDays => throw _privateConstructorUsedError;
  String get rentTime => throw _privateConstructorUsedError;
  double get totalCost => throw _privateConstructorUsedError;
  String get submittedAt => throw _privateConstructorUsedError;
  bool get withDriver => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this RentalRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RentalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RentalRequestModelCopyWith<RentalRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RentalRequestModelCopyWith<$Res> {
  factory $RentalRequestModelCopyWith(
          RentalRequestModel value, $Res Function(RentalRequestModel) then) =
      _$RentalRequestModelCopyWithImpl<$Res, RentalRequestModel>;
  @useResult
  $Res call(
      {String id,
      CarModel car,
      UserModel user,
      String reservationDateStart,
      String reservationDateEnd,
      int numberOfDays,
      String rentTime,
      double totalCost,
      String submittedAt,
      bool withDriver,
      String status});

  $CarModelCopyWith<$Res> get car;
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$RentalRequestModelCopyWithImpl<$Res, $Val extends RentalRequestModel>
    implements $RentalRequestModelCopyWith<$Res> {
  _$RentalRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RentalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? car = null,
    Object? user = null,
    Object? reservationDateStart = null,
    Object? reservationDateEnd = null,
    Object? numberOfDays = null,
    Object? rentTime = null,
    Object? totalCost = null,
    Object? submittedAt = null,
    Object? withDriver = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      car: null == car
          ? _value.car
          : car // ignore: cast_nullable_to_non_nullable
              as CarModel,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      reservationDateStart: null == reservationDateStart
          ? _value.reservationDateStart
          : reservationDateStart // ignore: cast_nullable_to_non_nullable
              as String,
      reservationDateEnd: null == reservationDateEnd
          ? _value.reservationDateEnd
          : reservationDateEnd // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfDays: null == numberOfDays
          ? _value.numberOfDays
          : numberOfDays // ignore: cast_nullable_to_non_nullable
              as int,
      rentTime: null == rentTime
          ? _value.rentTime
          : rentTime // ignore: cast_nullable_to_non_nullable
              as String,
      totalCost: null == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as String,
      withDriver: null == withDriver
          ? _value.withDriver
          : withDriver // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of RentalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CarModelCopyWith<$Res> get car {
    return $CarModelCopyWith<$Res>(_value.car, (value) {
      return _then(_value.copyWith(car: value) as $Val);
    });
  }

  /// Create a copy of RentalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RentalRequestModelImplCopyWith<$Res>
    implements $RentalRequestModelCopyWith<$Res> {
  factory _$$RentalRequestModelImplCopyWith(_$RentalRequestModelImpl value,
          $Res Function(_$RentalRequestModelImpl) then) =
      __$$RentalRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      CarModel car,
      UserModel user,
      String reservationDateStart,
      String reservationDateEnd,
      int numberOfDays,
      String rentTime,
      double totalCost,
      String submittedAt,
      bool withDriver,
      String status});

  @override
  $CarModelCopyWith<$Res> get car;
  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$RentalRequestModelImplCopyWithImpl<$Res>
    extends _$RentalRequestModelCopyWithImpl<$Res, _$RentalRequestModelImpl>
    implements _$$RentalRequestModelImplCopyWith<$Res> {
  __$$RentalRequestModelImplCopyWithImpl(_$RentalRequestModelImpl _value,
      $Res Function(_$RentalRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RentalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? car = null,
    Object? user = null,
    Object? reservationDateStart = null,
    Object? reservationDateEnd = null,
    Object? numberOfDays = null,
    Object? rentTime = null,
    Object? totalCost = null,
    Object? submittedAt = null,
    Object? withDriver = null,
    Object? status = null,
  }) {
    return _then(_$RentalRequestModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      car: null == car
          ? _value.car
          : car // ignore: cast_nullable_to_non_nullable
              as CarModel,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      reservationDateStart: null == reservationDateStart
          ? _value.reservationDateStart
          : reservationDateStart // ignore: cast_nullable_to_non_nullable
              as String,
      reservationDateEnd: null == reservationDateEnd
          ? _value.reservationDateEnd
          : reservationDateEnd // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfDays: null == numberOfDays
          ? _value.numberOfDays
          : numberOfDays // ignore: cast_nullable_to_non_nullable
              as int,
      rentTime: null == rentTime
          ? _value.rentTime
          : rentTime // ignore: cast_nullable_to_non_nullable
              as String,
      totalCost: null == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as String,
      withDriver: null == withDriver
          ? _value.withDriver
          : withDriver // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RentalRequestModelImpl implements _RentalRequestModel {
  const _$RentalRequestModelImpl(
      {required this.id,
      required this.car,
      required this.user,
      required this.reservationDateStart,
      required this.reservationDateEnd,
      required this.numberOfDays,
      required this.rentTime,
      required this.totalCost,
      required this.submittedAt,
      this.withDriver = false,
      required this.status});

  factory _$RentalRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RentalRequestModelImplFromJson(json);

  @override
  final String id;
  @override
  final CarModel car;
  @override
  final UserModel user;
  @override
  final String reservationDateStart;
  @override
  final String reservationDateEnd;
  @override
  final int numberOfDays;
  @override
  final String rentTime;
  @override
  final double totalCost;
  @override
  final String submittedAt;
  @override
  @JsonKey()
  final bool withDriver;
  @override
  final String status;

  @override
  String toString() {
    return 'RentalRequestModel(id: $id, car: $car, user: $user, reservationDateStart: $reservationDateStart, reservationDateEnd: $reservationDateEnd, numberOfDays: $numberOfDays, rentTime: $rentTime, totalCost: $totalCost, submittedAt: $submittedAt, withDriver: $withDriver, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RentalRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.car, car) || other.car == car) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.reservationDateStart, reservationDateStart) ||
                other.reservationDateStart == reservationDateStart) &&
            (identical(other.reservationDateEnd, reservationDateEnd) ||
                other.reservationDateEnd == reservationDateEnd) &&
            (identical(other.numberOfDays, numberOfDays) ||
                other.numberOfDays == numberOfDays) &&
            (identical(other.rentTime, rentTime) ||
                other.rentTime == rentTime) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.withDriver, withDriver) ||
                other.withDriver == withDriver) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      car,
      user,
      reservationDateStart,
      reservationDateEnd,
      numberOfDays,
      rentTime,
      totalCost,
      submittedAt,
      withDriver,
      status);

  /// Create a copy of RentalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RentalRequestModelImplCopyWith<_$RentalRequestModelImpl> get copyWith =>
      __$$RentalRequestModelImplCopyWithImpl<_$RentalRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RentalRequestModelImplToJson(
      this,
    );
  }
}

abstract class _RentalRequestModel implements RentalRequestModel {
  const factory _RentalRequestModel(
      {required final String id,
      required final CarModel car,
      required final UserModel user,
      required final String reservationDateStart,
      required final String reservationDateEnd,
      required final int numberOfDays,
      required final String rentTime,
      required final double totalCost,
      required final String submittedAt,
      final bool withDriver,
      required final String status}) = _$RentalRequestModelImpl;

  factory _RentalRequestModel.fromJson(Map<String, dynamic> json) =
      _$RentalRequestModelImpl.fromJson;

  @override
  String get id;
  @override
  CarModel get car;
  @override
  UserModel get user;
  @override
  String get reservationDateStart;
  @override
  String get reservationDateEnd;
  @override
  int get numberOfDays;
  @override
  String get rentTime;
  @override
  double get totalCost;
  @override
  String get submittedAt;
  @override
  bool get withDriver;
  @override
  String get status;

  /// Create a copy of RentalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RentalRequestModelImplCopyWith<_$RentalRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
