import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';
class TripModel extends TripEntity {
 const TripModel({required super.id,required super.name,required super.location,required super.departureAt,required super.returnAt,required super.status,required super.budget,required super.createdBy,super.description,super.meetingPoint,super.bankCardNumber,super.bankAccountName,super.scheduleType,super.costItems,super.rules,super.memberCount,super.leaderName,super.isCreator,super.isMember,super.canJoin,super.membershipClosed,super.currentMemberStatus,super.members,super.departureOptions});
 factory TripModel.fromJson(Map<String,dynamic> json,{String? currentMemberStatus})=>TripModel(
 id:(json['id'] as num).toInt(),name:json['name'] as String? ?? '',location:json['location'] as String? ?? '',
 departureAt:DateTime.parse(json['departure_at'] as String).toLocal(),returnAt:DateTime.parse(json['return_at'] as String).toLocal(),
 status:json['status'] as String? ?? 'preparing',budget:(json['budget'] as num?)?.toInt()??0,createdBy:json['created_by'] as String? ?? '',
 description:json['description'] as String?,meetingPoint:json['meeting_point'] as String?,bankCardNumber:json['bank_card_number'] as String?,bankAccountName:json['bank_account_name'] as String?,
 scheduleType:json['schedule_type'] as String? ?? 'fixed',costItems:List<String>.from(json['cost_items'] as List? ?? const []),rules:List<String>.from(json['rules'] as List? ?? const []),
 memberCount:(json['member_count'] as num?)?.toInt()??0,leaderName:json['leader_name'] as String? ?? 'کاربر هم‌سفر',isCreator:json['is_creator'] as bool? ?? false,isMember:json['is_member'] as bool? ?? false,canJoin:json['can_join'] as bool? ?? true,membershipClosed:json['membership_closed'] as bool? ?? false,currentMemberStatus:currentMemberStatus ?? json['current_member_status'] as String?,
 members:(json['members'] as List? ?? const []).map((e)=>Map<String,dynamic>.from(e as Map)).toList(),departureOptions:(json['departure_options'] as List? ?? const []).map((e)=>Map<String,dynamic>.from(e as Map)).toList());
}