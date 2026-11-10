import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/features/trip_creation/domain/entities/trip_draft.dart';
import 'package:hamsafar/features/trip_creation/domain/usecases/save_trip_usecase.dart';

class TripCreationState extends Equatable {
  final bool isSaving;
  final String? errorMessage;

  const TripCreationState({
    this.isSaving = false,
    this.errorMessage,
  });

  TripCreationState copyWith({
    bool? isSaving,
    String? errorMessage,
    bool clearError = false,
  }) {
    return TripCreationState(
      isSaving: isSaving ?? this.isSaving,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [isSaving, errorMessage];
}

class TripCreationCubit extends Cubit<TripCreationState> {
  final SaveTripUseCase saveTripUseCase;

  TripCreationCubit({required this.saveTripUseCase})
      : super(const TripCreationState());

  Future<int?> save(TripDraft draft, {int? tripId}) async {
    emit(state.copyWith(isSaving: true, clearError: true));
    try {
      final id = await saveTripUseCase(draft, tripId: tripId);
      emit(state.copyWith(isSaving: false));
      return id;
    } catch (error) {
      emit(
        state.copyWith(
          isSaving: false,
          errorMessage: _friendlyError(error),
        ),
      );
      return null;
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
