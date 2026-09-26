import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/features/auth/domain/params/sign_in_params.dart';
import 'package:hamsafar/features/auth/domain/params/sign_up_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<DataState<UserEntity>> signUp(SignUpParams signUpParams);
  Future<DataState<UserEntity>> signIn(SignInParams signInParams);
  Future<void> signOut(NoParams noParams);
  Future<DataState<UserEntity?>> getCurrentUser(NoParams noParams);
  Stream<DataState<UserEntity?>> get authStateChanges;
}
