import 'package:hamsafar/features/home/domain/entities/home_trip_member_entity.dart';

class HomeTripMemberModel extends HomeTripMemberEntity {
  const HomeTripMemberModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.avatarIcon,
  });

  factory HomeTripMemberModel.fromJson(Map<String, dynamic> json) {
    return HomeTripMemberModel(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      avatarIcon: json['avatar_icon'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'avatar_icon': avatarIcon,
    };
  }
}
