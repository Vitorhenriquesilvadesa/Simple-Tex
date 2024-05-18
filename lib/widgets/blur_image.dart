import 'dart:ui';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BlurImage extends StatelessWidget {
  String imagePath;
  double blurIntensity;
  double opacity;

  BlurImage({
    super.key,
    required this.imagePath,
    required this.blurIntensity,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurIntensity,
          sigmaY: blurIntensity,
        ),
        child: Container(
          color: Colors.black.withOpacity(opacity),
        ),
      ),
    );
  }
}
