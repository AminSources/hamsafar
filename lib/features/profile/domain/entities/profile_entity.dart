import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String userName;
  final String displayName;
  final String? bio;

  const ProfileEntity({
    required this.id,
    required this.userName,
    required this.displayName,
    this.bio,
  });

  @override
  List<Object?> get props => [id, userName, displayName, bio];
}
