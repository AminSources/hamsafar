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
    final user = _supabaseClient.auth.currentUser!;

    final response = await _supabaseClient
        .from('trip_members')
        .select('''
          trip_id,
          trips (*)
        ''')
        .eq('user_id', user.id)
        .eq('member_status', 'accepted')
        .maybeSingle();

    return response;
  }

  Future<Map<String, dynamic>> getProfile({required String userId}) async {
    final rows = await _supabaseClient
        .from('profiles')
        .select('id, first_name, avatar_icon')
        .eq('id', userId)
        .limit(1);

    return rows.first;
  }

  Future<Map<String, dynamic>> getHomeData() async {
    final profile = await getProfile(userId: _userId);

    final trip = await getCurrentTrip();

    if (trip == null) {
      return {'profile': profile, 'current_trip': null};
    }

    return {'profile': profile, 'current_trip': trip};
  }
}
