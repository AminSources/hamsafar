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
    final response = await supabaseClient.rpc(
      'get_trips',
      params: {
        'p_mode': mode,
        'p_query': query,
        'p_trip_id': tripId,
      },
    );

    return List<Map<String, dynamic>>.from(response as List);
  }

  Future<int> saveTrip(TripDraft draft, {int? tripId}) async {
    final response = await supabaseClient.rpc(
      'save_trip',
      params: {
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
      },
    );

    return (response as num).toInt();
  }

  Future<void> deleteTrip(int tripId) async {
    final rows = await supabaseClient
        .from('trips')
        .delete()
        .eq('id', tripId)
        .select('id');

    if (rows.isEmpty) {
      throw const PostgrestException(
        message: 'trip_not_found_or_forbidden',
      );
    }
  }
}
