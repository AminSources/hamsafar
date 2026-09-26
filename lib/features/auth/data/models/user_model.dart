import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.userName,
    super.displayName,
  });

  factory UserModel.fromJson(User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? "",
      userName: user.userMetadata?["userName"],
      displayName: user.userMetadata?["displayName"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "userName": userName,
    "displayName": displayName,
  };
}
