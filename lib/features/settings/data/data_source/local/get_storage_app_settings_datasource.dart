import 'package:get_storage/get_storage.dart';
import 'package:hamsafar/features/settings/domain/entities/app_settings_entity.dart';

class GetStorageAppSettingsDatasource {
  static const _languageKey = 'app_language';
  static const _themeModeKey = 'app_theme_mode';
  static const _themeModes = {'system', 'light', 'dark'};

  final GetStorage storage;

  const GetStorageAppSettingsDatasource({required this.storage});

  AppSettingsEntity loadSettings() {
    final savedLanguage = storage.read<String>(_languageKey);
    final savedThemeMode = storage.read<String>(_themeModeKey);

    return AppSettingsEntity(
      localeCode: savedLanguage == 'en' ? 'en' : 'fa',
      themeMode: _themeModes.contains(savedThemeMode)
          ? savedThemeMode!
          : 'system',
    );
  }

  Future<void> saveLanguage(String localeCode) {
    return storage.write(_languageKey, localeCode);
  }

  Future<void> saveThemeMode(String themeMode) {
    return storage.write(_themeModeKey, themeMode);
  }
}
