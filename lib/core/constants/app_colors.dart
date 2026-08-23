import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  //* Primary brand palette
  static const Color primary = Color(0xFF0E8172);
  static const Color primaryDeep = Color(0xFF0A5F55);
  static const Color saffron = Color(0xFFE89B2C);
  static const Color ink = Color(0xFF1B2A24);
  static const Color shell = Color(0xFFF7F8F4);
  static const Color brick = Color(0xFFC2452D);

  //* Semantic colors
  static const Color success = primary;
  static const Color warning = saffron;
  static const Color error = brick;

  //* Light theme derivatives
  static const Color primaryTint100 = Color(0xFFEFF6F4);
  static const Color primaryTint200 = Color(0xFFD5EBE5);
  static const Color primaryTint300 = Color(0xFFABD6CB);
  static const Color saffronTint = Color(0xFFFBEEDA);
  static const Color brickTint = Color(0xFFF9E1DA);
  static const Color inkSoft = Color(0xFF4A5A52);
  static const Color inkFaint = Color(0xFF8A978F);
  static const Color mist = Color(0xFFE9EDE6);
  static const Color line = Color(0xFFE1E5DC);

  //* Dark theme palette
  static const Color darkBackground = Color(0xFF101815);
  static const Color darkSurface = Color(0xFF1B2A24);
  static const Color darkSurfaceHigh = Color(0xFF243429);
  static const Color darkBorder = Color(0xFF2F4237);
  static const Color darkTextPrimary = Color(0xFFF7F8F4);
  static const Color darkTextSecondary = Color(0xFFAEBDB4);
  static const Color darkPrimary = Color(0xFF2FB8A2);
  static const Color darkSaffron = Color(0xFFF0AC44);
  static const Color darkBrick = Color(0xFFE26A50);
}

//* Spacing scale: 4, 8, 12, 16, 24
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

//* Border radius: 10, 14, 16, 20 | Control height: 48
class AppRadius {
  AppRadius._();

  static const double sm = 10;
  static const double md = 14;
  static const double lg = 16;
  static const double xl = 20;
  static const double control = 48;

  static BorderRadius get small => BorderRadius.circular(sm);
  static BorderRadius get medium => BorderRadius.circular(md);
  static BorderRadius get large => BorderRadius.circular(lg);
  static BorderRadius get extraLarge => BorderRadius.circular(xl);
}

//* Border widths (1.5px standard, 1px thin)
class AppBorders {
  AppBorders._();

  static const double width = 1.5;
  static const double widthThin = 1;
}

//* Soft & shallow shadows
class AppShadows {
  AppShadows._();

  static const BoxShadow subtle = BoxShadow(
    color: Color(0x0D1B2A24),
    blurRadius: 6,
    offset: Offset(0, 2),
  );

  static const BoxShadow soft = BoxShadow(
    color: Color(0x141B2A24),
    blurRadius: 10,
    offset: Offset(0, 3),
  );

  static const BoxShadow floating = BoxShadow(
    color: Color(0x291B2A24),
    blurRadius: 16,
    offset: Offset(0, 6),
  );
}
