// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_agent_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateAgentRequestModel _$CreateAgentRequestModelFromJson(
    Map<String, dynamic> json) {
  return _CreateAgentRequestModel.fromJson(json);
}

/// @nodoc
mixin _$CreateAgentRequestModel {
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;
  String get photoUrl => throw _privateConstructorUsedError;

  /// Serializes this CreateAgentRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateAgentRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateAgentRequestModelCopyWith<CreateAgentRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateAgentRequestModelCopyWith<$Res> {
  factory $CreateAgentRequestModelCopyWith(CreateAgentRequestModel value,
          $Res Function(CreateAgentRequestModel) then) =
      _$CreateAgentRequestModelCopyWithImpl<$Res, CreateAgentRequestModel>;
  @useResult
  $Res call(
      {String firstName,
      String lastName,
      String email,
      String phone,
      String password,
      String role,
      List<String> permissions,
      String photoUrl});
}

/// @nodoc
class _$CreateAgentRequestModelCopyWithImpl<$Res,
        $Val extends CreateAgentRequestModel>
    implements $CreateAgentRequestModelCopyWith<$Res> {
  _$CreateAgentRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateAgentRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phone = null,
    Object? password = null,
    Object? role = null,
    Object? permissions = null,
    Object? photoUrl = null,
  }) {
    return _then(_value.copyWith(
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateAgentRequestModelImplCopyWith<$Res>
    implements $CreateAgentRequestModelCopyWith<$Res> {
  factory _$$CreateAgentRequestModelImplCopyWith(
          _$CreateAgentRequestModelImpl value,
          $Res Function(_$CreateAgentRequestModelImpl) then) =
      __$$CreateAgentRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String firstName,
      String lastName,
      String email,
      String phone,
      String password,
      String role,
      List<String> permissions,
      String photoUrl});
}

/// @nodoc
class __$$CreateAgentRequestModelImplCopyWithImpl<$Res>
    extends _$CreateAgentRequestModelCopyWithImpl<$Res,
        _$CreateAgentRequestModelImpl>
    implements _$$CreateAgentRequestModelImplCopyWith<$Res> {
  __$$CreateAgentRequestModelImplCopyWithImpl(
      _$CreateAgentRequestModelImpl _value,
      $Res Function(_$CreateAgentRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateAgentRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phone = null,
    Object? password = null,
    Object? role = null,
    Object? permissions = null,
    Object? photoUrl = null,
  }) {
    return _then(_$CreateAgentRequestModelImpl(
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateAgentRequestModelImpl implements _CreateAgentRequestModel {
  const _$CreateAgentRequestModelImpl(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.password,
      required this.role,
      required final List<String> permissions,
      this.photoUrl = ''})
      : _permissions = permissions;

  factory _$CreateAgentRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateAgentRequestModelImplFromJson(json);

  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String phone;
  @override
  final String password;
  @override
  final String role;
  final List<String> _permissions;
  @override
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  @JsonKey()
  final String photoUrl;

  @override
  String toString() {
    return 'CreateAgentRequestModel(firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, password: $password, role: $role, permissions: $permissions, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateAgentRequestModelImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      firstName,
      lastName,
      email,
      phone,
      password,
      role,
      const DeepCollectionEquality().hash(_permissions),
      photoUrl);

  /// Create a copy of CreateAgentRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateAgentRequestModelImplCopyWith<_$CreateAgentRequestModelImpl>
      get copyWith => __$$CreateAgentRequestModelImplCopyWithImpl<
          _$CreateAgentRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateAgentRequestModelImplToJson(
      this,
    );
  }
}

abstract class _CreateAgentRequestModel implements CreateAgentRequestModel {
  const factory _CreateAgentRequestModel(
      {required final String firstName,
      required final String lastName,
      required final String email,
      required final String phone,
      required final String password,
      required final String role,
      required final List<String> permissions,
      final String photoUrl}) = _$CreateAgentRequestModelImpl;

  factory _CreateAgentRequestModel.fromJson(Map<String, dynamic> json) =
      _$CreateAgentRequestModelImpl.fromJson;

  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get phone;
  @override
  String get password;
  @override
  String get role;
  @override
  List<String> get permissions;
  @override
  String get photoUrl;

  /// Create a copy of CreateAgentRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateAgentRequestModelImplCopyWith<_$CreateAgentRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
