import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hamsafar/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hamsafar/features/friends/presentation/bloc/friends_bloc.dart';
import 'package:hamsafar/features/home/presentation/bloc/home_bloc.dart';
import 'package:hamsafar/core/router/app_routes.dart';
import 'package:hamsafar/core/theme/app_themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hamsafar/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:hamsafar/features/trips/presentation/bloc/trips_bloc.dart';
import 'package:hamsafar/features/settings/presentation/bloc/app_settings_bloc.dart';
import 'package:hamsafar/locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //? initialize local settings storage
  await GetStorage.init();

  //? load .env
  await dotenv.load(fileName: ".env");

  //? init supabase
  await Supabase.initialize(
    url: dotenv.env["SUPABASE_URL"]!,
    publishableKey: dotenv.env["SUPABASE_ANON_KEY"]!,
  );

  //? init locator
  setupLocator();

  //? on run app
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<TripsBloc>()),
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<ProfileBloc>()),
        BlocProvider(create: (context) => sl<HomeBloc>()),
        BlocProvider(create: (context) => sl<FriendsBloc>()),
        BlocProvider(create: (context) => sl<AppSettingsBloc>()),
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
        return BlocBuilder<AppSettingsBloc, AppSettingsState>(
          builder: (context, settings) {
            return MaterialApp.router(
              title: "Hamsafar Travel App",
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: settings.themeMode,
              routerConfig: AppRoutes.router,
              supportedLocales: const [Locale("fa"), Locale("en")],
              locale: Locale(settings.localeCode),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            );
          },
        );
      },
    );
  }
}
