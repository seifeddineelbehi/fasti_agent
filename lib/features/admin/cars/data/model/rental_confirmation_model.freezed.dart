// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rental_confirmation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RentalConfirmationModel _$RentalConfirmationModelFromJson(
    Map<String, dynamic> json) {
  return _RentalConfirmationModel.fromJson(json);
}

/// @nodoc
mixin _$RentalConfirmationModel {
  String get reservationId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  CarModel get car => throw _privateConstructorUsedError;
  String get reservationDateStart => throw _privateConstructorUsedError;
  String get reservationDateEnd => throw _privateConstructorUsedError;
  String get rentTime => throw _privateConstructorUsedError;
  int get numberOfDays => throw _privateConstructorUsedError;
  bool get withDriver => throw _privateConstructorUsedError;
  double get totalCost => throw _privateConstructorUsedError;
  String get submittedAt => throw _privateConstructorUsedError;

  /// Serializes this RentalConfirmationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RentalConfirmationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RentalConfirmationModelCopyWith<RentalConfirmationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RentalConfirmationModelCopyWith<$Res> {
  factory $RentalConfirmationModelCopyWith(RentalConfirmationModel value,
          $Res Function(RentalConfirmationModel) then) =
      _$RentalConfirmationModelCopyWithImpl<$Res, RentalConfirmationModel>;
  @useResult
  $Res call(
      {String reservationId,
      String status,
      CarModel car,
      String reservationDateStart,
      String reservationDateEnd,
      String rentTime,
      int numberOfDays,
      bool withDriver,
      double totalCost,
      String submittedAt});

  $CarModelCopyWith<$Res> get car;
}

/// @nodoc
class _$RentalConfirmationModelCopyWithImpl<$Res,
        $Val extends RentalConfirmationModel>
    implements $RentalConfirmationModelCopyWith<$Res> {
  _$RentalConfirmationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RentalConfirmationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservationId = null,
    Object? status = null,
    Object? car = null,
    Object? reservationDateStart = null,
    Object? reservationDateEnd = null,
    Object? rentTime = null,
    Object? numberOfDays = null,
    Object? withDriver = null,
    Object? totalCost = null,
    Object? submittedAt = null,
  }) {
    return _then(_value.copyWith(
      reservationId: null == reservationId
          ? _value.reservationId
          : reservationId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      car: null == car
          ? _value.car
          : car // ignore: cast_nullable_to_non_nullable
              as CarModel,
      reservationDateStart: null == reservationDateStart
          ? _value.reservationDateStart
          : reservationDateStart // ignore: cast_nullable_to_non_nullable
              as String,
      reservationDateEnd: null == reservationDateEnd
          ? _value.reservationDateEnd
          : reservationDateEnd // ignore: cast_nullable_to_non_nullable
              as String,
      rentTime: null == rentTime
          ? _value.rentTime
          : rentTime // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfDays: null == numberOfDays
          ? _value.numberOfDays
          : numberOfDays // ignore: cast_nullable_to_non_nullable
              as int,
      withDriver: null == withDriver
          ? _value.withDriver
          : withDriver // ignore: cast_nullable_to_non_nullable
              as bool,
      totalCost: null == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of RentalConfirmationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CarModelCopyWith<$Res> get car {
    return $CarModelCopyWith<$Res>(_value.car, (value) {
      return _then(_value.copyWith(car: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RentalConfirmationModelImplCopyWith<$Res>
    implements $RentalConfirmationModelCopyWith<$Res> {
  factory _$$RentalConfirmationModelImplCopyWith(
          _$RentalConfirmationModelImpl value,
          $Res Function(_$RentalConfirmationModelImpl) then) =
      __$$RentalConfirmationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String reservationId,
      String status,
      CarModel car,
      String reservationDateStart,
      String reservationDateEnd,
      String rentTime,
      int numberOfDays,
      bool withDriver,
      double totalCost,
      String submittedAt});

  @override
  $CarModelCopyWith<$Res> get car;
}

/// @nodoc
class __$$RentalConfirmationModelImplCopyWithImpl<$Res>
    extends _$RentalConfirmationModelCopyWithImpl<$Res,
        _$RentalConfirmationModelImpl>
    implements _$$RentalConfirmationModelImplCopyWith<$Res> {
  __$$RentalConfirmationModelImplCopyWithImpl(
      _$RentalConfirmationModelImpl _value,
      $Res Function(_$RentalConfirmationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RentalConfirmationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservationId = null,
    Object? status = null,
    Object? car = null,
    Object? reservationDateStart = null,
    Object? reservationDateEnd = null,
    Object? rentTime = null,
    Object? numberOfDays = null,
    Object? withDriver = null,
    Object? totalCost = null,
    Object? submittedAt = null,
  }) {
    return _then(_$RentalConfirmationModelImpl(
      reservationId: null == reservationId
          ? _value.reservationId
          : reservationId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      car: null == car
          ? _value.car
          : car // ignore: cast_nullable_to_non_nullable
              as CarModel,
      reservationDateStart: null == reservationDateStart
          ? _value.reservationDateStart
          : reservationDateStart // ignore: cast_nullable_to_non_nullable
              as String,
      reservationDateEnd: null == reservationDateEnd
          ? _value.reservationDateEnd
          : reservationDateEnd // ignore: cast_nullable_to_non_nullable
              as String,
      rentTime: null == rentTime
          ? _value.rentTime
          : rentTime // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfDays: null == numberOfDays
          ? _value.numberOfDays
          : numberOfDays // ignore: cast_nullable_to_non_nullable
              as int,
      withDriver: null == withDriver
          ? _value.withDriver
          : withDriver // ignore: cast_nullable_to_non_nullable
              as bool,
      totalCost: null == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RentalConfirmationModelImpl implements _RentalConfirmationModel {
  const _$RentalConfirmationModelImpl(
      {required this.reservationId,
      required this.status,
      required this.car,
      required this.reservationDateStart,
      required this.reservationDateEnd,
      required this.rentTime,
      required this.numberOfDays,
      required this.withDriver,
      required this.totalCost,
      required this.submittedAt});

  factory _$RentalConfirmationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RentalConfirmationModelImplFromJson(json);

  @override
  final String reservationId;
  @override
  final String status;
  @override
  final CarModel car;
  @override
  final String reservationDateStart;
  @override
  final String reservationDateEnd;
  @override
  final String rentTime;
  @override
  final int numberOfDays;
  @override
  final bool withDriver;
  @override
  final double totalCost;
  @override
  final String submittedAt;

  @override
  String toString() {
    return 'RentalConfirmationModel(reservationId: $reservationId, status: $status, car: $car, reservationDateStart: $reservationDateStart, reservationDateEnd: $reservationDateEnd, rentTime: $rentTime, numberOfDays: $numberOfDays, withDriver: $withDriver, totalCost: $totalCost, submittedAt: $submittedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RentalConfirmationModelImpl &&
            (identical(other.reservationId, reservationId) ||
                other.reservationId == reservationId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.car, car) || other.car == car) &&
            (identical(other.reservationDateStart, reservationDateStart) ||
                other.reservationDateStart == reservationDateStart) &&
            (identical(other.reservationDateEnd, reservationDateEnd) ||
                other.reservationDateEnd == reservationDateEnd) &&
            (identical(other.rentTime, rentTime) ||
                other.rentTime == rentTime) &&
            (identical(other.numberOfDays, numberOfDays) ||
                other.numberOfDays == numberOfDays) &&
            (identical(other.withDriver, withDriver) ||
                other.withDriver == withDriver) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      reservationId,
      status,
      car,
      reservationDateStart,
      reservationDateEnd,
      rentTime,
      numberOfDays,
      withDriver,
      totalCost,
      submittedAt);

  /// Create a copy of RentalConfirmationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RentalConfirmationModelImplCopyWith<_$RentalConfirmationModelImpl>
      get copyWith => __$$RentalConfirmationModelImplCopyWithImpl<
          _$RentalConfirmationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RentalConfirmationModelImplToJson(
      this,
    );
  }
}

abstract class _RentalConfirmationModel implements RentalConfirmationModel {
  const factory _RentalConfirmationModel(
      {required final String reservationId,
      required final String status,
      required final CarModel car,
      required final String reservationDateStart,
      required final String reservationDateEnd,
      required final String rentTime,
      required final int numberOfDays,
      required final bool withDriver,
      required final double totalCost,
      required final String submittedAt}) = _$RentalConfirmationModelImpl;

  factory _RentalConfirmationModel.fromJson(Map<String, dynamic> json) =
      _$RentalConfirmationModelImpl.fromJson;

  @override
  String get reservationId;
  @override
  String get status;
  @override
  CarModel get car;
  @override
  String get reservationDateStart;
  @override
  String get reservationDateEnd;
  @override
  String get rentTime;
  @override
  int get numberOfDays;
  @override
  bool get withDriver;
  @override
  double get totalCost;
  @override
  String get submittedAt;

  /// Create a copy of RentalConfirmationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RentalConfirmationModelImplCopyWith<_$RentalConfirmationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
