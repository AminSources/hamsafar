import 'package:hamsafar/features/trip_coordination/domain/entities/trip_coordination_entities.dart';
import 'package:hamsafar/features/trip_coordination/domain/repositories/trip_coordination_repository.dart';

class GetMyTripBudgetUseCase {
  final TripCoordinationRepository repository;
  const GetMyTripBudgetUseCase(this.repository);
  Future<TripBudgetEntity?> call() => repository.getMyTripBudget();
}

class SubmitTripPaymentUseCase {
  final TripCoordinationRepository repository;
  const SubmitTripPaymentUseCase(this.repository);

  Future<void> call({
    required int tripId,
    required String method,
    String? reference,
  }) {
    return repository.submitTripPayment(
      tripId: tripId,
      method: method,
      reference: reference,
    );
  }
}

class ConfirmTripPaymentUseCase {
  final TripCoordinationRepository repository;
  const ConfirmTripPaymentUseCase(this.repository);

  Future<void> call({required int tripId, required String userId}) {
    return repository.confirmTripPayment(tripId: tripId, userId: userId);
  }
}

class GetTripTaskContextUseCase {
  final TripCoordinationRepository repository;
  const GetTripTaskContextUseCase(this.repository);
  Future<TripTaskContextEntity> call(int tripId) =>
      repository.getTripTaskContext(tripId);
}

class GetCurrentUserIdUseCase {
  final TripCoordinationRepository repository;
  const GetCurrentUserIdUseCase(this.repository);
  String? call() => repository.getCurrentUserId();
}

class SaveTripTaskUseCase {
  final TripCoordinationRepository repository;
  const SaveTripTaskUseCase(this.repository);

  Future<void> call({
    int? taskId,
    required int tripMemberId,
    required String title,
  }) {
    return repository.saveTripTask(
      taskId: taskId,
      tripMemberId: tripMemberId,
      title: title,
    );
  }
}

class DeleteTripTaskUseCase {
  final TripCoordinationRepository repository;
  const DeleteTripTaskUseCase(this.repository);
  Future<void> call(int taskId) => repository.deleteTripTask(taskId);
}

class CompleteTripTaskUseCase {
  final TripCoordinationRepository repository;
  const CompleteTripTaskUseCase(this.repository);
  Future<void> call(int taskId) => repository.completeTripTask(taskId);
}

class GetMyDeparturePollsUseCase {
  final TripCoordinationRepository repository;
  const GetMyDeparturePollsUseCase(this.repository);
  Future<List<DeparturePollEntity>> call() =>
      repository.getMyDeparturePolls();
}

class CastDepartureVoteUseCase {
  final TripCoordinationRepository repository;
  const CastDepartureVoteUseCase(this.repository);

  Future<void> call({required int tripId, required int optionId}) {
    return repository.castDepartureVote(
      tripId: tripId,
      optionId: optionId,
    );
  }
}
