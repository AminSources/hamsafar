import 'package:hamsafar/features/profile/domain/entities/profile_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.userName,
    required super.displayName,
    super.bio,
  });

  factory ProfileModel.fromJson(User user) {
    return ProfileModel(
      id: user.id,
      userName: user.userMetadata?["userName"],
      displayName: user.userMetadata?["displayName"],
      bio: user.userMetadata?["bio"],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userName': userName,
    'displayName': displayName,
    'bio': bio,
  };
}
