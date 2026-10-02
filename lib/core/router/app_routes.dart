import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/router/auth_router_notifier.dart';
import 'package:hamsafar/features/auth/presentation/pages/login_page.dart';
import 'package:hamsafar/features/profile/presentation/pages/onboarding_page.dart';
import 'package:hamsafar/features/auth/presentation/pages/recovery_password_page.dart';
import 'package:hamsafar/features/auth/presentation/pages/register_page.dart';
import 'package:hamsafar/features/friends/presentation/pages/friend_profile_page.dart';
import 'package:hamsafar/features/home/presentation/pages/home_page.dart';
import 'package:hamsafar/features/profile/presentation/pages/available_days_page.dart';
import 'package:hamsafar/features/profile/presentation/pages/my_tools_page.dart';
import 'package:hamsafar/features/settings/presentation/pages/bug_report_page.dart';
import 'package:hamsafar/features/settings/presentation/pages/settings_page.dart';
import 'package:hamsafar/features/trip_coordination/presentation/pages/trip_budget_page.dart';
import 'package:hamsafar/features/trip_coordination/presentation/pages/trip_tasks_page.dart';
import 'package:hamsafar/features/trip_coordination/presentation/pages/trip_vote_page.dart';
import 'package:hamsafar/features/trip_creation/presentation/pages/trip_creation_wrapper.dart';
import 'package:hamsafar/features/trip_creation/presentation/pages/trip_success_page.dart';
import 'package:hamsafar/features/trips/presentation/pages/trip_details_page.dart';
import 'package:hamsafar/features/main_wrapper/presentation/pages/main_wrapper.dart';
import 'package:hamsafar/features/splash/presentation/pages/splash_page.dart';
import 'package:hamsafar/features/trips/presentation/pages/trip_search_page.dart';
import 'package:hamsafar/features/trips/presentation/pages/trips_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authRouterNotifier = AuthRouterNotifier();

class AppRoutes {
  AppRoutes._();

  static final GoRouter router = GoRouter(
    initialLocation: "/splash",
    refreshListenable: authRouterNotifier,
    redirect: (context, state) async {
      final session = Supabase.instance.client.auth.currentSession;

      final isLoggedIn = session != null;
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

      final userId = session.user.id;

      final profile = await Supabase.instance.client
          .from('profiles')
          .select('onboarding_completed')
          .eq('id', userId)
          .maybeSingle();

      final onboardingCompleted = profile?['onboarding_completed'] == true;

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
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(path: "/home", builder: (context, state) => const HomePage()),
      GoRoute(
        path: "/main-wrapper",
        builder: (context, state) => const MainWrapper(),
      ),
      GoRoute(path: "/trips", builder: (context, state) => const TripsPage()),
      GoRoute(
        path: "/trip-detail",
        builder: (context, state) {
          final bool isJoined = (state.extra as bool?) ?? true;

          return TripDetailsPage(isJoined: isJoined);
        },
      ),
      GoRoute(
        path: "/trip-search",
        builder: (context, state) => const TripSearchPage(),
      ),
      GoRoute(
        path: "/trip-create",
        builder: (context, state) => const TripCreationWrapper(),
      ),
      GoRoute(
        path: "/trip-success",
        builder: (context, state) => const TripSuccessPage(),
      ),
      GoRoute(
        path: "/trip-vote",
        builder: (context, state) => const TripVotePage(),
      ),
      GoRoute(
        path: "/trip-budget",
        builder: (context, state) => const TripBudgetPage(),
      ),
      GoRoute(
        path: "/trip-tasks",
        builder: (context, state) => const TripTasksPage(),
      ),
      GoRoute(
        path: "/friend-profile",
        builder: (context, state) => const FriendProfilePage(),
      ),
      GoRoute(
        path: "/available-days",
        builder: (context, state) => const AvailableDaysPage(),
      ),
      GoRoute(
        path: '/my-items',
        builder: (context, state) => const MyToolsPage(),
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
