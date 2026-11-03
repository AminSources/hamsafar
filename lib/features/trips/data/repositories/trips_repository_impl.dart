import 'package:hamsafar/features/trip_creation/presentation/cubit/trip_draft_cubit.dart';
import 'package:hamsafar/features/trips/data/data_source/remote/supabase_trips_datasource.dart';
import 'package:hamsafar/features/trips/data/models/trip_model.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';
import 'package:hamsafar/features/trips/domain/repositories/trips_repository.dart';

class TripsRepositoryImpl implements TripsRepository {
  final SupabaseTripsDatasource datasource;

  TripsRepositoryImpl({required this.datasource});

  @override
  Future<List<TripEntity>> getMyTrips() async {
    final rows = await datasource.getTrips(mode: 'mine');
    return rows.map(TripModel.fromJson).toList();
  }

  @override
  Future<List<TripEntity>> searchTrips(String query) async {
    final rows = await datasource.getTrips(mode: 'search', query: query);
    return rows.map(TripModel.fromJson).toList();
  }

  @override
  Future<TripEntity> getTripDetails(int tripId) async {
    final rows = await datasource.getTrips(
      mode: 'details',
      tripId: tripId,
    );
    if (rows.isEmpty) {
      throw Exception('trip_not_found_or_forbidden');
    }
    return TripModel.fromJson(rows.first);
  }

  @override
  Future<int> saveTrip(TripDraft draft, {int? tripId}) {
    return datasource.saveTrip(draft, tripId: tripId);
  }

  @override
  Future<void> deleteTrip(int tripId) => datasource.deleteTrip(tripId);
}
