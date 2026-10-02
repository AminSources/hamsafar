import 'package:hamsafar/features/profile/domain/params/edit_profile_params.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProfileDatasource {
  final SupabaseClient _supabaseClient;

  SupabaseProfileDatasource({required this._supabaseClient});

  Future<void> editProfile({required EditProfileParams params}) async {
    final user = _supabaseClient.auth.currentUser;

    if (user == null) {
      throw Exception('User is not authenticated');
    }

    await _supabaseClient
        .from('profiles')
        .update({
          'username': params.userName,
          'first_name': params.firstName,
          'last_name': params.lastName,
          'bio': params.bio ?? '',
          "avatar_icon": params.avatarIcon,
          "rate": params.rate ?? 0.0,
          "trip_count": params.tripCount ?? 0,
          "onboarding_completed": params.onboardingCompleted,
        })
        .eq('id', user.id);
  }

  Future<Map<String, dynamic>> getProfile() async {
    final user = _supabaseClient.auth.currentUser;

    if (user == null) {
      throw Exception('User is not authenticated');
    }

    final profile = await _supabaseClient
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    final friends = await _supabaseClient
        .from('friendships')
        .select('id')
        .eq('user_id', user.id);

    final freeDays = await _supabaseClient
        .from('user_availability')
        .select('day_of_week')
        .eq('user_id', user.id);

    final userTools = await _supabaseClient
        .from('user_tools')
        .select('id')
        .eq('user_id', user.id);

    return {
      ...profile,
      'friend_count': friends.length,
      'tool_count': userTools.length,
      'free_days': freeDays.map((day) => day['day_of_week']).toList(),
    };
  }
}
