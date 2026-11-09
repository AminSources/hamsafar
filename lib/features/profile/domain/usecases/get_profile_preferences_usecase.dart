import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/core/usecase/usecase.dart';
import 'package:hamsafar/features/profile/domain/entities/profile_preferences_entity.dart';
import 'package:hamsafar/features/profile/domain/repositories/profile_repository.dart';

class GetProfilePreferencesUsecase
    implements Usecase<DataState<ProfilePreferencesEntity>, NoParams> {
  final ProfileRepository profileRepository;

  GetProfilePreferencesUsecase({required this.profileRepository});

  @override
  Future<DataState<ProfilePreferencesEntity>> call(NoParams params) {
    return profileRepository.getProfilePreferences();
  }
}
