import 'package:equatable/equatable.dart';

class HomeTripMemberEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String avatarIcon;

  const HomeTripMemberEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatarIcon,
  });

  String get fullName => '$firstName $lastName'.trim();

  @override
  List<Object?> get props => [id, firstName, lastName, avatarIcon];
}
