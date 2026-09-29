import 'package:hamsafar/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.userName,
    required super.firstName,
    required super.lastName,
    required super.bio,
    required super.rate,
    required super.tripCount,
    required super.avatarIcon,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      userName: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      bio: json['bio'],
      avatarIcon: json['avatar_icon'],
      rate: (json['rate'] as num).toDouble(),
      tripCount: json['trip_count'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': userName,
    'first_name': firstName,
    'last_name': lastName,
    'bio': bio,
    'avatar_icon': avatarIcon,
    'rate': rate,
    'trip_count': tripCount,
  };
}
