// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_nearby_drivers_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ActiveNearByDriversModel _$ActiveNearByDriversModelFromJson(
    Map<String, dynamic> json) {
  return _ActiveNearByDriversModel.fromJson(json);
}

/// @nodoc
mixin _$ActiveNearByDriversModel {
  String? get driverId => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  double get distanceFromUser => throw _privateConstructorUsedError;

  /// Serializes this ActiveNearByDriversModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActiveNearByDriversModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActiveNearByDriversModelCopyWith<ActiveNearByDriversModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveNearByDriversModelCopyWith<$Res> {
  factory $ActiveNearByDriversModelCopyWith(ActiveNearByDriversModel value,
          $Res Function(ActiveNearByDriversModel) then) =
      _$ActiveNearByDriversModelCopyWithImpl<$Res, ActiveNearByDriversModel>;
  @useResult
  $Res call(
      {String? driverId,
      double? latitude,
      double? longitude,
      double distanceFromUser});
}

/// @nodoc
class _$ActiveNearByDriversModelCopyWithImpl<$Res,
        $Val extends ActiveNearByDriversModel>
    implements $ActiveNearByDriversModelCopyWith<$Res> {
  _$ActiveNearByDriversModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActiveNearByDriversModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? driverId = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? distanceFromUser = null,
  }) {
    return _then(_value.copyWith(
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      distanceFromUser: null == distanceFromUser
          ? _value.distanceFromUser
          : distanceFromUser // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActiveNearByDriversModelImplCopyWith<$Res>
    implements $ActiveNearByDriversModelCopyWith<$Res> {
  factory _$$ActiveNearByDriversModelImplCopyWith(
          _$ActiveNearByDriversModelImpl value,
          $Res Function(_$ActiveNearByDriversModelImpl) then) =
      __$$ActiveNearByDriversModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? driverId,
      double? latitude,
      double? longitude,
      double distanceFromUser});
}

/// @nodoc
class __$$ActiveNearByDriversModelImplCopyWithImpl<$Res>
    extends _$ActiveNearByDriversModelCopyWithImpl<$Res,
        _$ActiveNearByDriversModelImpl>
    implements _$$ActiveNearByDriversModelImplCopyWith<$Res> {
  __$$ActiveNearByDriversModelImplCopyWithImpl(
      _$ActiveNearByDriversModelImpl _value,
      $Res Function(_$ActiveNearByDriversModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActiveNearByDriversModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? driverId = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? distanceFromUser = null,
  }) {
    return _then(_$ActiveNearByDriversModelImpl(
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      distanceFromUser: null == distanceFromUser
          ? _value.distanceFromUser
          : distanceFromUser // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActiveNearByDriversModelImpl implements _ActiveNearByDriversModel {
  const _$ActiveNearByDriversModelImpl(
      {this.driverId,
      this.latitude,
      this.longitude,
      this.distanceFromUser = 0.0});

  factory _$ActiveNearByDriversModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActiveNearByDriversModelImplFromJson(json);

  @override
  final String? driverId;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey()
  final double distanceFromUser;

  @override
  String toString() {
    return 'ActiveNearByDriversModel(driverId: $driverId, latitude: $latitude, longitude: $longitude, distanceFromUser: $distanceFromUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveNearByDriversModelImpl &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.distanceFromUser, distanceFromUser) ||
                other.distanceFromUser == distanceFromUser));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, driverId, latitude, longitude, distanceFromUser);

  /// Create a copy of ActiveNearByDriversModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveNearByDriversModelImplCopyWith<_$ActiveNearByDriversModelImpl>
      get copyWith => __$$ActiveNearByDriversModelImplCopyWithImpl<
          _$ActiveNearByDriversModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActiveNearByDriversModelImplToJson(
      this,
    );
  }
}

abstract class _ActiveNearByDriversModel implements ActiveNearByDriversModel {
  const factory _ActiveNearByDriversModel(
      {final String? driverId,
      final double? latitude,
      final double? longitude,
      final double distanceFromUser}) = _$ActiveNearByDriversModelImpl;

  factory _ActiveNearByDriversModel.fromJson(Map<String, dynamic> json) =
      _$ActiveNearByDriversModelImpl.fromJson;

  @override
  String? get driverId;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  double get distanceFromUser;

  /// Create a copy of ActiveNearByDriversModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveNearByDriversModelImplCopyWith<_$ActiveNearByDriversModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
