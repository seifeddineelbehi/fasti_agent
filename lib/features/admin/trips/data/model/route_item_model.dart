import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_item_model.freezed.dart';

@freezed
class RouteItemModel with _$RouteItemModel {
  const RouteItemModel._(); // Needed for custom methods

  factory RouteItemModel({
    required String id,
    required String hint,
    required bool prefillText,
    String? selectedPlace,
    @Default(null) TextEditingController? controller,
  }) = _RouteItemModel;

  /// Always returns a controller instance (creates one if null)
  TextEditingController get safeController =>
      controller ?? TextEditingController();

  void dispose() {
    controller?.dispose();
  }
}
