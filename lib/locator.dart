import 'package:get_it/get_it.dart';
import 'package:hamsafar/core/cubit/bottom_nav_cubit.dart';

GetIt sl = GetIt.instance;

void setupLocator() {
  //* Blocs / Cubits
  sl.registerLazySingleton<BottomNavCubit>(() => BottomNavCubit());
}
