import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppSettingsState extends Equatable {
  final String localeCode;
  final ThemeMode themeMode;

  const AppSettingsState({
    this.localeCode = 'fa',
    this.themeMode = ThemeMode.system,
  });

  AppSettingsState copyWith({String? localeCode, ThemeMode? themeMode}) {
    return AppSettingsState(
      localeCode: localeCode ?? this.localeCode,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [localeCode, themeMode];
}
