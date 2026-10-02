import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/core/usecase/usecase.dart';
import 'package:hamsafar/features/profile/domain/entities/profile_entity.dart';
import 'package:hamsafar/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUsecase implements Usecase<DataState<ProfileEntity>, NoParams> {
  final ProfileRepository profileRepository;

  GetProfileUsecase({required this.profileRepository});

  @override
  Future<DataState<ProfileEntity>> call(NoParams params) {
    return profileRepository.getProfile(params);
  }
}
