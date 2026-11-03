import 'package:hamsafar/features/home/domain/entities/home_trip_entity.dart';
import 'package:hamsafar/features/home/enums/home_trip_enum.dart';

class HomeTripModel extends HomeTripEntity {
  const HomeTripModel({
    required super.id,
    required super.title,
    required super.location,
    required super.departureDate,
    super.returnDate,
    super.departureTime,
    super.returnTime,
    required super.status,
    required super.memberCount,
    required super.membersNames,
  });

  factory HomeTripModel.fromJson(Map<String, dynamic> json) {
    final departureValue = json['departure_at'] ?? json['departure_date'];
    if (departureValue == null) {
      throw const FormatException('Trip response is missing departure_at.');
    }

    final departureDate = DateTime.parse(departureValue.toString()).toLocal();
    final returnValue = json['return_at'] ?? json['return_date'];
    final returnDate = returnValue == null
        ? null
        : DateTime.parse(returnValue.toString()).toLocal();

    final rawMembers = (json['members'] as List? ?? const [])
        .map((member) => Map<String, dynamic>.from(member as Map))
        .toList();

    final membersNames = (json['members_names'] as List?)
            ?.map((name) => name.toString())
            .toList() ??
        rawMembers
            .where((member) =>
                member['member_status'] == null ||
                member['member_status'] == 'accepted')
            .map((member) {
              final firstName = (member['first_name'] as String? ?? '').trim();
              final lastName = (member['last_name'] as String? ?? '').trim();
              return [firstName, lastName]
                  .where((part) => part.isNotEmpty)
                  .join(' ');
            })
            .where((name) => name.isNotEmpty)
            .toList();

    final rawStatus = (json['status'] as String? ?? 'preparing').toLowerCase();
    final tripStatus = switch (rawStatus) {
      'active' || 'in_trip' => HomeTripStatus.inTrip,
      'completed' || 'finished' => HomeTripStatus.finished,
      'preparing' => HomeTripStatus.preparing,
      _ => HomeTripStatus.none,
    };

    final memberCount = (json['member_count'] as num?)?.toInt() ??
        rawMembers
            .where((member) =>
                member['member_status'] == null ||
                member['member_status'] == 'accepted')
            .length;

    String formatTime(DateTime? value) {
      if (value == null) return '';
      return '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
    }

    return HomeTripModel(
      id: (json['id'] ?? json['trip_id'] ?? '').toString(),
      title: (json['name'] ?? json['title'] ?? '').toString(),
      location: (json['location'] ?? '').toString(),
      departureDate: departureDate,
      returnDate: returnDate,
      departureTime: formatTime(departureDate),
      returnTime: formatTime(returnDate),
      status: tripStatus,
      memberCount: memberCount,
      membersNames: membersNames,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'location': location,
        'departure_date': departureDate.toIso8601String(),
        'return_date': returnDate?.toIso8601String(),
        'departure_time': departureTime,
        'return_time': returnTime,
        'status': status.name,
        'member_count': memberCount,
        'members_names': membersNames,
      };
}
