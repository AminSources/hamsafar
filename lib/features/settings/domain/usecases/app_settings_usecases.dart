import 'package:hamsafar/features/settings/domain/entities/app_settings_entity.dart';
import 'package:hamsafar/features/settings/domain/repositories/app_settings_repository.dart';

class LoadAppSettingsUseCase {
  final AppSettingsRepository repository;

  const LoadAppSettingsUseCase(this.repository);

  AppSettingsEntity call() => repository.loadSettings();
}

class SaveAppLanguageUseCase {
  final AppSettingsRepository repository;

  const SaveAppLanguageUseCase(this.repository);

  Future<void> call(String localeCode) =>
      repository.saveLanguage(localeCode);
}

class SaveAppThemeModeUseCase {
  final AppSettingsRepository repository;

  const SaveAppThemeModeUseCase(this.repository);

  Future<void> call(String themeMode) =>
      repository.saveThemeMode(themeMode);
}
