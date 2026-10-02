import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/profile/domain/entities/profile_entity.dart';
import 'package:hamsafar/features/profile/domain/params/edit_profile_params.dart';

abstract class ProfileRepository {
  Future<DataState<void>> editProfile(EditProfileParams editProfileParams);
  Future<DataState<ProfileEntity>> getProfile(NoParams noParams);
}
