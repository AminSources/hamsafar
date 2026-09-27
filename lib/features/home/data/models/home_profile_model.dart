import 'package:hamsafar/features/home/domain/entities/home_profile_entity.dart';

class HomeProfileModel extends HomeProfileEntity {
  const HomeProfileModel({required super.id, required super.displayName});

  factory HomeProfileModel.fromJson(Map<String, dynamic> json) {
    return HomeProfileModel(id: json['id'], displayName: json['displayName']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'displayName': displayName};
}
