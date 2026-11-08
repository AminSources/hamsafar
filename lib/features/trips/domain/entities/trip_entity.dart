import 'package:equatable/equatable.dart';

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
  final String scheduleType;
  final List<String> costItems;
  final List<String> rules;
  final int memberCount;
  final String leaderName;
  final bool isCreator;
  final bool isMember;
  final bool canJoin;
  final List<Map<String, dynamic>> members;
  final List<Map<String, dynamic>> departureOptions;

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
    this.scheduleType = 'fixed',
    this.costItems = const [],
    this.rules = const [],
    this.memberCount = 0,
    this.leaderName = 'کاربر هم‌سفر',
    this.isCreator = false,
    this.isMember = false,
    this.canJoin = true,
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
        scheduleType,
        costItems,
        rules,
        memberCount,
        leaderName,
        isCreator,
        isMember,
        canJoin,
        members,
        departureOptions,
      ];
}
