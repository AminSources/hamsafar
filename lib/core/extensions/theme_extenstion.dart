import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  //* Theme
  ThemeData get theme => Theme.of(this);

  //* Color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  //* Text theme
  TextTheme get textTheme => theme.textTheme;
}
