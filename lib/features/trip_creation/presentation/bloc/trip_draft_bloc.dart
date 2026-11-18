import 'package:bloc/bloc.dart';
import 'package:hamsafar/features/trip_creation/domain/entities/trip_draft.dart';
import 'package:hamsafar/features/trip_creation/presentation/bloc/trip_draft_event.dart';

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
      emit(
        state.copyWith(
          departureOptions: [
            ...state.departureOptions,
            DepartureOptionDraft(
              startsAt: event.startsAt,
              endsAt: event.endsAt,
            ),
          ],
        ),
      );
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
      emit(
        state.copyWith(
          costItems: state.costItems
              .where((item) => item != event.value)
              .toList(),
        ),
      );
    } else if (event is TripRuleAdded) {
      final rule = event.value.trim();
      if (rule.isEmpty) return;
      emit(state.copyWith(rules: [...state.rules, rule]));
    } else if (event is TripRuleRemoved) {
      emit(
        state.copyWith(
          rules: state.rules.where((item) => item != event.value).toList(),
        ),
      );
    }
  }
}
