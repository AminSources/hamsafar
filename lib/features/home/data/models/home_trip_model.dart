import 'package:hamsafar/features/home/domain/entities/home_trip_entity.dart';
import 'package:hamsafar/features/home/enums/home_trip_enum.dart';

class HomeTripModel extends HomeTripEntity {
  const HomeTripModel({
    required super.id,
    required super.title,
    required super.location,
    required super.departureDate,
    required super.status,
    required super.memberCount,
    required super.membersNames,
  });

  factory HomeTripModel.fromJson(Map<String, dynamic> json) => HomeTripModel(
    id: json['id'],
    title: json['title'],
    location: json['location'],
    departureDate: DateTime.parse(json['departure_date']),
    status: json['status'] == 'in_trip'
        ? HomeTripStatus.inTrip
        : HomeTripStatus.values.firstWhere(
            (e) => e.name == json['status'],
            orElse: () => HomeTripStatus.none,
          ),
    memberCount: json['member_count'] as int,
    membersNames: List<String>.from(json['members_names']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'location': location,
    'departure_date': departureDate,
    'status': status,
    'member_count': memberCount,
    'members_names': membersNames,
  };
}
