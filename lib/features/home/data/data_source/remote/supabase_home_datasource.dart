import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHomeDatasource {
  final SupabaseClient _supabaseClient;

  SupabaseHomeDatasource({required this._supabaseClient});

  String get _userId {
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User is not logged in.');
    }
    return userId;
  }

  Future<Map<String, dynamic>?> getCurrentTrip() async {
    final rows = await _supabaseClient
        .from('trip_members')
        .select('''
          trip:trips!inner(
            id,
            title,
            location,
            departure_date,
            return_date,
            departure_time,
            return_time,
            status,
            member_count,
            members_names
          )
        ''')
        .eq('user_id', _userId)
        .inFilter('trip.status', ['preparing', 'in_trip'])
        .limit(1);

    if (rows.isEmpty) return null;

    final trip = rows.first['trip'];
    if (trip is! Map<String, dynamic>) return null;

    return trip;
  }

  Future<List<Map<String, dynamic>>> getRecentActivities({
    required String tripId,
  }) async {
    final rows = await _supabaseClient
        .from('trip_activities')
        .select('id, title, activity_type, created_at')
        .eq('trip_id', tripId)
        .order('created_at', ascending: false)
        .limit(5);

    return rows;
  }

  Future<Map<String, dynamic>> getProfile({required String userId}) async {
    final rows = await _supabaseClient
        .from('profiles')
        .select('id, displayName')
        .eq('id', userId)
        .limit(1);

    return rows.first;
  }

  Future<Map<String, dynamic>> getHomeData() async {
    final profile = await getProfile(userId: _userId);

    final trip = await getCurrentTrip();

    if (trip == null) {
      return {
        'profile': profile,
        'current_trip': null,
        'recent_activities': <Map<String, dynamic>>[],
      };
    }

    final activities = await getRecentActivities(tripId: trip['id'] as String);

    return {
      'profile': profile,
      'current_trip': trip,
      'recent_activities': activities,
    };
  }
}
