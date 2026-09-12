import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  //? get current theme
  ThemeData get theme => Theme.of(this);

  //? get color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  //? get text theme
  TextTheme get textTheme => theme.textTheme;
}
