import 'package:hamsafar/features/trip_creation/presentation/cubit/trip_draft_cubit.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';

abstract class TripsRepository {
  Future<List<TripEntity>> getMyTrips();
  Future<List<TripEntity>> searchTrips(String query);
  Future<TripEntity> getTripDetails(int tripId);
  Future<int> saveTrip(TripDraft draft, {int? tripId});
  Future<void> deleteTrip(int tripId);
}
