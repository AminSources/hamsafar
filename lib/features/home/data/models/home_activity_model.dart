import 'package:hamsafar/features/home/domain/entities/home_activity_entity.dart';

class HomeActivityModel extends HomeActivityEntity {
  const HomeActivityModel({
    required super.id,
    required super.title,
    required super.createdAt,
  });

  factory HomeActivityModel.fromJson(Map<String, dynamic> json) =>
      HomeActivityModel(
        id: json['id'],
        title: json['title'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'created_at': createdAt,
  };
}
