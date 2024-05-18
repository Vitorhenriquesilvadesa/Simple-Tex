import 'package:flutter/material.dart';
import 'package:simple_tex/CoreX/core_xperience.dart';

final class AppConfig {
  static double publicationCardHeight = CoreX.device.logicalHeight / 15;
  static double publicationCardWidth = CoreX.device.logicalWidth;
  static double publicationWidth = CoreX.device.logicalWidth;
  static double publicationMinizedHeight = CoreX.device.logicalHeight / 18;
  static double publicationMaxHeight = CoreX.device.logicalHeight / 4;
  static double publicationIconsSize = CoreX.device.logicalHeight / 16;
  static double publicationProfileIconSize = CoreX.device.logicalHeight / 12;
  static double publicationProfileFontSize = CoreX.device.logicalWidth / 80;
}

final class AppColors {
  static const Map<Palette, Color> _colors = {
    Palette.cardMainColor: Color.fromRGBO(20, 20, 20, 1),
    Palette.cardBackgroundColor: Color.fromRGBO(5, 5, 5, 1),
    Palette.codeScopeHeader: Color.fromARGB(255, 42, 42, 42),
    Palette.likedColor: Color.fromARGB(255, 255, 44, 65),
    Palette.languageTabColor: Color.fromARGB(255, 79, 79, 79),
  };

  static Color get(Palette color) {
    return _colors[color]!;
  }
}

enum Palette {
  cardMainColor,
  cardBackgroundColor,
  codeScopeHeader,
  languageTabColor,
  likedColor
}
