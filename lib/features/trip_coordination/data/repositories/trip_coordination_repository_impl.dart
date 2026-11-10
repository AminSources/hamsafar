import 'package:hamsafar/features/trip_coordination/data/data_source/remote/supabase_trip_coordination_datasource.dart';
import 'package:hamsafar/features/trip_coordination/data/models/trip_coordination_models.dart';
import 'package:hamsafar/features/trip_coordination/domain/entities/trip_coordination_entities.dart';
import 'package:hamsafar/features/trip_coordination/domain/repositories/trip_coordination_repository.dart';

class TripCoordinationRepositoryImpl implements TripCoordinationRepository {
  final SupabaseTripCoordinationDatasource datasource;

  const TripCoordinationRepositoryImpl({required this.datasource});

  @override
  Future<TripBudgetEntity?> getMyTripBudget() async {
    final json = await datasource.getMyTripBudget();
    return json == null ? null : TripBudgetModel.fromJson(json);
  }

  @override
  Future<void> submitTripPayment({
    required int tripId,
    required String method,
    String? reference,
  }) {
    return datasource.submitTripPayment(
      tripId: tripId,
      method: method,
      reference: reference,
    );
  }

  @override
  Future<void> confirmTripPayment({
    required int tripId,
    required String userId,
  }) {
    return datasource.confirmTripPayment(tripId: tripId, userId: userId);
  }

  @override
  Future<TripTaskContextEntity> getTripTaskContext(int tripId) async {
    final json = await datasource.getTripTaskContext(tripId);
    return TripTaskContextModel.fromJson(json);
  }

  @override
  String? getCurrentUserId() => datasource.getCurrentUserId();

  @override
  Future<void> saveTripTask({
    int? taskId,
    required int tripMemberId,
    required String title,
  }) {
    return datasource.saveTripTask(
      taskId: taskId,
      tripMemberId: tripMemberId,
      title: title,
    );
  }

  @override
  Future<void> deleteTripTask(int taskId) => datasource.deleteTripTask(taskId);

  @override
  Future<void> completeTripTask(int taskId) =>
      datasource.completeTripTask(taskId);

  @override
  Future<List<DeparturePollEntity>> getMyDeparturePolls() async {
    final rows = await datasource.getMyDeparturePolls();
    return rows.map(DeparturePollModel.fromJson).toList();
  }

  @override
  Future<void> castDepartureVote({
    required int tripId,
    required int optionId,
  }) {
    return datasource.castDepartureVote(tripId: tripId, optionId: optionId);
  }
}
