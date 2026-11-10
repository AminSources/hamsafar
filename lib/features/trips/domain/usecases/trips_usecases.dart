import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';
import 'package:hamsafar/features/trips/domain/repositories/trips_repository.dart';

class GetMyTripsUseCase {
  final TripsRepository repository;
  const GetMyTripsUseCase(this.repository);
  Future<List<TripEntity>> call() => repository.getMyTrips();
}

class SearchTripsUseCase {
  final TripsRepository repository;
  const SearchTripsUseCase(this.repository);
  Future<List<TripEntity>> call(String query) =>
      repository.searchTrips(query);
}

class GetTripDetailsUseCase {
  final TripsRepository repository;
  const GetTripDetailsUseCase(this.repository);
  Future<TripEntity> call(int tripId) =>
      repository.getTripDetails(tripId);
}

class StartTripUseCase {
  final TripsRepository repository;
  const StartTripUseCase(this.repository);
  Future<void> call(int tripId) => repository.startTrip(tripId);
}

class SetTripMembershipClosedUseCase {
  final TripsRepository repository;
  const SetTripMembershipClosedUseCase(this.repository);
  Future<void> call(int tripId, bool closed) =>
      repository.setMembershipClosed(tripId, closed);
}

class DeleteTripUseCase {
  final TripsRepository repository;
  const DeleteTripUseCase(this.repository);
  Future<void> call(int tripId) => repository.deleteTrip(tripId);
}

class JoinTripUseCase {
  final TripsRepository repository;
  const JoinTripUseCase(this.repository);
  Future<void> call(int tripId) => repository.joinTrip(tripId);
}

class RespondToTripInvitationUseCase {
  final TripsRepository repository;
  const RespondToTripInvitationUseCase(this.repository);
  Future<void> call(int tripId, {required bool accept}) =>
      repository.respondToInvitation(tripId, accept: accept);
}

class LeaveTripUseCase {
  final TripsRepository repository;
  const LeaveTripUseCase(this.repository);
  Future<void> call(int tripId) => repository.leaveTrip(tripId);
}

class InviteUsersToTripUseCase {
  final TripsRepository repository;
  const InviteUsersToTripUseCase(this.repository);
  Future<void> call(int tripId, List<String> userIds) =>
      repository.inviteToTrip(tripId, userIds);
}

class RemoveTripMemberUseCase {
  final TripsRepository repository;
  const RemoveTripMemberUseCase(this.repository);
  Future<void> call(int tripId, String userId) =>
      repository.removeTripMember(tripId, userId);
}
