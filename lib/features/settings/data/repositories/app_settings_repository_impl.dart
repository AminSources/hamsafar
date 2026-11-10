import 'package:hamsafar/features/settings/data/data_source/local/get_storage_app_settings_datasource.dart';
import 'package:hamsafar/features/settings/domain/entities/app_settings_entity.dart';
import 'package:hamsafar/features/settings/domain/repositories/app_settings_repository.dart';

class AppSettingsRepositoryImpl implements AppSettingsRepository {
  final GetStorageAppSettingsDatasource datasource;

  const AppSettingsRepositoryImpl({required this.datasource});

  @override
  AppSettingsEntity loadSettings() => datasource.loadSettings();

  @override
  Future<void> saveLanguage(String localeCode) =>
      datasource.saveLanguage(localeCode);

  @override
  Future<void> saveThemeMode(String themeMode) =>
      datasource.saveThemeMode(themeMode);
}
