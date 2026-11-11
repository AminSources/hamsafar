import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/router/auth_router_notifier.dart';
import 'package:hamsafar/features/auth/presentation/pages/login_page.dart';
import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';
import 'package:hamsafar/features/profile/presentation/pages/onboarding_page.dart';
import 'package:hamsafar/features/auth/presentation/pages/recovery_password_page.dart';
import 'package:hamsafar/features/auth/presentation/pages/register_page.dart';
import 'package:hamsafar/features/friends/presentation/pages/friend_profile_page.dart';
import 'package:hamsafar/features/home/presentation/pages/home_page.dart';
import 'package:hamsafar/features/profile/presentation/pages/available_days_page.dart';
import 'package:hamsafar/features/profile/presentation/pages/my_tools_page.dart';
import 'package:hamsafar/features/profile/presentation/bloc/profile_preferences_bloc.dart';
import 'package:hamsafar/features/profile/presentation/bloc/profile_avatar_bloc.dart';
import 'package:hamsafar/features/main_wrapper/presentation/bloc/bottom_nav_bloc.dart';
import 'package:hamsafar/locator.dart';
import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/profile/domain/usecases/get_onboarding_completed_usecase.dart';
import 'package:hamsafar/features/auth/domain/repositories/auth_repository.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';
import 'package:hamsafar/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:hamsafar/features/settings/presentation/pages/bug_report_page.dart';
import 'package:hamsafar/features/settings/presentation/pages/settings_page.dart';
import 'package:hamsafar/features/trip_coordination/presentation/pages/trip_budget_page.dart';
import 'package:hamsafar/features/trip_coordination/presentation/bloc/trip_budget_bloc.dart';
import 'package:hamsafar/features/trip_coordination/presentation/pages/trip_tasks_page.dart';
import 'package:hamsafar/features/trip_coordination/presentation/bloc/trip_tasks_bloc.dart';
import 'package:hamsafar/features/trip_coordination/presentation/pages/trip_vote_page.dart';
import 'package:hamsafar/features/trip_coordination/domain/usecases/trip_coordination_usecases.dart';
import 'package:hamsafar/features/trip_creation/presentation/pages/trip_creation_wrapper.dart';
import 'package:hamsafar/features/trip_creation/domain/usecases/save_trip_usecase.dart';
import 'package:hamsafar/features/trip_creation/presentation/pages/trip_success_page.dart';
import 'package:hamsafar/features/trips/presentation/pages/trip_details_page.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';
import 'package:hamsafar/features/trip_creation/domain/entities/trip_creation_initial_data.dart';
import 'package:hamsafar/features/trip_creation/domain/entities/trip_draft.dart';
import 'package:hamsafar/features/friends/domain/usecases/get_friends_usecase.dart';
import 'package:hamsafar/features/trips/presentation/bloc/trips_bloc.dart';
import 'package:hamsafar/features/main_wrapper/presentation/pages/main_wrapper.dart';
import 'package:hamsafar/features/splash/presentation/pages/splash_page.dart';
import 'package:hamsafar/features/trips/presentation/pages/trip_search_page.dart';
import 'package:hamsafar/features/trips/presentation/pages/trips_page.dart';

final authRouterNotifier = AuthRouterNotifier(
  authStateChanges: sl<AuthRepository>().authStateChanges,
);

class AppRoutes {
  AppRoutes._();

  static final GoRouter router = GoRouter(
    initialLocation: "/splash",
    refreshListenable: authRouterNotifier,
    redirect: (context, state) async {
      final authState = await sl<GetCurrentUserUsecase>()(NoParams());
      final isLoggedIn =
          authState is DataSuccess<UserEntity?> && authState.data != null;
      final location = state.matchedLocation;

      final isSplash = location == '/splash';

      final isAuthRoute =
          location == '/login' ||
          location == '/register' ||
          location == '/recovery';

      final isOnboarding = location == '/onboarding';

      if (!isLoggedIn) {
        if (isAuthRoute) {
          return null;
        }

        return '/login';
      }

      final onboardingState = await sl<GetOnboardingCompletedUseCase>()(
        NoParams(),
      );
      final onboardingCompleted =
          onboardingState is DataSuccess<bool> && onboardingState.data == true;

      if (!onboardingCompleted) {
        if (isOnboarding) {
          return null;
        }

        return '/onboarding';
      }

      if (isSplash || isAuthRoute || isOnboarding) {
        return '/main-wrapper';
      }

      return null;
    },

    routes: <RouteBase>[
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: "/login", builder: (context, state) => const LoginPage()),
      GoRoute(
        path: "/register",
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: "/recovery",
        builder: (context, state) => const RecoveryPasswordPage(),
      ),
      GoRoute(
        path: "/onboarding",
        builder: (context, state) => BlocProvider(
          create: (_) => sl<ProfileAvatarBloc>(),
          child: const OnboardingPage(),
        ),
      ),
      GoRoute(path: "/home", builder: (context, state) => const HomePage()),
      GoRoute(
        path: "/main-wrapper",
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<BottomNavBloc>()),
            BlocProvider(create: (_) => sl<ProfileAvatarBloc>()),
          ],
          child: const MainWrapper(),
        ),
      ),
      GoRoute(path: "/trips", builder: (context, state) => const TripsPage()),
      GoRoute(
        path: "/trip-detail",
        builder: (context, state) {
          final tripId = state.extra is int ? state.extra as int : null;
          return TripDetailsPage(
            tripId: tripId,
            getFriendsUsecase: sl<GetFriendsUsecase>(),
          );
        },
      ),
      GoRoute(
        path: "/trip-search",
        builder: (context, state) => const TripSearchPage(),
      ),
      GoRoute(
        path: "/trip-create",
        builder: (context, state) {
          final trip = state.extra is TripEntity
              ? state.extra as TripEntity
              : null;
          final initialData = trip == null
              ? null
              : TripCreationInitialData(
                  tripId: trip.id,
                  name: trip.name,
                  description: trip.description ?? '',
                  location: trip.location,
                  meetingPoint: trip.meetingPoint ?? '',
                  bankCardNumber: trip.bankCardNumber ?? '',
                  bankAccountName: trip.bankAccountName ?? '',
                  scheduleType: trip.scheduleType,
                  departureAt: trip.departureAt,
                  returnAt: trip.returnAt,
                  budget: trip.budget,
                  departureOptions: trip.departureOptions
                      .map(
                        (option) => DepartureOptionDraft(
                          startsAt: option.startsAt,
                          endsAt: option.endsAt,
                        ),
                      )
                      .toList(),
                  costItems: trip.costItems,
                  rules: trip.rules,
                  invitedUserIds: trip.members
                      .where((member) => member.memberStatus == 'pending')
                      .map((member) => member.id)
                      .toList(),
                );

          return TripCreationWrapper(
            initialData: initialData,
            getFriendsUsecase: sl<GetFriendsUsecase>(),
            saveTripUseCase: sl<SaveTripUseCase>(),
          );
        },
      ),
      GoRoute(
        path: "/trip-success",
        builder: (context, state) {
          final tripId = state.extra is int ? state.extra as int : null;
          return TripSuccessPage(tripId: tripId);
        },
      ),
      GoRoute(
        path: "/trip-vote",
        builder: (context, state) => TripVotePage(
          getMyDeparturePollsUseCase: sl<GetMyDeparturePollsUseCase>(),
          castDepartureVoteUseCase: sl<CastDepartureVoteUseCase>(),
        ),
      ),
      GoRoute(
        path: "/trip-budget",
        builder: (context, state) => BlocProvider(
          create: (_) =>
              sl<TripBudgetBloc>()..add(const TripBudgetLoadRequested()),
          child: const TripBudgetPage(),
        ),
      ),
      GoRoute(
        path: "/trip-tasks",
        builder: (context, state) {
          final tripId = state.extra is int ? state.extra as int : null;
          if (tripId == null || tripId <= 0) {
            return const Scaffold(
              body: Center(child: Text('شناسه سفر معتبر نیست.')),
            );
          }
          return BlocProvider(
            create: (_) =>
                sl<TripTasksBloc>()..add(TripTasksLoadRequested(tripId)),
            child: TripTasksPage(tripId: tripId),
          );
        },
      ),
      GoRoute(
        path: "/friend-profile",
        builder: (context, state) {
          final FriendEntity friendEntity = (state.extra as FriendEntity);

          return FriendProfilePage(friendEntity: friendEntity);
        },
      ),
      GoRoute(
        path: "/available-days",
        builder: (context, state) => BlocProvider(
          create: (_) => sl<ProfilePreferencesBloc>()..add(const ProfilePreferencesLoadRequested()),
          child: const AvailableDaysPage(),
        ),
      ),
      GoRoute(
        path: '/my-items',
        builder: (context, state) => BlocProvider(
          create: (_) => sl<ProfilePreferencesBloc>()..add(const ProfilePreferencesLoadRequested()),
          child: const MyToolsPage(),
        ),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/bug-report',
        builder: (context, state) => const BugReportPage(),
      ),
    ],
  );
}
