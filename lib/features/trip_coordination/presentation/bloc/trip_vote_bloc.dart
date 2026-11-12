import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/features/trip_coordination/domain/entities/trip_coordination_entities.dart';
import 'package:hamsafar/features/trip_coordination/domain/usecases/trip_coordination_usecases.dart';

sealed class TripVoteEvent extends Equatable {
  const TripVoteEvent();

  @override
  List<Object?> get props => [];
}

final class TripVotesLoadRequested extends TripVoteEvent {
  const TripVotesLoadRequested();
}

final class TripVoteSelectionChanged extends TripVoteEvent {
  final int tripId;
  final int optionId;

  const TripVoteSelectionChanged({
    required this.tripId,
    required this.optionId,
  });

  @override
  List<Object?> get props => [tripId, optionId];
}

final class TripVoteSubmissionRequested extends TripVoteEvent {
  final int tripId;

  const TripVoteSubmissionRequested(this.tripId);

  @override
  List<Object?> get props => [tripId];
}

class TripVoteState extends Equatable {
  final List<DeparturePollEntity> polls;
  final Map<int, int?> selectedOptionIds;
  final Set<int> submittingTripIds;
  final bool isLoading;
  final String? errorMessage;
  final String? feedback;
  final bool? feedbackIsSuccess;

  const TripVoteState({
    this.polls = const [],
    this.selectedOptionIds = const {},
    this.submittingTripIds = const {},
    this.isLoading = false,
    this.errorMessage,
    this.feedback,
    this.feedbackIsSuccess,
  });

  TripVoteState copyWith({
    List<DeparturePollEntity>? polls,
    Map<int, int?>? selectedOptionIds,
    Set<int>? submittingTripIds,
    bool? isLoading,
    String? errorMessage,
    String? feedback,
    bool? feedbackIsSuccess,
    bool clearError = false,
    bool clearFeedback = false,
  }) {
    return TripVoteState(
      polls: polls ?? this.polls,
      selectedOptionIds: selectedOptionIds ?? this.selectedOptionIds,
      submittingTripIds: submittingTripIds ?? this.submittingTripIds,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      feedback: clearFeedback ? null : feedback ?? this.feedback,
      feedbackIsSuccess:
          clearFeedback ? null : feedbackIsSuccess ?? this.feedbackIsSuccess,
    );
  }

  @override
  List<Object?> get props => [
        polls,
        selectedOptionIds,
        submittingTripIds,
        isLoading,
        errorMessage,
        feedback,
        feedbackIsSuccess,
      ];
}

class TripVoteBloc extends Bloc<TripVoteEvent, TripVoteState> {
  final GetMyDeparturePollsUseCase getMyDeparturePollsUseCase;
  final CastDepartureVoteUseCase castDepartureVoteUseCase;

  TripVoteBloc({
    required this.getMyDeparturePollsUseCase,
    required this.castDepartureVoteUseCase,
  }) : super(const TripVoteState()) {
    on<TripVotesLoadRequested>(_onLoad);
    on<TripVoteSelectionChanged>(_onSelectionChanged);
    on<TripVoteSubmissionRequested>(_onSubmit);
  }

  Future<void> _onLoad(
    TripVotesLoadRequested event,
    Emitter<TripVoteState> emit,
  ) async {
    if (state.submittingTripIds.isNotEmpty) return;

    emit(state.copyWith(
      isLoading: true,
      clearError: true,
      clearFeedback: true,
    ));

    try {
      final polls = await getMyDeparturePollsUseCase();
      emit(state.copyWith(
        polls: polls,
        selectedOptionIds: {
          for (final poll in polls) poll.tripId: poll.myOptionId,
        },
        isLoading: false,
        clearError: true,
      ));
    } catch (_) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage:
            'دریافت رأی‌گیری‌ها انجام نشد. اتصال اینترنت را بررسی کنید.',
      ));
    }
  }

  void _onSelectionChanged(
    TripVoteSelectionChanged event,
    Emitter<TripVoteState> emit,
  ) {
    if (state.submittingTripIds.contains(event.tripId)) return;

    final matches = state.polls.where((poll) => poll.tripId == event.tripId);
    if (matches.isEmpty ||
        !matches.first.options.any((option) => option.id == event.optionId)) {
      return;
    }

    emit(state.copyWith(
      selectedOptionIds: {
        ...state.selectedOptionIds,
        event.tripId: event.optionId,
      },
      clearFeedback: true,
    ));
  }

  Future<void> _onSubmit(
    TripVoteSubmissionRequested event,
    Emitter<TripVoteState> emit,
  ) async {
    final optionId = state.selectedOptionIds[event.tripId];
    if (optionId == null ||
        state.submittingTripIds.contains(event.tripId)) {
      return;
    }

    emit(state.copyWith(
      submittingTripIds: {...state.submittingTripIds, event.tripId},
      clearError: true,
      clearFeedback: true,
    ));

    try {
      await castDepartureVoteUseCase(
        tripId: event.tripId,
        optionId: optionId,
      );

      try {
        final polls = await getMyDeparturePollsUseCase();
        emit(state.copyWith(
          polls: polls,
          selectedOptionIds: {
            for (final poll in polls) poll.tripId: poll.myOptionId,
          },
          submittingTripIds: {...state.submittingTripIds}..remove(event.tripId),
          feedback: 'رأی شما با موفقیت ثبت شد.',
          feedbackIsSuccess: true,
        ));
      } catch (_) {
        emit(state.copyWith(
          submittingTripIds: {...state.submittingTripIds}..remove(event.tripId),
          feedback:
              'رأی شما ثبت شد، اما دریافت نتیجهٔ به‌روز رأی‌گیری ناموفق بود.',
          feedbackIsSuccess: true,
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        submittingTripIds: {...state.submittingTripIds}..remove(event.tripId),
        feedback: 'ثبت رأی انجام نشد. دوباره تلاش کنید.',
        feedbackIsSuccess: false,
      ));
    }
  }
}
