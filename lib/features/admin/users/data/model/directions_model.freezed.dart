// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'directions_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DirectionsModel _$DirectionsModelFromJson(Map<String, dynamic> json) {
  return _DirectionsModel.fromJson(json);
}

/// @nodoc
mixin _$DirectionsModel {
  String? get humanReadableAddress => throw _privateConstructorUsedError;
  String? get locationName => throw _privateConstructorUsedError;
  String? get locationId => throw _privateConstructorUsedError;
  double? get locationLatitude => throw _privateConstructorUsedError;
  double? get locationLongitude => throw _privateConstructorUsedError;

  /// Serializes this DirectionsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DirectionsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DirectionsModelCopyWith<DirectionsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectionsModelCopyWith<$Res> {
  factory $DirectionsModelCopyWith(
          DirectionsModel value, $Res Function(DirectionsModel) then) =
      _$DirectionsModelCopyWithImpl<$Res, DirectionsModel>;
  @useResult
  $Res call(
      {String? humanReadableAddress,
      String? locationName,
      String? locationId,
      double? locationLatitude,
      double? locationLongitude});
}

/// @nodoc
class _$DirectionsModelCopyWithImpl<$Res, $Val extends DirectionsModel>
    implements $DirectionsModelCopyWith<$Res> {
  _$DirectionsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DirectionsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? humanReadableAddress = freezed,
    Object? locationName = freezed,
    Object? locationId = freezed,
    Object? locationLatitude = freezed,
    Object? locationLongitude = freezed,
  }) {
    return _then(_value.copyWith(
      humanReadableAddress: freezed == humanReadableAddress
          ? _value.humanReadableAddress
          : humanReadableAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      locationName: freezed == locationName
          ? _value.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationId: freezed == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as String?,
      locationLatitude: freezed == locationLatitude
          ? _value.locationLatitude
          : locationLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      locationLongitude: freezed == locationLongitude
          ? _value.locationLongitude
          : locationLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DirectionsModelImplCopyWith<$Res>
    implements $DirectionsModelCopyWith<$Res> {
  factory _$$DirectionsModelImplCopyWith(_$DirectionsModelImpl value,
          $Res Function(_$DirectionsModelImpl) then) =
      __$$DirectionsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? humanReadableAddress,
      String? locationName,
      String? locationId,
      double? locationLatitude,
      double? locationLongitude});
}

/// @nodoc
class __$$DirectionsModelImplCopyWithImpl<$Res>
    extends _$DirectionsModelCopyWithImpl<$Res, _$DirectionsModelImpl>
    implements _$$DirectionsModelImplCopyWith<$Res> {
  __$$DirectionsModelImplCopyWithImpl(
      _$DirectionsModelImpl _value, $Res Function(_$DirectionsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DirectionsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? humanReadableAddress = freezed,
    Object? locationName = freezed,
    Object? locationId = freezed,
    Object? locationLatitude = freezed,
    Object? locationLongitude = freezed,
  }) {
    return _then(_$DirectionsModelImpl(
      humanReadableAddress: freezed == humanReadableAddress
          ? _value.humanReadableAddress
          : humanReadableAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      locationName: freezed == locationName
          ? _value.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationId: freezed == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as String?,
      locationLatitude: freezed == locationLatitude
          ? _value.locationLatitude
          : locationLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      locationLongitude: freezed == locationLongitude
          ? _value.locationLongitude
          : locationLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DirectionsModelImpl implements _DirectionsModel {
  const _$DirectionsModelImpl(
      {this.humanReadableAddress,
      this.locationName,
      this.locationId,
      this.locationLatitude,
      this.locationLongitude});

  factory _$DirectionsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DirectionsModelImplFromJson(json);

  @override
  final String? humanReadableAddress;
  @override
  final String? locationName;
  @override
  final String? locationId;
  @override
  final double? locationLatitude;
  @override
  final double? locationLongitude;

  @override
  String toString() {
    return 'DirectionsModel(humanReadableAddress: $humanReadableAddress, locationName: $locationName, locationId: $locationId, locationLatitude: $locationLatitude, locationLongitude: $locationLongitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectionsModelImpl &&
            (identical(other.humanReadableAddress, humanReadableAddress) ||
                other.humanReadableAddress == humanReadableAddress) &&
            (identical(other.locationName, locationName) ||
                other.locationName == locationName) &&
            (identical(other.locationId, locationId) ||
                other.locationId == locationId) &&
            (identical(other.locationLatitude, locationLatitude) ||
                other.locationLatitude == locationLatitude) &&
            (identical(other.locationLongitude, locationLongitude) ||
                other.locationLongitude == locationLongitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, humanReadableAddress,
      locationName, locationId, locationLatitude, locationLongitude);

  /// Create a copy of DirectionsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DirectionsModelImplCopyWith<_$DirectionsModelImpl> get copyWith =>
      __$$DirectionsModelImplCopyWithImpl<_$DirectionsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DirectionsModelImplToJson(
      this,
    );
  }
}

abstract class _DirectionsModel implements DirectionsModel {
  const factory _DirectionsModel(
      {final String? humanReadableAddress,
      final String? locationName,
      final String? locationId,
      final double? locationLatitude,
      final double? locationLongitude}) = _$DirectionsModelImpl;

  factory _DirectionsModel.fromJson(Map<String, dynamic> json) =
      _$DirectionsModelImpl.fromJson;

  @override
  String? get humanReadableAddress;
  @override
  String? get locationName;
  @override
  String? get locationId;
  @override
  double? get locationLatitude;
  @override
  double? get locationLongitude;

  /// Create a copy of DirectionsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DirectionsModelImplCopyWith<_$DirectionsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
