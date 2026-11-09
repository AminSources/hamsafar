import 'package:hamsafar/features/home/domain/entities/home_activity_entity.dart';

class HomeActivityModel extends HomeActivityEntity {
  const HomeActivityModel({
    required super.id,
    required super.activityType,
    required super.actorName,
    super.subjectName,
    super.taskName,
    super.oldStatus,
    super.newStatus,
    required super.createdAt,
  });

  factory HomeActivityModel.fromJson(Map<String, dynamic> json) =>
      HomeActivityModel(
        id: (json['id'] ?? '').toString(),
        activityType: (json['activity'] ?? '').toString(),
        actorName: (json['actor_name'] ?? 'عضو سفر').toString(),
        subjectName: json['subject_name']?.toString(),
        taskName: json['task_name']?.toString(),
        oldStatus: json['old_status']?.toString(),
        newStatus: json['new_status']?.toString(),
        createdAt: DateTime.parse(json['created_at'].toString()).toLocal(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'activity': activityType,
        'actor_name': actorName,
        'subject_name': subjectName,
        'task_name': taskName,
        'old_status': oldStatus,
        'new_status': newStatus,
        'created_at': createdAt.toIso8601String(),
      };
}
