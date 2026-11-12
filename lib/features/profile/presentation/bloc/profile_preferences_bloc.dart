import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/profile/domain/entities/profile_preferences_entity.dart';
import 'package:hamsafar/features/profile/domain/params/save_availability_params.dart';
import 'package:hamsafar/features/profile/domain/usecases/get_profile_preferences_usecase.dart';
import 'package:hamsafar/features/profile/domain/usecases/save_availability_usecase.dart';
import 'package:hamsafar/features/profile/domain/usecases/save_tools_usecase.dart';

sealed class ProfilePreferencesEvent extends Equatable {
  const ProfilePreferencesEvent();

  @override
  List<Object?> get props => [];
}

final class ProfilePreferencesLoadRequested extends ProfilePreferencesEvent {
  const ProfilePreferencesLoadRequested();
}

final class ProfileAvailabilitySaveRequested extends ProfilePreferencesEvent {
  final SaveAvailabilityParams params;
  const ProfileAvailabilitySaveRequested(this.params);
  @override
  List<Object?> get props => [params];
}

final class ProfileToolsSaveRequested extends ProfilePreferencesEvent {
  final List<ProfileToolEntity> tools;
  const ProfileToolsSaveRequested(this.tools);
  @override
  List<Object?> get props => [tools];
}

class ProfilePreferencesState extends Equatable {
  final bool isLoading;
  final bool isLoaded;
  final bool isSaving;
  final List<ProfileAvailabilityEntity> availability;
  final List<ProfileToolEntity> tools;
  final String? message;
  final bool? saveSucceeded;

  const ProfilePreferencesState({
    this.isLoading = false,
    this.isLoaded = false,
    this.isSaving = false,
    this.availability = const [],
    this.tools = const [],
    this.message,
    this.saveSucceeded,
  });

  ProfilePreferencesState copyWith({
    bool? isLoading,
    bool? isLoaded,
    bool? isSaving,
    List<ProfileAvailabilityEntity>? availability,
    List<ProfileToolEntity>? tools,
    String? message,
    bool? saveSucceeded,
    bool clearMessage = false,
    bool clearSaveResult = false,
  }) {
    return ProfilePreferencesState(
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      isSaving: isSaving ?? this.isSaving,
      availability: availability ?? this.availability,
      tools: tools ?? this.tools,
      message: clearMessage ? null : message ?? this.message,
      saveSucceeded: clearSaveResult ? null : saveSucceeded ?? this.saveSucceeded,
    );
  }

  @override
  List<Object?> get props => [
    isLoading, isLoaded, isSaving, availability, tools, message, saveSucceeded,
  ];
}

class ProfilePreferencesBloc
    extends Bloc<ProfilePreferencesEvent, ProfilePreferencesState> {
  final GetProfilePreferencesUsecase getProfilePreferencesUsecase;
  final SaveAvailabilityUsecase saveAvailabilityUsecase;
  final SaveToolsUsecase saveToolsUsecase;

  ProfilePreferencesBloc({
    required this.getProfilePreferencesUsecase,
    required this.saveAvailabilityUsecase,
    required this.saveToolsUsecase,
  }) : super(const ProfilePreferencesState()) {
    on<ProfilePreferencesLoadRequested>(_onLoad);
    on<ProfileAvailabilitySaveRequested>(_onSaveAvailability);
    on<ProfileToolsSaveRequested>(_onSaveTools);
  }

  Future<void> _onLoad(
    ProfilePreferencesLoadRequested event,
    Emitter<ProfilePreferencesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearMessage: true, clearSaveResult: true));
    final result = await getProfilePreferencesUsecase(NoParams());
    if (result is DataSuccess<ProfilePreferencesEntity> && result.data != null) {
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

  Future<void> _onSaveAvailability(
    ProfileAvailabilitySaveRequested event,
    Emitter<ProfilePreferencesState> emit,
  ) async {
    emit(state.copyWith(isSaving: true, clearMessage: true, clearSaveResult: true));
    final result = await saveAvailabilityUsecase(event.params);
    if (result is DataSuccess) {
      emit(state.copyWith(isSaving: false, saveSucceeded: true, clearMessage: true));
      return;
    }
    emit(state.copyWith(
      isSaving: false,
      saveSucceeded: false,
      message: result.message ?? 'ذخیره روزهای آزاد ناموفق بود',
    ));
  }

  Future<void> _onSaveTools(
    ProfileToolsSaveRequested event,
    Emitter<ProfilePreferencesState> emit,
  ) async {
    emit(state.copyWith(isSaving: true, clearMessage: true, clearSaveResult: true));
    final result = await saveToolsUsecase(event.tools);
    if (result is DataSuccess) {
      emit(state.copyWith(isSaving: false, saveSucceeded: true, clearMessage: true));
      return;
    }
    emit(state.copyWith(
      isSaving: false,
      saveSucceeded: false,
      message: result.message ?? 'ذخیره وسایل ناموفق بود',
    ));
  }
}
