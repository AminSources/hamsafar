import 'package:hamsafar/features/trip_coordination/domain/entities/trip_coordination_entities.dart';

abstract interface class TripCoordinationRepository {
  Future<TripBudgetEntity?> getMyTripBudget();
  Future<void> submitTripPayment({
    required int tripId,
    required String method,
    String? reference,
  });
  Future<void> confirmTripPayment({
    required int tripId,
    required String userId,
  });

  Future<TripTaskContextEntity> getTripTaskContext(int tripId);
  Future<void> saveTripTask({
    int? taskId,
    required int tripMemberId,
    required String title,
  });
  Future<void> deleteTripTask(int taskId);
  Future<void> completeTripTask(int taskId);

  Future<List<DeparturePollEntity>> getMyDeparturePolls();
  Future<void> castDepartureVote({
    required int tripId,
    required int optionId,
  });
}
