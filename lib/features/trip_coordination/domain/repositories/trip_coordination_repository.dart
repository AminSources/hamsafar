typedef CoordinationJson = Map<String, dynamic>;

abstract interface class TripCoordinationRepository {
  Future<CoordinationJson?> getMyTripBudget();
  Future<void> submitTripPayment({
    required int tripId,
    required String method,
    String? reference,
  });
  Future<void> confirmTripPayment({
    required int tripId,
    required String userId,
  });

  Future<CoordinationJson> getTripTaskContext(int tripId);
  String? getCurrentUserId();
  Future<void> saveTripTask({
    int? taskId,
    required int tripMemberId,
    required String title,
  });
  Future<void> deleteTripTask(int taskId);
  Future<void> completeTripTask(int taskId);

  Future<List<CoordinationJson>> getMyDeparturePolls();
  Future<void> castDepartureVote({
    required int tripId,
    required int optionId,
  });
}
