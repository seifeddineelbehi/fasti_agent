// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RouteItemModel {
  String get id => throw _privateConstructorUsedError;
  String get hint => throw _privateConstructorUsedError;
  bool get prefillText => throw _privateConstructorUsedError;
  String? get selectedPlace => throw _privateConstructorUsedError;
  TextEditingController? get controller => throw _privateConstructorUsedError;

  /// Create a copy of RouteItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteItemModelCopyWith<RouteItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteItemModelCopyWith<$Res> {
  factory $RouteItemModelCopyWith(
          RouteItemModel value, $Res Function(RouteItemModel) then) =
      _$RouteItemModelCopyWithImpl<$Res, RouteItemModel>;
  @useResult
  $Res call(
      {String id,
      String hint,
      bool prefillText,
      String? selectedPlace,
      TextEditingController? controller});
}

/// @nodoc
class _$RouteItemModelCopyWithImpl<$Res, $Val extends RouteItemModel>
    implements $RouteItemModelCopyWith<$Res> {
  _$RouteItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hint = null,
    Object? prefillText = null,
    Object? selectedPlace = freezed,
    Object? controller = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hint: null == hint
          ? _value.hint
          : hint // ignore: cast_nullable_to_non_nullable
              as String,
      prefillText: null == prefillText
          ? _value.prefillText
          : prefillText // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedPlace: freezed == selectedPlace
          ? _value.selectedPlace
          : selectedPlace // ignore: cast_nullable_to_non_nullable
              as String?,
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RouteItemModelImplCopyWith<$Res>
    implements $RouteItemModelCopyWith<$Res> {
  factory _$$RouteItemModelImplCopyWith(_$RouteItemModelImpl value,
          $Res Function(_$RouteItemModelImpl) then) =
      __$$RouteItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String hint,
      bool prefillText,
      String? selectedPlace,
      TextEditingController? controller});
}

/// @nodoc
class __$$RouteItemModelImplCopyWithImpl<$Res>
    extends _$RouteItemModelCopyWithImpl<$Res, _$RouteItemModelImpl>
    implements _$$RouteItemModelImplCopyWith<$Res> {
  __$$RouteItemModelImplCopyWithImpl(
      _$RouteItemModelImpl _value, $Res Function(_$RouteItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RouteItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hint = null,
    Object? prefillText = null,
    Object? selectedPlace = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$RouteItemModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hint: null == hint
          ? _value.hint
          : hint // ignore: cast_nullable_to_non_nullable
              as String,
      prefillText: null == prefillText
          ? _value.prefillText
          : prefillText // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedPlace: freezed == selectedPlace
          ? _value.selectedPlace
          : selectedPlace // ignore: cast_nullable_to_non_nullable
              as String?,
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
    ));
  }
}

/// @nodoc

class _$RouteItemModelImpl extends _RouteItemModel {
  _$RouteItemModelImpl(
      {required this.id,
      required this.hint,
      required this.prefillText,
      this.selectedPlace,
      this.controller = null})
      : super._();

  @override
  final String id;
  @override
  final String hint;
  @override
  final bool prefillText;
  @override
  final String? selectedPlace;
  @override
  @JsonKey()
  final TextEditingController? controller;

  @override
  String toString() {
    return 'RouteItemModel(id: $id, hint: $hint, prefillText: $prefillText, selectedPlace: $selectedPlace, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hint, hint) || other.hint == hint) &&
            (identical(other.prefillText, prefillText) ||
                other.prefillText == prefillText) &&
            (identical(other.selectedPlace, selectedPlace) ||
                other.selectedPlace == selectedPlace) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, hint, prefillText, selectedPlace, controller);

  /// Create a copy of RouteItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteItemModelImplCopyWith<_$RouteItemModelImpl> get copyWith =>
      __$$RouteItemModelImplCopyWithImpl<_$RouteItemModelImpl>(
          this, _$identity);
}

abstract class _RouteItemModel extends RouteItemModel {
  factory _RouteItemModel(
      {required final String id,
      required final String hint,
      required final bool prefillText,
      final String? selectedPlace,
      final TextEditingController? controller}) = _$RouteItemModelImpl;
  _RouteItemModel._() : super._();

  @override
  String get id;
  @override
  String get hint;
  @override
  bool get prefillText;
  @override
  String? get selectedPlace;
  @override
  TextEditingController? get controller;

  /// Create a copy of RouteItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteItemModelImplCopyWith<_$RouteItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
