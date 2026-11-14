import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String avatarIcon;
  final String bio;
  final double rate;
  final int tripCount;
  final List<String> freeDays;
  final List<UserProfileToolEntity> tools;
  final String relationStatus;

  const UserProfileEntity({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.avatarIcon,
    this.bio = '',
    this.rate = 0,
    this.tripCount = 0,
    this.freeDays = const [],
    this.tools = const [],
    this.relationStatus = 'none',
  });

  @override
  List<Object?> get props => [
    id, username, firstName, lastName, avatarIcon, bio, rate,
    tripCount, freeDays, tools, relationStatus,
  ];
}

class UserProfileToolEntity extends Equatable {
  final String id;
  final String name;
  final String icon;
  final bool isAvailable;

  const UserProfileToolEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.isAvailable,
  });

  @override
  List<Object?> get props => [id, name, icon, isAvailable];
}
