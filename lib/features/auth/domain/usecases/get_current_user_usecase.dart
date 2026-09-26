import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/core/usecase/usecase.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';
import 'package:hamsafar/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUsecase
    implements Usecase<DataState<UserEntity?>, NoParams> {
  final AuthRepository authRepository;

  GetCurrentUserUsecase({required this.authRepository});

  @override
  Future<DataState<UserEntity?>> call(NoParams params) {
    return authRepository.getCurrentUser(params);
  }
}
