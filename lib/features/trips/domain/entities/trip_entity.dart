import 'package:equatable/equatable.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_departure_option_entity.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_member_entity.dart';

class TripEntity extends Equatable {
  final int id;
  final String name;
  final String location;
  final DateTime departureAt;
  final DateTime returnAt;
  final String status;
  final int budget;
  final String createdBy;
  final String? description;
  final String? meetingPoint;
  final String? bankCardNumber;
  final String? bankAccountName;
  final String scheduleType;
  final List<String> costItems;
  final List<String> rules;
  final int memberCount;
  final String leaderName;
  final bool isCreator;
  final bool isMember;
  final bool canJoin;
  final bool membershipClosed;
  final String? currentMemberStatus;
  final List<TripMemberEntity> members;
  final List<TripDepartureOptionEntity> departureOptions;

  const TripEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.departureAt,
    required this.returnAt,
    required this.status,
    required this.budget,
    required this.createdBy,
    this.description,
    this.meetingPoint,
    this.bankCardNumber,
    this.bankAccountName,
    this.scheduleType = 'fixed',
    this.costItems = const [],
    this.rules = const [],
    this.memberCount = 0,
    this.leaderName = 'کاربر هم‌سفر',
    this.isCreator = false,
    this.isMember = false,
    this.canJoin = true,
    this.membershipClosed = false,
    this.currentMemberStatus,
    this.members = const [],
    this.departureOptions = const [],
  });

  bool get isPreparing => status == 'preparing';
  bool get canEdit => isCreator;
  bool get isFixedSchedule => scheduleType == 'fixed';

  @override
  List<Object?> get props => [
        id,
        name,
        location,
        departureAt,
        returnAt,
        status,
        budget,
        createdBy,
        description,
        meetingPoint,
        bankCardNumber,
        bankAccountName,
        scheduleType,
        costItems,
        rules,
        memberCount,
        leaderName,
        isCreator,
        isMember,
        canJoin,
        membershipClosed,
        currentMemberStatus,
        members,
        departureOptions,
      ];
}
