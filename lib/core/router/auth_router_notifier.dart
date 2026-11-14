import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';
import 'package:hamsafar/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:hamsafar/features/profile/domain/usecases/get_onboarding_completed_usecase.dart';

class AuthRouterNotifier extends ChangeNotifier {
  AuthRouterNotifier({
    required Stream<DataState<UserEntity?>> authStateChanges,
    GetCurrentUserUsecase? getCurrentUser,
    GetOnboardingCompletedUseCase? getOnboardingCompleted,
  }) : _getCurrentUser = getCurrentUser,
       _getOnboardingCompleted = getOnboardingCompleted {
    _subscription = authStateChanges.listen((_) {
      if (_getCurrentUser != null && _getOnboardingCompleted != null) {
        unawaited(initialize(force: true));
      }
    });
  }

  final GetCurrentUserUsecase? _getCurrentUser;
  final GetOnboardingCompletedUseCase? _getOnboardingCompleted;
  late final StreamSubscription<DataState<UserEntity?>> _subscription;

  bool isInitialized = false;
  bool hasError = false;
  bool isAuthenticated = false;
  bool onboardingCompleted = false;
  int _generation = 0;
  Future<void>? _initialization;

  Future<void> initialize({bool force = false}) {
    if (!force && isInitialized) return Future.value();
    if (!force && _initialization != null) return _initialization!;
    final future = _load(++_generation);
    _initialization = future;
    return future;
  }

  Future<void> _load(int generation) async {
    isInitialized = false;
    hasError = false;
    try {
      final getCurrentUser = _getCurrentUser;
      final getOnboardingCompleted = _getOnboardingCompleted;
      if (getCurrentUser == null || getOnboardingCompleted == null) {
        _setError();
        return;
      }
      final authState = await getCurrentUser(NoParams());
      if (generation != _generation) return;
      if (authState is DataFailed<UserEntity?>) {
        _setError();
        return;
      }

      final user = authState is DataSuccess<UserEntity?> ? authState.data : null;
      isAuthenticated = user != null;
      onboardingCompleted = false;

      if (user != null) {
        final onboardingState = await getOnboardingCompleted(NoParams());
        if (generation != _generation) return;
        if (onboardingState is! DataSuccess<bool>) {
          _setError();
          return;
        }
        onboardingCompleted = onboardingState.data == true;
      }

      hasError = false;
      isInitialized = true;
      notifyListeners();
    } catch (_) {
      if (generation == _generation) _setError();
    } finally {
      if (generation == _generation) _initialization = null;
    }
  }

  void _setError() {
    hasError = true;
    isInitialized = true;
    notifyListeners();
  }

  void markOnboardingCompleted() {
    onboardingCompleted = true;
    notifyListeners();
  }

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}
