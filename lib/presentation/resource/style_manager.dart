import 'color_manager.dart';
import 'package:flutter/material.dart';

class StyleManager {
  StyleManager._();

  static final TextStyle _baseTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// --- Dark Text Styles ---
  static TextStyle get headlineMediumDark {
    return _baseTextStyle.copyWith(
      color: ColorManager.text,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
  }

  static TextStyle get bodyLargeDark {
    return _baseTextStyle.copyWith(
      color: ColorManager.text,
      fontSize: 16,
    );
  }

  /// --- Light Text Styles ---
  static TextStyle get headlineMediumLight {
    return _baseTextStyle.copyWith(
      color: ColorManager.lightText,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
  }

  static TextStyle get bodyLargeLight {
    return _baseTextStyle.copyWith(
      color: ColorManager.lightText,
      fontSize: 16,
    );
  }
}
