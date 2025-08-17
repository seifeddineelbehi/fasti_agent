// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_rating_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserRatingModel _$UserRatingModelFromJson(Map<String, dynamic> json) {
  return _UserRatingModel.fromJson(json);
}

/// @nodoc
mixin _$UserRatingModel {
  UserModel get user => throw _privateConstructorUsedError;
  double get ratingGiven => throw _privateConstructorUsedError;

  /// Serializes this UserRatingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserRatingModelCopyWith<UserRatingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRatingModelCopyWith<$Res> {
  factory $UserRatingModelCopyWith(
          UserRatingModel value, $Res Function(UserRatingModel) then) =
      _$UserRatingModelCopyWithImpl<$Res, UserRatingModel>;
  @useResult
  $Res call({UserModel user, double ratingGiven});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$UserRatingModelCopyWithImpl<$Res, $Val extends UserRatingModel>
    implements $UserRatingModelCopyWith<$Res> {
  _$UserRatingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? ratingGiven = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      ratingGiven: null == ratingGiven
          ? _value.ratingGiven
          : ratingGiven // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  /// Create a copy of UserRatingModel
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
abstract class _$$UserRatingModelImplCopyWith<$Res>
    implements $UserRatingModelCopyWith<$Res> {
  factory _$$UserRatingModelImplCopyWith(_$UserRatingModelImpl value,
          $Res Function(_$UserRatingModelImpl) then) =
      __$$UserRatingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserModel user, double ratingGiven});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$UserRatingModelImplCopyWithImpl<$Res>
    extends _$UserRatingModelCopyWithImpl<$Res, _$UserRatingModelImpl>
    implements _$$UserRatingModelImplCopyWith<$Res> {
  __$$UserRatingModelImplCopyWithImpl(
      _$UserRatingModelImpl _value, $Res Function(_$UserRatingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? ratingGiven = null,
  }) {
    return _then(_$UserRatingModelImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      ratingGiven: null == ratingGiven
          ? _value.ratingGiven
          : ratingGiven // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserRatingModelImpl implements _UserRatingModel {
  const _$UserRatingModelImpl({required this.user, required this.ratingGiven});

  factory _$UserRatingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserRatingModelImplFromJson(json);

  @override
  final UserModel user;
  @override
  final double ratingGiven;

  @override
  String toString() {
    return 'UserRatingModel(user: $user, ratingGiven: $ratingGiven)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRatingModelImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.ratingGiven, ratingGiven) ||
                other.ratingGiven == ratingGiven));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, ratingGiven);

  /// Create a copy of UserRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserRatingModelImplCopyWith<_$UserRatingModelImpl> get copyWith =>
      __$$UserRatingModelImplCopyWithImpl<_$UserRatingModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserRatingModelImplToJson(
      this,
    );
  }
}

abstract class _UserRatingModel implements UserRatingModel {
  const factory _UserRatingModel(
      {required final UserModel user,
      required final double ratingGiven}) = _$UserRatingModelImpl;

  factory _UserRatingModel.fromJson(Map<String, dynamic> json) =
      _$UserRatingModelImpl.fromJson;

  @override
  UserModel get user;
  @override
  double get ratingGiven;

  /// Create a copy of UserRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserRatingModelImplCopyWith<_$UserRatingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
