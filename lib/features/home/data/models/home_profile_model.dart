import 'package:hamsafar/features/home/domain/entities/home_profile_entity.dart';

class HomeProfileModel extends HomeProfileEntity {
  const HomeProfileModel({
    required super.id,
    required super.firstName,
    required super.avatarIcon,
  });

  factory HomeProfileModel.fromJson(Map<String, dynamic> json) {
    return HomeProfileModel(
      id: (json['id'] ?? '').toString(),
      firstName: (json['first_name'] as String?)?.trim().isNotEmpty == true
          ? (json['first_name'] as String).trim()
          : 'دوست',
      avatarIcon: (json['avatar_icon'] as String?)?.trim().isNotEmpty == true
          ? (json['avatar_icon'] as String).trim()
          : 'tent',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'avatar_icon': avatarIcon,
      };
}
