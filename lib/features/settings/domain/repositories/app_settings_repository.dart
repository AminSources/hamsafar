import 'package:hamsafar/features/settings/domain/entities/app_settings_entity.dart';

abstract interface class AppSettingsRepository {
  AppSettingsEntity loadSettings();
  Future<void> saveLanguage(String localeCode);
  Future<void> saveThemeMode(String themeMode);
}
