import 'package:bloc/bloc.dart';
import 'package:hamsafar/features/trip_creation/domain/usecases/save_trip_usecase.dart';
import 'package:hamsafar/features/trip_creation/presentation/bloc/trip_creation_event.dart';
import 'package:hamsafar/features/trip_creation/presentation/bloc/trip_creation_state.dart';

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
    emit(
      state.copyWith(isSaving: true, clearError: true, clearSavedTripId: true),
    );
    try {
      final id = await saveTripUseCase(event.draft, tripId: event.tripId);
      emit(state.copyWith(isSaving: false, savedTripId: id));
    } catch (error) {
      emit(
        state.copyWith(isSaving: false, errorMessage: _friendlyError(error)),
      );
    }
  }

  String _friendlyError(Object error) {
    final raw = error.toString().toLowerCase();
    if (raw.contains('invalid_trip_dates')) {
      return 'زمان برگشت باید بعد از زمان رفت باشد.';
    }
    if (raw.contains('trip_name_required')) return 'نام سفر را وارد کنید.';
    if (raw.contains('trip_location_required')) return 'مقصد سفر را وارد کنید.';
    if (raw.contains('not_authenticated')) {
      return 'ابتدا وارد حساب کاربری شوید.';
    }
    return 'ذخیره سفر انجام نشد. اتصال اینترنت و اطلاعات را بررسی کنید.';
  }
}
