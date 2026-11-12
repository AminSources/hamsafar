import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHomeDatasource {
  final SupabaseClient supabaseClient;

  SupabaseHomeDatasource({required this.supabaseClient});

  String get _userId {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User is not logged in.');
    }
    return userId;
  }

  Future<List<Map<String, dynamic>>> getMyTrips() async {
    final response = await supabaseClient.rpc(
      'get_trips',
      params: {'p_mode': 'mine', 'p_query': null, 'p_trip_id': null},
    );

    return List<Map<String, dynamic>>.from(response as List);
  }

  Future<Map<String, dynamic>> getProfile({required String userId}) async {
    final profile = await supabaseClient
        .from('profiles')
        .select('id, first_name, avatar_icon')
        .eq('id', userId)
        .maybeSingle();

    if (profile == null) {
      throw Exception('Profile not found for the current user.');
    }

    return profile;
  }

  Map<String, dynamic>? _selectCurrentTrip(List<Map<String, dynamic>> trips) {
    final currentTrips = trips.where((trip) {
      final status = trip['status'] as String?;
      return status == 'active' || status == 'preparing';
    }).toList();

    if (currentTrips.isEmpty) return null;

    // Prefer an ongoing trip. Otherwise show the nearest upcoming trip.
    currentTrips.sort((a, b) {
      final aStatus = a['status'] == 'active' ? 0 : 1;
      final bStatus = b['status'] == 'active' ? 0 : 1;
      if (aStatus != bStatus) return aStatus.compareTo(bStatus);

      final aDate = DateTime.parse(a['departure_at'] as String);
      final bDate = DateTime.parse(b['departure_at'] as String);
      return aDate.compareTo(bDate);
    });

    return currentTrips.first;
  }

  Future<List<Map<String, dynamic>>> getRecentActivities(int tripId) async {
    final response = await supabaseClient.rpc(
      'get_recent_trip_activities',
      params: {'p_trip_id': tripId},
    );

    if (response is! List) {
      throw const FormatException(
        'Invalid response from get_recent_trip_activities.',
      );
    }

    return response.map((row) {
      if (row is! Map) {
        throw const FormatException(
          'Invalid activity row in get_recent_trip_activities.',
        );
      }
      return Map<String, dynamic>.from(row);
    }).toList(growable: false);
  }

  Future<Map<String, dynamic>> getHomeData() async {
    final profile = await getProfile(userId: _userId);
    final trips = await getMyTrips();
    final currentTrip = _selectCurrentTrip(trips);
    final tripId = int.tryParse(currentTrip?['id']?.toString() ?? '');
    final activities = tripId == null
        ? <Map<String, dynamic>>[]
        : await getRecentActivities(tripId);
    return {
      'profile': profile,
      'current_trip': currentTrip,
      'activities': activities,
    };
  }
}
