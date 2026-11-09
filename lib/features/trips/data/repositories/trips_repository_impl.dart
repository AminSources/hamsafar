import 'package:hamsafar/features/trips/domain/entities/trip_draft.dart';
import 'package:hamsafar/features/trips/data/data_source/remote/supabase_trips_datasource.dart';
import 'package:hamsafar/features/trips/data/models/trip_model.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';
import 'package:hamsafar/features/trips/domain/repositories/trips_repository.dart';

class TripsRepositoryImpl implements TripsRepository {
  final SupabaseTripsDatasource datasource;
  TripsRepositoryImpl({required this.datasource});

  @override
  Future<List<TripEntity>> getMyTrips() async =>
      (await datasource.getTrips(mode: 'mine')).map(TripModel.fromJson).toList();

  @override
  Future<List<TripEntity>> searchTrips(String query) async =>
      (await datasource.getTrips(mode: 'search', query: query)).map(TripModel.fromJson).toList();

  @override
  Future<TripEntity> getTripDetails(int tripId) async {
    final rows = await datasource.getTrips(mode: 'details', tripId: tripId);
    if (rows.isEmpty) throw Exception('trip_not_found_or_forbidden');
    final status = await datasource.getMembershipStatus(tripId);
    final membershipClosed = await datasource.getMembershipClosed(tripId);
    final options = await datasource.getDepartureOptions(tripId);
    final bankDetails = rows.first['is_creator'] == true
        ? await datasource.getTripPaymentDetails(tripId)
        : null;
    return TripModel.fromJson({
      ...rows.first,
      ...?bankDetails,
      'departure_options': options,
      'membership_closed': membershipClosed,
    }, currentMemberStatus: status);
  }

  @override
  Future<int> saveTrip(TripDraft draft, {int? tripId}) =>
      datasource.saveTrip(draft, tripId: tripId);
  @override
  Future<void> startTrip(int tripId) => datasource.startTrip(tripId);

  @override
  Future<void> setMembershipClosed(int tripId, bool closed) =>
      datasource.setMembershipClosed(tripId, closed);

  @override
  Future<void> deleteTrip(int tripId) => datasource.deleteTrip(tripId);
  @override
  Future<void> joinTrip(int tripId) => datasource.joinTrip(tripId);
  @override
  Future<void> respondToInvitation(int tripId, {required bool accept}) =>
      datasource.respondToInvitation(tripId, accept);
  @override
  Future<void> leaveTrip(int tripId) => datasource.leaveTrip(tripId);
  @override
  Future<void> inviteToTrip(int tripId, List<String> userIds) =>
      datasource.inviteToTrip(tripId, userIds);
  @override
  Future<void> removeTripMember(int tripId, String userId) =>
      datasource.removeTripMember(tripId, userId);
}
