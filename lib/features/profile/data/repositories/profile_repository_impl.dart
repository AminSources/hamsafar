import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/profile/data/data_source/remote/supabase_profile_datasource.dart';
import 'package:hamsafar/features/profile/data/models/profile_model.dart';
import 'package:hamsafar/features/profile/domain/entities/profile_entity.dart';
import 'package:hamsafar/features/profile/domain/params/edit_profile_params.dart';
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
      return DataFailed("خطای ناشناخته‌ای رخ داد: ${e.toString()}");
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
      return DataFailed("خطای ناشناخته‌ای رخ داد: ${e.toString()}");
    }
  }
}
