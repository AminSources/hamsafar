import 'package:bloc/bloc.dart';
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

class TripDraftBloc extends Bloc<TripDraftEvent, TripDraft> {
  TripDraftBloc() : super(TripDraft.empty()) {
    on<TripDraftEvent>(_onDraftEvent);
  }

  void _onDraftEvent(TripDraftEvent event, Emitter<TripDraft> emit) {
    if (event is TripDraftInitialized) {
      emit(event.initialData?.toDraft() ?? TripDraft.empty());
    } else if (event is TripNameChanged) {
      emit(state.copyWith(name: event.value));
    } else if (event is TripDescriptionChanged) {
      emit(state.copyWith(description: event.value));
    } else if (event is TripLocationChanged) {
      emit(state.copyWith(location: event.value));
    } else if (event is TripMeetingPointChanged) {
      emit(state.copyWith(meetingPoint: event.value));
    } else if (event is TripDepartureAtChanged) {
      emit(state.copyWith(departureAt: event.value));
    } else if (event is TripReturnAtChanged) {
      emit(state.copyWith(returnAt: event.value));
    } else if (event is TripBudgetChanged) {
      emit(state.copyWith(budget: event.value));
    } else if (event is TripBankCardNumberChanged) {
      emit(state.copyWith(bankCardNumber: event.value));
    } else if (event is TripBankAccountNameChanged) {
      emit(state.copyWith(bankAccountName: event.value));
    } else if (event is TripScheduleTypeChanged) {
      emit(state.copyWith(scheduleType: event.value));
    } else if (event is TripDepartureOptionAdded) {
      emit(state.copyWith(departureOptions: [
        ...state.departureOptions,
        DepartureOptionDraft(startsAt: event.startsAt, endsAt: event.endsAt),
      ]));
    } else if (event is TripDepartureOptionUpdated) {
      if (event.index < 0 || event.index >= state.departureOptions.length) {
        return;
      }
      final options = [...state.departureOptions]..[event.index] = event.option;
      emit(state.copyWith(departureOptions: options));
    } else if (event is TripDepartureOptionRemoved) {
      if (event.index < 0 || event.index >= state.departureOptions.length) {
        return;
      }
      final options = [...state.departureOptions]..removeAt(event.index);
      emit(state.copyWith(departureOptions: options));
    } else if (event is TripInviteToggled) {
      final userIds = [...state.invitedUserIds];
      if (event.selected && !userIds.contains(event.userId)) {
        userIds.add(event.userId);
      } else if (!event.selected) {
        userIds.remove(event.userId);
      }
      emit(state.copyWith(invitedUserIds: userIds));
    } else if (event is TripCostItemAdded) {
      final item = event.value.trim();
      if (item.isEmpty || state.costItems.contains(item)) return;
      emit(state.copyWith(costItems: [...state.costItems, item]));
    } else if (event is TripCostItemRemoved) {
      emit(state.copyWith(
        costItems: state.costItems.where((item) => item != event.value).toList(),
      ));
    } else if (event is TripRuleAdded) {
      final rule = event.value.trim();
      if (rule.isEmpty) return;
      emit(state.copyWith(rules: [...state.rules, rule]));
    } else if (event is TripRuleRemoved) {
      emit(state.copyWith(
        rules: state.rules.where((item) => item != event.value).toList(),
      ));
    }
  }
}
