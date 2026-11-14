import 'package:hamsafar/core/router/auth_router_notifier.dart';
import 'package:hamsafar/features/auth/domain/repositories/auth_repository.dart';
import 'package:hamsafar/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:hamsafar/features/profile/domain/usecases/get_onboarding_completed_usecase.dart';
import 'package:hamsafar/locator.dart';

final authRouterNotifier = AuthRouterNotifier(
  authStateChanges: sl<AuthRepository>().authStateChanges,
  getCurrentUser: sl<GetCurrentUserUsecase>(),
  getOnboardingCompleted: sl<GetOnboardingCompletedUseCase>(),
);
