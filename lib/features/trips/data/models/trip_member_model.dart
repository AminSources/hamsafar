import 'package:hamsafar/features/trips/domain/entities/trip_member_entity.dart';

class TripMemberModel extends TripMemberEntity {
  const TripMemberModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.username,
    required super.avatarIcon,
    required super.memberType,
    required super.memberStatus,
  });

  factory TripMemberModel.fromJson(Map<String, dynamic> json) {
    return TripMemberModel(
      id: _requiredString(json, 'id'),
      firstName: _optionalString(json, 'first_name'),
      lastName: _optionalString(json, 'last_name'),
      username: _optionalString(json, 'username'),
      avatarIcon: _optionalString(json, 'avatar_icon').isEmpty
          ? 'tent'
          : _optionalString(json, 'avatar_icon'),
      memberType: _requiredString(json, 'member_type'),
      memberStatus: _requiredString(json, 'member_status'),
    );
  }

  static String _requiredString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is String && value.isNotEmpty) return value;
    throw FormatException('Invalid or missing trip member field: $key');
  }

  static String _optionalString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return '';
    if (value is String) return value;
    throw FormatException('Invalid trip member field: $key');
  }
}
