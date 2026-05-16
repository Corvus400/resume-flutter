import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData light() {
    final colorScheme = const ColorScheme.light(
      brightness: Brightness.light,
      surface: AppColors.surface,
      onSurface: AppColors.ink900,
      surfaceContainerLowest: AppColors.surface,
      surfaceContainerLow: AppColors.bg,
      surfaceContainer: AppColors.surfaceAlt,
      surfaceContainerHigh: AppColors.surfaceSunk,
      surfaceContainerHighest: AppColors.lineSoft,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.primary,
      secondary: AppColors.accent,
      onSecondary: AppColors.onPrimary,
      secondaryContainer: AppColors.accentSoft,
      onSecondaryContainer: AppColors.accent,
      error: AppColors.error,
    );

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.bg,
      canvasColor: AppColors.bg,
      cardColor: AppColors.surface,
      dividerColor: AppColors.line,
      hoverColor: AppColors.primaryContainer.withValues(alpha: 0.25),
      splashColor: AppColors.primaryContainer.withValues(alpha: 0.35),
      highlightColor: AppColors.primaryContainer.withValues(alpha: 0.2),
      useMaterial3: true,
      fontFamily: 'Noto Sans JP',
      fontFamilyFallback: const [
        'Hiragino Sans',
        'Hiragino Kaku Gothic ProN',
        'Yu Gothic',
        'Meiryo',
        'sans-serif',
      ],
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 84,
          height: 1.02,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.0,
          color: AppColors.ink900,
        ),
        displayMedium: TextStyle(
          fontSize: 40,
          height: 1.2,
          fontWeight: FontWeight.w700,
          color: AppColors.ink900,
        ),
        headlineLarge: TextStyle(
          fontSize: 40,
          height: 1.16,
          fontWeight: FontWeight.w700,
          color: AppColors.ink900,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          height: 1.36,
          fontWeight: FontWeight.w700,
          color: AppColors.ink900,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          height: 1.36,
          fontWeight: FontWeight.w700,
          color: AppColors.ink900,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          height: 1.44,
          fontWeight: FontWeight.w600,
          color: AppColors.ink700,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          height: 1.75,
          color: AppColors.ink500,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          height: 1.7,
          color: AppColors.ink500,
        ),
        labelLarge: TextStyle(
          fontSize: 13,
          height: 1.54,
          fontWeight: FontWeight.w500,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink900,
          side: const BorderSide(color: AppColors.lineStrong),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        ),
      ),
    );
  }
}
