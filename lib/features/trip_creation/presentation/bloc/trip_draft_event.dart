import 'package:equatable/equatable.dart';
import 'package:hamsafar/features/trip_creation/domain/entities/trip_creation_initial_data.dart';
import 'package:hamsafar/features/trip_creation/domain/entities/trip_draft.dart';

sealed class TripDraftEvent extends Equatable {
  const TripDraftEvent();

  @override
  List<Object?> get props => [];
}

final class TripDraftInitialized extends TripDraftEvent {
  final TripCreationInitialData? initialData;
  const TripDraftInitialized(this.initialData);
  @override
  List<Object?> get props => [initialData];
}

final class TripNameChanged extends TripDraftEvent {
  final String value;
  const TripNameChanged(this.value);
  @override
  List<Object?> get props => [value];
}

final class TripDescriptionChanged extends TripDraftEvent {
  final String value;
  const TripDescriptionChanged(this.value);
  @override
  List<Object?> get props => [value];
}

final class TripLocationChanged extends TripDraftEvent {
  final String value;
  const TripLocationChanged(this.value);
  @override
  List<Object?> get props => [value];
}

final class TripMeetingPointChanged extends TripDraftEvent {
  final String value;
  const TripMeetingPointChanged(this.value);
  @override
  List<Object?> get props => [value];
}

final class TripDepartureAtChanged extends TripDraftEvent {
  final DateTime value;
  const TripDepartureAtChanged(this.value);
  @override
  List<Object?> get props => [value];
}

final class TripReturnAtChanged extends TripDraftEvent {
  final DateTime value;
  const TripReturnAtChanged(this.value);
  @override
  List<Object?> get props => [value];
}

final class TripBudgetChanged extends TripDraftEvent {
  final int value;
  const TripBudgetChanged(this.value);
  @override
  List<Object?> get props => [value];
}

final class TripBankCardNumberChanged extends TripDraftEvent {
  final String value;
  const TripBankCardNumberChanged(this.value);
  @override
  List<Object?> get props => [value];
}

final class TripBankAccountNameChanged extends TripDraftEvent {
  final String value;
  const TripBankAccountNameChanged(this.value);
  @override
  List<Object?> get props => [value];
}

final class TripScheduleTypeChanged extends TripDraftEvent {
  final String value;
  const TripScheduleTypeChanged(this.value);
  @override
  List<Object?> get props => [value];
}

final class TripDepartureOptionAdded extends TripDraftEvent {
  final DateTime startsAt;
  final DateTime endsAt;
  const TripDepartureOptionAdded(this.startsAt, this.endsAt);
  @override
  List<Object?> get props => [startsAt, endsAt];
}

final class TripDepartureOptionUpdated extends TripDraftEvent {
  final int index;
  final DepartureOptionDraft option;
  const TripDepartureOptionUpdated(this.index, this.option);
  @override
  List<Object?> get props => [index, option];
}

final class TripDepartureOptionRemoved extends TripDraftEvent {
  final int index;
  const TripDepartureOptionRemoved(this.index);
  @override
  List<Object?> get props => [index];
}

final class TripInviteToggled extends TripDraftEvent {
  final String userId;
  final bool selected;
  const TripInviteToggled(this.userId, this.selected);
  @override
  List<Object?> get props => [userId, selected];
}

final class TripCostItemAdded extends TripDraftEvent {
  final String value;
  const TripCostItemAdded(this.value);
  @override
  List<Object?> get props => [value];
}

final class TripCostItemRemoved extends TripDraftEvent {
  final String value;
  const TripCostItemRemoved(this.value);
  @override
  List<Object?> get props => [value];
}

final class TripRuleAdded extends TripDraftEvent {
  final String value;
  const TripRuleAdded(this.value);
  @override
  List<Object?> get props => [value];
}

final class TripRuleRemoved extends TripDraftEvent {
  final String value;
  const TripRuleRemoved(this.value);
  @override
  List<Object?> get props => [value];
}
