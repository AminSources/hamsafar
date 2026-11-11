import 'package:flutter_test/flutter_test.dart';
import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';
import 'package:hamsafar/features/auth/domain/params/sign_in_params.dart';
import 'package:hamsafar/features/auth/domain/params/sign_up_params.dart';
import 'package:hamsafar/features/auth/domain/repositories/auth_repository.dart';
import 'package:hamsafar/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:hamsafar/features/trip_coordination/domain/entities/trip_coordination_entities.dart';
import 'package:hamsafar/features/trip_coordination/domain/repositories/trip_coordination_repository.dart';
import 'package:hamsafar/features/trip_coordination/domain/usecases/trip_coordination_usecases.dart';
import 'package:hamsafar/features/trip_coordination/presentation/bloc/trip_budget_bloc.dart';
import 'package:hamsafar/features/trip_coordination/presentation/bloc/trip_tasks_bloc.dart';

class _FakeAuthRepository implements AuthRepository {
  @override
  Stream<DataState<UserEntity?>> get authStateChanges =>
      const Stream<DataState<UserEntity?>>.empty();

  @override
  Future<DataState<UserEntity?>> getCurrentUser(NoParams noParams) async {
    return const DataSuccess<UserEntity?>(
      UserEntity(id: 'user-1', email: 'test@example.com'),
    );
  }

  @override
  Future<DataState<UserEntity>> signIn(SignInParams params) =>
      throw UnimplementedError();

  @override
  Future<DataState<UserEntity>> signUp(SignUpParams params) =>
      throw UnimplementedError();

  @override
  Future<void> signOut(NoParams noParams) => throw UnimplementedError();
}

class _FakeTripCoordinationRepository implements TripCoordinationRepository {
  TripBudgetEntity? budget = const TripBudgetEntity(
    tripId: 12,
    isLeader: false,
    members: [],
    myPaymentStatus: 'pending',
    tripName: 'Test trip',
    totalBudget: 1000,
    myShare: 500,
    bankCardNumber: null,
    bankAccountName: null,
  );

  TripTaskContextEntity taskContext = const TripTaskContextEntity(
    isLeader: true,
    membershipClosed: true,
    members: [
      TripTaskMemberEntity(
        tripMemberId: 5,
        firstName: 'Test',
        lastName: 'Member',
        username: 'test',
      ),
    ],
    tasks: [],
  );

  int submittedPayments = 0;
  int confirmedPayments = 0;
  int savedTasks = 0;
  int deletedTasks = 0;
  int completedTasks = 0;

  @override
  Future<TripBudgetEntity?> getMyTripBudget() async => budget;

  @override
  Future<void> submitTripPayment({
    required int tripId,
    required String method,
    String? reference,
  }) async {
    submittedPayments++;
  }

  @override
  Future<void> confirmTripPayment({
    required int tripId,
    required String userId,
  }) async {
    confirmedPayments++;
  }

  @override
  Future<TripTaskContextEntity> getTripTaskContext(int tripId) async =>
      taskContext;

  @override
  Future<void> saveTripTask({
    int? taskId,
    required int tripMemberId,
    required String title,
  }) async {
    savedTasks++;
  }

  @override
  Future<void> deleteTripTask(int taskId) async {
    deletedTasks++;
  }

  @override
  Future<void> completeTripTask(int taskId) async {
    completedTasks++;
  }

  @override
  Future<List<DeparturePollEntity>> getMyDeparturePolls() async => [];

  @override
  Future<void> castDepartureVote({
    required int tripId,
    required int optionId,
  }) async {}
}

void main() {
  group('TripTasksBloc', () {
    test('loads user context and stores the current user id', () async {
      final repository = _FakeTripCoordinationRepository();
      final bloc = TripTasksBloc(
        getCurrentUserUsecase: GetCurrentUserUsecase(
          authRepository: _FakeAuthRepository(),
        ),
        getTripTaskContextUseCase: GetTripTaskContextUseCase(repository),
        saveTripTaskUseCase: SaveTripTaskUseCase(repository),
        deleteTripTaskUseCase: DeleteTripTaskUseCase(repository),
        completeTripTaskUseCase: CompleteTripTaskUseCase(repository),
      );
      addTearDown(bloc.close);

      final result = bloc.stream.firstWhere((state) => state.data != null);
      bloc.add(const TripTasksLoadRequested(12));
      final state = await result;

      expect(state.currentUserId, 'user-1');
      expect(state.data?.isLeader, isTrue);
      expect(state.data?.members, hasLength(1));
    });

    test('saves a task and refreshes its context', () async {
      final repository = _FakeTripCoordinationRepository();
      final bloc = TripTasksBloc(
        getCurrentUserUsecase: GetCurrentUserUsecase(
          authRepository: _FakeAuthRepository(),
        ),
        getTripTaskContextUseCase: GetTripTaskContextUseCase(repository),
        saveTripTaskUseCase: SaveTripTaskUseCase(repository),
        deleteTripTaskUseCase: DeleteTripTaskUseCase(repository),
        completeTripTaskUseCase: CompleteTripTaskUseCase(repository),
      );
      addTearDown(bloc.close);

      final loaded = bloc.stream.firstWhere((state) => state.data != null);
      bloc.add(const TripTasksLoadRequested(12));
      await loaded;

      final saved = bloc.stream.firstWhere(
        (state) => state.feedbackIsSuccess == true,
      );
      bloc.add(const TripTaskSaveRequested(
        tripId: 12,
        tripMemberId: 5,
        title: 'Book accommodation',
      ));
      final state = await saved;

      expect(repository.savedTasks, 1);
      expect(state.isBusy, isFalse);
      expect(state.feedback, 'وظیفه اضافه شد.');
    });
  });

  group('TripBudgetBloc', () {
    test('submits a payment and publishes success state', () async {
      final repository = _FakeTripCoordinationRepository();
      final bloc = TripBudgetBloc(
        getMyTripBudgetUseCase: GetMyTripBudgetUseCase(repository),
        submitTripPaymentUseCase: SubmitTripPaymentUseCase(repository),
        confirmTripPaymentUseCase: ConfirmTripPaymentUseCase(repository),
      );
      addTearDown(bloc.close);

      final loaded = bloc.stream.firstWhere((state) => state.data != null);
      bloc.add(const TripBudgetLoadRequested());
      await loaded;

      final submitted = bloc.stream.firstWhere(
        (state) => state.feedbackIsSuccess == true,
      );
      bloc.add(const TripPaymentSubmissionRequested(
        method: 'bank_transfer',
        reference: '123456',
      ));
      final state = await submitted;

      expect(repository.submittedPayments, 1);
      expect(state.isBusy, isFalse);
      expect(state.feedback, contains('در انتظار تأیید'));
    });

    test('only exposes confirmation flow when current budget belongs to leader', () async {
      final repository = _FakeTripCoordinationRepository()
        ..budget = const TripBudgetEntity(
          tripId: 12,
          isLeader: true,
          members: [],
          myPaymentStatus: null,
          tripName: 'Test trip',
          totalBudget: 1000,
          myShare: 0,
          bankCardNumber: null,
          bankAccountName: null,
        );
      final bloc = TripBudgetBloc(
        getMyTripBudgetUseCase: GetMyTripBudgetUseCase(repository),
        submitTripPaymentUseCase: SubmitTripPaymentUseCase(repository),
        confirmTripPaymentUseCase: ConfirmTripPaymentUseCase(repository),
      );
      addTearDown(bloc.close);

      final loaded = bloc.stream.firstWhere((state) => state.data != null);
      bloc.add(const TripBudgetLoadRequested());
      await loaded;

      final confirmed = bloc.stream.firstWhere(
        (state) => state.feedbackIsSuccess == true,
      );
      bloc.add(const TripPaymentConfirmationRequested('member-1'));
      final state = await confirmed;

      expect(repository.confirmedPayments, 1);
      expect(state.feedback, 'پرداخت عضو تأیید شد.');
    });
  });
}
