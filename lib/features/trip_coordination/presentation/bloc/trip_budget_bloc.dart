import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/features/trip_coordination/domain/entities/trip_coordination_entities.dart';
import 'package:hamsafar/features/trip_coordination/domain/usecases/trip_coordination_usecases.dart';

sealed class TripBudgetEvent extends Equatable {
  const TripBudgetEvent();

  @override
  List<Object?> get props => [];
}

final class TripBudgetLoadRequested extends TripBudgetEvent {
  const TripBudgetLoadRequested();
}

final class TripPaymentSubmissionRequested extends TripBudgetEvent {
  final String method;
  final String? reference;

  const TripPaymentSubmissionRequested({
    required this.method,
    this.reference,
  });

  @override
  List<Object?> get props => [method, reference];
}

final class TripPaymentConfirmationRequested extends TripBudgetEvent {
  final String userId;
  const TripPaymentConfirmationRequested(this.userId);
  @override
  List<Object?> get props => [userId];
}

class TripBudgetState extends Equatable {
  final TripBudgetEntity? data;
  final bool isLoading;
  final bool isBusy;
  final String? errorMessage;
  final String? feedback;
  final bool? feedbackIsSuccess;

  const TripBudgetState({
    this.data,
    this.isLoading = false,
    this.isBusy = false,
    this.errorMessage,
    this.feedback,
    this.feedbackIsSuccess,
  });

  TripBudgetState copyWith({
    TripBudgetEntity? data,
    bool clearData = false,
    bool? isLoading,
    bool? isBusy,
    String? errorMessage,
    String? feedback,
    bool? feedbackIsSuccess,
    bool clearError = false,
    bool clearFeedback = false,
  }) {
    return TripBudgetState(
      data: clearData ? null : data ?? this.data,
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
        isLoading,
        isBusy,
        errorMessage,
        feedback,
        feedbackIsSuccess,
      ];
}

class TripBudgetBloc extends Bloc<TripBudgetEvent, TripBudgetState> {
  final GetMyTripBudgetUseCase getMyTripBudgetUseCase;
  final SubmitTripPaymentUseCase submitTripPaymentUseCase;
  final ConfirmTripPaymentUseCase confirmTripPaymentUseCase;

  TripBudgetBloc({
    required this.getMyTripBudgetUseCase,
    required this.submitTripPaymentUseCase,
    required this.confirmTripPaymentUseCase,
  }) : super(const TripBudgetState()) {
    on<TripBudgetLoadRequested>(_onLoad);
    on<TripPaymentSubmissionRequested>(_onSubmitPayment);
    on<TripPaymentConfirmationRequested>(_onConfirmPayment);
  }

  Future<void> _onLoad(
    TripBudgetLoadRequested event,
    Emitter<TripBudgetState> emit,
  ) async {
    if (state.isBusy || state.isLoading) return;
    emit(state.copyWith(
      isLoading: true,
      clearError: true,
      clearFeedback: true,
    ));
    try {
      final data = await getMyTripBudgetUseCase();
      emit(state.copyWith(data: data, isLoading: false, clearError: true));
    } catch (_) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'دریافت اطلاعات بودجه انجام نشد. دوباره تلاش کنید.',
      ));
    }
  }

  Future<void> _onSubmitPayment(
    TripPaymentSubmissionRequested event,
    Emitter<TripBudgetState> emit,
  ) async {
    final data = state.data;
    if (state.isBusy || data == null) return;
    emit(state.copyWith(
      isBusy: true,
      clearError: true,
      clearFeedback: true,
    ));

    try {
      await submitTripPaymentUseCase(
        tripId: data.tripId,
        method: event.method,
        reference: event.reference,
      );
      try {
        final refreshedData = await getMyTripBudgetUseCase();
        emit(state.copyWith(
          data: refreshedData,
          isBusy: false,
          feedback: 'پرداخت ثبت شد و در انتظار تأیید لیدر است.',
          feedbackIsSuccess: true,
        ));
      } catch (_) {
        emit(state.copyWith(
          isBusy: false,
          feedback: 'پرداخت ثبت شد، اما دریافت وضعیت به‌روز آن ناموفق بود.',
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

  Future<void> _onConfirmPayment(
    TripPaymentConfirmationRequested event,
    Emitter<TripBudgetState> emit,
  ) async {
    final data = state.data;
    if (state.isBusy || data == null || !data.isLeader) return;
    emit(state.copyWith(
      isBusy: true,
      clearError: true,
      clearFeedback: true,
    ));

    try {
      await confirmTripPaymentUseCase(
        tripId: data.tripId,
        userId: event.userId,
      );
      try {
        final refreshedData = await getMyTripBudgetUseCase();
        emit(state.copyWith(
          data: refreshedData,
          isBusy: false,
          feedback: 'پرداخت عضو تأیید شد.',
          feedbackIsSuccess: true,
        ));
      } catch (_) {
        emit(state.copyWith(
          isBusy: false,
          feedback: 'پرداخت تأیید شد، اما دریافت وضعیت به‌روز ناموفق بود.',
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
    if (raw.contains('invalid_payment_method')) {
      return 'روش پرداخت انتخاب‌شده معتبر نیست.';
    }
    if (raw.contains('payment_reference_required')) {
      return 'شماره پیگیری تراکنش را وارد کنید.';
    }
    if (raw.contains('payment_not_allowed')) {
      return 'امکان ثبت این پرداخت وجود ندارد.';
    }
    if (raw.contains('leader_only')) {
      return 'فقط لیدر سفر می‌تواند پرداخت را تأیید کند.';
    }
    if (raw.contains('payment_not_under_review')) {
      return 'این پرداخت در انتظار بررسی نیست.';
    }
    return 'عملیات پرداخت انجام نشد. دوباره تلاش کنید.';
  }
}
