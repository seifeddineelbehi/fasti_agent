// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String get photoUrl => throw _privateConstructorUsedError;
  String get deviceToken => throw _privateConstructorUsedError;
  String get role =>
      throw _privateConstructorUsedError; // "client", "driver", "agent"
  bool get isBanned => throw _privateConstructorUsedError;
  double get walletBalance => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  List<LocationModel> get favorites => throw _privateConstructorUsedError;
  LocationModel? get location => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // "online", "offline", etc.
  List<String> get trips => throw _privateConstructorUsedError;
  List<NotificationModel> get notifications =>
      throw _privateConstructorUsedError;
  List<TransactionModel> get transactions => throw _privateConstructorUsedError;
  DriverInfoModel? get driverInfo => throw _privateConstructorUsedError;
  List<RentalConfirmationModel> get rentalCars =>
      throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String firstName,
      String lastName,
      String phone,
      String? email,
      String photoUrl,
      String deviceToken,
      String role,
      bool isBanned,
      double walletBalance,
      int points,
      List<LocationModel> favorites,
      LocationModel? location,
      String status,
      List<String> trips,
      List<NotificationModel> notifications,
      List<TransactionModel> transactions,
      DriverInfoModel? driverInfo,
      List<RentalConfirmationModel> rentalCars});

  $LocationModelCopyWith<$Res>? get location;
  $DriverInfoModelCopyWith<$Res>? get driverInfo;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
    Object? email = freezed,
    Object? photoUrl = null,
    Object? deviceToken = null,
    Object? role = null,
    Object? isBanned = null,
    Object? walletBalance = null,
    Object? points = null,
    Object? favorites = null,
    Object? location = freezed,
    Object? status = null,
    Object? trips = null,
    Object? notifications = null,
    Object? transactions = null,
    Object? driverInfo = freezed,
    Object? rentalCars = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      deviceToken: null == deviceToken
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      isBanned: null == isBanned
          ? _value.isBanned
          : isBanned // ignore: cast_nullable_to_non_nullable
              as bool,
      walletBalance: null == walletBalance
          ? _value.walletBalance
          : walletBalance // ignore: cast_nullable_to_non_nullable
              as double,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      favorites: null == favorites
          ? _value.favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<LocationModel>,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationModel?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      trips: null == trips
          ? _value.trips
          : trips // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<NotificationModel>,
      transactions: null == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<TransactionModel>,
      driverInfo: freezed == driverInfo
          ? _value.driverInfo
          : driverInfo // ignore: cast_nullable_to_non_nullable
              as DriverInfoModel?,
      rentalCars: null == rentalCars
          ? _value.rentalCars
          : rentalCars // ignore: cast_nullable_to_non_nullable
              as List<RentalConfirmationModel>,
    ) as $Val);
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationModelCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationModelCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriverInfoModelCopyWith<$Res>? get driverInfo {
    if (_value.driverInfo == null) {
      return null;
    }

    return $DriverInfoModelCopyWith<$Res>(_value.driverInfo!, (value) {
      return _then(_value.copyWith(driverInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String firstName,
      String lastName,
      String phone,
      String? email,
      String photoUrl,
      String deviceToken,
      String role,
      bool isBanned,
      double walletBalance,
      int points,
      List<LocationModel> favorites,
      LocationModel? location,
      String status,
      List<String> trips,
      List<NotificationModel> notifications,
      List<TransactionModel> transactions,
      DriverInfoModel? driverInfo,
      List<RentalConfirmationModel> rentalCars});

  @override
  $LocationModelCopyWith<$Res>? get location;
  @override
  $DriverInfoModelCopyWith<$Res>? get driverInfo;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
    Object? email = freezed,
    Object? photoUrl = null,
    Object? deviceToken = null,
    Object? role = null,
    Object? isBanned = null,
    Object? walletBalance = null,
    Object? points = null,
    Object? favorites = null,
    Object? location = freezed,
    Object? status = null,
    Object? trips = null,
    Object? notifications = null,
    Object? transactions = null,
    Object? driverInfo = freezed,
    Object? rentalCars = null,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      deviceToken: null == deviceToken
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      isBanned: null == isBanned
          ? _value.isBanned
          : isBanned // ignore: cast_nullable_to_non_nullable
              as bool,
      walletBalance: null == walletBalance
          ? _value.walletBalance
          : walletBalance // ignore: cast_nullable_to_non_nullable
              as double,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      favorites: null == favorites
          ? _value._favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<LocationModel>,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationModel?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      trips: null == trips
          ? _value._trips
          : trips // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notifications: null == notifications
          ? _value._notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<NotificationModel>,
      transactions: null == transactions
          ? _value._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<TransactionModel>,
      driverInfo: freezed == driverInfo
          ? _value.driverInfo
          : driverInfo // ignore: cast_nullable_to_non_nullable
              as DriverInfoModel?,
      rentalCars: null == rentalCars
          ? _value._rentalCars
          : rentalCars // ignore: cast_nullable_to_non_nullable
              as List<RentalConfirmationModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phone,
      this.email,
      this.photoUrl = '',
      this.deviceToken = '',
      this.role = 'client',
      this.isBanned = false,
      this.walletBalance = 0.0,
      this.points = 0,
      final List<LocationModel> favorites = const [],
      this.location,
      this.status = 'offline',
      final List<String> trips = const [],
      final List<NotificationModel> notifications = const [],
      final List<TransactionModel> transactions = const [],
      this.driverInfo,
      final List<RentalConfirmationModel> rentalCars = const []})
      : _favorites = favorites,
        _trips = trips,
        _notifications = notifications,
        _transactions = transactions,
        _rentalCars = rentalCars;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String phone;
  @override
  final String? email;
  @override
  @JsonKey()
  final String photoUrl;
  @override
  @JsonKey()
  final String deviceToken;
  @override
  @JsonKey()
  final String role;
// "client", "driver", "agent"
  @override
  @JsonKey()
  final bool isBanned;
  @override
  @JsonKey()
  final double walletBalance;
  @override
  @JsonKey()
  final int points;
  final List<LocationModel> _favorites;
  @override
  @JsonKey()
  List<LocationModel> get favorites {
    if (_favorites is EqualUnmodifiableListView) return _favorites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favorites);
  }

  @override
  final LocationModel? location;
  @override
  @JsonKey()
  final String status;
// "online", "offline", etc.
  final List<String> _trips;
// "online", "offline", etc.
  @override
  @JsonKey()
  List<String> get trips {
    if (_trips is EqualUnmodifiableListView) return _trips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trips);
  }

  final List<NotificationModel> _notifications;
  @override
  @JsonKey()
  List<NotificationModel> get notifications {
    if (_notifications is EqualUnmodifiableListView) return _notifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifications);
  }

  final List<TransactionModel> _transactions;
  @override
  @JsonKey()
  List<TransactionModel> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  final DriverInfoModel? driverInfo;
  final List<RentalConfirmationModel> _rentalCars;
  @override
  @JsonKey()
  List<RentalConfirmationModel> get rentalCars {
    if (_rentalCars is EqualUnmodifiableListView) return _rentalCars;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rentalCars);
  }

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, photoUrl: $photoUrl, deviceToken: $deviceToken, role: $role, isBanned: $isBanned, walletBalance: $walletBalance, points: $points, favorites: $favorites, location: $location, status: $status, trips: $trips, notifications: $notifications, transactions: $transactions, driverInfo: $driverInfo, rentalCars: $rentalCars)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.deviceToken, deviceToken) ||
                other.deviceToken == deviceToken) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.isBanned, isBanned) ||
                other.isBanned == isBanned) &&
            (identical(other.walletBalance, walletBalance) ||
                other.walletBalance == walletBalance) &&
            (identical(other.points, points) || other.points == points) &&
            const DeepCollectionEquality()
                .equals(other._favorites, _favorites) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._trips, _trips) &&
            const DeepCollectionEquality()
                .equals(other._notifications, _notifications) &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions) &&
            (identical(other.driverInfo, driverInfo) ||
                other.driverInfo == driverInfo) &&
            const DeepCollectionEquality()
                .equals(other._rentalCars, _rentalCars));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        firstName,
        lastName,
        phone,
        email,
        photoUrl,
        deviceToken,
        role,
        isBanned,
        walletBalance,
        points,
        const DeepCollectionEquality().hash(_favorites),
        location,
        status,
        const DeepCollectionEquality().hash(_trips),
        const DeepCollectionEquality().hash(_notifications),
        const DeepCollectionEquality().hash(_transactions),
        driverInfo,
        const DeepCollectionEquality().hash(_rentalCars)
      ]);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String id,
      required final String firstName,
      required final String lastName,
      required final String phone,
      final String? email,
      final String photoUrl,
      final String deviceToken,
      final String role,
      final bool isBanned,
      final double walletBalance,
      final int points,
      final List<LocationModel> favorites,
      final LocationModel? location,
      final String status,
      final List<String> trips,
      final List<NotificationModel> notifications,
      final List<TransactionModel> transactions,
      final DriverInfoModel? driverInfo,
      final List<RentalConfirmationModel> rentalCars}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get phone;
  @override
  String? get email;
  @override
  String get photoUrl;
  @override
  String get deviceToken;
  @override
  String get role; // "client", "driver", "agent"
  @override
  bool get isBanned;
  @override
  double get walletBalance;
  @override
  int get points;
  @override
  List<LocationModel> get favorites;
  @override
  LocationModel? get location;
  @override
  String get status; // "online", "offline", etc.
  @override
  List<String> get trips;
  @override
  List<NotificationModel> get notifications;
  @override
  List<TransactionModel> get transactions;
  @override
  DriverInfoModel? get driverInfo;
  @override
  List<RentalConfirmationModel> get rentalCars;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
