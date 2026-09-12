import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const String _fontFamily = 'vazirmatn';

  //* light theme config
  static ThemeData get light => _build(
    isDark: false,
    scheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      primaryFixed: AppColors.primaryDark,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.primaryDark,
      secondary: AppColors.accent,
      onSecondary: AppColors.onPrimary,
      secondaryContainer: AppColors.accentContainer,
      onSecondaryContainer: AppColors.onAccentContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onPrimary,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      error: AppColors.error,
      onError: AppColors.onPrimary,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
      surfaceContainerLowest: AppColors.surface,
      surfaceContainerLow: AppColors.background,
      surfaceContainer: AppColors.surfaceSoft,
      surfaceContainerHigh: AppColors.borderSoft,
      outline: AppColors.border,
      outlineVariant: AppColors.borderSoft,
      inverseSurface: AppColors.darkBackground,
      onInverseSurface: AppColors.background,
      inversePrimary: AppColors.inversePrimary,
      shadow: AppColors.darkBackground,
    ),
  );

  //* dark theme config
  static ThemeData get dark => _build(
    isDark: true,
    scheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.darkPrimary,
      primaryFixed: AppColors.darkPrimaryDark,
      onPrimary: AppColors.darkOnPrimary,
      primaryContainer: AppColors.darkPrimaryContainer,
      onPrimaryContainer: AppColors.primaryContainer,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkOnSecondary,
      secondaryContainer: AppColors.darkSeconderyContainer,
      onSecondaryContainer: AppColors.accentContainer,
      tertiary: AppColors.darkTertriary,
      onTertiary: AppColors.darkOnTertriary,
      tertiaryContainer: AppColors.darkTertriaryContainer,
      onTertiaryContainer: AppColors.tertiaryContainer,
      error: AppColors.darkError,
      onError: AppColors.darkOnError,
      errorContainer: AppColors.darkErrorContainer,
      onErrorContainer: AppColors.errorSoftBorder,
      surface: AppColors.darkBackground,
      onSurface: AppColors.darkTextPrimary,
      onSurfaceVariant: AppColors.darkTextSecondary,
      surfaceContainerLowest: AppColors.darkSurfaceContainerLowest,
      surfaceContainerLow: AppColors.darkSurfaceLow,
      surfaceContainer: AppColors.darkSurface,
      surfaceContainerHigh: AppColors.darkSurfaceHigh,
      outline: AppColors.darkBorder,
      outlineVariant: AppColors.darkOutlineVariant,
      inverseSurface: AppColors.darkTextPrimary,
      onInverseSurface: AppColors.darkBackground,
      inversePrimary: AppColors.primaryDark,
      shadow: AppColors.darkShadow,
    ),
  );

  //* text theme config
  static TextTheme _textTheme(bool isDark) {
    final Color main = isDark
        ? AppColors.darkTextPrimary
        : AppColors.textPrimary;

    final Color muted = isDark
        ? AppColors.darkTextSecondary
        : AppColors.textSecondary;

    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 38.sp,
        fontWeight: FontWeight.w900,
        color: main,
      ),
      displayMedium: TextStyle(
        fontSize: 30.sp,
        fontWeight: FontWeight.w900,
        color: main,
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w900,
        color: main,
      ),
      headlineLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w900,
        color: main,
        height: 1.4,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w800,
        color: main,
        height: 1.4,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w800,
        color: main,
        height: 1.4,
      ),
      titleLarge: TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w900,
        color: main,
      ),
      titleMedium: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w800,
        color: main,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w800,
        color: main,
      ),
      bodyLarge: TextStyle(
        fontSize: 13.5.sp,
        fontWeight: FontWeight.w600,
        color: main,
        height: 2.1,
      ),
      bodyMedium: TextStyle(
        fontSize: 12.5.sp,
        fontWeight: FontWeight.w600,
        color: main,
        height: 1.9,
      ),
      bodySmall: TextStyle(
        fontSize: 11.5.sp,
        fontWeight: FontWeight.w600,
        color: muted,
        height: 1.8,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w800,
        color: main,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: muted,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w700,
        color: muted,
        letterSpacing: 0.3,
      ),
    );
  }

  //* components theme config
  static ThemeData _build({required bool isDark, required ColorScheme scheme}) {
    final Color bg = isDark ? AppColors.darkBackground : AppColors.background;
    final Color card = isDark ? AppColors.darkSurface : AppColors.surface;
    final Color hint = isDark
        ? AppColors.darkTextSecondary
        : AppColors.textTertiary;

    return ThemeData(
      useMaterial3: true,
      fontFamily: _fontFamily,
      colorScheme: scheme,
      scaffoldBackgroundColor: bg,
      textTheme: _textTheme(isDark),
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: false,
        foregroundColor: scheme.onSurface,
        titleTextStyle: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w800,
          color: scheme.onSurface,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: Size(double.infinity, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(double.infinity, 50.h),
          foregroundColor: scheme.onSurface,
          side: BorderSide(color: scheme.outline, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
        hintStyle: TextStyle(
          fontSize: 12.5.sp,
          fontWeight: FontWeight.w600,
          color: hint,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: scheme.outline, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: scheme.outline, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: card,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: scheme.onPrimaryContainer,
        unselectedItemColor: scheme.onSurfaceVariant,
        selectedLabelStyle: TextStyle(
          fontSize: 10.5.sp,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 10.5.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      dividerTheme: DividerThemeData(color: scheme.outline, thickness: 1),
    );
  }
}
