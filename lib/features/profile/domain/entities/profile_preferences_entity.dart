import 'package:equatable/equatable.dart';

class ProfileAvailabilityEntity extends Equatable {
  final String dayOfWeek;
  final String timeFrom;
  final String timeTo;

  const ProfileAvailabilityEntity({
    required this.dayOfWeek,
    required this.timeFrom,
    required this.timeTo,
  });

  @override
  List<Object?> get props => [dayOfWeek, timeFrom, timeTo];
}

class ProfileToolEntity extends Equatable {
  final int? userToolId;
  final int? toolId;
  final String name;
  final bool isAvailable;

  const ProfileToolEntity({
    this.userToolId,
    this.toolId,
    required this.name,
    this.isAvailable = true,
  });

  ProfileToolEntity copyWith({
    int? userToolId,
    int? toolId,
    String? name,
    bool? isAvailable,
  }) {
    return ProfileToolEntity(
      userToolId: userToolId ?? this.userToolId,
      toolId: toolId ?? this.toolId,
      name: name ?? this.name,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  @override
  List<Object?> get props => [userToolId, toolId, name, isAvailable];
}

class ProfilePreferencesEntity extends Equatable {
  final List<ProfileAvailabilityEntity> availability;
  final List<ProfileToolEntity> tools;

  const ProfilePreferencesEntity({
    required this.availability,
    required this.tools,
  });

  @override
  List<Object?> get props => [availability, tools];
}
