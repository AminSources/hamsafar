import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/core/usecase/usecase.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';
import 'package:hamsafar/features/auth/domain/params/sign_in_params.dart';
import 'package:hamsafar/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase implements Usecase<DataState<UserEntity>, SignInParams> {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  @override
  Future<DataState<UserEntity>> call(SignInParams params) {
    return authRepository.signIn(params);
  }
}
