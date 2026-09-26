import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/core/usecase/usecase.dart';
import 'package:hamsafar/features/profile/domain/entities/profile_entity.dart';
import 'package:hamsafar/features/profile/domain/params/edit_profile_params.dart';
import 'package:hamsafar/features/profile/domain/repositories/profile_repository.dart';

class EditProfileUsecase
    implements Usecase<DataState<ProfileEntity>, EditProfileParams> {
  final ProfileRepository profileRepository;

  EditProfileUsecase({required this.profileRepository});

  @override
  Future<DataState<ProfileEntity>> call(EditProfileParams params) {
    return profileRepository.editProfile(params);
  }
}
