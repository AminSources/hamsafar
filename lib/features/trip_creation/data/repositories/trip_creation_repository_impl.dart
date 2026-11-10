import 'package:hamsafar/features/trip_creation/data/data_source/remote/supabase_trip_creation_datasource.dart';
import 'package:hamsafar/features/trip_creation/domain/entities/trip_draft.dart';
import 'package:hamsafar/features/trip_creation/domain/repositories/trip_creation_repository.dart';

class TripCreationRepositoryImpl implements TripCreationRepository {
  final SupabaseTripCreationDatasource datasource;

  const TripCreationRepositoryImpl({required this.datasource});

  @override
  Future<int> saveTrip(TripDraft draft, {int? tripId}) {
    return datasource.saveTrip(draft, tripId: tripId);
  }
}
