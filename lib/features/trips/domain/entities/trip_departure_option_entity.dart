import 'package:equatable/equatable.dart';

/// A persisted departure-time option for a trip using voting schedule.
class TripDepartureOptionEntity extends Equatable {
  final int id;
  final DateTime startsAt;
  final DateTime endsAt;

  const TripDepartureOptionEntity({
    required this.id,
    required this.startsAt,
    required this.endsAt,
  });

  @override
  List<Object?> get props => [id, startsAt, endsAt];
}
