import 'package:equatable/equatable.dart';

class HomeProfileEntity extends Equatable {
  final String id;
  final String firstName;
  final String avatarIcon;

  const HomeProfileEntity({
    required this.id,
    required this.firstName,
    required this.avatarIcon,
  });

  @override
  List<Object?> get props => [id, firstName, avatarIcon];
}
