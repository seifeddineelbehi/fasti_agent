// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rental_period_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RentalPeriodModel _$RentalPeriodModelFromJson(Map<String, dynamic> json) {
  return _RentalPeriodModel.fromJson(json);
}

/// @nodoc
mixin _$RentalPeriodModel {
  String get start => throw _privateConstructorUsedError;
  String get end => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;

  /// Serializes this RentalPeriodModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RentalPeriodModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RentalPeriodModelCopyWith<RentalPeriodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RentalPeriodModelCopyWith<$Res> {
  factory $RentalPeriodModelCopyWith(
          RentalPeriodModel value, $Res Function(RentalPeriodModel) then) =
      _$RentalPeriodModelCopyWithImpl<$Res, RentalPeriodModel>;
  @useResult
  $Res call({String start, String end, UserModel user});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$RentalPeriodModelCopyWithImpl<$Res, $Val extends RentalPeriodModel>
    implements $RentalPeriodModelCopyWith<$Res> {
  _$RentalPeriodModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RentalPeriodModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ) as $Val);
  }

  /// Create a copy of RentalPeriodModel
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
abstract class _$$RentalPeriodModelImplCopyWith<$Res>
    implements $RentalPeriodModelCopyWith<$Res> {
  factory _$$RentalPeriodModelImplCopyWith(_$RentalPeriodModelImpl value,
          $Res Function(_$RentalPeriodModelImpl) then) =
      __$$RentalPeriodModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String start, String end, UserModel user});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$RentalPeriodModelImplCopyWithImpl<$Res>
    extends _$RentalPeriodModelCopyWithImpl<$Res, _$RentalPeriodModelImpl>
    implements _$$RentalPeriodModelImplCopyWith<$Res> {
  __$$RentalPeriodModelImplCopyWithImpl(_$RentalPeriodModelImpl _value,
      $Res Function(_$RentalPeriodModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RentalPeriodModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? user = null,
  }) {
    return _then(_$RentalPeriodModelImpl(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RentalPeriodModelImpl implements _RentalPeriodModel {
  const _$RentalPeriodModelImpl(
      {required this.start, required this.end, required this.user});

  factory _$RentalPeriodModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RentalPeriodModelImplFromJson(json);

  @override
  final String start;
  @override
  final String end;
  @override
  final UserModel user;

  @override
  String toString() {
    return 'RentalPeriodModel(start: $start, end: $end, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RentalPeriodModelImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, start, end, user);

  /// Create a copy of RentalPeriodModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RentalPeriodModelImplCopyWith<_$RentalPeriodModelImpl> get copyWith =>
      __$$RentalPeriodModelImplCopyWithImpl<_$RentalPeriodModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RentalPeriodModelImplToJson(
      this,
    );
  }
}

abstract class _RentalPeriodModel implements RentalPeriodModel {
  const factory _RentalPeriodModel(
      {required final String start,
      required final String end,
      required final UserModel user}) = _$RentalPeriodModelImpl;

  factory _RentalPeriodModel.fromJson(Map<String, dynamic> json) =
      _$RentalPeriodModelImpl.fromJson;

  @override
  String get start;
  @override
  String get end;
  @override
  UserModel get user;

  /// Create a copy of RentalPeriodModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RentalPeriodModelImplCopyWith<_$RentalPeriodModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
