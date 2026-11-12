import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';
import 'package:hamsafar/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:hamsafar/features/trip_coordination/domain/entities/trip_coordination_entities.dart';
import 'package:hamsafar/features/trip_coordination/domain/usecases/trip_coordination_usecases.dart';

sealed class TripTasksEvent extends Equatable {
  const TripTasksEvent();

  @override
  List<Object?> get props => [];
}

final class TripTasksLoadRequested extends TripTasksEvent {
  final int tripId;
  const TripTasksLoadRequested(this.tripId);
  @override
  List<Object?> get props => [tripId];
}

final class TripTaskSaveRequested extends TripTasksEvent {
  final int tripId;
  final int? taskId;
  final int tripMemberId;
  final String title;

  const TripTaskSaveRequested({
    required this.tripId,
    this.taskId,
    required this.tripMemberId,
    required this.title,
  });

  @override
  List<Object?> get props => [tripId, taskId, tripMemberId, title];
}

final class TripTaskDeleteRequested extends TripTasksEvent {
  final int tripId;
  final int taskId;
  const TripTaskDeleteRequested({required this.tripId, required this.taskId});
  @override
  List<Object?> get props => [tripId, taskId];
}

final class TripTaskCompletionRequested extends TripTasksEvent {
  final int tripId;
  final int taskId;
  const TripTaskCompletionRequested({
    required this.tripId,
    required this.taskId,
  });
  @override
  List<Object?> get props => [tripId, taskId];
}

class TripTasksState extends Equatable {
  final TripTaskContextEntity? data;
  final String? currentUserId;
  final bool isLoading;
  final bool isBusy;
  final String? errorMessage;
  final String? feedback;
  final bool? feedbackIsSuccess;

  const TripTasksState({
    this.data,
    this.currentUserId,
    this.isLoading = false,
    this.isBusy = false,
    this.errorMessage,
    this.feedback,
    this.feedbackIsSuccess,
  });

  TripTasksState copyWith({
    TripTaskContextEntity? data,
    bool clearData = false,
    String? currentUserId,
    bool? isLoading,
    bool? isBusy,
    String? errorMessage,
    String? feedback,
    bool? feedbackIsSuccess,
    bool clearError = false,
    bool clearFeedback = false,
  }) {
    return TripTasksState(
      data: clearData ? null : data ?? this.data,
      currentUserId: currentUserId ?? this.currentUserId,
      isLoading: isLoading ?? this.isLoading,
      isBusy: isBusy ?? this.isBusy,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      feedback: clearFeedback ? null : feedback ?? this.feedback,
      feedbackIsSuccess:
          clearFeedback ? null : feedbackIsSuccess ?? this.feedbackIsSuccess,
    );
  }

  @override
  List<Object?> get props => [
        data,
        currentUserId,
        isLoading,
        isBusy,
        errorMessage,
        feedback,
        feedbackIsSuccess,
      ];
}

class TripTasksBloc extends Bloc<TripTasksEvent, TripTasksState> {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final GetTripTaskContextUseCase getTripTaskContextUseCase;
  final SaveTripTaskUseCase saveTripTaskUseCase;
  final DeleteTripTaskUseCase deleteTripTaskUseCase;
  final CompleteTripTaskUseCase completeTripTaskUseCase;

  TripTasksBloc({
    required this.getCurrentUserUsecase,
    required this.getTripTaskContextUseCase,
    required this.saveTripTaskUseCase,
    required this.deleteTripTaskUseCase,
    required this.completeTripTaskUseCase,
  }) : super(const TripTasksState()) {
    on<TripTasksLoadRequested>(_onLoad);
    on<TripTaskSaveRequested>(_onSave);
    on<TripTaskDeleteRequested>(_onDelete);
    on<TripTaskCompletionRequested>(_onComplete);
  }

  Future<void> _onLoad(
    TripTasksLoadRequested event,
    Emitter<TripTasksState> emit,
  ) async {
    if (state.isBusy || state.isLoading) return;
    emit(state.copyWith(
      isLoading: true,
      clearError: true,
      clearFeedback: true,
    ));

    try {
      var userId = state.currentUserId;
      if (userId == null) {
        final authResult = await getCurrentUserUsecase(NoParams());
        if (authResult is! DataSuccess<UserEntity?> ||
            authResult.data == null) {
          emit(state.copyWith(
            isLoading: false,
            clearData: true,
            errorMessage: 'ابتدا وارد حساب کاربری شوید.',
          ));
          return;
        }
        userId = authResult.data!.id;
      }

      final data = await getTripTaskContextUseCase(event.tripId);
      emit(state.copyWith(
        data: data,
        currentUserId: userId,
        isLoading: false,
        clearError: true,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: _friendlyError(error),
      ));
    }
  }

  Future<void> _onSave(
    TripTaskSaveRequested event,
    Emitter<TripTasksState> emit,
  ) async {
    if (state.isBusy) return;
    emit(state.copyWith(
      isBusy: true,
      clearError: true,
      clearFeedback: true,
    ));

    try {
      await saveTripTaskUseCase(
        taskId: event.taskId,
        tripMemberId: event.tripMemberId,
        title: event.title,
      );
      try {
        final data = await getTripTaskContextUseCase(event.tripId);
        emit(state.copyWith(
          data: data,
          isBusy: false,
          feedback:
              event.taskId == null ? 'وظیفه اضافه شد.' : 'وظیفه ویرایش شد.',
          feedbackIsSuccess: true,
        ));
      } catch (_) {
        emit(state.copyWith(
          isBusy: false,
          feedback: 'وظیفه ثبت شد، اما دریافت فهرست به‌روز وظایف ناموفق بود.',
          feedbackIsSuccess: true,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        isBusy: false,
        feedback: _friendlyError(error),
        feedbackIsSuccess: false,
      ));
    }
  }

  Future<void> _onDelete(
    TripTaskDeleteRequested event,
    Emitter<TripTasksState> emit,
  ) async {
    if (state.isBusy) return;
    emit(state.copyWith(
      isBusy: true,
      clearError: true,
      clearFeedback: true,
    ));

    try {
      await deleteTripTaskUseCase(event.taskId);
      try {
        final data = await getTripTaskContextUseCase(event.tripId);
        emit(state.copyWith(
          data: data,
          isBusy: false,
          feedback: 'وظیفه حذف شد.',
          feedbackIsSuccess: true,
        ));
      } catch (_) {
        emit(state.copyWith(
          isBusy: false,
          feedback: 'وظیفه حذف شد، اما دریافت فهرست به‌روز وظایف ناموفق بود.',
          feedbackIsSuccess: true,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        isBusy: false,
        feedback: _friendlyError(error),
        feedbackIsSuccess: false,
      ));
    }
  }

  Future<void> _onComplete(
    TripTaskCompletionRequested event,
    Emitter<TripTasksState> emit,
  ) async {
    if (state.isBusy) return;
    emit(state.copyWith(
      isBusy: true,
      clearError: true,
      clearFeedback: true,
    ));

    try {
      await completeTripTaskUseCase(event.taskId);
      try {
        final data = await getTripTaskContextUseCase(event.tripId);
        emit(state.copyWith(
          data: data,
          isBusy: false,
          feedback: 'وظیفه به‌عنوان انجام‌شده ثبت شد.',
          feedbackIsSuccess: true,
        ));
      } catch (_) {
        emit(state.copyWith(
          isBusy: false,
          feedback: 'وضعیت وظیفه ثبت شد، اما دریافت فهرست به‌روز ناموفق بود.',
          feedbackIsSuccess: true,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        isBusy: false,
        feedback: _friendlyError(error),
        feedbackIsSuccess: false,
      ));
    }
  }

  String _friendlyError(Object error) {
    final raw = error.toString().toLowerCase();
    if (raw.contains('membership_closed')) {
      return 'عضوگیری بسته شده است.';
    }
    if (raw.contains('membership_not_closed')) {
      return 'برای مدیریت وظایف ابتدا عضوگیری را ببندید.';
    }
    if (raw.contains('task_already_completed')) {
      return 'وظیفه انجام شده و دیگر قابل تغییر نیست.';
    }
    if (raw.contains('leader_only')) {
      return 'فقط لیدر سفر می‌تواند این عملیات را انجام دهد.';
    }
    if (raw.contains('trip_not_found_or_forbidden')) {
      return 'به اطلاعات وظایف این سفر دسترسی ندارید.';
    }
    if (raw.contains('task_assignee_not_active')) {
      return 'مسئول انتخاب‌شده دیگر عضو فعال سفر نیست.';
    }
    return 'عملیات وظیفه انجام نشد. دوباره تلاش کنید.';
  }
}
