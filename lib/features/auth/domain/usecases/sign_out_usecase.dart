import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/usecase/usecase.dart';
import 'package:hamsafar/features/auth/domain/repositories/auth_repository.dart';

class SignOutUsecase implements Usecase<void, NoParams> {
  final AuthRepository authRepository;

  SignOutUsecase({required this.authRepository});

  @override
  Future<void> call(NoParams params) {
    return authRepository.signOut(params);
  }
}
