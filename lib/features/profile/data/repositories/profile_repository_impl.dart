import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/profile/data/data_source/remote/supabase_profile_datasource.dart';
import 'package:hamsafar/features/profile/data/models/profile_model.dart';
import 'package:hamsafar/features/profile/data/models/profile_preferences_model.dart';
import 'package:hamsafar/features/profile/domain/entities/profile_entity.dart';
import 'package:hamsafar/features/profile/domain/entities/profile_preferences_entity.dart';
import 'package:hamsafar/features/profile/domain/params/edit_profile_params.dart';
import 'package:hamsafar/features/profile/domain/params/save_availability_params.dart';
import 'package:hamsafar/features/profile/domain/repositories/profile_repository.dart';
import 'package:logger/logger.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final SupabaseProfileDatasource supabaseProfileDatasource;

  ProfileRepositoryImpl({required this.supabaseProfileDatasource});

  Logger log = Logger();

  @override
  Future<DataState<void>> editProfile(
    EditProfileParams editProfileParams,
  ) async {
    try {
      await supabaseProfileDatasource.editProfile(params: editProfileParams);

      return DataSuccess(null);
    } catch (e) {
      log.e(e);

      final rawError = e.toString();
      if (rawError.contains('23505') ||
          rawError.contains('profiles_username_key')) {
        return DataFailed('این نام کاربری قبلاً انتخاب شده است');
      }

      return DataFailed('خطای ناشناخته‌ای رخ داد: $rawError');
    }
  }

  @override
  Future<DataState<ProfileEntity>> getProfile(NoParams noParams) async {
    try {
      final response = await supabaseProfileDatasource.getProfile();

      final profileData = ProfileModel.fromJson(response);

      return DataSuccess(profileData);
    } catch (e) {
      log.e(e);
      return DataFailed('خطای ناشناخته‌ای رخ داد: ${e.toString()}');
    }
  }

  @override
  Future<DataState<ProfilePreferencesEntity>> getProfilePreferences() async {
    try {
      final response = await supabaseProfileDatasource.getProfilePreferences();
      return DataSuccess(ProfilePreferencesModel.fromJson(response));
    } catch (e) {
      log.e(e);
      return DataFailed('دریافت تنظیمات پروفایل ناموفق بود: ' + e.toString());
    }
  }

  @override
  Future<DataState<void>> saveAvailability(
    SaveAvailabilityParams params,
  ) async {
    try {
      await supabaseProfileDatasource.saveAvailability(params);
      return DataSuccess(null);
    } catch (e) {
      log.e(e);
      return DataFailed('ذخیره روزهای آزاد ناموفق بود: ' + e.toString());
    }
  }

  @override
  Future<DataState<void>> saveTools(List<ProfileToolEntity> tools) async {
    try {
      await supabaseProfileDatasource.saveTools(tools);
      return DataSuccess(null);
    } catch (e) {
      log.e(e);
      return DataFailed('ذخیره وسایل ناموفق بود: ' + e.toString());
    }
  }

}
