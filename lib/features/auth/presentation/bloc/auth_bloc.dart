import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';
import 'package:hamsafar/features/auth/domain/params/sign_in_params.dart';
import 'package:hamsafar/features/auth/domain/params/sign_up_params.dart';
import 'package:hamsafar/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:hamsafar/features/auth/domain/usecases/login_usecase.dart';
import 'package:hamsafar/features/auth/domain/usecases/sign_up_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final SignUpUsecase signUpUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;

  AuthBloc({
    required this.loginUsecase,
    required this.signUpUsecase,
    required this.getCurrentUserUsecase,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<AuthCheckStatusEvent>(onCheckStatus);
    on<LoginEvent>(onLogin);
    on<SignUpEvent>(onSignUp);
    on<LogoutEvent>(onLogout);
  }

  Future<void> onCheckStatus(AuthCheckStatusEvent event, emit) async {
    emit(AuthLoading());
    final result = await getCurrentUserUsecase(NoParams());

    if (result.data != null) {
      emit(AuthSuccess(result.data!));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> onLogin(LoginEvent event, emit) async {
    emit(AuthLoading());
    final result = await loginUsecase(event.signInParams);

    if (result.data != null) {
      emit(AuthSuccess(result.data!));
    } else {
      emit(AuthFailed(result.message ?? "Login failed - bloc"));
    }
  }

  Future<void> onSignUp(SignUpEvent event, emit) async {
    emit(AuthLoading());
    final result = await signUpUsecase(event.signUpParams);

    if (result.data != null) {
      emit(AuthSuccess(result.data!));
    } else {
      emit(AuthFailed(result.message ?? "SignUp failed - bloc"));
    }
  }

  Future<void> onLogout(LogoutEvent event, emit) async {
    emit(AuthInitial());
  }
}
