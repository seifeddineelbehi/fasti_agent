import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtons {
  static simpleButton({
    required void Function()? onPressed,
    required String text,
    bool? isLoading = false,
    double? width,
  }) {
    return SizedBox(
      width: width ?? 1.0.sw,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.mainDarkColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
        ),
        child: isLoading == true
            ? SizedBox(
                height: 20.sp,
                width: 20.sp,
                child: const CircularProgressIndicator(
                  color: Palette.mainDarkColor,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  height: 0,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: Palette.whiteColor,
                ),
              ),
      ),
    );
  }

  static simpleLongButton({
    required void Function()? onPressed,
    bool isLoading = false,
    required String text,
  }) {
    return SizedBox(
      width: 1.0.sw,
      height: 70.sp,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.mainDarkColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                height: 16.sp,
                width: 16.sp,
                child: CircularProgressIndicator(
                  color: Palette.whiteColor,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Palette.whiteColor,
                ),
              ),
      ),
    );
  }

  static simpleLongButtonWithIcon({
    required void Function()? onPressed,
    required String text,
    required Widget icon,
    double? width,
    double? height,
  }) {
    return SizedBox(
      width: width ?? 1.0.sw,
      height: height ?? 70.sp,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.mainDarkColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
        ),
        icon: icon,
        label: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            color: Palette.whiteColor,
          ),
        ),
      ),
    );
  }

  static circularButtonWithIconAndTooltip({
    required void Function()? onTap,
    required String tooltip,
    required IconData icon,
    required Color? color,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: tooltip,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
