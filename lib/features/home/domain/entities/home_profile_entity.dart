import 'package:equatable/equatable.dart';

class HomeProfileEntity extends Equatable {
  final String id;
  final String displayName;

  const HomeProfileEntity({required this.id, required this.displayName});

  @override
  List<Object?> get props => [id, displayName];
}
