import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/profile/domain/entities/profile_entity.dart';
import 'package:hamsafar/features/profile/domain/params/edit_profile_params.dart';

abstract class ProfileRepository {
  Future<DataState<ProfileEntity>> editProfile(
    EditProfileParams editProfileParams,
  );
}
