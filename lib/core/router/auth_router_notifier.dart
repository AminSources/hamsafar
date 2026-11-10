import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';

class AuthRouterNotifier extends ChangeNotifier {
  AuthRouterNotifier({
    required Stream<DataState<UserEntity?>> authStateChanges,
  }) {
    _subscription = authStateChanges.listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<DataState<UserEntity?>> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
