import 'package:get_it/get_it.dart';
import 'package:hamsafar/features/main_wrapper_feature/presentation/cubit/bottom_nav_cubit.dart';
import 'package:hamsafar/features/friends_feature/presentation/cubit/friends_tab_bar_cubit.dart';
import 'package:hamsafar/features/trip_creation_feature/presentation/cubit/trip_date_coordination_cubit.dart';
import 'package:hamsafar/features/trip_creation_feature/presentation/cubit/trip_stepper_cubit.dart';

GetIt sl = GetIt.instance;

void setupLocator() {
  //* Blocs / Cubits
  sl.registerLazySingleton<BottomNavCubit>(() => BottomNavCubit());
  sl.registerLazySingleton<TripStepperCubit>(() => TripStepperCubit());
  sl.registerLazySingleton<FriendsTabBarCubit>(() => FriendsTabBarCubit());
  sl.registerLazySingleton<TripDateCoordinationCubit>(
    () => TripDateCoordinationCubit(),
  );
}
