part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckStatusEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final SignInParams signInParams;
  const LoginEvent(this.signInParams);

  @override
  List<Object> get props => [signInParams];
}

class SignUpEvent extends AuthEvent {
  final SignUpParams signUpParams;
  const SignUpEvent(this.signUpParams);

  @override
  List<Object> get props => [signUpParams];
}

class LogoutEvent extends AuthEvent {}
