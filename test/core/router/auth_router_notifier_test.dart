import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/core/router/auth_router_notifier.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';

void main() {
  group('AuthRouterNotifier', () {
    test('stores a successful onboarding result for the current user',
        () async {
      final events = StreamController<DataState<UserEntity?>>.broadcast();
      final notifier = AuthRouterNotifier(authStateChanges: events.stream);
      addTearDown(notifier.dispose);
      addTearDown(events.close);

      expect(notifier.isOnboardingCompleted('user-1'), isFalse);
      notifier.markOnboardingCompleted('user-1');
      expect(notifier.isOnboardingCompleted('user-1'), isTrue);
    });

    test('invalidates onboarding cache when auth state changes', () async {
      final events = StreamController<DataState<UserEntity?>>.broadcast();
      final notifier = AuthRouterNotifier(authStateChanges: events.stream);
      addTearDown(notifier.dispose);
      addTearDown(events.close);

      notifier.markOnboardingCompleted('user-1');
      events.add(const DataSuccess<UserEntity?>(null));
      await Future<void>.delayed(Duration.zero);

      expect(notifier.isOnboardingCompleted('user-1'), isFalse);
    });
  });
}
