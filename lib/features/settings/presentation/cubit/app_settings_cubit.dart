import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

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

class AppSettingsCubit extends Cubit<AppSettingsState> {
  static const _languageKey = 'app_language';
  static const _themeModeKey = 'app_theme_mode';

  final GetStorage _storage;

  AppSettingsCubit({GetStorage? storage})
      : _storage = storage ?? GetStorage(),
        super(const AppSettingsState()) {
    final savedLanguage = _storage.read<String>(_languageKey);
    final savedThemeMode = _storage.read<String>(_themeModeKey);

    final language = savedLanguage == 'en' ? 'en' : 'fa';
    final themeMode = ThemeMode.values.firstWhere(
      (mode) => mode.name == savedThemeMode,
      orElse: () => ThemeMode.system,
    );

    emit(AppSettingsState(localeCode: language, themeMode: themeMode));
  }

  Future<void> setLanguage(String localeCode) async {
    if (localeCode != 'fa' && localeCode != 'en') return;
    if (state.localeCode == localeCode) return;

    emit(state.copyWith(localeCode: localeCode));
    await _storage.write(_languageKey, localeCode);
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    if (state.themeMode == themeMode) return;

    emit(state.copyWith(themeMode: themeMode));
    await _storage.write(_themeModeKey, themeMode.name);
  }
}
