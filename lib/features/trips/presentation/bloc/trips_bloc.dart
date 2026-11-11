import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/features/trips/domain/usecases/trips_usecases.dart';
import 'package:hamsafar/features/trips/presentation/bloc/trips_state.dart';

sealed class TripsEvent extends Equatable {
  const TripsEvent();

  @override
  List<Object?> get props => [];
}

final class TripsLoadRequested extends TripsEvent {
  const TripsLoadRequested();
}

final class TripsSearchRequested extends TripsEvent {
  final String query;
  const TripsSearchRequested(this.query);
  @override
  List<Object?> get props => [query];
}

final class TripDetailsLoadRequested extends TripsEvent {
  final int tripId;
  const TripDetailsLoadRequested(this.tripId);
  @override
  List<Object?> get props => [tripId];
}

final class CurrentTripDetailsLoadRequested extends TripsEvent {
  const CurrentTripDetailsLoadRequested();
}

final class TripJoinRequested extends TripsEvent {
  final int tripId;
  const TripJoinRequested(this.tripId);
  @override
  List<Object?> get props => [tripId];
}

final class TripInvitationResponseRequested extends TripsEvent {
  final int tripId;
  final bool accept;
  const TripInvitationResponseRequested(this.tripId, {required this.accept});
  @override
  List<Object?> get props => [tripId, accept];
}

final class TripLeaveRequested extends TripsEvent {
  final int tripId;
  const TripLeaveRequested(this.tripId);
  @override
  List<Object?> get props => [tripId];
}

final class TripUsersInviteRequested extends TripsEvent {
  final int tripId;
  final List<String> userIds;
  const TripUsersInviteRequested(this.tripId, this.userIds);
  @override
  List<Object?> get props => [tripId, userIds];
}

final class TripMemberRemovalRequested extends TripsEvent {
  final int tripId;
  final String userId;
  const TripMemberRemovalRequested(this.tripId, this.userId);
  @override
  List<Object?> get props => [tripId, userId];
}

final class TripMembershipClosureChanged extends TripsEvent {
  final int tripId;
  final bool closed;
  const TripMembershipClosureChanged(this.tripId, this.closed);
  @override
  List<Object?> get props => [tripId, closed];
}

final class TripStartRequested extends TripsEvent {
  final int tripId;
  const TripStartRequested(this.tripId);
  @override
  List<Object?> get props => [tripId];
}

final class TripDeletionRequested extends TripsEvent {
  final int tripId;
  const TripDeletionRequested(this.tripId);
  @override
  List<Object?> get props => [tripId];
}

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  final GetMyTripsUseCase getMyTripsUseCase;
  final SearchTripsUseCase searchTripsUseCase;
  final GetTripDetailsUseCase getTripDetailsUseCase;
  final StartTripUseCase startTripUseCase;
  final SetTripMembershipClosedUseCase setMembershipClosedUseCase;
  final DeleteTripUseCase deleteTripUseCase;
  final JoinTripUseCase joinTripUseCase;
  final RespondToTripInvitationUseCase respondToTripInvitationUseCase;
  final LeaveTripUseCase leaveTripUseCase;
  final InviteUsersToTripUseCase inviteUsersToTripUseCase;
  final RemoveTripMemberUseCase removeTripMemberUseCase;

  int _searchVersion = 0;

  TripsBloc({
    required this.getMyTripsUseCase,
    required this.searchTripsUseCase,
    required this.getTripDetailsUseCase,
    required this.startTripUseCase,
    required this.setMembershipClosedUseCase,
    required this.deleteTripUseCase,
    required this.joinTripUseCase,
    required this.respondToTripInvitationUseCase,
    required this.leaveTripUseCase,
    required this.inviteUsersToTripUseCase,
    required this.removeTripMemberUseCase,
  }) : super(const TripsState()) {
    on<TripsLoadRequested>(_onLoadMyTrips);
    on<TripsSearchRequested>(_onSearchTrips);
    on<TripDetailsLoadRequested>(_onLoadTripDetails);
    on<CurrentTripDetailsLoadRequested>(_onLoadCurrentTripDetails);
    on<TripJoinRequested>((event, emit) => _runMembershipAction(
      emit,
      action: () => joinTripUseCase(event.tripId),
      tripId: event.tripId,
      actionType: TripActionType.joined,
    ));
    on<TripInvitationResponseRequested>((event, emit) => _runMembershipAction(
      emit,
      action: () => respondToTripInvitationUseCase(
        event.tripId,
        accept: event.accept,
      ),
      tripId: event.tripId,
      actionType: TripActionType.invitationResponded,
    ));
    on<TripLeaveRequested>((event, emit) => _runMembershipAction(
      emit,
      action: () => leaveTripUseCase(event.tripId),
      tripId: event.tripId,
      actionType: TripActionType.left,
    ));
    on<TripUsersInviteRequested>((event, emit) => _runMembershipAction(
      emit,
      action: () => inviteUsersToTripUseCase(event.tripId, event.userIds),
      tripId: event.tripId,
      actionType: TripActionType.invited,
    ));
    on<TripMemberRemovalRequested>((event, emit) => _runMembershipAction(
      emit,
      action: () => removeTripMemberUseCase(event.tripId, event.userId),
      tripId: event.tripId,
      actionType: TripActionType.memberRemoved,
    ));
    on<TripMembershipClosureChanged>(_onMembershipClosureChanged);
    on<TripStartRequested>(_onStartTrip);
    on<TripDeletionRequested>(_onDeleteTrip);
  }

  Future<void> _onLoadMyTrips(
    TripsLoadRequested event,
    Emitter<TripsState> emit,
  ) async {
    emit(state.copyWith(isLoadingMyTrips: true, clearError: true, clearActionResult: true));
    try {
      final trips = await getMyTripsUseCase();
      emit(state.copyWith(myTrips: trips, isLoadingMyTrips: false));
    } catch (error) {
      emit(state.copyWith(
        isLoadingMyTrips: false,
        errorMessage: _friendlyError(error),
      ));
    }
  }

  Future<void> _onSearchTrips(
    TripsSearchRequested event,
    Emitter<TripsState> emit,
  ) async {
    final version = ++_searchVersion;
    emit(state.copyWith(isSearching: true, clearError: true, clearActionResult: true));
    try {
      final trips = await searchTripsUseCase(event.query.trim());
      if (version != _searchVersion) return;
      emit(state.copyWith(searchResults: trips, isSearching: false));
    } catch (error) {
      if (version != _searchVersion) return;
      emit(state.copyWith(
        isSearching: false,
        errorMessage: _friendlyError(error),
      ));
    }
  }

  Future<void> _onLoadTripDetails(
    TripDetailsLoadRequested event,
    Emitter<TripsState> emit,
  ) async {
    emit(state.copyWith(
      isLoadingDetails: true,
      clearSelectedTrip: true,
      clearError: true,
      clearActionResult: true,
    ));
    try {
      final trip = await getTripDetailsUseCase(event.tripId);
      emit(state.copyWith(selectedTrip: trip, isLoadingDetails: false));
    } catch (error) {
      emit(state.copyWith(
        isLoadingDetails: false,
        errorMessage: _friendlyError(error),
      ));
    }
  }

  Future<void> _onLoadCurrentTripDetails(
    CurrentTripDetailsLoadRequested event,
    Emitter<TripsState> emit,
  ) async {
    emit(state.copyWith(
      isLoadingMyTrips: true,
      isLoadingDetails: true,
      clearSelectedTrip: true,
      clearError: true,
      clearActionResult: true,
    ));
    try {
      final trips = await getMyTripsUseCase();
      if (trips.isEmpty) {
        emit(state.copyWith(
          myTrips: trips,
          isLoadingMyTrips: false,
          isLoadingDetails: false,
        ));
        return;
      }
      final trip = await getTripDetailsUseCase(trips.first.id);
      emit(state.copyWith(
        myTrips: trips,
        selectedTrip: trip,
        isLoadingMyTrips: false,
        isLoadingDetails: false,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoadingMyTrips: false,
        isLoadingDetails: false,
        errorMessage: _friendlyError(error),
      ));
    }
  }

  Future<void> _runMembershipAction(
    Emitter<TripsState> emit, {
    required Future<void> Function() action,
    required int tripId,
    required TripActionType actionType,
  }) async {
    emit(state.copyWith(clearError: true, clearActionResult: true));
    try {
      await action();
      final trip = await getTripDetailsUseCase(tripId);
      final trips = await getMyTripsUseCase();
      emit(state.copyWith(
        selectedTrip: trip,
        myTrips: trips,
        lastActionResult: TripActionResult(
          type: actionType,
          tripId: tripId,
          succeeded: true,
        ),
      ));
    } catch (error) {
      emit(state.copyWith(
        errorMessage: _friendlyError(error),
        lastActionResult: TripActionResult(
          type: actionType,
          tripId: tripId,
          succeeded: false,
        ),
      ));
    }
  }

  Future<void> _onMembershipClosureChanged(
    TripMembershipClosureChanged event,
    Emitter<TripsState> emit,
  ) async {
    emit(state.copyWith(
      isUpdatingMembership: true,
      clearError: true,
      clearActionResult: true,
    ));
    try {
      await setMembershipClosedUseCase(event.tripId, event.closed);
      final trip = await getTripDetailsUseCase(event.tripId);
      final trips = await getMyTripsUseCase();
      emit(state.copyWith(
        selectedTrip: trip,
        myTrips: trips,
        isUpdatingMembership: false,
        lastActionResult: TripActionResult(
          type: TripActionType.membershipChanged,
          tripId: event.tripId,
          succeeded: true,
        ),
      ));
    } catch (error) {
      emit(state.copyWith(
        isUpdatingMembership: false,
        errorMessage: _friendlyError(error),
        lastActionResult: TripActionResult(
          type: TripActionType.membershipChanged,
          tripId: event.tripId,
          succeeded: false,
        ),
      ));
    }
  }

  Future<void> _onStartTrip(
    TripStartRequested event,
    Emitter<TripsState> emit,
  ) async {
    emit(state.copyWith(
      isUpdatingStatus: true,
      clearError: true,
      clearActionResult: true,
    ));
    try {
      await startTripUseCase(event.tripId);
      final trip = await getTripDetailsUseCase(event.tripId);
      final trips = await getMyTripsUseCase();
      emit(state.copyWith(
        selectedTrip: trip,
        myTrips: trips,
        isUpdatingStatus: false,
        lastActionResult: TripActionResult(
          type: TripActionType.started,
          tripId: event.tripId,
          succeeded: true,
        ),
      ));
    } catch (error) {
      emit(state.copyWith(
        isUpdatingStatus: false,
        errorMessage: _friendlyError(error),
        lastActionResult: TripActionResult(
          type: TripActionType.started,
          tripId: event.tripId,
          succeeded: false,
        ),
      ));
    }
  }

  Future<void> _onDeleteTrip(
    TripDeletionRequested event,
    Emitter<TripsState> emit,
  ) async {
    emit(state.copyWith(
      isDeleting: true,
      clearError: true,
      clearActionResult: true,
    ));
    try {
      await deleteTripUseCase(event.tripId);
      emit(state.copyWith(
        isDeleting: false,
        myTrips: state.myTrips.where((trip) => trip.id != event.tripId).toList(),
        searchResults: state.searchResults
            .where((trip) => trip.id != event.tripId)
            .toList(),
        clearSelectedTrip: true,
        lastActionResult: TripActionResult(
          type: TripActionType.deleted,
          tripId: event.tripId,
          succeeded: true,
        ),
      ));
    } catch (error) {
      emit(state.copyWith(
        isDeleting: false,
        errorMessage: _friendlyError(error),
        lastActionResult: TripActionResult(
          type: TripActionType.deleted,
          tripId: event.tripId,
          succeeded: false,
        ),
      ));
    }
  }

  String _friendlyError(Object error) {
    final raw = error.toString().toLowerCase();
    if (raw.contains('not_authenticated')) {
      return 'برای انجام این عملیات وارد حساب خود شوید.';
    }
    if (raw.contains('membership_closed')) {
      return 'عضوگیری این سفر بسته شده است و امکان تغییر عضویت وجود ندارد.';
    }
    if (raw.contains('trip_not_preparing') ||
        raw.contains('trip_already_started')) {
      return 'پس از شروع سفر، امکان تغییر وضعیت عضوگیری وجود ندارد.';
    }
    if (raw.contains('already_in_another_trip')) {
      return 'شما در حال حاضر عضو سفر دیگری هستید؛ ابتدا از سفر فعلی خارج شوید.';
    }
    if (raw.contains('invalid_invitees')) {
      return 'فقط می‌توانید دوستان خود را به سفر دعوت کنید.';
    }
    if (raw.contains('invalid_trip_dates')) {
      return 'زمان برگشت باید بعد از زمان رفت باشد.';
    }
    if (raw.contains('trip_name_required')) return 'نام سفر را وارد کنید.';
    if (raw.contains('trip_location_required')) return 'مقصد سفر را وارد کنید.';
    if (raw.contains('trip_not_found_or_forbidden') ||
        raw.contains('trip_not_found_or_not_preparing')) {
      return 'سفر پیدا نشد، قبلاً شروع شده یا اجازهٔ انجام این عملیات را ندارید.';
    }
    return 'عملیات سفر انجام نشد. اتصال اینترنت و اطلاعات را بررسی کنید.';
  }
}
