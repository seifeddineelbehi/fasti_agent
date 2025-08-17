import 'package:flutter/material.dart';

class CommonText {
  static textBoldWeight400(
      {required String text,
      double? fontSize,
      Color? color,
      int maxLine = 1,
      TextAlign? textAlign,
      FontWeight fontWeight = FontWeight.w400}) {
    return SelectableText(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      style: TextStyle(
        height: 0,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  static Widget textBoldWeight500(
      {required String text,
      double? fontSize,
      Color? color,
      height = 0.0,
      final TextAlign? textAlign,
      TextOverflow textOverflow = TextOverflow.ellipsis,
      int maxLine = 1,
      TextDecoration textDecoration = TextDecoration.none,
      FontWeight fontWeight = FontWeight.w500}) {
    return SelectableText(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      style: TextStyle(
        height: height,
        fontWeight: fontWeight,
        decoration: textDecoration,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  static Widget textBoldWeight600(
      {required String text,
      double? fontSize,
      double? height,
      GestureTapCallback? onTap,
      Color? color,
      TextAlign textAlign = TextAlign.left,
      // TextOverflow textOverflow = TextOverflow.ellipsis,
      int maxLine = 1,
      FontWeight fontWeight = FontWeight.w600}) {
    return SelectableText(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        height: height,
        color: color,
      ),
    );
  }

  static textBoldWeight700({
    required String text,
    double? fontSize,
    Color? color,
    int maxLine = 1,
    TextDecoration textDecoration = TextDecoration.none,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    return SelectableText(
      text,
      maxLines: maxLine,
      style: TextStyle(
        height: 0,
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        decoration: textDecoration,
        color: color,
      ),
    );
  }
}
