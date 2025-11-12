import 'package:flutter/material.dart';
import 'package:tactix/core/locator/injection.dart';
import 'package:tactix/presentation/resource/style_manager.dart';
import 'package:tactix/presentation/resource/values_manager.dart';


import 'color_manager.dart';


class ThemeManager {
  ThemeManager._(); // private constructor

  /// App light resource
  static ThemeData get lightTheme {
    final metrics = getIt<AppMetrics>();
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // --- Color Scheme ---
      colorScheme: const ColorScheme.light(
        primary: ColorManager.primary,
        surface: ColorManager.lightBackground,
        secondary: ColorManager.lightSecondary,
        surfaceContainerHighest: ColorManager.lightText, // Text on background
        onSurface: ColorManager.lightText,    // Text on components
      ),

      // --- Backgrounds ---
      scaffoldBackgroundColor: ColorManager.lightBackground,

      // --- Text Theme ---
      textTheme: TextTheme(
        headlineMedium: StyleManager.headlineMediumLight.copyWith(
            fontSize: metrics.f20
        ),
        bodyLarge: StyleManager.bodyLargeLight.copyWith(
            fontSize: metrics.f16
        ),
      ),

      // --- AppBar Theme ---
      appBarTheme: AppBarTheme(
        backgroundColor: ColorManager.lightBackground,
        elevation: 0,
        titleTextStyle: StyleManager.headlineMediumLight.copyWith(fontSize: metrics.f20),
        iconTheme: const IconThemeData(color: ColorManager.lightText),
      ),

      // --- ElevatedButton Theme ---
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.text, // Text on button
          padding: EdgeInsets.symmetric(
            horizontal: metrics.p20,
            vertical: metrics.p16,
          ),
          textStyle: StyleManager.bodyLargeDark.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: metrics.f16
          ),
        ),
      ),

      // --- SegmentedButton Theme ---
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return ColorManager.primary;
              }
              return ColorManager.lightAccent; // Unselected color
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return ColorManager.text;
              }
              return ColorManager.lightText; // Unselected text
            },
          ),
          iconColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return ColorManager.text;
              }
              return ColorManager.lightText;
            },
          ),
        ),
      ),
    );
  }

  /// App dark resource (from our previous work)
  static ThemeData get darkTheme {
    final metrics = getIt<AppMetrics>();
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // --- Color Scheme ---
      colorScheme: const ColorScheme.dark(
        primary: ColorManager.primary,
        surface: ColorManager.background,
        secondary: ColorManager.secondary,
        surfaceContainerHighest: ColorManager.text,
        onSurface: ColorManager.text,
      ),

      // --- Backgrounds ---
      scaffoldBackgroundColor: ColorManager.background,

      // --- Text Theme ---
      textTheme: TextTheme(
        headlineMedium: StyleManager.headlineMediumDark.copyWith(
            fontSize: metrics.f20
        ),
        bodyLarge: StyleManager.bodyLargeDark.copyWith(
            fontSize: metrics.f16
        ),
      ),

      // --- AppBar Theme ---
      appBarTheme: AppBarTheme(
        backgroundColor: ColorManager.background,
        elevation: 0,
        titleTextStyle: StyleManager.headlineMediumDark.copyWith(fontSize: metrics.f20),
      ),

      // --- ElevatedButton Theme ---
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.text,
          padding: EdgeInsets.symmetric(
            horizontal: metrics.p20,
            vertical: metrics.p16,
          ),
          textStyle: StyleManager.bodyLargeDark.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: metrics.f16
          ),
        ),
      ),

      // --- SegmentedButton Theme ---
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return ColorManager.primary;
              }
              return ColorManager.accent; // Unselected color
            },
          ),
          foregroundColor: WidgetStateProperty.all(ColorManager.text),
          iconColor: WidgetStateProperty.all(ColorManager.text),
        ),
      ),
    );
  }
}
