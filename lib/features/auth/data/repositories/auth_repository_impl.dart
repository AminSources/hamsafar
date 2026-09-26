import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/features/auth/domain/params/sign_in_params.dart';
import 'package:hamsafar/features/auth/domain/params/sign_up_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/auth/data/data_source/remote/supabase_auth_datasource.dart';
import 'package:hamsafar/features/auth/data/models/user_model.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';
import 'package:hamsafar/features/auth/domain/repositories/auth_repository.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl extends AuthRepository {
  final SupabaseAuthDatasource supabaseAuthDatasource;

  AuthRepositoryImpl({required this.supabaseAuthDatasource});

  Logger log = Logger();

  @override
  Future<DataState<UserEntity>> signIn(SignInParams signInParams) async {
    try {
      final response = await supabaseAuthDatasource.signIn(
        email: signInParams.email,
        password: signInParams.password,
      );

      if (response.user == null) {
        log.e("user data is null");
        return DataFailed("Login failed");
      }

      final UserEntity data = UserModel.fromJson(response.user!);
      return DataSuccess(data);
    } on AuthException catch (e) {
      log.e(e.message);
      return DataFailed(e.message);
    } catch (e) {
      log.e(e.toString());
      return DataFailed("خطای ناشناخته‌ای رخ داد: ${e.toString()}");
    }
  }

  @override
  Future<DataState<UserEntity>> signUp(SignUpParams signUpParams) async {
    try {
      final response = await supabaseAuthDatasource.signUp(
        email: signUpParams.email,
        password: signUpParams.password,
        metadata: {
          if (signUpParams.displayName != null)
            'displayName': signUpParams.displayName,
          'userName': signUpParams.userName,
        },
      );

      if (response.user == null) {
        return DataFailed("SignUp failed");
      }

      final UserEntity data = UserModel.fromJson(response.user!);
      return DataSuccess(data);
    } on AuthException catch (e) {
      log.e(e.message);
      return DataFailed(e.message);
    } catch (e) {
      log.e(e.toString());
      return DataFailed("خطای ناشناخته‌ای رخ داد: ${e.toString()}");
    }
  }

  @override
  Future<void> signOut(NoParams noParams) {
    return supabaseAuthDatasource.signOut();
  }

  @override
  Future<DataState<UserEntity?>> getCurrentUser(NoParams noParams) async {
    final user = supabaseAuthDatasource.currentUser;

    if (user == null) {
      return DataFailed("User not found");
    }

    return DataSuccess(UserModel.fromJson(user));
  }

  @override
  Stream<DataState<UserEntity?>> get authStateChanges {
    return supabaseAuthDatasource.authStateChanges.map((event) {
      if (event.session?.user == null) {
        return DataFailed("Error on state chages");
      }

      final data = UserModel.fromJson(event.session!.user);
      return DataSuccess(data);
    });
  }
}
