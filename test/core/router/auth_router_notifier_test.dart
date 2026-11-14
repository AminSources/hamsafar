import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/core/router/auth_router_notifier.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';

void main() {
  group('AuthRouterNotifier', () {
    test('marks onboarding as completed and notifies listeners', () {
      final events = StreamController<DataState<UserEntity?>>.broadcast();
      final notifier = AuthRouterNotifier(authStateChanges: events.stream);
      addTearDown(notifier.dispose);
      addTearDown(events.close);

      var notified = false;
      notifier.addListener(() => notified = true);
      notifier.markOnboardingCompleted();

      expect(notifier.onboardingCompleted, isTrue);
      expect(notified, isTrue);
    });

    test('does not run auth refresh without configured use cases', () async {
      final events = StreamController<DataState<UserEntity?>>.broadcast();
      final notifier = AuthRouterNotifier(authStateChanges: events.stream);
      addTearDown(notifier.dispose);
      addTearDown(events.close);

      events.add(const DataSuccess<UserEntity?>(null));
      await Future<void>.delayed(Duration.zero);

      expect(notifier.isInitialized, isFalse);
    });
  });
}
