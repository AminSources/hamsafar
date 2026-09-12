import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  //? get current theme
  ThemeData get theme => Theme.of(this);

  //? get color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  //? get text theme
  TextTheme get textTheme => theme.textTheme;

  //? get vertical gradient
  LinearGradient get verticalGradient => LinearGradient(
    colors: [colorScheme.primary, colorScheme.primaryFixed],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  //? get horizontal gradient
  LinearGradient get horizontalGradient => LinearGradient(
    colors: [colorScheme.primary, colorScheme.primaryFixed],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
