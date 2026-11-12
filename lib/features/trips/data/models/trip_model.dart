import 'package:hamsafar/features/trips/data/models/trip_departure_option_model.dart';
import 'package:hamsafar/features/trips/data/models/trip_member_model.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';

class TripModel extends TripEntity {
  const TripModel({
    required super.id,
    required super.name,
    required super.location,
    required super.departureAt,
    required super.returnAt,
    required super.status,
    required super.budget,
    required super.createdBy,
    super.description,
    super.meetingPoint,
    super.bankCardNumber,
    super.bankAccountName,
    super.scheduleType,
    super.costItems,
    super.rules,
    super.memberCount,
    super.leaderName,
    super.isCreator,
    super.isMember,
    super.canJoin,
    super.membershipClosed,
    super.currentMemberStatus,
    super.members,
    super.departureOptions,
  });

  factory TripModel.fromJson(
    Map<String, dynamic> json, {
    String? currentMemberStatus,
  }) {
    final status = _requiredString(json, 'status');
    final members = _requiredObjectList(json, 'members')
        .map(TripMemberModel.fromJson)
        .toList(growable: false);
    final departureOptions = _optionalObjectList(json, 'departure_options')
        .map(TripDepartureOptionModel.fromJson)
        .toList(growable: false);

    return TripModel(
      id: _requiredInt(json, 'id'),
      name: _requiredString(json, 'name'),
      location: _requiredString(json, 'location'),
      departureAt: _dateTime(json, 'departure_at'),
      returnAt: _dateTime(json, 'return_at'),
      status: status,
      budget: _requiredInt(json, 'budget'),
      createdBy: _requiredString(json, 'created_by'),
      description: _nullableString(json, 'description'),
      meetingPoint: _nullableString(json, 'meeting_point'),
      bankCardNumber: _nullableString(json, 'bank_card_number'),
      bankAccountName: _nullableString(json, 'bank_account_name'),
      scheduleType: _requiredString(json, 'schedule_type'),
      costItems: _requiredStringList(json, 'cost_items'),
      rules: _requiredStringList(json, 'rules'),
      memberCount: _requiredInt(json, 'member_count'),
      leaderName: _requiredString(json, 'leader_name'),
      isCreator: _requiredBool(json, 'is_creator'),
      isMember: _requiredBool(json, 'is_member'),
      canJoin: _requiredBool(json, 'can_join'),
      membershipClosed:
          _optionalBool(json, 'membership_closed', fallback: false) ||
          status != 'preparing',
      currentMemberStatus:
          currentMemberStatus ?? _nullableString(json, 'current_member_status'),
      members: members,
      departureOptions: departureOptions,
    );
  }

  static String _requiredString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is String && value.isNotEmpty) return value;
    throw FormatException('Invalid or missing trip field: $key');
  }

  static String? _nullableString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return null;
    if (value is String) return value;
    throw FormatException('Invalid trip field: $key');
  }

  static int _requiredInt(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is num) return value.toInt();
    throw FormatException('Invalid or missing trip field: $key');
  }

  static bool _optionalBool(
    Map<String, dynamic> json,
    String key, {
    required bool fallback,
  }) {
    final value = json[key];
    if (value == null) return fallback;
    if (value is bool) return value;
    throw FormatException('Invalid trip field: $key');
  }

  static bool _requiredBool(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is bool) return value;
    throw FormatException('Invalid or missing trip field: $key');
  }

  static DateTime _dateTime(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is DateTime) return value.toLocal();
    if (value is String) {
      final parsed = DateTime.tryParse(value);
      if (parsed != null) return parsed.toLocal();
    }
    throw FormatException('Invalid or missing trip field: $key');
  }

  static List<String> _requiredStringList(
    Map<String, dynamic> json,
    String key,
  ) {
    final value = json[key];
    if (value is! List) {
      throw FormatException('Invalid or missing trip field: $key');
    }
    return value.map((item) {
      if (item is String) return item;
      throw FormatException('Invalid item in trip field: $key');
    }).toList(growable: false);
  }

  static List<Map<String, dynamic>> _optionalObjectList(
    Map<String, dynamic> json,
    String key,
  ) {
    final value = json[key];
    if (value == null) return const [];
    if (value is! List) {
      throw FormatException('Invalid trip field: $key');
    }
    return value.map((item) {
      if (item is Map<String, dynamic>) return item;
      if (item is Map) return Map<String, dynamic>.from(item);
      throw FormatException('Invalid item in trip field: $key');
    }).toList(growable: false);
  }

  static List<Map<String, dynamic>> _requiredObjectList(
    Map<String, dynamic> json,
    String key,
  ) {
    final value = json[key];
    if (value is! List) {
      throw FormatException('Invalid or missing trip field: $key');
    }
    return value.map((item) {
      if (item is Map<String, dynamic>) return item;
      if (item is Map) return Map<String, dynamic>.from(item);
      throw FormatException('Invalid item in trip field: $key');
    }).toList(growable: false);
  }
}
