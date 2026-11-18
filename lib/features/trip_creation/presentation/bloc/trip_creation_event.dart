import 'package:equatable/equatable.dart';
import 'package:hamsafar/features/trip_creation/domain/entities/trip_draft.dart';

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
