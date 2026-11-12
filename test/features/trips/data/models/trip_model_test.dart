import 'package:flutter_test/flutter_test.dart';
import 'package:hamsafar/features/trips/data/models/trip_model.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_departure_option_entity.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_member_entity.dart';

Map<String, dynamic> validTripJson({
  List<Map<String, dynamic>>? members,
  Object? departureOptions,
}) {
  final Map<String, dynamic> json = {
    'id': 42,
    'name': 'North trip',
    'location': 'Tabriz',
    'departure_at': '2026-12-01T07:00:00Z',
    'return_at': '2026-12-03T21:00:00Z',
    'status': 'preparing',
    'budget': 1200000,
    'created_by': 'creator-uuid',
    'description': null,
    'meeting_point': 'Central square',
    'bank_card_number': null,
    'bank_account_name': null,
    'schedule_type': 'voting',
    'cost_items': <String>['transport', 'food'],
    'rules': <String>['arrive on time'],
    'member_count': 2,
    'leader_name': 'Trip Leader',
    'is_creator': true,
    'is_member': true,
    'can_join': false,
    'membership_closed': false,
    'members': members ??
        <Map<String, dynamic>>[
          {
            'id': 'creator-uuid',
            'first_name': 'Amin',
            'last_name': 'User',
            'username': 'amin',
            'avatar_icon': 'tent',
            'member_type': 'leader',
            'member_status': 'accepted',
          },
          {
            'id': 'member-uuid',
            'first_name': 'Sara',
            'last_name': '',
            'username': 'sara',
            'avatar_icon': 'cat',
            'member_type': 'member',
            'member_status': 'pending',
          },
        ],
  };
  if (departureOptions != null) {
    json['departure_options'] = departureOptions;
  }
  return json;
}

void main() {
  group('TripModel.fromJson', () {
    test('maps RPC member JSON into typed domain entities', () {
      final trip = TripModel.fromJson(validTripJson());

      expect(trip.id, 42);
      expect(trip.isCreator, isTrue);
      expect(trip.canJoin, isFalse);
      expect(trip.members, hasLength(2));
      expect(trip.members.first, isA<TripMemberEntity>());
      expect(trip.members.first.displayName, 'Amin User');
      expect(trip.members.first.isLeader, isTrue);
      expect(trip.members.last.memberStatus, 'pending');
      expect(trip.members.last.displayName, 'Sara');
    });

    test('maps departure option JSON into typed entities', () {
      final trip = TripModel.fromJson(
        validTripJson(
          departureOptions: [
            {
              'id': 7,
              'starts_at': '2026-12-01T07:00:00Z',
              'ends_at': '2026-12-01T09:00:00Z',
            },
          ],
        ),
      );

      expect(trip.departureOptions, hasLength(1));
      expect(trip.departureOptions.first, isA<TripDepartureOptionEntity>());
      expect(trip.departureOptions.first.id, 7);
      expect(
        trip.departureOptions.first.endsAt.isAfter(
          trip.departureOptions.first.startsAt,
        ),
        isTrue,
      );
    });

    test('allows departure options to be absent in list/search RPC results', () {
      final trip = TripModel.fromJson(validTripJson());

      expect(trip.departureOptions, isEmpty);
    });

    test('rejects missing required members response instead of returning empty', () {
      final json = validTripJson()..remove('members');

      expect(() => TripModel.fromJson(json), throwsFormatException);
    });

    test('rejects malformed member status', () {
      final json = validTripJson(
        members: [
          {
            'id': 'member-uuid',
            'first_name': 'Sara',
            'last_name': '',
            'username': 'sara',
            'avatar_icon': 'cat',
            'member_type': 'member',
          },
        ],
      );

      expect(() => TripModel.fromJson(json), throwsFormatException);
    });

    test('rejects invalid departure option date ranges', () {
      final json = validTripJson(
        departureOptions: [
          {
            'id': 7,
            'starts_at': '2026-12-01T09:00:00Z',
            'ends_at': '2026-12-01T07:00:00Z',
          },
        ],
      );

      expect(() => TripModel.fromJson(json), throwsFormatException);
    });
  });
}
