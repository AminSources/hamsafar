import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class AppSettingsEvent extends Equatable {
  const AppSettingsEvent();

  @override
  List<Object?> get props => [];
}

final class AppLanguageChanged extends AppSettingsEvent {
  final String localeCode;
  const AppLanguageChanged(this.localeCode);
  @override
  List<Object?> get props => [localeCode];
}

final class AppThemeChanged extends AppSettingsEvent {
  final ThemeMode themeMode;
  const AppThemeChanged(this.themeMode);
  @override
  List<Object?> get props => [themeMode];
}
