// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_role_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentRoleModel _$AgentRoleModelFromJson(Map<String, dynamic> json) {
  return _AgentRoleModel.fromJson(json);
}

/// @nodoc
mixin _$AgentRoleModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AgentRoleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AgentRoleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgentRoleModelCopyWith<AgentRoleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentRoleModelCopyWith<$Res> {
  factory $AgentRoleModelCopyWith(
          AgentRoleModel value, $Res Function(AgentRoleModel) then) =
      _$AgentRoleModelCopyWithImpl<$Res, AgentRoleModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<String> permissions,
      bool isActive,
      DateTime createdAt});
}

/// @nodoc
class _$AgentRoleModelCopyWithImpl<$Res, $Val extends AgentRoleModel>
    implements $AgentRoleModelCopyWith<$Res> {
  _$AgentRoleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AgentRoleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? permissions = null,
    Object? isActive = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentRoleModelImplCopyWith<$Res>
    implements $AgentRoleModelCopyWith<$Res> {
  factory _$$AgentRoleModelImplCopyWith(_$AgentRoleModelImpl value,
          $Res Function(_$AgentRoleModelImpl) then) =
      __$$AgentRoleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<String> permissions,
      bool isActive,
      DateTime createdAt});
}

/// @nodoc
class __$$AgentRoleModelImplCopyWithImpl<$Res>
    extends _$AgentRoleModelCopyWithImpl<$Res, _$AgentRoleModelImpl>
    implements _$$AgentRoleModelImplCopyWith<$Res> {
  __$$AgentRoleModelImplCopyWithImpl(
      _$AgentRoleModelImpl _value, $Res Function(_$AgentRoleModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AgentRoleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? permissions = null,
    Object? isActive = null,
    Object? createdAt = null,
  }) {
    return _then(_$AgentRoleModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentRoleModelImpl implements _AgentRoleModel {
  const _$AgentRoleModelImpl(
      {required this.id,
      required this.name,
      required this.description,
      required final List<String> permissions,
      this.isActive = true,
      required this.createdAt})
      : _permissions = permissions;

  factory _$AgentRoleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentRoleModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  final List<String> _permissions;
  @override
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'AgentRoleModel(id: $id, name: $name, description: $description, permissions: $permissions, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgentRoleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description,
      const DeepCollectionEquality().hash(_permissions), isActive, createdAt);

  /// Create a copy of AgentRoleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentRoleModelImplCopyWith<_$AgentRoleModelImpl> get copyWith =>
      __$$AgentRoleModelImplCopyWithImpl<_$AgentRoleModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentRoleModelImplToJson(
      this,
    );
  }
}

abstract class _AgentRoleModel implements AgentRoleModel {
  const factory _AgentRoleModel(
      {required final String id,
      required final String name,
      required final String description,
      required final List<String> permissions,
      final bool isActive,
      required final DateTime createdAt}) = _$AgentRoleModelImpl;

  factory _AgentRoleModel.fromJson(Map<String, dynamic> json) =
      _$AgentRoleModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  List<String> get permissions;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;

  /// Create a copy of AgentRoleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgentRoleModelImplCopyWith<_$AgentRoleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
