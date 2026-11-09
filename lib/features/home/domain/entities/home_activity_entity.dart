import 'package:equatable/equatable.dart';

class HomeActivityEntity extends Equatable {
  final String id;
  final String activityType;
  final String actorName;
  final String? subjectName;
  final String? taskName;
  final String? oldStatus;
  final String? newStatus;
  final DateTime createdAt;

  const HomeActivityEntity({
    required this.id,
    required this.activityType,
    required this.actorName,
    this.subjectName,
    this.taskName,
    this.oldStatus,
    this.newStatus,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        activityType,
        actorName,
        subjectName,
        taskName,
        oldStatus,
        newStatus,
        createdAt,
      ];
}
