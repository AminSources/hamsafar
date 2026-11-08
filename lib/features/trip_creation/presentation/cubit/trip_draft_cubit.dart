import 'package:bloc/bloc.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_draft.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';
class TripDraftCubit extends Cubit<TripDraft>{
 TripDraftCubit():super(TripDraft.empty());
 void initialize(TripEntity? trip)=>emit(trip==null?TripDraft.empty():TripDraft.fromTrip(trip));
 void setName(String v)=>emit(state.copyWith(name:v)); void setDescription(String v)=>emit(state.copyWith(description:v)); void setLocation(String v)=>emit(state.copyWith(location:v)); void setMeetingPoint(String v)=>emit(state.copyWith(meetingPoint:v)); void setDepartureAt(DateTime v)=>emit(state.copyWith(departureAt:v)); void setReturnAt(DateTime v)=>emit(state.copyWith(returnAt:v)); void setBudget(int v)=>emit(state.copyWith(budget:v)); void setBankCardNumber(String v)=>emit(state.copyWith(bankCardNumber:v)); void setBankAccountName(String v)=>emit(state.copyWith(bankAccountName:v)); void setScheduleType(String v)=>emit(state.copyWith(scheduleType:v));
 void addDepartureOption(DateTime s,DateTime e)=>emit(state.copyWith(departureOptions:[...state.departureOptions,DepartureOptionDraft(startsAt:s,endsAt:e)]));
 void updateDepartureOption(int i,DepartureOptionDraft o){final a=[...state.departureOptions];if(i<0||i>=a.length)return;a[i]=o;emit(state.copyWith(departureOptions:a));}
 void removeDepartureOption(int i){final a=[...state.departureOptions]..removeAt(i);emit(state.copyWith(departureOptions:a));}
 void toggleInvite(String id,bool selected){final a=[...state.invitedUserIds];if(selected&&!a.contains(id))a.add(id);else if(!selected)a.remove(id);emit(state.copyWith(invitedUserIds:a));}
 void addCostItem(String v){final x=v.trim();if(x.isEmpty||state.costItems.contains(x))return;emit(state.copyWith(costItems:[...state.costItems,x]));}
 void removeCostItem(String v)=>emit(state.copyWith(costItems:state.costItems.where((x)=>x!=v).toList()));
 void addRule(String v){final x=v.trim();if(x.isEmpty)return;emit(state.copyWith(rules:[...state.rules,x]));}
 void removeRule(String v)=>emit(state.copyWith(rules:state.rules.where((x)=>x!=v).toList()));
}