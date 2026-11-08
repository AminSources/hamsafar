import 'package:equatable/equatable.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';

class DepartureOptionDraft extends Equatable {
  final DateTime startsAt;
  final DateTime endsAt;
  const DepartureOptionDraft({required this.startsAt, required this.endsAt});

  DepartureOptionDraft copyWith({DateTime? startsAt, DateTime? endsAt}) =>
      DepartureOptionDraft(startsAt: startsAt ?? this.startsAt, endsAt: endsAt ?? this.endsAt);

  @override
  List<Object?> get props => [startsAt, endsAt];
}

class TripDraft extends Equatable {
  final String name;
  final String description;
  final String location;
  final String meetingPoint;
  final DateTime departureAt;
  final DateTime returnAt;
  final int budget;
  final String scheduleType;
  final List<DepartureOptionDraft> departureOptions;
  final List<String> costItems;
  final List<String> rules;
  final List<String> invitedUserIds;

  const TripDraft({
    this.name = '',
    this.description = '',
    this.location = '',
    this.meetingPoint = '',
    required this.departureAt,
    required this.returnAt,
    this.budget = 0,
    this.scheduleType = 'fixed',
    this.departureOptions = const [],
    this.costItems = const [],
    this.rules = const [],
    this.invitedUserIds = const [],
  });

  factory TripDraft.empty() {
    final now = DateTime.now();
    final departure = DateTime(now.year, now.month, now.day + 1, 7);
    final returning = DateTime(now.year, now.month, now.day + 2, 21);
    return TripDraft(
      departureAt: departure,
      returnAt: returning,
      departureOptions: [
        DepartureOptionDraft(startsAt: departure, endsAt: departure.add(const Duration(hours: 2))),
        DepartureOptionDraft(startsAt: departure.add(const Duration(hours: 2)), endsAt: departure.add(const Duration(hours: 4))),
      ],
      rules: const ['حضور به‌موقع در محل تجمع', 'تقسیم منصفانه هزینه‌ها و احترام به طبیعت'],
    );
  }

  factory TripDraft.fromTrip(TripEntity trip) => TripDraft(
    name: trip.name,
    description: trip.description ?? '',
    location: trip.location,
    meetingPoint: trip.meetingPoint ?? '',
    departureAt: trip.departureAt,
    returnAt: trip.returnAt,
    budget: trip.budget,
    scheduleType: trip.scheduleType,
    costItems: trip.costItems,
    rules: trip.rules,
    invitedUserIds: trip.members.where((member) => member['member_status'] == 'pending').map((member) => member['id'] as String).toList(),
  );

  TripDraft copyWith({
    String? name, String? description, String? location, String? meetingPoint,
    DateTime? departureAt, DateTime? returnAt, int? budget, String? scheduleType,
    List<DepartureOptionDraft>? departureOptions, List<String>? costItems,
    List<String>? rules, List<String>? invitedUserIds,
  }) => TripDraft(
    name: name ?? this.name, description: description ?? this.description,
    location: location ?? this.location, meetingPoint: meetingPoint ?? this.meetingPoint,
    departureAt: departureAt ?? this.departureAt, returnAt: returnAt ?? this.returnAt,
    budget: budget ?? this.budget, scheduleType: scheduleType ?? this.scheduleType,
    departureOptions: departureOptions ?? this.departureOptions,
    costItems: costItems ?? this.costItems, rules: rules ?? this.rules,
    invitedUserIds: invitedUserIds ?? this.invitedUserIds,
  );

  @override
  List<Object?> get props => [name, description, location, meetingPoint, departureAt, returnAt, budget, scheduleType, departureOptions, costItems, rules, invitedUserIds];
}
