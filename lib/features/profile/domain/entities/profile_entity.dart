import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String userName;
  final String firstName;
  final String lastName;
  final String avatarIcon;
  final String bio;
  final double rate;
  final int tripCount;
  final int friendCount;
  final int toolCount;
  final List<String> freeDays;

  const ProfileEntity({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.avatarIcon,
    required this.rate,
    required this.tripCount,
    required this.bio,
    required this.friendCount,
    required this.toolCount,
    required this.freeDays,
  });

  @override
  List<Object?> get props => [
    id,
    userName,
    bio,
    firstName,
    lastName,
    rate,
    tripCount,
    avatarIcon,
    friendCount,
    toolCount,
    freeDays,
  ];
}
