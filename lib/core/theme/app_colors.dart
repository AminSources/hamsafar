import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  //* primary
  static const Color primary = Color(0xFF0D9488);
  static const Color primaryBright = Color(0xFF14B8A6);
  static const Color primaryDark = Color(0xFF0F766E);
  static const Color primaryContainer = Color(0xFFCCFBF1);
  static const Color primaryContainerSoft = Color(0xFFE9FBF7);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color inversePrimary = Color(0xFF5EEAD4);

  //* primary dark theme
  static const Color darkPrimary = Color(0xFF2DD4BF);
  static const Color darkOnPrimary = Color(0xFF042F2E);
  static const Color darkPrimaryContainer = Color(0xFF115E59);
  static const Color darkSecondary = Color(0xFFFBBF24);
  static const Color darkOnSecondary = Color(0xFF451A03);
  static const Color darkSeconderyContainer = Color(0xFF78350F);
  static const Color darkTertriary = Color(0xFFA78BFA);
  static const Color darkOnTertriary = Color(0xFF2E1065);
  static const Color darkTertriaryContainer = Color(0xFF4C1D95);
  static const Color darkError = Color(0xFFF87171);
  static const Color darkOnError = Color(0xFF450A0A);
  static const Color darkErrorContainer = Color(0xFF7F1D1D);
  static const Color darkSurfaceContainerLowest = Color(0xFF020617);
  static const Color darkOutlineVariant = Color(0xFF1E293B);
  static const Color darkShadow = Color(0xFF000000);

  //* accent
  static const Color accent = Color(0xFFF59E0B);
  static const Color accentBright = Color(0xFFFCD34D);
  static const Color accentContainer = Color(0xFFFEF3C7);
  static const Color onAccentContainer = Color(0xFFB45309);

  //* tertiary
  static const Color tertiary = Color(0xFF8B5CF6);
  static const Color tertiaryContainer = Color(0xFFEDE9FE);
  static const Color onTertiaryContainer = Color(0xFF6D28D9);

  //* semantic
  static const Color success = Color(0xFF22C55E);
  static const Color successContainer = Color(0xFFDCFCE7);
  static const Color onSuccessContainer = Color(0xFF15803D);

  //* errors
  static const Color error = Color(0xFFDC2626);
  static const Color errorBright = Color(0xFFEF4444);
  static const Color errorContainer = Color(0xFFFEE2E2);
  static const Color onErrorContainer = Color(0xFFB91C1C);
  static const Color errorSoftBorder = Color(0xFFFECACA);

  //* light neutral
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF5B6B7F);
  static const Color textTertiary = Color(0xFF9AA7B8);
  static const Color textDisabled = Color(0xFFC4CEDA);
  static const Color border = Color(0xFFE4E9F0);
  static const Color borderSoft = Color(0xFFEEF2F7);
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSoft = Color(0xFFF7FAFC);

  //* dark neutral
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurfaceLow = Color(0xFF131C2E);
  static const Color darkSurface = Color(0xFF1A2438);
  static const Color darkSurfaceHigh = Color(0xFF243044);
  static const Color darkTextPrimary = Color(0xFFE2E8F0);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF334155);

  //* avatars
  static const List<Color> avatars = [
    Color(0xFF0EA5E9),
    Color(0xFFF97316),
    Color(0xFF8B5CF6),
    Color(0xFFEC4899),
    Color(0xFF22C55E),
    Color(0xFF64748B),
  ];

  //* gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF14B8A6), Color(0xFF0D9488)],
  );
  static const LinearGradient tripLiveGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF10A396), Color(0xFF085F59)],
  );
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.55, 1.0],
    colors: [Color(0xFF10A79A), Color(0xFF0A6E64), Color(0xFF064E46)],
  );
}
