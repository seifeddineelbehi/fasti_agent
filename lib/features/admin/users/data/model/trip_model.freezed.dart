// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TripModel _$TripModelFromJson(Map<String, dynamic> json) {
  return _TripModel.fromJson(json);
}

/// @nodoc
mixin _$TripModel {
  String get id => throw _privateConstructorUsedError;
  bool get isFromAdmin => throw _privateConstructorUsedError;
  DirectionsModel get userPickupLocation => throw _privateConstructorUsedError;
  List<DirectionsModel> get userDropOffLocations =>
      throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  String get originAddressName => throw _privateConstructorUsedError;
  List<String> get destinationAddressNames =>
      throw _privateConstructorUsedError;
  UserModel get driver => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;
  bool get isStopOver => throw _privateConstructorUsedError;
  double get fare => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get distance => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  String get cancellationReason => throw _privateConstructorUsedError;

  /// Serializes this TripModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripModelCopyWith<TripModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripModelCopyWith<$Res> {
  factory $TripModelCopyWith(TripModel value, $Res Function(TripModel) then) =
      _$TripModelCopyWithImpl<$Res, TripModel>;
  @useResult
  $Res call(
      {String id,
      bool isFromAdmin,
      DirectionsModel userPickupLocation,
      List<DirectionsModel> userDropOffLocations,
      String time,
      String paymentMethod,
      String originAddressName,
      List<String> destinationAddressNames,
      UserModel driver,
      UserModel user,
      bool isStopOver,
      double fare,
      String status,
      int distance,
      int duration,
      String cancellationReason});

  $DirectionsModelCopyWith<$Res> get userPickupLocation;
  $UserModelCopyWith<$Res> get driver;
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$TripModelCopyWithImpl<$Res, $Val extends TripModel>
    implements $TripModelCopyWith<$Res> {
  _$TripModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isFromAdmin = null,
    Object? userPickupLocation = null,
    Object? userDropOffLocations = null,
    Object? time = null,
    Object? paymentMethod = null,
    Object? originAddressName = null,
    Object? destinationAddressNames = null,
    Object? driver = null,
    Object? user = null,
    Object? isStopOver = null,
    Object? fare = null,
    Object? status = null,
    Object? distance = null,
    Object? duration = null,
    Object? cancellationReason = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isFromAdmin: null == isFromAdmin
          ? _value.isFromAdmin
          : isFromAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      userPickupLocation: null == userPickupLocation
          ? _value.userPickupLocation
          : userPickupLocation // ignore: cast_nullable_to_non_nullable
              as DirectionsModel,
      userDropOffLocations: null == userDropOffLocations
          ? _value.userDropOffLocations
          : userDropOffLocations // ignore: cast_nullable_to_non_nullable
              as List<DirectionsModel>,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      originAddressName: null == originAddressName
          ? _value.originAddressName
          : originAddressName // ignore: cast_nullable_to_non_nullable
              as String,
      destinationAddressNames: null == destinationAddressNames
          ? _value.destinationAddressNames
          : destinationAddressNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as UserModel,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      isStopOver: null == isStopOver
          ? _value.isStopOver
          : isStopOver // ignore: cast_nullable_to_non_nullable
              as bool,
      fare: null == fare
          ? _value.fare
          : fare // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      cancellationReason: null == cancellationReason
          ? _value.cancellationReason
          : cancellationReason // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectionsModelCopyWith<$Res> get userPickupLocation {
    return $DirectionsModelCopyWith<$Res>(_value.userPickupLocation, (value) {
      return _then(_value.copyWith(userPickupLocation: value) as $Val);
    });
  }

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get driver {
    return $UserModelCopyWith<$Res>(_value.driver, (value) {
      return _then(_value.copyWith(driver: value) as $Val);
    });
  }

  /// Create a copy of TripModel
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
abstract class _$$TripModelImplCopyWith<$Res>
    implements $TripModelCopyWith<$Res> {
  factory _$$TripModelImplCopyWith(
          _$TripModelImpl value, $Res Function(_$TripModelImpl) then) =
      __$$TripModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      bool isFromAdmin,
      DirectionsModel userPickupLocation,
      List<DirectionsModel> userDropOffLocations,
      String time,
      String paymentMethod,
      String originAddressName,
      List<String> destinationAddressNames,
      UserModel driver,
      UserModel user,
      bool isStopOver,
      double fare,
      String status,
      int distance,
      int duration,
      String cancellationReason});

  @override
  $DirectionsModelCopyWith<$Res> get userPickupLocation;
  @override
  $UserModelCopyWith<$Res> get driver;
  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$TripModelImplCopyWithImpl<$Res>
    extends _$TripModelCopyWithImpl<$Res, _$TripModelImpl>
    implements _$$TripModelImplCopyWith<$Res> {
  __$$TripModelImplCopyWithImpl(
      _$TripModelImpl _value, $Res Function(_$TripModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isFromAdmin = null,
    Object? userPickupLocation = null,
    Object? userDropOffLocations = null,
    Object? time = null,
    Object? paymentMethod = null,
    Object? originAddressName = null,
    Object? destinationAddressNames = null,
    Object? driver = null,
    Object? user = null,
    Object? isStopOver = null,
    Object? fare = null,
    Object? status = null,
    Object? distance = null,
    Object? duration = null,
    Object? cancellationReason = null,
  }) {
    return _then(_$TripModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isFromAdmin: null == isFromAdmin
          ? _value.isFromAdmin
          : isFromAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      userPickupLocation: null == userPickupLocation
          ? _value.userPickupLocation
          : userPickupLocation // ignore: cast_nullable_to_non_nullable
              as DirectionsModel,
      userDropOffLocations: null == userDropOffLocations
          ? _value._userDropOffLocations
          : userDropOffLocations // ignore: cast_nullable_to_non_nullable
              as List<DirectionsModel>,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      originAddressName: null == originAddressName
          ? _value.originAddressName
          : originAddressName // ignore: cast_nullable_to_non_nullable
              as String,
      destinationAddressNames: null == destinationAddressNames
          ? _value._destinationAddressNames
          : destinationAddressNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as UserModel,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      isStopOver: null == isStopOver
          ? _value.isStopOver
          : isStopOver // ignore: cast_nullable_to_non_nullable
              as bool,
      fare: null == fare
          ? _value.fare
          : fare // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      cancellationReason: null == cancellationReason
          ? _value.cancellationReason
          : cancellationReason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripModelImpl implements _TripModel {
  const _$TripModelImpl(
      {this.id = '',
      this.isFromAdmin = true,
      required this.userPickupLocation,
      required final List<DirectionsModel> userDropOffLocations,
      required this.time,
      required this.paymentMethod,
      required this.originAddressName,
      required final List<String> destinationAddressNames,
      required this.driver,
      required this.user,
      required this.isStopOver,
      required this.fare,
      required this.status,
      required this.distance,
      required this.duration,
      this.cancellationReason = ''})
      : _userDropOffLocations = userDropOffLocations,
        _destinationAddressNames = destinationAddressNames;

  factory _$TripModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripModelImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final bool isFromAdmin;
  @override
  final DirectionsModel userPickupLocation;
  final List<DirectionsModel> _userDropOffLocations;
  @override
  List<DirectionsModel> get userDropOffLocations {
    if (_userDropOffLocations is EqualUnmodifiableListView)
      return _userDropOffLocations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userDropOffLocations);
  }

  @override
  final String time;
  @override
  final String paymentMethod;
  @override
  final String originAddressName;
  final List<String> _destinationAddressNames;
  @override
  List<String> get destinationAddressNames {
    if (_destinationAddressNames is EqualUnmodifiableListView)
      return _destinationAddressNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_destinationAddressNames);
  }

  @override
  final UserModel driver;
  @override
  final UserModel user;
  @override
  final bool isStopOver;
  @override
  final double fare;
  @override
  final String status;
  @override
  final int distance;
  @override
  final int duration;
  @override
  @JsonKey()
  final String cancellationReason;

  @override
  String toString() {
    return 'TripModel(id: $id, isFromAdmin: $isFromAdmin, userPickupLocation: $userPickupLocation, userDropOffLocations: $userDropOffLocations, time: $time, paymentMethod: $paymentMethod, originAddressName: $originAddressName, destinationAddressNames: $destinationAddressNames, driver: $driver, user: $user, isStopOver: $isStopOver, fare: $fare, status: $status, distance: $distance, duration: $duration, cancellationReason: $cancellationReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isFromAdmin, isFromAdmin) ||
                other.isFromAdmin == isFromAdmin) &&
            (identical(other.userPickupLocation, userPickupLocation) ||
                other.userPickupLocation == userPickupLocation) &&
            const DeepCollectionEquality()
                .equals(other._userDropOffLocations, _userDropOffLocations) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.originAddressName, originAddressName) ||
                other.originAddressName == originAddressName) &&
            const DeepCollectionEquality().equals(
                other._destinationAddressNames, _destinationAddressNames) &&
            (identical(other.driver, driver) || other.driver == driver) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.isStopOver, isStopOver) ||
                other.isStopOver == isStopOver) &&
            (identical(other.fare, fare) || other.fare == fare) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.cancellationReason, cancellationReason) ||
                other.cancellationReason == cancellationReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      isFromAdmin,
      userPickupLocation,
      const DeepCollectionEquality().hash(_userDropOffLocations),
      time,
      paymentMethod,
      originAddressName,
      const DeepCollectionEquality().hash(_destinationAddressNames),
      driver,
      user,
      isStopOver,
      fare,
      status,
      distance,
      duration,
      cancellationReason);

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripModelImplCopyWith<_$TripModelImpl> get copyWith =>
      __$$TripModelImplCopyWithImpl<_$TripModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripModelImplToJson(
      this,
    );
  }
}

abstract class _TripModel implements TripModel {
  const factory _TripModel(
      {final String id,
      final bool isFromAdmin,
      required final DirectionsModel userPickupLocation,
      required final List<DirectionsModel> userDropOffLocations,
      required final String time,
      required final String paymentMethod,
      required final String originAddressName,
      required final List<String> destinationAddressNames,
      required final UserModel driver,
      required final UserModel user,
      required final bool isStopOver,
      required final double fare,
      required final String status,
      required final int distance,
      required final int duration,
      final String cancellationReason}) = _$TripModelImpl;

  factory _TripModel.fromJson(Map<String, dynamic> json) =
      _$TripModelImpl.fromJson;

  @override
  String get id;
  @override
  bool get isFromAdmin;
  @override
  DirectionsModel get userPickupLocation;
  @override
  List<DirectionsModel> get userDropOffLocations;
  @override
  String get time;
  @override
  String get paymentMethod;
  @override
  String get originAddressName;
  @override
  List<String> get destinationAddressNames;
  @override
  UserModel get driver;
  @override
  UserModel get user;
  @override
  bool get isStopOver;
  @override
  double get fare;
  @override
  String get status;
  @override
  int get distance;
  @override
  int get duration;
  @override
  String get cancellationReason;

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripModelImplCopyWith<_$TripModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
