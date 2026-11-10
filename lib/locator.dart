import 'package:get_it/get_it.dart';
import 'package:hamsafar/features/auth/data/data_source/remote/supabase_auth_datasource.dart';
import 'package:hamsafar/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hamsafar/features/auth/domain/repositories/auth_repository.dart';
import 'package:hamsafar/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:hamsafar/features/auth/domain/usecases/login_usecase.dart';
import 'package:hamsafar/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:hamsafar/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:hamsafar/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hamsafar/features/friends/data/data_source/remote/supabase_friends_datasource.dart';
import 'package:hamsafar/features/friends/data/repositories/friends_repository_impl.dart';
import 'package:hamsafar/features/friends/domain/repositories/friends_repository.dart';
import 'package:hamsafar/features/friends/domain/usecases/friend_request_usecases.dart';
import 'package:hamsafar/features/friends/domain/usecases/get_friends_usecase.dart';
import 'package:hamsafar/features/friends/presentation/bloc/friends_bloc.dart';
import 'package:hamsafar/features/home/data/data_source/remote/supabase_home_datasource.dart';
import 'package:hamsafar/features/home/data/repositories/home_repository_impl.dart';
import 'package:hamsafar/features/home/domain/repositories/home_repository.dart';
import 'package:hamsafar/features/home/domain/usecases/get_home_usecase.dart';
import 'package:hamsafar/features/home/presentation/bloc/home_bloc.dart';
import 'package:hamsafar/features/main_wrapper/presentation/cubit/bottom_nav_cubit.dart';
import 'package:hamsafar/features/friends/presentation/cubit/friends_tab_bar_cubit.dart';
import 'package:hamsafar/features/profile/data/data_source/remote/supabase_profile_datasource.dart';
import 'package:hamsafar/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:hamsafar/features/profile/domain/repositories/profile_repository.dart';
import 'package:hamsafar/features/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:hamsafar/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:hamsafar/features/profile/domain/usecases/get_onboarding_completed_usecase.dart';
import 'package:hamsafar/features/profile/domain/usecases/get_profile_preferences_usecase.dart';
import 'package:hamsafar/features/profile/domain/usecases/save_availability_usecase.dart';
import 'package:hamsafar/features/profile/domain/usecases/save_tools_usecase.dart';
import 'package:hamsafar/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:hamsafar/features/profile/presentation/cubit/profile_avatar_cubit.dart';
import 'package:hamsafar/features/profile/presentation/cubit/profile_preferences_cubit.dart';
import 'package:hamsafar/features/trip_creation/presentation/cubit/trip_date_coordination_cubit.dart';
import 'package:hamsafar/features/trips/data/data_source/remote/supabase_trips_datasource.dart';
import 'package:hamsafar/features/trips/data/repositories/trips_repository_impl.dart';
import 'package:hamsafar/features/trips/domain/repositories/trips_repository.dart';
import 'package:hamsafar/features/trips/domain/usecases/trips_usecases.dart';
import 'package:hamsafar/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:hamsafar/features/trip_creation/presentation/cubit/trip_stepper_cubit.dart';
import 'package:hamsafar/features/trip_creation/data/data_source/remote/supabase_trip_creation_datasource.dart';
import 'package:hamsafar/features/trip_creation/data/repositories/trip_creation_repository_impl.dart';
import 'package:hamsafar/features/trip_creation/domain/repositories/trip_creation_repository.dart';
import 'package:hamsafar/features/trip_creation/domain/usecases/save_trip_usecase.dart';
import 'package:hamsafar/features/trip_coordination/data/data_source/remote/supabase_trip_coordination_datasource.dart';
import 'package:hamsafar/features/trip_coordination/data/repositories/trip_coordination_repository_impl.dart';
import 'package:hamsafar/features/trip_coordination/domain/repositories/trip_coordination_repository.dart';
import 'package:hamsafar/features/trip_coordination/domain/usecases/trip_coordination_usecases.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hamsafar/features/settings/data/data_source/local/get_storage_app_settings_datasource.dart';
import 'package:hamsafar/features/settings/data/repositories/app_settings_repository_impl.dart';
import 'package:hamsafar/features/settings/domain/repositories/app_settings_repository.dart';
import 'package:hamsafar/features/settings/domain/usecases/app_settings_usecases.dart';
import 'package:hamsafar/features/settings/presentation/cubit/app_settings_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GetIt sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // Data sources
  sl.registerLazySingleton<GetStorageAppSettingsDatasource>(
    () => GetStorageAppSettingsDatasource(storage: GetStorage()),
  );
  sl.registerLazySingleton<SupabaseAuthDatasource>(
    () => SupabaseAuthDatasource(supabaseClient: sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<SupabaseProfileDatasource>(
    () => SupabaseProfileDatasource(supabaseClient: sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<SupabaseHomeDatasource>(
    () => SupabaseHomeDatasource(supabaseClient: sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<SupabaseTripsDatasource>(
    () => SupabaseTripsDatasource(supabaseClient: sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<SupabaseFriendsDatasource>(
    () => SupabaseFriendsDatasource(supabaseClient: sl<SupabaseClient>()),
  );

  sl.registerLazySingleton<SupabaseTripCreationDatasource>(
    () => SupabaseTripCreationDatasource(client: sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<SupabaseTripCoordinationDatasource>(
    () => SupabaseTripCoordinationDatasource(client: sl<SupabaseClient>()),
  );

  // Repositories
  sl.registerLazySingleton<AppSettingsRepository>(
    () => AppSettingsRepositoryImpl(
      datasource: sl<GetStorageAppSettingsDatasource>(),
    ),
  );
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
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      supabaseHomeDatasource: sl<SupabaseHomeDatasource>(),
    ),
  );
  sl.registerLazySingleton<TripsRepository>(
    () => TripsRepositoryImpl(datasource: sl<SupabaseTripsDatasource>()),
  );
  sl.registerLazySingleton<FriendsRepository>(
    () => FriendsRepositoryImpl(
      supabaseFriendsDatasource: sl<SupabaseFriendsDatasource>(),
    ),
  );

  sl.registerLazySingleton<TripCreationRepository>(
    () => TripCreationRepositoryImpl(
      datasource: sl<SupabaseTripCreationDatasource>(),
    ),
  );
  sl.registerLazySingleton<TripCoordinationRepository>(
    () => TripCoordinationRepositoryImpl(
      datasource: sl<SupabaseTripCoordinationDatasource>(),
    ),
  );

  // Trip use cases
  sl.registerLazySingleton<GetMyTripsUseCase>(
    () => GetMyTripsUseCase(sl<TripsRepository>()),
  );
  sl.registerLazySingleton<SearchTripsUseCase>(
    () => SearchTripsUseCase(sl<TripsRepository>()),
  );
  sl.registerLazySingleton<GetTripDetailsUseCase>(
    () => GetTripDetailsUseCase(sl<TripsRepository>()),
  );
  sl.registerLazySingleton<StartTripUseCase>(
    () => StartTripUseCase(sl<TripsRepository>()),
  );
  sl.registerLazySingleton<SetTripMembershipClosedUseCase>(
    () => SetTripMembershipClosedUseCase(sl<TripsRepository>()),
  );
  sl.registerLazySingleton<DeleteTripUseCase>(
    () => DeleteTripUseCase(sl<TripsRepository>()),
  );
  sl.registerLazySingleton<JoinTripUseCase>(
    () => JoinTripUseCase(sl<TripsRepository>()),
  );
  sl.registerLazySingleton<RespondToTripInvitationUseCase>(
    () => RespondToTripInvitationUseCase(sl<TripsRepository>()),
  );
  sl.registerLazySingleton<LeaveTripUseCase>(
    () => LeaveTripUseCase(sl<TripsRepository>()),
  );
  sl.registerLazySingleton<InviteUsersToTripUseCase>(
    () => InviteUsersToTripUseCase(sl<TripsRepository>()),
  );
  sl.registerLazySingleton<RemoveTripMemberUseCase>(
    () => RemoveTripMemberUseCase(sl<TripsRepository>()),
  );

  // Use cases
  sl.registerLazySingleton<LoadAppSettingsUseCase>(
    () => LoadAppSettingsUseCase(sl<AppSettingsRepository>()),
  );
  sl.registerLazySingleton<SaveAppLanguageUseCase>(
    () => SaveAppLanguageUseCase(sl<AppSettingsRepository>()),
  );
  sl.registerLazySingleton<SaveAppThemeModeUseCase>(
    () => SaveAppThemeModeUseCase(sl<AppSettingsRepository>()),
  );
  sl.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SignUpUsecase>(
    () => SignUpUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SignOutUsecase>(
    () => SignOutUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetCurrentUserUsecase>(
    () => GetCurrentUserUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<EditProfileUsecase>(
    () => EditProfileUsecase(profileRepository: sl<ProfileRepository>()),
  );
  sl.registerLazySingleton<GetOnboardingCompletedUseCase>(
    () => GetOnboardingCompletedUseCase(repository: sl<ProfileRepository>()),
  );
  sl.registerLazySingleton(
    () => GetProfileUsecase(profileRepository: sl<ProfileRepository>()),
  );
  sl.registerLazySingleton<GetProfilePreferencesUsecase>(
    () => GetProfilePreferencesUsecase(profileRepository: sl<ProfileRepository>()),
  );
  sl.registerLazySingleton<SaveAvailabilityUsecase>(
    () => SaveAvailabilityUsecase(profileRepository: sl<ProfileRepository>()),
  );
  sl.registerLazySingleton<SaveToolsUsecase>(
    () => SaveToolsUsecase(profileRepository: sl<ProfileRepository>()),
  );
  sl.registerFactory<ProfilePreferencesCubit>(
    () => ProfilePreferencesCubit(
      getProfilePreferencesUsecase: sl<GetProfilePreferencesUsecase>(),
      saveAvailabilityUsecase: sl<SaveAvailabilityUsecase>(),
      saveToolsUsecase: sl<SaveToolsUsecase>(),
    ),
  );
  sl.registerLazySingleton<GetHomeUsecase>(
    () => GetHomeUsecase(homeRepository: sl<HomeRepository>()),
  );
  sl.registerLazySingleton<GetFriendsUsecase>(
    () => GetFriendsUsecase(friendsRepository: sl<FriendsRepository>()),
  );
  sl.registerLazySingleton<SearchFriendsUsecase>(
    () => SearchFriendsUsecase(friendsRepository: sl<FriendsRepository>()),
  );
  sl.registerLazySingleton<GetPendingFriendRequestsUsecase>(
    () => GetPendingFriendRequestsUsecase(
      friendsRepository: sl<FriendsRepository>(),
    ),
  );
  sl.registerLazySingleton<SendFriendRequestUsecase>(
    () => SendFriendRequestUsecase(friendsRepository: sl<FriendsRepository>()),
  );
  sl.registerLazySingleton<RespondToFriendRequestUsecase>(
    () => RespondToFriendRequestUsecase(
      friendsRepository: sl<FriendsRepository>(),
    ),
  );
  sl.registerLazySingleton<CancelFriendRequestUsecase>(
    () => CancelFriendRequestUsecase(
      friendsRepository: sl<FriendsRepository>(),
    ),
  );
  sl.registerLazySingleton<RemoveFriendUsecase>(
    () => RemoveFriendUsecase(friendsRepository: sl<FriendsRepository>()),
  );

  sl.registerLazySingleton<SaveTripUseCase>(
    () => SaveTripUseCase(repository: sl<TripCreationRepository>()),
  );
  sl.registerLazySingleton<GetMyTripBudgetUseCase>(
    () => GetMyTripBudgetUseCase(sl<TripCoordinationRepository>()),
  );
  sl.registerLazySingleton<SubmitTripPaymentUseCase>(
    () => SubmitTripPaymentUseCase(sl<TripCoordinationRepository>()),
  );
  sl.registerLazySingleton<ConfirmTripPaymentUseCase>(
    () => ConfirmTripPaymentUseCase(sl<TripCoordinationRepository>()),
  );
  sl.registerLazySingleton<GetTripTaskContextUseCase>(
    () => GetTripTaskContextUseCase(sl<TripCoordinationRepository>()),
  );
  sl.registerLazySingleton<SaveTripTaskUseCase>(
    () => SaveTripTaskUseCase(sl<TripCoordinationRepository>()),
  );
  sl.registerLazySingleton<DeleteTripTaskUseCase>(
    () => DeleteTripTaskUseCase(sl<TripCoordinationRepository>()),
  );
  sl.registerLazySingleton<CompleteTripTaskUseCase>(
    () => CompleteTripTaskUseCase(sl<TripCoordinationRepository>()),
  );
  sl.registerLazySingleton<GetMyDeparturePollsUseCase>(
    () => GetMyDeparturePollsUseCase(sl<TripCoordinationRepository>()),
  );
  sl.registerLazySingleton<CastDepartureVoteUseCase>(
    () => CastDepartureVoteUseCase(sl<TripCoordinationRepository>()),
  );

  // Blocs and cubits
  sl.registerFactory<AppSettingsCubit>(
    () => AppSettingsCubit(
      loadSettingsUseCase: sl<LoadAppSettingsUseCase>(),
      saveLanguageUseCase: sl<SaveAppLanguageUseCase>(),
      saveThemeModeUseCase: sl<SaveAppThemeModeUseCase>(),
    ),
  );
  sl.registerLazySingleton<BottomNavCubit>(() => BottomNavCubit());
  sl.registerLazySingleton<TripStepperCubit>(() => TripStepperCubit());
  sl.registerLazySingleton<TripsCubit>(
    () => TripsCubit(
      getMyTripsUseCase: sl<GetMyTripsUseCase>(),
      searchTripsUseCase: sl<SearchTripsUseCase>(),
      getTripDetailsUseCase: sl<GetTripDetailsUseCase>(),
      startTripUseCase: sl<StartTripUseCase>(),
      setMembershipClosedUseCase: sl<SetTripMembershipClosedUseCase>(),
      deleteTripUseCase: sl<DeleteTripUseCase>(),
      joinTripUseCase: sl<JoinTripUseCase>(),
      respondToTripInvitationUseCase: sl<RespondToTripInvitationUseCase>(),
      leaveTripUseCase: sl<LeaveTripUseCase>(),
      inviteUsersToTripUseCase: sl<InviteUsersToTripUseCase>(),
      removeTripMemberUseCase: sl<RemoveTripMemberUseCase>(),
    ),
  );
  sl.registerLazySingleton<FriendsTabBarCubit>(() => FriendsTabBarCubit());
  sl.registerLazySingleton<TripDateCoordinationCubit>(
    () => TripDateCoordinationCubit(),
  );
  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      loginUsecase: sl<LoginUsecase>(),
      signUpUsecase: sl<SignUpUsecase>(),
      getCurrentUserUsecase: sl<GetCurrentUserUsecase>(),
      signOutUsecase: sl<SignOutUsecase>(),
    ),
  );
  sl.registerLazySingleton<ProfileBloc>(
    () => ProfileBloc(
      editProfileUsecase: sl<EditProfileUsecase>(),
      getProfileUsecase: sl<GetProfileUsecase>(),
    ),
  );
  sl.registerLazySingleton<HomeBloc>(
    () => HomeBloc(getHomeUsecase: sl<GetHomeUsecase>()),
  );
  sl.registerLazySingleton<ProfileAvatarCubit>(() => ProfileAvatarCubit());
  sl.registerLazySingleton<FriendsBloc>(
    () => FriendsBloc(
      getFriendsUsecase: sl<GetFriendsUsecase>(),
      searchFriendsUsecase: sl<SearchFriendsUsecase>(),
      getPendingFriendRequestsUsecase:
          sl<GetPendingFriendRequestsUsecase>(),
      sendFriendRequestUsecase: sl<SendFriendRequestUsecase>(),
      respondToFriendRequestUsecase: sl<RespondToFriendRequestUsecase>(),
      cancelFriendRequestUsecase: sl<CancelFriendRequestUsecase>(),
      removeFriendUsecase: sl<RemoveFriendUsecase>(),
    ),
  );
}
