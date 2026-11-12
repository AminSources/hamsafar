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
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final SupabaseProfileDatasource supabaseProfileDatasource;

  ProfileRepositoryImpl({required this.supabaseProfileDatasource});

  @override
  Future<DataState<void>> editProfile(
    EditProfileParams editProfileParams,
  ) async {
    try {
      await supabaseProfileDatasource.editProfile(params: editProfileParams);
      return const DataSuccess<void>(null);
    } on PostgrestException catch (error) {
      if (error.code == '23505' &&
          error.message.contains('profiles_username_key')) {
        return const DataFailed('این نام کاربری قبلاً انتخاب شده است');
      }
      return const DataFailed(
        'ویرایش اطلاعات پروفایل ناموفق بود. دوباره تلاش کنید.',
      );
    } catch (_) {
      return const DataFailed(
        'ویرایش اطلاعات پروفایل ناموفق بود. دوباره تلاش کنید.',
      );
    }
  }

  @override
  Future<DataState<ProfileEntity>> getProfile(NoParams noParams) async {
    try {
      final response = await supabaseProfileDatasource.getProfile();
      return DataSuccess(ProfileModel.fromJson(response));
    } catch (_) {
      return const DataFailed(
        'دریافت اطلاعات پروفایل ناموفق بود. دوباره تلاش کنید.',
      );
    }
  }

  @override
  Future<DataState<bool>> getOnboardingCompleted(NoParams noParams) async {
    try {
      final completed =
          await supabaseProfileDatasource.getOnboardingCompleted();
      return DataSuccess(completed);
    } catch (_) {
      return const DataFailed(
        'بررسی وضعیت تکمیل پروفایل ناموفق بود. دوباره تلاش کنید.',
      );
    }
  }

  @override
  Future<DataState<ProfilePreferencesEntity>> getProfilePreferences() async {
    try {
      final response = await supabaseProfileDatasource.getProfilePreferences();
      return DataSuccess(ProfilePreferencesModel.fromJson(response));
    } catch (_) {
      return const DataFailed(
        'دریافت تنظیمات پروفایل ناموفق بود. دوباره تلاش کنید.',
      );
    }
  }

  @override
  Future<DataState<void>> saveAvailability(
    SaveAvailabilityParams params,
  ) async {
    try {
      await supabaseProfileDatasource.saveAvailability(params);
      return const DataSuccess<void>(null);
    } catch (_) {
      return const DataFailed(
        'ذخیره روزهای آزاد ناموفق بود. دوباره تلاش کنید.',
      );
    }
  }

  @override
  Future<DataState<void>> saveTools(List<ProfileToolEntity> tools) async {
    try {
      await supabaseProfileDatasource.saveTools(tools);
      return const DataSuccess<void>(null);
    } catch (_) {
      return const DataFailed(
        'ذخیره وسایل ناموفق بود. دوباره تلاش کنید.',
      );
    }
  }
}
