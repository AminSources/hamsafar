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
            user_availability(day_of_week),
            user_tools(
              id,
              is_available,
              tools(id, name, icon)
            )
          )
        ''')
        .eq('user_id', _userId);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    final response = await supabaseClient.rpc(
      'search_friend_profiles',
      params: {'p_query': query},
    );
    return List<Map<String, dynamic>>.from(response as List);
  }

  Future<List<Map<String, dynamic>>> getPendingRequests({
    required bool incoming,
  }) async {
    final response = await supabaseClient.rpc(
      'get_pending_friend_request_profiles',
      params: {'p_direction': incoming ? 'incoming' : 'outgoing'},
    );
    return List<Map<String, dynamic>>.from(response as List);
  }

  Future<void> sendFriendRequest(String receiverId) async {
    await supabaseClient.rpc(
      'send_friend_request',
      params: {'p_receiver_id': receiverId},
    );
  }

  Future<void> respondToFriendRequest({
    required String otherUserId,
    required bool accept,
  }) async {
    await supabaseClient.rpc(
      'respond_to_friend_request',
      params: {'p_other_user_id': otherUserId, 'p_accept': accept},
    );
  }

  Future<void> cancelFriendRequest({
    required String otherUserId,
  }) async {
    await supabaseClient.rpc(
      'cancel_friend_request',
      params: {'p_other_user_id': otherUserId},
    );
  }
}
