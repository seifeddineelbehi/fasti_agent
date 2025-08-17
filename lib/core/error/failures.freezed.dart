// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Failure {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) auth,
    required TResult Function(String message) network,
    required TResult Function(String message) user,
    required TResult Function(String message) unknown,
    required TResult Function(String message) emptyCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? auth,
    TResult? Function(String message)? network,
    TResult? Function(String message)? user,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? emptyCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? auth,
    TResult Function(String message)? network,
    TResult Function(String message)? user,
    TResult Function(String message)? unknown,
    TResult Function(String message)? emptyCache,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthFailure value) auth,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(UserFailure value) user,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(EmptyCacheFailure value) emptyCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(UserFailure value)? user,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(EmptyCacheFailure value)? emptyCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthFailure value)? auth,
    TResult Function(NetworkFailure value)? network,
    TResult Function(UserFailure value)? user,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(EmptyCacheFailure value)? emptyCache,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$AuthFailureImplCopyWith(
          _$AuthFailureImpl value, $Res Function(_$AuthFailureImpl) then) =
      __$$AuthFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$AuthFailureImpl>
    implements _$$AuthFailureImplCopyWith<$Res> {
  __$$AuthFailureImplCopyWithImpl(
      _$AuthFailureImpl _value, $Res Function(_$AuthFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AuthFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthFailureImpl implements AuthFailure {
  const _$AuthFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.auth(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthFailureImplCopyWith<_$AuthFailureImpl> get copyWith =>
      __$$AuthFailureImplCopyWithImpl<_$AuthFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) auth,
    required TResult Function(String message) network,
    required TResult Function(String message) user,
    required TResult Function(String message) unknown,
    required TResult Function(String message) emptyCache,
  }) {
    return auth(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? auth,
    TResult? Function(String message)? network,
    TResult? Function(String message)? user,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? emptyCache,
  }) {
    return auth?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? auth,
    TResult Function(String message)? network,
    TResult Function(String message)? user,
    TResult Function(String message)? unknown,
    TResult Function(String message)? emptyCache,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthFailure value) auth,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(UserFailure value) user,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(EmptyCacheFailure value) emptyCache,
  }) {
    return auth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(UserFailure value)? user,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(EmptyCacheFailure value)? emptyCache,
  }) {
    return auth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthFailure value)? auth,
    TResult Function(NetworkFailure value)? network,
    TResult Function(UserFailure value)? user,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(EmptyCacheFailure value)? emptyCache,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(this);
    }
    return orElse();
  }
}

abstract class AuthFailure implements Failure {
  const factory AuthFailure(final String message) = _$AuthFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthFailureImplCopyWith<_$AuthFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(_$NetworkFailureImpl value,
          $Res Function(_$NetworkFailureImpl) then) =
      __$$NetworkFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
      _$NetworkFailureImpl _value, $Res Function(_$NetworkFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$NetworkFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NetworkFailureImpl implements NetworkFailure {
  const _$NetworkFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.network(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      __$$NetworkFailureImplCopyWithImpl<_$NetworkFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) auth,
    required TResult Function(String message) network,
    required TResult Function(String message) user,
    required TResult Function(String message) unknown,
    required TResult Function(String message) emptyCache,
  }) {
    return network(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? auth,
    TResult? Function(String message)? network,
    TResult? Function(String message)? user,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? emptyCache,
  }) {
    return network?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? auth,
    TResult Function(String message)? network,
    TResult Function(String message)? user,
    TResult Function(String message)? unknown,
    TResult Function(String message)? emptyCache,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthFailure value) auth,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(UserFailure value) user,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(EmptyCacheFailure value) emptyCache,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(UserFailure value)? user,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(EmptyCacheFailure value)? emptyCache,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthFailure value)? auth,
    TResult Function(NetworkFailure value)? network,
    TResult Function(UserFailure value)? user,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(EmptyCacheFailure value)? emptyCache,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure implements Failure {
  const factory NetworkFailure(final String message) = _$NetworkFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UserFailureImplCopyWith(
          _$UserFailureImpl value, $Res Function(_$UserFailureImpl) then) =
      __$$UserFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UserFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UserFailureImpl>
    implements _$$UserFailureImplCopyWith<$Res> {
  __$$UserFailureImplCopyWithImpl(
      _$UserFailureImpl _value, $Res Function(_$UserFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UserFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UserFailureImpl implements UserFailure {
  const _$UserFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.user(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserFailureImplCopyWith<_$UserFailureImpl> get copyWith =>
      __$$UserFailureImplCopyWithImpl<_$UserFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) auth,
    required TResult Function(String message) network,
    required TResult Function(String message) user,
    required TResult Function(String message) unknown,
    required TResult Function(String message) emptyCache,
  }) {
    return user(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? auth,
    TResult? Function(String message)? network,
    TResult? Function(String message)? user,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? emptyCache,
  }) {
    return user?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? auth,
    TResult Function(String message)? network,
    TResult Function(String message)? user,
    TResult Function(String message)? unknown,
    TResult Function(String message)? emptyCache,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthFailure value) auth,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(UserFailure value) user,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(EmptyCacheFailure value) emptyCache,
  }) {
    return user(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(UserFailure value)? user,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(EmptyCacheFailure value)? emptyCache,
  }) {
    return user?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthFailure value)? auth,
    TResult Function(NetworkFailure value)? network,
    TResult Function(UserFailure value)? user,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(EmptyCacheFailure value)? emptyCache,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(this);
    }
    return orElse();
  }
}

abstract class UserFailure implements Failure {
  const factory UserFailure(final String message) = _$UserFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserFailureImplCopyWith<_$UserFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnknownFailureImplCopyWith(_$UnknownFailureImpl value,
          $Res Function(_$UnknownFailureImpl) then) =
      __$$UnknownFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UnknownFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnknownFailureImpl>
    implements _$$UnknownFailureImplCopyWith<$Res> {
  __$$UnknownFailureImplCopyWithImpl(
      _$UnknownFailureImpl _value, $Res Function(_$UnknownFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UnknownFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UnknownFailureImpl implements UnknownFailure {
  const _$UnknownFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.unknown(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      __$$UnknownFailureImplCopyWithImpl<_$UnknownFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) auth,
    required TResult Function(String message) network,
    required TResult Function(String message) user,
    required TResult Function(String message) unknown,
    required TResult Function(String message) emptyCache,
  }) {
    return unknown(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? auth,
    TResult? Function(String message)? network,
    TResult? Function(String message)? user,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? emptyCache,
  }) {
    return unknown?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? auth,
    TResult Function(String message)? network,
    TResult Function(String message)? user,
    TResult Function(String message)? unknown,
    TResult Function(String message)? emptyCache,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthFailure value) auth,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(UserFailure value) user,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(EmptyCacheFailure value) emptyCache,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(UserFailure value)? user,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(EmptyCacheFailure value)? emptyCache,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthFailure value)? auth,
    TResult Function(NetworkFailure value)? network,
    TResult Function(UserFailure value)? user,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(EmptyCacheFailure value)? emptyCache,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownFailure implements Failure {
  const factory UnknownFailure(final String message) = _$UnknownFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmptyCacheFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$EmptyCacheFailureImplCopyWith(_$EmptyCacheFailureImpl value,
          $Res Function(_$EmptyCacheFailureImpl) then) =
      __$$EmptyCacheFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$EmptyCacheFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$EmptyCacheFailureImpl>
    implements _$$EmptyCacheFailureImplCopyWith<$Res> {
  __$$EmptyCacheFailureImplCopyWithImpl(_$EmptyCacheFailureImpl _value,
      $Res Function(_$EmptyCacheFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$EmptyCacheFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EmptyCacheFailureImpl implements EmptyCacheFailure {
  const _$EmptyCacheFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.emptyCache(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmptyCacheFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmptyCacheFailureImplCopyWith<_$EmptyCacheFailureImpl> get copyWith =>
      __$$EmptyCacheFailureImplCopyWithImpl<_$EmptyCacheFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) auth,
    required TResult Function(String message) network,
    required TResult Function(String message) user,
    required TResult Function(String message) unknown,
    required TResult Function(String message) emptyCache,
  }) {
    return emptyCache(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? auth,
    TResult? Function(String message)? network,
    TResult? Function(String message)? user,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? emptyCache,
  }) {
    return emptyCache?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? auth,
    TResult Function(String message)? network,
    TResult Function(String message)? user,
    TResult Function(String message)? unknown,
    TResult Function(String message)? emptyCache,
    required TResult orElse(),
  }) {
    if (emptyCache != null) {
      return emptyCache(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthFailure value) auth,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(UserFailure value) user,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(EmptyCacheFailure value) emptyCache,
  }) {
    return emptyCache(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(UserFailure value)? user,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(EmptyCacheFailure value)? emptyCache,
  }) {
    return emptyCache?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthFailure value)? auth,
    TResult Function(NetworkFailure value)? network,
    TResult Function(UserFailure value)? user,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(EmptyCacheFailure value)? emptyCache,
    required TResult orElse(),
  }) {
    if (emptyCache != null) {
      return emptyCache(this);
    }
    return orElse();
  }
}

abstract class EmptyCacheFailure implements Failure {
  const factory EmptyCacheFailure(final String message) =
      _$EmptyCacheFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmptyCacheFailureImplCopyWith<_$EmptyCacheFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
