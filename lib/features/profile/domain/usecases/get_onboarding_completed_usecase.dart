import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/core/usecase/usecase.dart';
import 'package:hamsafar/features/profile/domain/repositories/profile_repository.dart';

class GetOnboardingCompletedUseCase
    implements Usecase<DataState<bool>, NoParams> {
  final ProfileRepository repository;

  const GetOnboardingCompletedUseCase({required this.repository});

  @override
  Future<DataState<bool>> call(NoParams params) {
    return repository.getOnboardingCompleted(params);
  }
}
