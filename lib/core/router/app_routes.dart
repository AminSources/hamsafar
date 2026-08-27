import 'package:flutter/material.dart';
import 'package:hamsafar/core/splash/splash_page.dart';
import 'package:hamsafar/features/auth_feature/presentation/pages/auth_page.dart';
import 'package:hamsafar/features/auth_feature/presentation/pages/verify_page.dart';

class AppRoutes {
  AppRoutes._();

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    "/splash": (context) => const SplashPage(),
    "/auth": (context) => const AuthPage(),
    "/verify": (context) => const VerifyPage(),
  };
}
