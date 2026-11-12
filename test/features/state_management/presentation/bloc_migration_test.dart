import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamsafar/features/friends/presentation/bloc/friends_tab_bar_bloc.dart';
import 'package:hamsafar/features/main_wrapper/presentation/bloc/bottom_nav_bloc.dart';
import 'package:hamsafar/features/profile/presentation/bloc/profile_avatar_bloc.dart';
import 'package:hamsafar/features/settings/domain/entities/app_settings_entity.dart';
import 'package:hamsafar/features/settings/domain/repositories/app_settings_repository.dart';
import 'package:hamsafar/features/settings/domain/usecases/app_settings_usecases.dart';
import 'package:hamsafar/features/settings/presentation/bloc/app_settings_bloc.dart';
import 'package:hamsafar/features/trip_creation/domain/entities/trip_draft.dart';
import 'package:hamsafar/features/trip_creation/domain/repositories/trip_creation_repository.dart';
import 'package:hamsafar/features/trip_creation/domain/usecases/save_trip_usecase.dart';
import 'package:hamsafar/features/trip_creation/presentation/bloc/trip_creation_bloc.dart';
import 'package:hamsafar/features/trip_creation/presentation/bloc/trip_stepper_bloc.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';
import 'package:hamsafar/features/trips/domain/repositories/trips_repository.dart';
import 'package:hamsafar/features/trips/domain/usecases/trips_usecases.dart';
import 'package:hamsafar/features/trips/presentation/bloc/trips_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class _FakeSettingsRepository implements AppSettingsRepository {
  String? savedLanguage;
  String? savedTheme;

  @override
  AppSettingsEntity loadSettings() => const AppSettingsEntity(
        localeCode: 'en',
        themeMode: 'dark',
      );

  @override
  Future<void> saveLanguage(String localeCode) async {
    savedLanguage = localeCode;
  }

  @override
  Future<void> saveThemeMode(String themeMode) async {
    savedTheme = themeMode;
  }
}

class _FakeTripCreationRepository implements TripCreationRepository {
  int? persistedTripId;

  @override
  Future<int> saveTrip(TripDraft draft, {int? tripId}) async {
    persistedTripId = tripId ?? 123;
    return persistedTripId!;
  }
}

class _FakeTripsRepository implements TripsRepository {
  final TripEntity trip = TripEntity(
    id: 12,
    name: 'Test trip',
    location: 'Tabriz',
    departureAt: DateTime.utc(2026, 12, 1),
    returnAt: DateTime.utc(2026, 12, 2),
    status: 'preparing',
    budget: 1000,
    createdBy: 'creator-1',
  );

  @override
  Future<List<TripEntity>> getMyTrips() async => [trip];

  @override
  Future<List<TripEntity>> searchTrips(String query) async => [trip];

  @override
  Future<TripEntity> getTripDetails(int tripId) async => trip;

  @override
  Future<void> startTrip(int tripId) async {}

  @override
  Future<void> setMembershipClosed(int tripId, bool closed) async {}

  @override
  Future<void> deleteTrip(int tripId) async {}

  @override
  Future<void> joinTrip(int tripId) async {}

  @override
  Future<void> respondToInvitation(int tripId, {required bool accept}) async {}

  @override
  Future<void> leaveTrip(int tripId) async {}

  @override
  Future<void> inviteToTrip(int tripId, List<String> userIds) async {}

  @override
  Future<void> removeTripMember(int tripId, String userId) async {}
}

void main() {
  group('Navigation and selection Blocs', () {
    test('BottomNavBloc changes the active page', () async {
      final bloc = BottomNavBloc();
      addTearDown(bloc.close);

      final result = bloc.stream.firstWhere((index) => index == 2);
      bloc.add(const BottomNavIndexChanged(2));

      expect(await result, 2);
    });

    test('FriendsTabBarBloc changes the selected tab', () async {
      final bloc = FriendsTabBarBloc();
      addTearDown(bloc.close);

      final result = bloc.stream.firstWhere((index) => index == 1);
      bloc.add(const FriendsTabChanged(1));

      expect(await result, 1);
    });

    test('ProfileAvatarBloc changes the selected icon', () async {
      final bloc = ProfileAvatarBloc();
      addTearDown(bloc.close);

      final result = bloc.stream.firstWhere((icon) => icon == LucideIcons.cat);
      bloc.add(const ProfileAvatarChanged(LucideIcons.cat));

      expect(await result, LucideIcons.cat);
    });

    test('TripStepperBloc advances, returns, and resets', () async {
      final bloc = TripStepperBloc();
      addTearDown(bloc.close);

      final advanced = bloc.stream.firstWhere((step) => step == 1);
      bloc.add(const TripStepperNextRequested());
      await advanced;

      final returned = bloc.stream.firstWhere((step) => step == 0);
      bloc.add(const TripStepperPreviousRequested());
      await returned;

      final advancedAgain = bloc.stream.firstWhere((step) => step == 1);
      bloc.add(const TripStepperNextRequested());
      await advancedAgain;

      final reset = bloc.stream.firstWhere((step) => step == 0);
      bloc.add(const TripStepperResetRequested());
      expect(await reset, 0);
    });
  });

  group('AppSettingsBloc', () {
    test('restores persisted settings and handles setting events', () async {
      final repository = _FakeSettingsRepository();
      final bloc = AppSettingsBloc(
        loadSettingsUseCase: LoadAppSettingsUseCase(repository),
        saveLanguageUseCase: SaveAppLanguageUseCase(repository),
        saveThemeModeUseCase: SaveAppThemeModeUseCase(repository),
      );
      addTearDown(bloc.close);

      expect(bloc.state.localeCode, 'en');
      expect(bloc.state.themeMode, ThemeMode.dark);

      final languageChanged =
          bloc.stream.firstWhere((state) => state.localeCode == 'fa');
      bloc.add(const AppLanguageChanged('fa'));
      await languageChanged;

      final themeChanged =
          bloc.stream.firstWhere((state) => state.themeMode == ThemeMode.light);
      bloc.add(const AppThemeChanged(ThemeMode.light));
      await themeChanged;

      expect(repository.savedLanguage, 'fa');
      expect(repository.savedTheme, 'light');
    });
  });

  group('TripCreationBloc', () {
    test('emits the persisted trip id after a successful save', () async {
      final repository = _FakeTripCreationRepository();
      final bloc = TripCreationBloc(
        saveTripUseCase: SaveTripUseCase(repository: repository),
      );
      addTearDown(bloc.close);

      final saved = bloc.stream.firstWhere((state) => state.savedTripId != null);
      bloc.add(TripCreationSaveRequested(TripDraft.empty()));
      final state = await saved;

      expect(repository.persistedTripId, 123);
      expect(state.savedTripId, 123);
      expect(state.isSaving, isFalse);
    });
  });

  group('TripsBloc', () {
    test('loads trips and runs searches through Bloc events', () async {
      final repository = _FakeTripsRepository();
      final bloc = TripsBloc(
        getMyTripsUseCase: GetMyTripsUseCase(repository),
        searchTripsUseCase: SearchTripsUseCase(repository),
        getTripDetailsUseCase: GetTripDetailsUseCase(repository),
        startTripUseCase: StartTripUseCase(repository),
        setMembershipClosedUseCase:
            SetTripMembershipClosedUseCase(repository),
        deleteTripUseCase: DeleteTripUseCase(repository),
        joinTripUseCase: JoinTripUseCase(repository),
        respondToTripInvitationUseCase:
            RespondToTripInvitationUseCase(repository),
        leaveTripUseCase: LeaveTripUseCase(repository),
        inviteUsersToTripUseCase: InviteUsersToTripUseCase(repository),
        removeTripMemberUseCase: RemoveTripMemberUseCase(repository),
      );
      addTearDown(bloc.close);

      final loaded = bloc.stream.firstWhere(
        (state) => !state.isLoadingMyTrips,
      );
      bloc.add(const TripsLoadRequested());
      expect((await loaded).myTrips.single.id, 12);

      final searched = bloc.stream.firstWhere((state) => !state.isSearching);
      bloc.add(const TripsSearchRequested('tabriz'));
      expect((await searched).searchResults.single.id, 12);
    });
  });
}
