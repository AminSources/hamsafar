import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';

class FriendModel extends FriendEntity {
  const FriendModel({
    required super.id,
    required super.userName,
    required super.firstName,
    required super.lastName,
    required super.avatarIcon,
    required super.bio,
    required super.rate,
    required super.tripCount,
    required super.freeDays,
    required super.tools,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      id: json['id'] as String,
      userName: json['username'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      avatarIcon: json['avatar_icon'] as String,
      bio: json['bio'] as String,
      rate: (json['rate'] as num).toDouble(),
      tripCount: json['trip_count'] as int,
      freeDays: List<String>.from(
        (json['user_availability'] as List<dynamic>).map(
          (availability) => availability['day_of_week'] as String,
        ),
      ),
      tools: List<FriendToolModel>.from(
        (json['user_tools'] as List<dynamic>).map(
          (tool) => FriendToolModel.fromJson(tool as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': userName,
      'first_name': firstName,
      'last_name': lastName,
      'avatar_icon': avatarIcon,
      'bio': bio,
      'rate': rate,
      'trip_count': tripCount,
      'user_availability': freeDays.map((day) => {'day_of_week': day}).toList(),
      'user_tools': tools
          .map((tool) => (tool as FriendToolModel).toJson())
          .toList(),
    };
  }
}

class FriendToolModel extends FriendToolEntity {
  const FriendToolModel({
    required super.id,
    required super.toolName,
    required super.toolIcon,
    required super.isAvailable,
  });

  factory FriendToolModel.fromJson(Map<String, dynamic> json) {
    final tool = json['tools'] as Map<String, dynamic>;

    return FriendToolModel(
      id: tool['id'] as String,
      toolName: tool['name'] as String,
      toolIcon: tool['icon'] as String,
      isAvailable: json['is_available'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tool_name': toolName,
      'tool_icon': toolIcon,
      'is_available': isAvailable,
    };
  }
}
