import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/auth/data/data_source/remote/supabase_auth_datasource.dart';
import 'package:hamsafar/features/auth/data/models/user_model.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';
import 'package:hamsafar/features/auth/domain/params/sign_in_params.dart';
import 'package:hamsafar/features/auth/domain/params/sign_up_params.dart';
import 'package:hamsafar/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl extends AuthRepository {
  final SupabaseAuthDatasource supabaseAuthDatasource;

  AuthRepositoryImpl({required this.supabaseAuthDatasource});

  @override
  Future<DataState<UserEntity>> signIn(SignInParams params) async {
    try {
      final response = await supabaseAuthDatasource.signIn(
        email: params.email,
        password: params.password,
      );
      final user = response.user;
      if (user == null) {
        return const DataFailed(
          'ورود ناموفق بود. اطلاعات حساب را بررسی کنید.',
        );
      }
      return DataSuccess(UserModel.fromJson(user));
    } on AuthException catch (error) {
      return DataFailed(_authErrorMessage(error, isSignUp: false));
    } catch (_) {
      return const DataFailed('ورود انجام نشد. اتصال اینترنت را بررسی کنید.');
    }
  }

  @override
  Future<DataState<UserEntity>> signUp(SignUpParams params) async {
    try {
      final response = await supabaseAuthDatasource.signUp(
        email: params.email,
        password: params.password,
        metadata: {
          if (params.displayName != null) 'displayName': params.displayName,
          'userName': params.userName,
        },
      );
      final user = response.user;
      if (user == null) {
        return const DataFailed(
          'ساخت حساب کاربری انجام نشد. دوباره تلاش کنید.',
        );
      }
      return DataSuccess(UserModel.fromJson(user));
    } on AuthException catch (error) {
      return DataFailed(_authErrorMessage(error, isSignUp: true));
    } catch (_) {
      return const DataFailed(
        'ساخت حساب کاربری انجام نشد. اتصال اینترنت را بررسی کنید.',
      );
    }
  }

  @override
  Future<void> signOut(NoParams noParams) =>
      supabaseAuthDatasource.signOut();

  @override
  Future<DataState<UserEntity?>> getCurrentUser(NoParams noParams) async {
    final user = supabaseAuthDatasource.currentUser;
    if (user == null) return const DataSuccess<UserEntity?>(null);

    try {
      return DataSuccess<UserEntity?>(UserModel.fromJson(user));
    } catch (_) {
      return const DataFailed(
        'وضعیت حساب کاربری قابل بررسی نیست. دوباره تلاش کنید.',
      );
    }
  }

  @override
  Stream<DataState<UserEntity?>> get authStateChanges {
    return supabaseAuthDatasource.authStateChanges.map((event) {
      final user = event.session?.user;
      if (user == null) return const DataSuccess<UserEntity?>(null);

      try {
        return DataSuccess<UserEntity?>(UserModel.fromJson(user));
      } catch (_) {
        return const DataFailed(
          'وضعیت حساب کاربری قابل بررسی نیست. دوباره تلاش کنید.',
        );
      }
    });
  }

  String _authErrorMessage(
    AuthException error, {
    required bool isSignUp,
  }) {
    final message = error.message.toLowerCase();

    if (message.contains('invalid login credentials') ||
        message.contains('invalid_credentials')) {
      return 'ایمیل یا رمز عبور نادرست است.';
    }
    if (message.contains('already registered') ||
        message.contains('user already exists')) {
      return 'این ایمیل قبلاً ثبت‌نام شده است.';
    }
    if (message.contains('email not confirmed')) {
      return 'ابتدا ایمیل خود را تأیید کنید.';
    }
    if (message.contains('rate limit')) {
      return 'تعداد درخواست‌ها زیاد است. کمی بعد دوباره تلاش کنید.';
    }

    return isSignUp
        ? 'ساخت حساب کاربری انجام نشد. اطلاعات واردشده را بررسی کنید.'
        : 'ورود انجام نشد. اطلاعات حساب را بررسی کنید.';
  }
}
