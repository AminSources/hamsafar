import 'package:flutter/material.dart';
import 'package:hamsafar/core/splash/splash_page.dart';

class AppRoutes {
  AppRoutes._();

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    "/splash": (context) => const SplashPage(),
  };
}
