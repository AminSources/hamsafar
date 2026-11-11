import 'package:hamsafar/features/trips/domain/entities/trip_departure_option_entity.dart';

class TripDepartureOptionModel extends TripDepartureOptionEntity {
  const TripDepartureOptionModel({
    required super.id,
    required super.startsAt,
    required super.endsAt,
  });

  factory TripDepartureOptionModel.fromJson(Map<String, dynamic> json) {
    final startsAt = _dateTime(json, 'starts_at');
    final endsAt = _dateTime(json, 'ends_at');
    if (!endsAt.isAfter(startsAt)) {
      throw const FormatException('Invalid trip departure option range');
    }

    return TripDepartureOptionModel(
      id: _requiredInt(json, 'id'),
      startsAt: startsAt,
      endsAt: endsAt,
    );
  }

  static int _requiredInt(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is num) return value.toInt();
    throw FormatException('Invalid or missing trip departure option field: $key');
  }

  static DateTime _dateTime(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is DateTime) return value.toLocal();
    if (value is String) {
      final parsed = DateTime.tryParse(value);
      if (parsed != null) return parsed.toLocal();
    }
    throw FormatException('Invalid or missing trip departure option field: $key');
  }
}
