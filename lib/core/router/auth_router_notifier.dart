import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';

class AuthRouterNotifier extends ChangeNotifier {
  AuthRouterNotifier({
    required Stream<DataState<UserEntity?>> authStateChanges,
  }) {
    _subscription = authStateChanges.listen((_) {
      _onboardingCompletedByUser.clear();
      notifyListeners();
    });
  }

  late final StreamSubscription<DataState<UserEntity?>> _subscription;
  final Map<String, bool> _onboardingCompletedByUser = {};

  bool isOnboardingCompleted(String userId) =>
      _onboardingCompletedByUser[userId] == true;

  void markOnboardingCompleted(String userId) {
    _onboardingCompletedByUser[userId] = true;
  }

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    _onboardingCompletedByUser.clear();
    super.dispose();
  }
}
