import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/core/usecase/usecase.dart';
import 'package:hamsafar/features/profile/domain/entities/profile_preferences_entity.dart';
import 'package:hamsafar/features/profile/domain/repositories/profile_repository.dart';

class SaveToolsUsecase
    implements Usecase<DataState<void>, List<ProfileToolEntity>> {
  final ProfileRepository profileRepository;

  SaveToolsUsecase({required this.profileRepository});

  @override
  Future<DataState<void>> call(List<ProfileToolEntity> tools) {
    return profileRepository.saveTools(tools);
  }
}
