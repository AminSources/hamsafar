import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseFriendsDatasource {
  final SupabaseClient supabaseClient;

  SupabaseFriendsDatasource({required this.supabaseClient});

  String get _userId {
    final userId = supabaseClient.auth.currentUser?.id;

    if (userId == null) {
      throw Exception('User is not authenticated');
    }

    return userId;
  }

  Future<List<Map<String, dynamic>>> getFriends() async {
    final response = await supabaseClient
        .from('friendships')
        .select('''
        friend_id,
        profiles!friendships_friend_id_fkey(
          id,
          username,
          first_name,
          last_name,
          avatar_icon,
          bio,
          rate,
          trip_count,
          user_availability(
            day_of_week
          ),
          user_tools(
            id,
            is_available,
            tools(
              id,
              name,
              icon
            )
          )
        )
      ''')
        .eq('user_id', _userId);

    return List<Map<String, dynamic>>.from(response);
  }
}
