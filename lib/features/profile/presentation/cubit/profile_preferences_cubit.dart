import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/profile/domain/entities/profile_preferences_entity.dart';
import 'package:hamsafar/features/profile/domain/params/save_availability_params.dart';
import 'package:hamsafar/features/profile/domain/usecases/get_profile_preferences_usecase.dart';
import 'package:hamsafar/features/profile/domain/usecases/save_availability_usecase.dart';
import 'package:hamsafar/features/profile/domain/usecases/save_tools_usecase.dart';

class ProfilePreferencesState extends Equatable {
  final bool isLoading;
  final bool isLoaded;
  final bool isSaving;
  final List<ProfileAvailabilityEntity> availability;
  final List<ProfileToolEntity> tools;
  final String? message;

  const ProfilePreferencesState({
    this.isLoading = false,
    this.isLoaded = false,
    this.isSaving = false,
    this.availability = const [],
    this.tools = const [],
    this.message,
  });

  ProfilePreferencesState copyWith({
    bool? isLoading,
    bool? isLoaded,
    bool? isSaving,
    List<ProfileAvailabilityEntity>? availability,
    List<ProfileToolEntity>? tools,
    String? message,
    bool clearMessage = false,
  }) {
    return ProfilePreferencesState(
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      isSaving: isSaving ?? this.isSaving,
      availability: availability ?? this.availability,
      tools: tools ?? this.tools,
      message: clearMessage ? null : message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    isLoading, isLoaded, isSaving, availability, tools, message,
  ];
}

class ProfilePreferencesCubit extends Cubit<ProfilePreferencesState> {
  final GetProfilePreferencesUsecase getProfilePreferencesUsecase;
  final SaveAvailabilityUsecase saveAvailabilityUsecase;
  final SaveToolsUsecase saveToolsUsecase;

  ProfilePreferencesCubit({
    required this.getProfilePreferencesUsecase,
    required this.saveAvailabilityUsecase,
    required this.saveToolsUsecase,
  }) : super(const ProfilePreferencesState());

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, clearMessage: true));
    final result = await getProfilePreferencesUsecase(NoParams());

    if (result is DataSuccess<ProfilePreferencesEntity> &&
        result.data != null) {
      emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        availability: result.data!.availability,
        tools: result.data!.tools,
        clearMessage: true,
      ));
      return;
    }

    emit(state.copyWith(
      isLoading: false,
      isLoaded: false,
      message: result.message ?? 'دریافت تنظیمات پروفایل ناموفق بود',
    ));
  }

  Future<bool> saveAvailability(SaveAvailabilityParams params) async {
    emit(state.copyWith(isSaving: true, clearMessage: true));
    final result = await saveAvailabilityUsecase(params);

    if (result is DataSuccess) {
      emit(state.copyWith(isSaving: false, clearMessage: true));
      return true;
    }

    emit(state.copyWith(
      isSaving: false,
      message: result.message ?? 'ذخیره روزهای آزاد ناموفق بود',
    ));
    return false;
  }

  Future<bool> saveTools(List<ProfileToolEntity> tools) async {
    emit(state.copyWith(isSaving: true, clearMessage: true));
    final result = await saveToolsUsecase(tools);

    if (result is DataSuccess) {
      emit(state.copyWith(isSaving: false, clearMessage: true));
      return true;
    }

    emit(state.copyWith(
      isSaving: false,
      message: result.message ?? 'ذخیره وسایل ناموفق بود',
    ));
    return false;
  }
}
