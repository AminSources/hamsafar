import 'package:hamsafar/features/trips/domain/entities/trip_draft.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseTripsDatasource {
  final SupabaseClient supabaseClient;

  SupabaseTripsDatasource({required this.supabaseClient});

  Future<List<Map<String, dynamic>>> getTrips({
    required String mode,
    String query = '',
    int? tripId,
  }) async {
    final response = await supabaseClient.rpc('get_trips', params: {
      'p_mode': mode, 'p_query': query, 'p_trip_id': tripId,
    });
    return List<Map<String, dynamic>>.from(response as List);
  }

  Future<String?> getMembershipStatus(int tripId) async {
    final value = await supabaseClient.rpc(
      'get_trip_membership_status',
      params: {'p_trip_id': tripId},
    );
    return value as String?;
  }

  Future<void> joinTrip(int tripId) async {
    await supabaseClient.rpc('join_trip', params: {'p_trip_id': tripId});
  }

  Future<void> respondToInvitation(int tripId, bool accept) async {
    await supabaseClient.rpc('respond_to_trip_invitation', params: {
      'p_trip_id': tripId, 'p_accept': accept,
    });
  }

  Future<void> leaveTrip(int tripId) async {
    await supabaseClient.rpc('leave_trip', params: {'p_trip_id': tripId});
  }

  Future<void> inviteToTrip(int tripId, List<String> userIds) async {
    await supabaseClient.rpc('invite_to_trip', params: {
      'p_trip_id': tripId, 'p_user_ids': userIds,
    });
  }

  Future<void> removeTripMember(int tripId, String userId) async {
    await supabaseClient.rpc('remove_trip_member', params: {
      'p_trip_id': tripId, 'p_user_id': userId,
    });
  }

  Future<int> saveTrip(TripDraft draft, {int? tripId}) async {
    final response = await supabaseClient.rpc('save_trip', params: {
      'p_trip_id': tripId,
      'p_name': draft.name.trim(),
      'p_location': draft.location.trim(),
      'p_description': draft.description.trim(),
      'p_meeting_point': draft.meetingPoint.trim(),
      'p_departure_at': draft.departureAt.toUtc().toIso8601String(),
      'p_return_at': draft.returnAt.toUtc().toIso8601String(),
      'p_budget': draft.budget,
      'p_schedule_type': draft.scheduleType,
      'p_cost_items': draft.costItems,
      'p_rules': draft.rules,
      'p_invited_user_ids': draft.invitedUserIds,
    });
    final tripId = (response as num).toInt();
    final options = draft.scheduleType == 'voting'
        ? draft.departureOptions.map((option) => {
            'starts_at': option.startsAt.toUtc().toIso8601String(),
            'ends_at': option.endsAt.toUtc().toIso8601String(),
          }).toList()
        : <Map<String, String>>[];
    await supabaseClient.rpc('replace_trip_departure_options', params: {
      'p_trip_id': tripId,
      'p_options': options,
    });
    return tripId;
  }

  Future<void> deleteTrip(int tripId) async {
    final rows = await supabaseClient.from('trips').delete()
        .eq('id', tripId).select('id');
    if (rows.isEmpty) throw Exception('trip_not_found_or_forbidden');
  }
}
