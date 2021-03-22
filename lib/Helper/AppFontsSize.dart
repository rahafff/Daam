import 'package:flutter/material.dart';

import '../DataStore.dart';

abstract class AppFontsSize {
  static const double xx_small_font_size = 9.0;
  static const double x_small_font_size = 10.0;
  static const double halfx_small_font_size = 11.5;
  static const double small_font_size = 12.0;
  static const double medium_font_size = 14.0;
  static const double normal_font_size = 16.0;
  static const double large_font_size = 20.0;
  static const double x_large_font_size = 35.0;

  static getScale(langCode, screenSize) {
    double scale = 1;

    if (screenSize != null) {
      if (screenSize.width <= 320) {
        // iPhone 4 & 5 (480 - 568)
        scale = 0.8;
      } else if (screenSize.width > 320) {
        // iPhone 6 & 7 (667)
        scale = 0.95;
      } else {
        // iPhone 6+ & 7+ (736)
        scale = 1.0;
      }
    }

    if (langCode == "ar") {
      scale *= 1;
    } else {
      scale *= 1;
    }

    return scale;
  }

  static getScaledFontSize(double fontSize, {Size screenSize}) =>
      fontSize * getScale(dataStore.lang, screenSize);
}
