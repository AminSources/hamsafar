import 'package:go_router/go_router.dart';
import 'package:hamsafar/features/auth_feature/presentation/pages/login_page.dart';
import 'package:hamsafar/features/auth_feature/presentation/pages/onboarding_page.dart';
import 'package:hamsafar/features/auth_feature/presentation/pages/recovery_password_page.dart';
import 'package:hamsafar/features/auth_feature/presentation/pages/register_page.dart';
import 'package:hamsafar/features/home_feature/presentation/pages/home_page.dart';
import 'package:hamsafar/features/main_wrapper_feature/presentation/pages/main_wrapper.dart';
import 'package:hamsafar/features/splash_feature/presentation/pages/splash_page.dart';

class AppRoutes {
  AppRoutes._();

  static final GoRouter router = GoRouter(
    initialLocation: "/splash",
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
    ],
  );
}
