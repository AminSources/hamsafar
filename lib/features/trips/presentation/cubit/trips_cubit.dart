import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';
import 'package:hamsafar/features/trips/domain/usecases/trips_usecases.dart';

class TripsState extends Equatable {
  final List<TripEntity> myTrips;
  final List<TripEntity> searchResults;
  final TripEntity? selectedTrip;
  final bool isLoadingMyTrips;
  final bool isSearching;
  final bool isLoadingDetails;
  final bool isDeleting;
  final bool isUpdatingStatus;
  final bool isUpdatingMembership;
  final String? errorMessage;

  const TripsState({
    this.myTrips = const [],
    this.searchResults = const [],
    this.selectedTrip,
    this.isLoadingMyTrips = false,
    this.isSearching = false,
    this.isLoadingDetails = false,
    this.isDeleting = false,
    this.isUpdatingStatus = false,
    this.isUpdatingMembership = false,
    this.errorMessage,
  });

  TripsState copyWith({
    List<TripEntity>? myTrips,
    List<TripEntity>? searchResults,
    TripEntity? selectedTrip,
    bool clearSelectedTrip = false,
    bool? isLoadingMyTrips,
    bool? isSearching,
    bool? isLoadingDetails,
    bool? isDeleting,
    bool? isUpdatingStatus,
    bool? isUpdatingMembership,
    String? errorMessage,
    bool clearError = false,
  }) {
    return TripsState(
      myTrips: myTrips ?? this.myTrips,
      searchResults: searchResults ?? this.searchResults,
      selectedTrip:
          clearSelectedTrip ? null : (selectedTrip ?? this.selectedTrip),
      isLoadingMyTrips: isLoadingMyTrips ?? this.isLoadingMyTrips,
      isSearching: isSearching ?? this.isSearching,
      isLoadingDetails: isLoadingDetails ?? this.isLoadingDetails,
      isDeleting: isDeleting ?? this.isDeleting,
      isUpdatingStatus: isUpdatingStatus ?? this.isUpdatingStatus,
      isUpdatingMembership: isUpdatingMembership ?? this.isUpdatingMembership,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        myTrips,
        searchResults,
        selectedTrip,
        isLoadingMyTrips,
        isSearching,
        isLoadingDetails,
        isDeleting,
        isUpdatingStatus,
        isUpdatingMembership,
        errorMessage,
      ];
}

class TripsCubit extends Cubit<TripsState> {
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

  TripsCubit({
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
  }) : super(const TripsState());

  Future<void> loadMyTrips() async {
    emit(state.copyWith(isLoadingMyTrips: true, clearError: true));
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

  Future<void> searchTrips(String query) async {
    final version = ++_searchVersion;
    emit(state.copyWith(isSearching: true, clearError: true));
    try {
      final trips = await searchTripsUseCase(query.trim());
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

  Future<TripEntity?> loadTripDetails(int tripId) async {
    emit(state.copyWith(
      isLoadingDetails: true,
      clearSelectedTrip: true,
      clearError: true,
    ));
    try {
      final trip = await getTripDetailsUseCase(tripId);
      emit(state.copyWith(selectedTrip: trip, isLoadingDetails: false));
      return trip;
    } catch (error) {
      emit(state.copyWith(
        isLoadingDetails: false,
        errorMessage: _friendlyError(error),
      ));
      return null;
    }
  }

  Future<bool> joinTrip(int tripId) => _runMembershipAction(() => joinTripUseCase(tripId), tripId);
  Future<bool> respondToInvitation(int tripId, {required bool accept}) =>
      _runMembershipAction(() => respondToTripInvitationUseCase(tripId, accept: accept), tripId);
  Future<bool> leaveTrip(int tripId) =>
      _runMembershipAction(() => leaveTripUseCase(tripId), tripId);
  Future<bool> inviteToTrip(int tripId, List<String> userIds) =>
      _runMembershipAction(() => inviteUsersToTripUseCase(tripId, userIds), tripId);
  Future<bool> removeTripMember(int tripId, String userId) =>
      _runMembershipAction(() => removeTripMemberUseCase(tripId, userId), tripId);

  Future<bool> setMembershipClosed(int tripId, bool closed) async {
    emit(state.copyWith(isUpdatingMembership: true, clearError: true));
    try {
      await setMembershipClosedUseCase(tripId, closed);
      await loadTripDetails(tripId);
      await loadMyTrips();
      emit(state.copyWith(isUpdatingMembership: false));
      return true;
    } catch (error) {
      emit(state.copyWith(
        isUpdatingMembership: false,
        errorMessage: _friendlyError(error),
      ));
      return false;
    }
  }

  Future<bool> startTrip(int tripId) async {
    emit(state.copyWith(isUpdatingStatus: true, clearError: true));
    try {
      await startTripUseCase(tripId);
      await loadTripDetails(tripId);
      await loadMyTrips();
      emit(state.copyWith(isUpdatingStatus: false));
      return true;
    } catch (error) {
      emit(state.copyWith(
        isUpdatingStatus: false,
        errorMessage: _friendlyError(error),
      ));
      return false;
    }
  }

  Future<bool> _runMembershipAction(Future<void> Function() action, int tripId) async {
    emit(state.copyWith(clearError: true));
    try {
      await action();
      await loadTripDetails(tripId);
      await loadMyTrips();
      return true;
    } catch (error) {
      emit(state.copyWith(errorMessage: _friendlyError(error)));
      return false;
    }
  }

  Future<bool> deleteTrip(int tripId) async {
    emit(state.copyWith(isDeleting: true, clearError: true));
    try {
      await deleteTripUseCase(tripId);
      emit(state.copyWith(
        isDeleting: false,
        myTrips: state.myTrips.where((trip) => trip.id != tripId).toList(),
        searchResults:
            state.searchResults.where((trip) => trip.id != tripId).toList(),
        clearSelectedTrip: true,
      ));
      return true;
    } catch (error) {
      emit(state.copyWith(
        isDeleting: false,
        errorMessage: _friendlyError(error),
      ));
      return false;
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
    if (raw.contains('trip_not_preparing') || raw.contains('trip_already_started')) {
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
