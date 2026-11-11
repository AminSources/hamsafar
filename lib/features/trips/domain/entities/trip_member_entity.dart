import 'package:equatable/equatable.dart';

/// Domain representation of a participant returned by the trip-members RPC.
class TripMemberEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String avatarIcon;
  final String memberType;
  final String memberStatus;

  const TripMemberEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.avatarIcon,
    required this.memberType,
    required this.memberStatus,
  });

  String get displayName {
    final name = '$firstName $lastName'.trim();
    return name.isEmpty ? username : name;
  }

  bool get isLeader => memberType == 'leader';
  bool get isAccepted => memberStatus == 'accepted';
  bool get isPending => memberStatus == 'pending';

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        username,
        avatarIcon,
        memberType,
        memberStatus,
      ];
}
