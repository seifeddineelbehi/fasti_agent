import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:flutter/material.dart';

class FullscreenLoader extends StatelessWidget {
  const FullscreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        // Black semi-transparent background
        Opacity(
          opacity: 0.6,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        // Centered CircularProgressIndicator
        Center(
          child: CircularProgressIndicator(
            color: Palette.mainDarkColor, // Optional: customize color
          ),
        ),
      ],
    );
  }
}
