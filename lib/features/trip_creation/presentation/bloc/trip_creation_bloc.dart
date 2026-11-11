import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/features/trip_creation/domain/entities/trip_draft.dart';
import 'package:hamsafar/features/trip_creation/domain/usecases/save_trip_usecase.dart';

sealed class TripCreationEvent extends Equatable {
  const TripCreationEvent();

  @override
  List<Object?> get props => [];
}

final class TripCreationSaveRequested extends TripCreationEvent {
  final TripDraft draft;
  final int? tripId;

  const TripCreationSaveRequested(this.draft, {this.tripId});

  @override
  List<Object?> get props => [draft, tripId];
}

class TripCreationState extends Equatable {
  final bool isSaving;
  final String? errorMessage;
  final int? savedTripId;

  const TripCreationState({
    this.isSaving = false,
    this.errorMessage,
    this.savedTripId,
  });

  TripCreationState copyWith({
    bool? isSaving,
    String? errorMessage,
    int? savedTripId,
    bool clearError = false,
    bool clearSavedTripId = false,
  }) {
    return TripCreationState(
      isSaving: isSaving ?? this.isSaving,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      savedTripId: clearSavedTripId ? null : savedTripId ?? this.savedTripId,
    );
  }

  @override
  List<Object?> get props => [isSaving, errorMessage, savedTripId];
}

class TripCreationBloc extends Bloc<TripCreationEvent, TripCreationState> {
  final SaveTripUseCase saveTripUseCase;

  TripCreationBloc({required this.saveTripUseCase})
      : super(const TripCreationState()) {
    on<TripCreationSaveRequested>(_onSaveRequested);
  }

  Future<void> _onSaveRequested(
    TripCreationSaveRequested event,
    Emitter<TripCreationState> emit,
  ) async {
    emit(state.copyWith(
      isSaving: true,
      clearError: true,
      clearSavedTripId: true,
    ));
    try {
      final id = await saveTripUseCase(event.draft, tripId: event.tripId);
      emit(state.copyWith(isSaving: false, savedTripId: id));
    } catch (error) {
      emit(state.copyWith(
        isSaving: false,
        errorMessage: _friendlyError(error),
      ));
    }
  }

  String _friendlyError(Object error) {
    final raw = error.toString().toLowerCase();
    if (raw.contains('invalid_trip_dates')) {
      return 'زمان برگشت باید بعد از زمان رفت باشد.';
    }
    if (raw.contains('trip_name_required')) return 'نام سفر را وارد کنید.';
    if (raw.contains('trip_location_required')) return 'مقصد سفر را وارد کنید.';
    if (raw.contains('not_authenticated')) return 'ابتدا وارد حساب کاربری شوید.';
    return 'ذخیره سفر انجام نشد. اتصال اینترنت و اطلاعات را بررسی کنید.';
  }
}
