import 'package:flutter/material.dart';

class GradiantCustomButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final bool disabled;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const GradiantCustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 44.0,
    this.disabled = false,
    this.gradient = const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return !disabled
        ? InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(20),
            child: Ink(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: borderRadius,
              ),
              child: Center(child: child),
            ),
          )
        : Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: gradient,
            ),
            child: Center(child: child),
          );
  }
}
