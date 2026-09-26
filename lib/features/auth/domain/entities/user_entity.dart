import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? userName;
  final String? displayName;

  const UserEntity({
    required this.id,
    required this.email,
    this.userName,
    this.displayName,
  });

  @override
  List<Object?> get props => [id, email, userName, displayName];
}
