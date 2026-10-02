import 'package:equatable/equatable.dart';

class FriendEntity extends Equatable {
  final String id;
  final String userName;
  final String firstName;
  final String lastName;
  final String avatarIcon;
  final String bio;
  final double rate;
  final int tripCount;
  final List<String> freeDays;
  final List<FriendToolEntity> tools;

  const FriendEntity({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.avatarIcon,
    required this.bio,
    required this.rate,
    required this.tripCount,
    required this.freeDays,
    required this.tools,
  });

  @override
  List<Object?> get props => [
    id,
    userName,
    firstName,
    lastName,
    avatarIcon,
    bio,
    rate,
    tripCount,
    freeDays,
    tools,
  ];
}

class FriendToolEntity extends Equatable {
  final String id;
  final String toolName;
  final String toolIcon;
  final bool isAvailable;

  const FriendToolEntity({
    required this.id,
    required this.toolName,
    required this.isAvailable,
    required this.toolIcon,
  });

  @override
  List<Object?> get props => [id, toolName, isAvailable, toolIcon];
}
