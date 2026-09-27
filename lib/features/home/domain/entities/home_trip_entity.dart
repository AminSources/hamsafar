import 'package:equatable/equatable.dart';
import 'package:hamsafar/features/home/enums/home_trip_enum.dart';

class HomeTripEntity extends Equatable {
  final String id;
  final String title;
  final String location;
  final DateTime departureDate;
  final DateTime? returnDate;
  final String? departureTime;
  final String? returnTime;
  final HomeTripStatus status;
  final int memberCount;
  final List<String> membersNames;

  const HomeTripEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.departureDate,
    this.returnDate,
    this.departureTime,
    this.returnTime,
    required this.status,
    required this.memberCount,
    required this.membersNames,
  });

  bool get isInTrip => status == HomeTripStatus.inTrip;

  @override
  List<Object?> get props => [
    id,
    title,
    location,
    departureDate,
    returnDate,
    departureTime,
    returnTime,
    status,
    memberCount,
    membersNames,
  ];
}
