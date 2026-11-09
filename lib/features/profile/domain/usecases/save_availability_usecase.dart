import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/core/usecase/usecase.dart';
import 'package:hamsafar/features/profile/domain/params/save_availability_params.dart';
import 'package:hamsafar/features/profile/domain/repositories/profile_repository.dart';

class SaveAvailabilityUsecase
    implements Usecase<DataState<void>, SaveAvailabilityParams> {
  final ProfileRepository profileRepository;

  SaveAvailabilityUsecase({required this.profileRepository});

  @override
  Future<DataState<void>> call(SaveAvailabilityParams params) {
    return profileRepository.saveAvailability(params);
  }
}
