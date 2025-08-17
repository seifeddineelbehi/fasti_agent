import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField {
  static driverRegistration({
    required TextEditingController firstNameController,
    String? Function(String?)? validator,
    TextInputType? keyboardType = TextInputType.text,
    required String hint,
  }) {
    return TextFormField(
      controller: firstNameController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: hint,
        floatingLabelBehavior:
            FloatingLabelBehavior.never, // Keep label inside the box
        filled: true,
        fillColor: Palette.lightGreyColor,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8.sp),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
        ),
      ),
      validator:
          validator ?? (value) => value?.isEmpty ?? true ? 'Required' : null,
    );
  }
}
