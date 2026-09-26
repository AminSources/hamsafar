import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/core/usecase/usecase.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';
import 'package:hamsafar/features/auth/domain/params/sign_up_params.dart';
import 'package:hamsafar/features/auth/domain/repositories/auth_repository.dart';

class SignUpUsecase implements Usecase<DataState<UserEntity>, SignUpParams> {
  final AuthRepository authRepository;

  SignUpUsecase({required this.authRepository});

  @override
  Future<DataState<UserEntity>> call(SignUpParams params) {
    return authRepository.signUp(params);
  }
}
