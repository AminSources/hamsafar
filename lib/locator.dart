import 'package:get_it/get_it.dart';
import 'package:hamsafar/features/auth/data/data_source/remote/supabase_auth_datasource.dart';
import 'package:hamsafar/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hamsafar/features/auth/domain/repositories/auth_repository.dart';
import 'package:hamsafar/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:hamsafar/features/auth/domain/usecases/login_usecase.dart';
import 'package:hamsafar/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:hamsafar/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hamsafar/features/main_wrapper/presentation/cubit/bottom_nav_cubit.dart';
import 'package:hamsafar/features/friends/presentation/cubit/friends_tab_bar_cubit.dart';
import 'package:hamsafar/features/profile/data/data_source/remote/supabase_profile_datasource.dart';
import 'package:hamsafar/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:hamsafar/features/profile/domain/repositories/profile_repository.dart';
import 'package:hamsafar/features/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:hamsafar/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:hamsafar/features/trip_creation/presentation/cubit/trip_date_coordination_cubit.dart';
import 'package:hamsafar/features/trip_creation/presentation/cubit/trip_stepper_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  //* supabase
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  //* data sources
  sl.registerLazySingleton<SupabaseAuthDatasource>(
    () => SupabaseAuthDatasource(supabaseClient: sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<SupabaseProfileDatasource>(
    () => SupabaseProfileDatasource(supabaseClient: sl<SupabaseClient>()),
  );

  //* repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      supabaseAuthDatasource: sl<SupabaseAuthDatasource>(),
    ),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      supabaseProfileDatasource: sl<SupabaseProfileDatasource>(),
    ),
  );

  //* usecases
  sl.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SignUpUsecase>(
    () => SignUpUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetCurrentUserUsecase>(
    () => GetCurrentUserUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<EditProfileUsecase>(
    () => EditProfileUsecase(profileRepository: sl<ProfileRepository>()),
  );

  //* Blocs / Cubits
  sl.registerLazySingleton<BottomNavCubit>(() => BottomNavCubit());
  sl.registerLazySingleton<TripStepperCubit>(() => TripStepperCubit());
  sl.registerLazySingleton<FriendsTabBarCubit>(() => FriendsTabBarCubit());
  sl.registerLazySingleton<TripDateCoordinationCubit>(
    () => TripDateCoordinationCubit(),
  );
  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      loginUsecase: sl<LoginUsecase>(),
      signUpUsecase: sl<SignUpUsecase>(),
      getCurrentUserUsecase: sl<GetCurrentUserUsecase>(),
    ),
  );
  sl.registerLazySingleton<ProfileBloc>(
    () => ProfileBloc(editProfileUsecase: sl<EditProfileUsecase>()),
  );
}
