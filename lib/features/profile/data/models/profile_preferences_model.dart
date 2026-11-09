import 'package:hamsafar/features/profile/domain/entities/profile_preferences_entity.dart';

class ProfileAvailabilityModel extends ProfileAvailabilityEntity {
  const ProfileAvailabilityModel({
    required super.dayOfWeek,
    required super.timeFrom,
    required super.timeTo,
  });

  factory ProfileAvailabilityModel.fromJson(Map<String, dynamic> json) {
    return ProfileAvailabilityModel(
      dayOfWeek: json['day_of_week'] as String,
      timeFrom: (json['time_from'] as String).substring(0, 5),
      timeTo: (json['time_to'] as String).substring(0, 5),
    );
  }
}

class ProfileToolModel extends ProfileToolEntity {
  const ProfileToolModel({
    required super.userToolId,
    required super.toolId,
    required super.name,
    required super.isAvailable,
  });

  factory ProfileToolModel.fromJson(Map<String, dynamic> json) {
    final tool = json['tools'] as Map<String, dynamic>;
    return ProfileToolModel(
      userToolId: (json['id'] as num).toInt(),
      toolId: (json['tool_id'] as num).toInt(),
      name: tool['name'] as String,
      isAvailable: json['is_available'] as bool? ?? true,
    );
  }
}

class ProfilePreferencesModel extends ProfilePreferencesEntity {
  const ProfilePreferencesModel({
    required super.availability,
    required super.tools,
  });

  factory ProfilePreferencesModel.fromJson(Map<String, dynamic> json) {
    final availabilityJson = json['availability'] as List<dynamic>? ?? const [];
    final toolsJson = json['tools'] as List<dynamic>? ?? const [];

    return ProfilePreferencesModel(
      availability: availabilityJson
          .map((item) => ProfileAvailabilityModel.fromJson(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList(),
      tools: toolsJson
          .map((item) => ProfileToolModel.fromJson(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList(),
    );
  }
}
