import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/cubit/bottom_nav_cubit.dart';
import 'package:hamsafar/core/router/app_routes.dart';
import 'package:hamsafar/core/theme/app_themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hamsafar/features/trip_creation_feature/presentation/cubit/trip_stepper_cubit.dart';
import 'package:hamsafar/locator.dart';

void main() {
  //? init app
  WidgetsFlutterBinding.ensureInitialized();

  //? init locator
  setupLocator();

  //? on run app
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<BottomNavCubit>()),
        BlocProvider(create: (_) => sl<TripStepperCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp.router(
          title: "Hamsafar Travel App",
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          routerConfig: AppRoutes.router,
          supportedLocales: const [Locale("fa"), Locale("en")],
          locale: const Locale("fa"),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
