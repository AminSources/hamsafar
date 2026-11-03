import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_draft.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';
import 'package:hamsafar/features/trips/domain/repositories/trips_repository.dart';

class TripsState extends Equatable {
  final List<TripEntity> myTrips;
  final List<TripEntity> searchResults;
  final TripEntity? selectedTrip;
  final bool isLoadingMyTrips;
  final bool isSearching;
  final bool isLoadingDetails;
  final bool isSaving;
  final bool isDeleting;
  final String? errorMessage;

  const TripsState({
    this.myTrips = const [],
    this.searchResults = const [],
    this.selectedTrip,
    this.isLoadingMyTrips = false,
    this.isSearching = false,
    this.isLoadingDetails = false,
    this.isSaving = false,
    this.isDeleting = false,
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
    bool? isSaving,
    bool? isDeleting,
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
      isSaving: isSaving ?? this.isSaving,
      isDeleting: isDeleting ?? this.isDeleting,
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
        isSaving,
        isDeleting,
        errorMessage,
      ];
}

class TripsCubit extends Cubit<TripsState> {
  final TripsRepository repository;
  int _searchVersion = 0;

  TripsCubit({required this.repository}) : super(const TripsState());

  Future<void> loadMyTrips() async {
    emit(state.copyWith(isLoadingMyTrips: true, clearError: true));
    try {
      final trips = await repository.getMyTrips();
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
      final trips = await repository.searchTrips(query.trim());
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
      final trip = await repository.getTripDetails(tripId);
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

  Future<int?> saveTrip(TripDraft draft, {int? tripId}) async {
    emit(state.copyWith(isSaving: true, clearError: true));
    try {
      final id = await repository.saveTrip(draft, tripId: tripId);
      emit(state.copyWith(isSaving: false));
      await loadMyTrips();
      return id;
    } catch (error) {
      emit(state.copyWith(
        isSaving: false,
        errorMessage: _friendlyError(error),
      ));
      return null;
    }
  }

  Future<bool> deleteTrip(int tripId) async {
    emit(state.copyWith(isDeleting: true, clearError: true));
    try {
      await repository.deleteTrip(tripId);
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
    if (raw.contains('invalid_invitees')) {
      return 'فقط می‌توانید دوستان خود را به سفر دعوت کنید.';
    }
    if (raw.contains('invalid_trip_dates')) {
      return 'زمان برگشت باید بعد از زمان رفت باشد.';
    }
    if (raw.contains('trip_name_required')) return 'نام سفر را وارد کنید.';
    if (raw.contains('trip_location_required')) return 'مقصد سفر را وارد کنید.';
    if (raw.contains('trip_not_found_or_forbidden')) {
      return 'سفر پیدا نشد یا اجازهٔ انجام این عملیات را ندارید.';
    }
    return 'عملیات سفر انجام نشد. اتصال اینترنت و اطلاعات را بررسی کنید.';
  }
}
