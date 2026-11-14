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
import 'package:hamsafar/features/settings/presentation/bloc/app_settings_state.dart';
import 'package:hamsafar/features/trips/presentation/bloc/trips_bloc.dart';
import 'package:hamsafar/features/settings/presentation/bloc/app_settings_bloc.dart';
import 'package:hamsafar/locator.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppBootstrap());
}

class AppBootstrap extends StatefulWidget {
  const AppBootstrap({super.key});

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  bool _initialized = false;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    if (_loading == false && _initialized) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await GetStorage.init();
      await dotenv.load(fileName: '.env');
      final url = dotenv.env['SUPABASE_URL'];
      final publishableKey = dotenv.env['SUPABASE_ANON_KEY'];
      if (url == null || url.isEmpty ||
          publishableKey == null || publishableKey.isEmpty) {
        throw StateError('Supabase environment variables are missing.');
      }
      await Supabase.initialize(url: url, publishableKey: publishableKey);
      setupLocator();
      if (!mounted) return;
      setState(() {
        _initialized = true;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(gradient: AppColors.splashGradient),
            child: Center(
              child: _loading
                  ? const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.backpack_outlined, color: Colors.white, size: 72),
                        SizedBox(height: 24),
                        Text('همسفر', style: TextStyle(color: Colors.white, fontSize: 28)),
                        SizedBox(height: 28),
                        CircularProgressIndicator(color: Colors.white),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.cloud_off_outlined, color: Colors.white, size: 48),
                          const SizedBox(height: 16),
                          const Text(
                            'راه‌اندازی برنامه ناموفق بود.',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _error ?? '',
                            style: const TextStyle(color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          FilledButton(
                            onPressed: _initialize,
                            child: const Text('تلاش مجدد'),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<TripsBloc>()),
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<ProfileBloc>()),
        BlocProvider(create: (context) => sl<HomeBloc>()),
        BlocProvider(create: (context) => sl<FriendsBloc>()),
        BlocProvider(create: (context) => sl<AppSettingsBloc>()),
      ],
      child: const MyApp(),
    );
  }
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
            final fontFamily = settings.localeCode == 'fa'
                ? 'vazirmatn'
                : 'poppins';

            return MaterialApp.router(
              title: 'Hamsafar Travel App',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light.copyWith(
                textTheme: AppTheme.light.textTheme.apply(fontFamily: fontFamily),
              ),
              darkTheme: AppTheme.dark.copyWith(
                textTheme: AppTheme.dark.textTheme.apply(fontFamily: fontFamily),
              ),
              themeMode: settings.themeMode,
              routerConfig: AppRoutes.router,
              supportedLocales: const [Locale('fa'), Locale('en')],
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
