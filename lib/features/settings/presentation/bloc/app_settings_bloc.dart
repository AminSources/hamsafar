import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hamsafar/features/settings/domain/entities/app_settings_entity.dart';
import 'package:hamsafar/features/settings/domain/usecases/app_settings_usecases.dart';

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

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  final SaveAppLanguageUseCase saveLanguageUseCase;
  final SaveAppThemeModeUseCase saveThemeModeUseCase;

  AppSettingsBloc({
    required LoadAppSettingsUseCase loadSettingsUseCase,
    required this.saveLanguageUseCase,
    required this.saveThemeModeUseCase,
  }) : super(_mapSettings(loadSettingsUseCase())) {
    on<AppLanguageChanged>(_onLanguageChanged);
    on<AppThemeChanged>(_onThemeChanged);
  }

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

  Future<void> _onLanguageChanged(
    AppLanguageChanged event,
    Emitter<AppSettingsState> emit,
  ) async {
    if (event.localeCode != 'fa' && event.localeCode != 'en') return;
    if (state.localeCode == event.localeCode) return;
    await saveLanguageUseCase(event.localeCode);
    emit(state.copyWith(localeCode: event.localeCode));
  }

  Future<void> _onThemeChanged(
    AppThemeChanged event,
    Emitter<AppSettingsState> emit,
  ) async {
    if (state.themeMode == event.themeMode) return;
    await saveThemeModeUseCase(event.themeMode.name);
    emit(state.copyWith(themeMode: event.themeMode));
  }
}
