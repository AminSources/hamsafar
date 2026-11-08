import 'package:bloc/bloc.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_draft.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';

class TripDraftCubit extends Cubit<TripDraft> {
  TripDraftCubit() : super(TripDraft.empty());

  void initialize(TripEntity? trip) {
    emit(trip == null ? TripDraft.empty() : TripDraft.fromTrip(trip));
  }

  void setName(String value) => emit(state.copyWith(name: value));
  void setDescription(String value) =>
      emit(state.copyWith(description: value));
  void setLocation(String value) => emit(state.copyWith(location: value));
  void setMeetingPoint(String value) =>
      emit(state.copyWith(meetingPoint: value));
  void setDepartureAt(DateTime value) =>
      emit(state.copyWith(departureAt: value));
  void setReturnAt(DateTime value) => emit(state.copyWith(returnAt: value));
  void setBudget(int value) => emit(state.copyWith(budget: value));
  void setBankCardNumber(String value) =>
      emit(state.copyWith(bankCardNumber: value));
  void setBankAccountName(String value) =>
      emit(state.copyWith(bankAccountName: value));
  void setScheduleType(String value) =>
      emit(state.copyWith(scheduleType: value));

  void addDepartureOption(DateTime startsAt, DateTime endsAt) {
    emit(
      state.copyWith(
        departureOptions: [
          ...state.departureOptions,
          DepartureOptionDraft(startsAt: startsAt, endsAt: endsAt),
        ],
      ),
    );
  }

  void updateDepartureOption(int index, DepartureOptionDraft option) {
    final options = [...state.departureOptions];
    if (index < 0 || index >= options.length) {
      return;
    }
    options[index] = option;
    emit(state.copyWith(departureOptions: options));
  }

  void removeDepartureOption(int index) {
    if (index < 0 || index >= state.departureOptions.length) {
      return;
    }
    final options = [...state.departureOptions]..removeAt(index);
    emit(state.copyWith(departureOptions: options));
  }

  void toggleInvite(String userId, bool selected) {
    final userIds = [...state.invitedUserIds];
    if (selected && !userIds.contains(userId)) {
      userIds.add(userId);
    } else if (!selected) {
      userIds.remove(userId);
    }
    emit(state.copyWith(invitedUserIds: userIds));
  }

  void addCostItem(String value) {
    final item = value.trim();
    if (item.isEmpty || state.costItems.contains(item)) {
      return;
    }
    emit(state.copyWith(costItems: [...state.costItems, item]));
  }

  void removeCostItem(String value) {
    emit(
      state.copyWith(
        costItems: state.costItems.where((item) => item != value).toList(),
      ),
    );
  }

  void addRule(String value) {
    final rule = value.trim();
    if (rule.isEmpty) {
      return;
    }
    emit(state.copyWith(rules: [...state.rules, rule]));
  }

  void removeRule(String value) {
    emit(state.copyWith(rules: state.rules.where((rule) => rule != value).toList()));
  }
}
