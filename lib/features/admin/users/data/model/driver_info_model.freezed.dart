// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DriverInfoModel _$DriverInfoModelFromJson(Map<String, dynamic> json) {
  return _DriverInfoModel.fromJson(json);
}

/// @nodoc
mixin _$DriverInfoModel {
  String get dateOfBirth => throw _privateConstructorUsedError;
  String get approvedStatus => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  bool get availableStatus => throw _privateConstructorUsedError;
  String get idLicensePicture => throw _privateConstructorUsedError;
  String get driverLicenseNumber => throw _privateConstructorUsedError;
  String get driverLicenseFrontPicture => throw _privateConstructorUsedError;
  String get driverLicenseBackPicture => throw _privateConstructorUsedError;
  String get driverLicenseExpirationDate => throw _privateConstructorUsedError;
  VehicleInfoModel get vehicleInfo => throw _privateConstructorUsedError;
  int get totalRatings => throw _privateConstructorUsedError;
  double get ratingSum => throw _privateConstructorUsedError;
  double get unpaidEarnings => throw _privateConstructorUsedError;
  List<DailyEarningModel> get dailyEarnings =>
      throw _privateConstructorUsedError;
  List<UserRatingModel> get ratings => throw _privateConstructorUsedError;
  List<WalletTripPaymentModel> get walletTripPayments =>
      throw _privateConstructorUsedError;

  /// Serializes this DriverInfoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DriverInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DriverInfoModelCopyWith<DriverInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverInfoModelCopyWith<$Res> {
  factory $DriverInfoModelCopyWith(
          DriverInfoModel value, $Res Function(DriverInfoModel) then) =
      _$DriverInfoModelCopyWithImpl<$Res, DriverInfoModel>;
  @useResult
  $Res call(
      {String dateOfBirth,
      String approvedStatus,
      double rating,
      bool availableStatus,
      String idLicensePicture,
      String driverLicenseNumber,
      String driverLicenseFrontPicture,
      String driverLicenseBackPicture,
      String driverLicenseExpirationDate,
      VehicleInfoModel vehicleInfo,
      int totalRatings,
      double ratingSum,
      double unpaidEarnings,
      List<DailyEarningModel> dailyEarnings,
      List<UserRatingModel> ratings,
      List<WalletTripPaymentModel> walletTripPayments});

  $VehicleInfoModelCopyWith<$Res> get vehicleInfo;
}

/// @nodoc
class _$DriverInfoModelCopyWithImpl<$Res, $Val extends DriverInfoModel>
    implements $DriverInfoModelCopyWith<$Res> {
  _$DriverInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DriverInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateOfBirth = null,
    Object? approvedStatus = null,
    Object? rating = null,
    Object? availableStatus = null,
    Object? idLicensePicture = null,
    Object? driverLicenseNumber = null,
    Object? driverLicenseFrontPicture = null,
    Object? driverLicenseBackPicture = null,
    Object? driverLicenseExpirationDate = null,
    Object? vehicleInfo = null,
    Object? totalRatings = null,
    Object? ratingSum = null,
    Object? unpaidEarnings = null,
    Object? dailyEarnings = null,
    Object? ratings = null,
    Object? walletTripPayments = null,
  }) {
    return _then(_value.copyWith(
      dateOfBirth: null == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String,
      approvedStatus: null == approvedStatus
          ? _value.approvedStatus
          : approvedStatus // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      availableStatus: null == availableStatus
          ? _value.availableStatus
          : availableStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      idLicensePicture: null == idLicensePicture
          ? _value.idLicensePicture
          : idLicensePicture // ignore: cast_nullable_to_non_nullable
              as String,
      driverLicenseNumber: null == driverLicenseNumber
          ? _value.driverLicenseNumber
          : driverLicenseNumber // ignore: cast_nullable_to_non_nullable
              as String,
      driverLicenseFrontPicture: null == driverLicenseFrontPicture
          ? _value.driverLicenseFrontPicture
          : driverLicenseFrontPicture // ignore: cast_nullable_to_non_nullable
              as String,
      driverLicenseBackPicture: null == driverLicenseBackPicture
          ? _value.driverLicenseBackPicture
          : driverLicenseBackPicture // ignore: cast_nullable_to_non_nullable
              as String,
      driverLicenseExpirationDate: null == driverLicenseExpirationDate
          ? _value.driverLicenseExpirationDate
          : driverLicenseExpirationDate // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleInfo: null == vehicleInfo
          ? _value.vehicleInfo
          : vehicleInfo // ignore: cast_nullable_to_non_nullable
              as VehicleInfoModel,
      totalRatings: null == totalRatings
          ? _value.totalRatings
          : totalRatings // ignore: cast_nullable_to_non_nullable
              as int,
      ratingSum: null == ratingSum
          ? _value.ratingSum
          : ratingSum // ignore: cast_nullable_to_non_nullable
              as double,
      unpaidEarnings: null == unpaidEarnings
          ? _value.unpaidEarnings
          : unpaidEarnings // ignore: cast_nullable_to_non_nullable
              as double,
      dailyEarnings: null == dailyEarnings
          ? _value.dailyEarnings
          : dailyEarnings // ignore: cast_nullable_to_non_nullable
              as List<DailyEarningModel>,
      ratings: null == ratings
          ? _value.ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as List<UserRatingModel>,
      walletTripPayments: null == walletTripPayments
          ? _value.walletTripPayments
          : walletTripPayments // ignore: cast_nullable_to_non_nullable
              as List<WalletTripPaymentModel>,
    ) as $Val);
  }

  /// Create a copy of DriverInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VehicleInfoModelCopyWith<$Res> get vehicleInfo {
    return $VehicleInfoModelCopyWith<$Res>(_value.vehicleInfo, (value) {
      return _then(_value.copyWith(vehicleInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DriverInfoModelImplCopyWith<$Res>
    implements $DriverInfoModelCopyWith<$Res> {
  factory _$$DriverInfoModelImplCopyWith(_$DriverInfoModelImpl value,
          $Res Function(_$DriverInfoModelImpl) then) =
      __$$DriverInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String dateOfBirth,
      String approvedStatus,
      double rating,
      bool availableStatus,
      String idLicensePicture,
      String driverLicenseNumber,
      String driverLicenseFrontPicture,
      String driverLicenseBackPicture,
      String driverLicenseExpirationDate,
      VehicleInfoModel vehicleInfo,
      int totalRatings,
      double ratingSum,
      double unpaidEarnings,
      List<DailyEarningModel> dailyEarnings,
      List<UserRatingModel> ratings,
      List<WalletTripPaymentModel> walletTripPayments});

  @override
  $VehicleInfoModelCopyWith<$Res> get vehicleInfo;
}

/// @nodoc
class __$$DriverInfoModelImplCopyWithImpl<$Res>
    extends _$DriverInfoModelCopyWithImpl<$Res, _$DriverInfoModelImpl>
    implements _$$DriverInfoModelImplCopyWith<$Res> {
  __$$DriverInfoModelImplCopyWithImpl(
      _$DriverInfoModelImpl _value, $Res Function(_$DriverInfoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DriverInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateOfBirth = null,
    Object? approvedStatus = null,
    Object? rating = null,
    Object? availableStatus = null,
    Object? idLicensePicture = null,
    Object? driverLicenseNumber = null,
    Object? driverLicenseFrontPicture = null,
    Object? driverLicenseBackPicture = null,
    Object? driverLicenseExpirationDate = null,
    Object? vehicleInfo = null,
    Object? totalRatings = null,
    Object? ratingSum = null,
    Object? unpaidEarnings = null,
    Object? dailyEarnings = null,
    Object? ratings = null,
    Object? walletTripPayments = null,
  }) {
    return _then(_$DriverInfoModelImpl(
      dateOfBirth: null == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String,
      approvedStatus: null == approvedStatus
          ? _value.approvedStatus
          : approvedStatus // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      availableStatus: null == availableStatus
          ? _value.availableStatus
          : availableStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      idLicensePicture: null == idLicensePicture
          ? _value.idLicensePicture
          : idLicensePicture // ignore: cast_nullable_to_non_nullable
              as String,
      driverLicenseNumber: null == driverLicenseNumber
          ? _value.driverLicenseNumber
          : driverLicenseNumber // ignore: cast_nullable_to_non_nullable
              as String,
      driverLicenseFrontPicture: null == driverLicenseFrontPicture
          ? _value.driverLicenseFrontPicture
          : driverLicenseFrontPicture // ignore: cast_nullable_to_non_nullable
              as String,
      driverLicenseBackPicture: null == driverLicenseBackPicture
          ? _value.driverLicenseBackPicture
          : driverLicenseBackPicture // ignore: cast_nullable_to_non_nullable
              as String,
      driverLicenseExpirationDate: null == driverLicenseExpirationDate
          ? _value.driverLicenseExpirationDate
          : driverLicenseExpirationDate // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleInfo: null == vehicleInfo
          ? _value.vehicleInfo
          : vehicleInfo // ignore: cast_nullable_to_non_nullable
              as VehicleInfoModel,
      totalRatings: null == totalRatings
          ? _value.totalRatings
          : totalRatings // ignore: cast_nullable_to_non_nullable
              as int,
      ratingSum: null == ratingSum
          ? _value.ratingSum
          : ratingSum // ignore: cast_nullable_to_non_nullable
              as double,
      unpaidEarnings: null == unpaidEarnings
          ? _value.unpaidEarnings
          : unpaidEarnings // ignore: cast_nullable_to_non_nullable
              as double,
      dailyEarnings: null == dailyEarnings
          ? _value._dailyEarnings
          : dailyEarnings // ignore: cast_nullable_to_non_nullable
              as List<DailyEarningModel>,
      ratings: null == ratings
          ? _value._ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as List<UserRatingModel>,
      walletTripPayments: null == walletTripPayments
          ? _value._walletTripPayments
          : walletTripPayments // ignore: cast_nullable_to_non_nullable
              as List<WalletTripPaymentModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverInfoModelImpl implements _DriverInfoModel {
  const _$DriverInfoModelImpl(
      {required this.dateOfBirth,
      required this.approvedStatus,
      this.rating = 5.0,
      required this.availableStatus,
      required this.idLicensePicture,
      required this.driverLicenseNumber,
      required this.driverLicenseFrontPicture,
      required this.driverLicenseBackPicture,
      required this.driverLicenseExpirationDate,
      required this.vehicleInfo,
      this.totalRatings = 0,
      this.ratingSum = 0.0,
      this.unpaidEarnings = 0.0,
      final List<DailyEarningModel> dailyEarnings = const [],
      final List<UserRatingModel> ratings = const [],
      final List<WalletTripPaymentModel> walletTripPayments = const []})
      : _dailyEarnings = dailyEarnings,
        _ratings = ratings,
        _walletTripPayments = walletTripPayments;

  factory _$DriverInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverInfoModelImplFromJson(json);

  @override
  final String dateOfBirth;
  @override
  final String approvedStatus;
  @override
  @JsonKey()
  final double rating;
  @override
  final bool availableStatus;
  @override
  final String idLicensePicture;
  @override
  final String driverLicenseNumber;
  @override
  final String driverLicenseFrontPicture;
  @override
  final String driverLicenseBackPicture;
  @override
  final String driverLicenseExpirationDate;
  @override
  final VehicleInfoModel vehicleInfo;
  @override
  @JsonKey()
  final int totalRatings;
  @override
  @JsonKey()
  final double ratingSum;
  @override
  @JsonKey()
  final double unpaidEarnings;
  final List<DailyEarningModel> _dailyEarnings;
  @override
  @JsonKey()
  List<DailyEarningModel> get dailyEarnings {
    if (_dailyEarnings is EqualUnmodifiableListView) return _dailyEarnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyEarnings);
  }

  final List<UserRatingModel> _ratings;
  @override
  @JsonKey()
  List<UserRatingModel> get ratings {
    if (_ratings is EqualUnmodifiableListView) return _ratings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ratings);
  }

  final List<WalletTripPaymentModel> _walletTripPayments;
  @override
  @JsonKey()
  List<WalletTripPaymentModel> get walletTripPayments {
    if (_walletTripPayments is EqualUnmodifiableListView)
      return _walletTripPayments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_walletTripPayments);
  }

  @override
  String toString() {
    return 'DriverInfoModel(dateOfBirth: $dateOfBirth, approvedStatus: $approvedStatus, rating: $rating, availableStatus: $availableStatus, idLicensePicture: $idLicensePicture, driverLicenseNumber: $driverLicenseNumber, driverLicenseFrontPicture: $driverLicenseFrontPicture, driverLicenseBackPicture: $driverLicenseBackPicture, driverLicenseExpirationDate: $driverLicenseExpirationDate, vehicleInfo: $vehicleInfo, totalRatings: $totalRatings, ratingSum: $ratingSum, unpaidEarnings: $unpaidEarnings, dailyEarnings: $dailyEarnings, ratings: $ratings, walletTripPayments: $walletTripPayments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverInfoModelImpl &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.approvedStatus, approvedStatus) ||
                other.approvedStatus == approvedStatus) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.availableStatus, availableStatus) ||
                other.availableStatus == availableStatus) &&
            (identical(other.idLicensePicture, idLicensePicture) ||
                other.idLicensePicture == idLicensePicture) &&
            (identical(other.driverLicenseNumber, driverLicenseNumber) ||
                other.driverLicenseNumber == driverLicenseNumber) &&
            (identical(other.driverLicenseFrontPicture,
                    driverLicenseFrontPicture) ||
                other.driverLicenseFrontPicture == driverLicenseFrontPicture) &&
            (identical(
                    other.driverLicenseBackPicture, driverLicenseBackPicture) ||
                other.driverLicenseBackPicture == driverLicenseBackPicture) &&
            (identical(other.driverLicenseExpirationDate,
                    driverLicenseExpirationDate) ||
                other.driverLicenseExpirationDate ==
                    driverLicenseExpirationDate) &&
            (identical(other.vehicleInfo, vehicleInfo) ||
                other.vehicleInfo == vehicleInfo) &&
            (identical(other.totalRatings, totalRatings) ||
                other.totalRatings == totalRatings) &&
            (identical(other.ratingSum, ratingSum) ||
                other.ratingSum == ratingSum) &&
            (identical(other.unpaidEarnings, unpaidEarnings) ||
                other.unpaidEarnings == unpaidEarnings) &&
            const DeepCollectionEquality()
                .equals(other._dailyEarnings, _dailyEarnings) &&
            const DeepCollectionEquality().equals(other._ratings, _ratings) &&
            const DeepCollectionEquality()
                .equals(other._walletTripPayments, _walletTripPayments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      dateOfBirth,
      approvedStatus,
      rating,
      availableStatus,
      idLicensePicture,
      driverLicenseNumber,
      driverLicenseFrontPicture,
      driverLicenseBackPicture,
      driverLicenseExpirationDate,
      vehicleInfo,
      totalRatings,
      ratingSum,
      unpaidEarnings,
      const DeepCollectionEquality().hash(_dailyEarnings),
      const DeepCollectionEquality().hash(_ratings),
      const DeepCollectionEquality().hash(_walletTripPayments));

  /// Create a copy of DriverInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverInfoModelImplCopyWith<_$DriverInfoModelImpl> get copyWith =>
      __$$DriverInfoModelImplCopyWithImpl<_$DriverInfoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverInfoModelImplToJson(
      this,
    );
  }
}

abstract class _DriverInfoModel implements DriverInfoModel {
  const factory _DriverInfoModel(
          {required final String dateOfBirth,
          required final String approvedStatus,
          final double rating,
          required final bool availableStatus,
          required final String idLicensePicture,
          required final String driverLicenseNumber,
          required final String driverLicenseFrontPicture,
          required final String driverLicenseBackPicture,
          required final String driverLicenseExpirationDate,
          required final VehicleInfoModel vehicleInfo,
          final int totalRatings,
          final double ratingSum,
          final double unpaidEarnings,
          final List<DailyEarningModel> dailyEarnings,
          final List<UserRatingModel> ratings,
          final List<WalletTripPaymentModel> walletTripPayments}) =
      _$DriverInfoModelImpl;

  factory _DriverInfoModel.fromJson(Map<String, dynamic> json) =
      _$DriverInfoModelImpl.fromJson;

  @override
  String get dateOfBirth;
  @override
  String get approvedStatus;
  @override
  double get rating;
  @override
  bool get availableStatus;
  @override
  String get idLicensePicture;
  @override
  String get driverLicenseNumber;
  @override
  String get driverLicenseFrontPicture;
  @override
  String get driverLicenseBackPicture;
  @override
  String get driverLicenseExpirationDate;
  @override
  VehicleInfoModel get vehicleInfo;
  @override
  int get totalRatings;
  @override
  double get ratingSum;
  @override
  double get unpaidEarnings;
  @override
  List<DailyEarningModel> get dailyEarnings;
  @override
  List<UserRatingModel> get ratings;
  @override
  List<WalletTripPaymentModel> get walletTripPayments;

  /// Create a copy of DriverInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DriverInfoModelImplCopyWith<_$DriverInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyEarningModel _$DailyEarningModelFromJson(Map<String, dynamic> json) {
  return _DailyEarningModel.fromJson(json);
}

/// @nodoc
mixin _$DailyEarningModel {
  String get date => throw _privateConstructorUsedError; // format: yyyy-MM-dd
  double get amount => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this DailyEarningModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyEarningModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyEarningModelCopyWith<DailyEarningModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyEarningModelCopyWith<$Res> {
  factory $DailyEarningModelCopyWith(
          DailyEarningModel value, $Res Function(DailyEarningModel) then) =
      _$DailyEarningModelCopyWithImpl<$Res, DailyEarningModel>;
  @useResult
  $Res call({String date, double amount, String method, String? note});
}

/// @nodoc
class _$DailyEarningModelCopyWithImpl<$Res, $Val extends DailyEarningModel>
    implements $DailyEarningModelCopyWith<$Res> {
  _$DailyEarningModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyEarningModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? amount = null,
    Object? method = null,
    Object? note = freezed,
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
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyEarningModelImplCopyWith<$Res>
    implements $DailyEarningModelCopyWith<$Res> {
  factory _$$DailyEarningModelImplCopyWith(_$DailyEarningModelImpl value,
          $Res Function(_$DailyEarningModelImpl) then) =
      __$$DailyEarningModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, double amount, String method, String? note});
}

/// @nodoc
class __$$DailyEarningModelImplCopyWithImpl<$Res>
    extends _$DailyEarningModelCopyWithImpl<$Res, _$DailyEarningModelImpl>
    implements _$$DailyEarningModelImplCopyWith<$Res> {
  __$$DailyEarningModelImplCopyWithImpl(_$DailyEarningModelImpl _value,
      $Res Function(_$DailyEarningModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyEarningModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? amount = null,
    Object? method = null,
    Object? note = freezed,
  }) {
    return _then(_$DailyEarningModelImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyEarningModelImpl implements _DailyEarningModel {
  const _$DailyEarningModelImpl(
      {required this.date,
      required this.amount,
      required this.method,
      this.note});

  factory _$DailyEarningModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyEarningModelImplFromJson(json);

  @override
  final String date;
// format: yyyy-MM-dd
  @override
  final double amount;
  @override
  final String method;
  @override
  final String? note;

  @override
  String toString() {
    return 'DailyEarningModel(date: $date, amount: $amount, method: $method, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyEarningModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, amount, method, note);

  /// Create a copy of DailyEarningModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyEarningModelImplCopyWith<_$DailyEarningModelImpl> get copyWith =>
      __$$DailyEarningModelImplCopyWithImpl<_$DailyEarningModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyEarningModelImplToJson(
      this,
    );
  }
}

abstract class _DailyEarningModel implements DailyEarningModel {
  const factory _DailyEarningModel(
      {required final String date,
      required final double amount,
      required final String method,
      final String? note}) = _$DailyEarningModelImpl;

  factory _DailyEarningModel.fromJson(Map<String, dynamic> json) =
      _$DailyEarningModelImpl.fromJson;

  @override
  String get date; // format: yyyy-MM-dd
  @override
  double get amount;
  @override
  String get method;
  @override
  String? get note;

  /// Create a copy of DailyEarningModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyEarningModelImplCopyWith<_$DailyEarningModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
