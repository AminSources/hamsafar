import 'package:hamsafar/features/trip_creation/domain/entities/trip_draft.dart';

/// UI-independent values required to prefill the trip creation form.
class TripCreationInitialData {
  final int? tripId;
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

  const TripCreationInitialData({
    this.tripId,
    required this.name,
    required this.description,
    required this.location,
    required this.meetingPoint,
    required this.bankCardNumber,
    required this.bankAccountName,
    required this.scheduleType,
    required this.departureAt,
    required this.returnAt,
    required this.budget,
    required this.departureOptions,
    required this.costItems,
    required this.rules,
    required this.invitedUserIds,
  });

  TripDraft toDraft() {
    return TripDraft(
      name: name,
      description: description,
      location: location,
      meetingPoint: meetingPoint,
      bankCardNumber: bankCardNumber,
      bankAccountName: bankAccountName,
      scheduleType: scheduleType,
      departureAt: departureAt,
      returnAt: returnAt,
      budget: budget,
      departureOptions: departureOptions,
      costItems: costItems,
      rules: rules,
      invitedUserIds: invitedUserIds,
    );
  }
}
