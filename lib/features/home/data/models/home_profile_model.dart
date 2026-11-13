import 'package:hamsafar/features/home/domain/entities/home_profile_entity.dart';

class HomeProfileModel extends HomeProfileEntity {
  const HomeProfileModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.avatarIcon,
  });

  factory HomeProfileModel.fromJson(Map<String, dynamic> json) {
    return HomeProfileModel(
      id: (json['id'] ?? '').toString(),
      firstName: (json['first_name'] as String?)?.trim().isNotEmpty == true
          ? (json['first_name'] as String).trim()
          : 'دوست',
      lastName: (json['last_name'] as String?)?.trim().isNotEmpty == true
          ? (json['last_name'] as String).trim()
          : 'کاربر',
      avatarIcon: (json['avatar_icon'] as String?)?.trim().isNotEmpty == true
          ? (json['avatar_icon'] as String).trim()
          : 'tent',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'avatar_icon': avatarIcon,
  };
}
