import 'package:hamsafar/features/trip_creation/domain/entities/trip_draft.dart';

abstract interface class TripCreationRepository {
  Future<int> saveTrip(TripDraft draft, {int? tripId});
}
