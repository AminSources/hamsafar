import 'package:equatable/equatable.dart';

class DepartureOptionDraft extends Equatable {
  final DateTime startsAt;
  final DateTime endsAt;

  const DepartureOptionDraft({
    required this.startsAt,
    required this.endsAt,
  });

  DepartureOptionDraft copyWith({
    DateTime? startsAt,
    DateTime? endsAt,
  }) {
    return DepartureOptionDraft(
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
    );
  }

  @override
  List<Object?> get props => [startsAt, endsAt];
}

class TripDraft extends Equatable {
  final String name;
  final String description;
  final String location;
  final String meetingPoint;
  final String bankCardNumber;
  final String bankAccountName;
  final String scheduleType;
  final DateTime departureAt;
  final DateTime returnAt;
  final int budget;
  final List<DepartureOptionDraft> departureOptions;
  final List<String> costItems;
  final List<String> rules;
  final List<String> invitedUserIds;

  const TripDraft({
    this.name = '',
    this.description = '',
    this.location = '',
    this.meetingPoint = '',
    this.bankCardNumber = '',
    this.bankAccountName = '',
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

    return TripDraft(
      departureAt: departure,
      returnAt: DateTime(now.year, now.month, now.day + 2, 21),
      departureOptions: [
        DepartureOptionDraft(
          startsAt: departure,
          endsAt: departure.add(const Duration(hours: 2)),
        ),
        DepartureOptionDraft(
          startsAt: departure.add(const Duration(hours: 2)),
          endsAt: departure.add(const Duration(hours: 4)),
        ),
      ],
      rules: const [
        'حضور به‌موقع در محل تجمع',
        'تقسیم منصفانه هزینه‌ها و احترام به طبیعت',
      ],
    );
  }

  TripDraft copyWith({
    String? name,
    String? description,
    String? location,
    String? meetingPoint,
    String? bankCardNumber,
    String? bankAccountName,
    DateTime? departureAt,
    DateTime? returnAt,
    int? budget,
    String? scheduleType,
    List<DepartureOptionDraft>? departureOptions,
    List<String>? costItems,
    List<String>? rules,
    List<String>? invitedUserIds,
  }) {
    return TripDraft(
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      meetingPoint: meetingPoint ?? this.meetingPoint,
      bankCardNumber: bankCardNumber ?? this.bankCardNumber,
      bankAccountName: bankAccountName ?? this.bankAccountName,
      departureAt: departureAt ?? this.departureAt,
      returnAt: returnAt ?? this.returnAt,
      budget: budget ?? this.budget,
      scheduleType: scheduleType ?? this.scheduleType,
      departureOptions: departureOptions ?? this.departureOptions,
      costItems: costItems ?? this.costItems,
      rules: rules ?? this.rules,
      invitedUserIds: invitedUserIds ?? this.invitedUserIds,
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        location,
        meetingPoint,
        bankCardNumber,
        bankAccountName,
        departureAt,
        returnAt,
        budget,
        scheduleType,
        departureOptions,
        costItems,
        rules,
        invitedUserIds,
      ];
}
