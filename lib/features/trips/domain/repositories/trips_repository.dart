import 'package:hamsafar/features/trips/domain/entities/trip_draft.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';

abstract class TripsRepository {
  Future<List<TripEntity>> getMyTrips();
  Future<List<TripEntity>> searchTrips(String query);
  Future<TripEntity> getTripDetails(int tripId);
  Future<int> saveTrip(TripDraft draft, {int? tripId});
  Future<void> startTrip(int tripId);
  Future<void> setMembershipClosed(int tripId, bool closed);
  Future<void> deleteTrip(int tripId);
  Future<void> joinTrip(int tripId);
  Future<void> respondToInvitation(int tripId, {required bool accept});
  Future<void> leaveTrip(int tripId);
  Future<void> inviteToTrip(int tripId, List<String> userIds);
  Future<void> removeTripMember(int tripId, String userId);
}
