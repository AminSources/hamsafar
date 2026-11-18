import 'package:equatable/equatable.dart';

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
