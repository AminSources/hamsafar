import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';
import 'package:hamsafar/features/auth/domain/repositories/auth_repository.dart';

class AuthStateChangesUsecase {
  final AuthRepository authRepository;

  AuthStateChangesUsecase({required this.authRepository});

  Stream<DataState<UserEntity?>> call(NoParams params) {
    return authRepository.authStateChanges;
  }
}
