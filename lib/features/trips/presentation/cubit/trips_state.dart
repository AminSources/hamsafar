import 'package:equatable/equatable.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';

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
      selectedTrip: clearSelectedTrip
          ? null
          : (selectedTrip ?? this.selectedTrip),
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
