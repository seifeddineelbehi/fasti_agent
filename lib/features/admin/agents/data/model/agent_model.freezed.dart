// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentModel _$AgentModelFromJson(Map<String, dynamic> json) {
  return _AgentModel.fromJson(json);
}

/// @nodoc
mixin _$AgentModel {
  String get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get photoUrl => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String get role =>
      throw _privateConstructorUsedError; // 'super_admin', 'car_agent', 'trip_agent', etc.
  List<String> get permissions => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;
  String get createdByAdminId => throw _privateConstructorUsedError;
  String get createdByAdminName => throw _privateConstructorUsedError;

  /// Serializes this AgentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AgentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgentModelCopyWith<AgentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentModelCopyWith<$Res> {
  factory $AgentModelCopyWith(
          AgentModel value, $Res Function(AgentModel) then) =
      _$AgentModelCopyWithImpl<$Res, AgentModel>;
  @useResult
  $Res call(
      {String id,
      String firstName,
      String lastName,
      String email,
      String phone,
      String photoUrl,
      bool isActive,
      String role,
      List<String> permissions,
      DateTime createdAt,
      DateTime? lastLoginAt,
      String createdByAdminId,
      String createdByAdminName});
}

/// @nodoc
class _$AgentModelCopyWithImpl<$Res, $Val extends AgentModel>
    implements $AgentModelCopyWith<$Res> {
  _$AgentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AgentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phone = null,
    Object? photoUrl = null,
    Object? isActive = null,
    Object? role = null,
    Object? permissions = null,
    Object? createdAt = null,
    Object? lastLoginAt = freezed,
    Object? createdByAdminId = null,
    Object? createdByAdminName = null,
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
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdByAdminId: null == createdByAdminId
          ? _value.createdByAdminId
          : createdByAdminId // ignore: cast_nullable_to_non_nullable
              as String,
      createdByAdminName: null == createdByAdminName
          ? _value.createdByAdminName
          : createdByAdminName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentModelImplCopyWith<$Res>
    implements $AgentModelCopyWith<$Res> {
  factory _$$AgentModelImplCopyWith(
          _$AgentModelImpl value, $Res Function(_$AgentModelImpl) then) =
      __$$AgentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String firstName,
      String lastName,
      String email,
      String phone,
      String photoUrl,
      bool isActive,
      String role,
      List<String> permissions,
      DateTime createdAt,
      DateTime? lastLoginAt,
      String createdByAdminId,
      String createdByAdminName});
}

/// @nodoc
class __$$AgentModelImplCopyWithImpl<$Res>
    extends _$AgentModelCopyWithImpl<$Res, _$AgentModelImpl>
    implements _$$AgentModelImplCopyWith<$Res> {
  __$$AgentModelImplCopyWithImpl(
      _$AgentModelImpl _value, $Res Function(_$AgentModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AgentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phone = null,
    Object? photoUrl = null,
    Object? isActive = null,
    Object? role = null,
    Object? permissions = null,
    Object? createdAt = null,
    Object? lastLoginAt = freezed,
    Object? createdByAdminId = null,
    Object? createdByAdminName = null,
  }) {
    return _then(_$AgentModelImpl(
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
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdByAdminId: null == createdByAdminId
          ? _value.createdByAdminId
          : createdByAdminId // ignore: cast_nullable_to_non_nullable
              as String,
      createdByAdminName: null == createdByAdminName
          ? _value.createdByAdminName
          : createdByAdminName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentModelImpl implements _AgentModel {
  const _$AgentModelImpl(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      this.photoUrl = '',
      this.isActive = true,
      required this.role,
      required final List<String> permissions,
      required this.createdAt,
      this.lastLoginAt,
      this.createdByAdminId = '',
      this.createdByAdminName = ''})
      : _permissions = permissions;

  factory _$AgentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentModelImplFromJson(json);

  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String phone;
  @override
  @JsonKey()
  final String photoUrl;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String role;
// 'super_admin', 'car_agent', 'trip_agent', etc.
  final List<String> _permissions;
// 'super_admin', 'car_agent', 'trip_agent', etc.
  @override
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? lastLoginAt;
  @override
  @JsonKey()
  final String createdByAdminId;
  @override
  @JsonKey()
  final String createdByAdminName;

  @override
  String toString() {
    return 'AgentModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, photoUrl: $photoUrl, isActive: $isActive, role: $role, permissions: $permissions, createdAt: $createdAt, lastLoginAt: $lastLoginAt, createdByAdminId: $createdByAdminId, createdByAdminName: $createdByAdminName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.createdByAdminId, createdByAdminId) ||
                other.createdByAdminId == createdByAdminId) &&
            (identical(other.createdByAdminName, createdByAdminName) ||
                other.createdByAdminName == createdByAdminName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      firstName,
      lastName,
      email,
      phone,
      photoUrl,
      isActive,
      role,
      const DeepCollectionEquality().hash(_permissions),
      createdAt,
      lastLoginAt,
      createdByAdminId,
      createdByAdminName);

  /// Create a copy of AgentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentModelImplCopyWith<_$AgentModelImpl> get copyWith =>
      __$$AgentModelImplCopyWithImpl<_$AgentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentModelImplToJson(
      this,
    );
  }
}

abstract class _AgentModel implements AgentModel {
  const factory _AgentModel(
      {required final String id,
      required final String firstName,
      required final String lastName,
      required final String email,
      required final String phone,
      final String photoUrl,
      final bool isActive,
      required final String role,
      required final List<String> permissions,
      required final DateTime createdAt,
      final DateTime? lastLoginAt,
      final String createdByAdminId,
      final String createdByAdminName}) = _$AgentModelImpl;

  factory _AgentModel.fromJson(Map<String, dynamic> json) =
      _$AgentModelImpl.fromJson;

  @override
  String get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get phone;
  @override
  String get photoUrl;
  @override
  bool get isActive;
  @override
  String get role; // 'super_admin', 'car_agent', 'trip_agent', etc.
  @override
  List<String> get permissions;
  @override
  DateTime get createdAt;
  @override
  DateTime? get lastLoginAt;
  @override
  String get createdByAdminId;
  @override
  String get createdByAdminName;

  /// Create a copy of AgentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgentModelImplCopyWith<_$AgentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
