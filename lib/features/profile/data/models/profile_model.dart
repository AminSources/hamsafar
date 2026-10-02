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
    required super.friendCount,
    required super.toolCount,
    required super.freeDays,
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
      friendCount: json['friend_count'],
      toolCount: json['tool_count'],
      freeDays: (json['free_days'] as List<dynamic>)
          .map((day) => day.toString())
          .toList(),
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
    'friend_count': friendCount,
    'tool_count': toolCount,
    'free_days': freeDays,
  };
}
