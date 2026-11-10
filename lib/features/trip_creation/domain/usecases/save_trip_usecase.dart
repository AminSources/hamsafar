import 'package:hamsafar/features/trip_creation/domain/entities/trip_draft.dart';
import 'package:hamsafar/features/trip_creation/domain/repositories/trip_creation_repository.dart';

class SaveTripUseCase {
  final TripCreationRepository repository;

  const SaveTripUseCase({required this.repository});

  Future<int> call(TripDraft draft, {int? tripId}) {
    return repository.saveTrip(draft, tripId: tripId);
  }
}
