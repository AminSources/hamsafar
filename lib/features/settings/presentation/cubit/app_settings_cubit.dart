import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hamsafar/features/settings/domain/entities/app_settings_entity.dart';
import 'package:hamsafar/features/settings/domain/usecases/app_settings_usecases.dart';

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
  final SaveAppLanguageUseCase saveLanguageUseCase;
  final SaveAppThemeModeUseCase saveThemeModeUseCase;

  AppSettingsCubit({
    required LoadAppSettingsUseCase loadSettingsUseCase,
    required this.saveLanguageUseCase,
    required this.saveThemeModeUseCase,
  }) : super(_mapSettings(loadSettingsUseCase()));

  static AppSettingsState _mapSettings(AppSettingsEntity settings) {
    final themeMode = ThemeMode.values.firstWhere(
      (mode) => mode.name == settings.themeMode,
      orElse: () => ThemeMode.system,
    );

    return AppSettingsState(
      localeCode: settings.localeCode == 'en' ? 'en' : 'fa',
      themeMode: themeMode,
    );
  }

  Future<void> setLanguage(String localeCode) async {
    if (localeCode != 'fa' && localeCode != 'en') return;
    if (state.localeCode == localeCode) return;

    await saveLanguageUseCase(localeCode);
    emit(state.copyWith(localeCode: localeCode));
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    if (state.themeMode == themeMode) return;

    await saveThemeModeUseCase(themeMode.name);
    emit(state.copyWith(themeMode: themeMode));
  }
}
