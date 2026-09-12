import 'package:go_router/go_router.dart';
import 'package:hamsafar/features/splash_feature/presentation/pages/splash_page.dart';

class AppRoutes {
  AppRoutes._();

  static final GoRouter router = GoRouter(
    initialLocation: "/splash",
    routes: <RouteBase>[
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
    ],
  );
}
