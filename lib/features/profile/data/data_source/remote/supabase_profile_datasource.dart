import 'package:hamsafar/features/profile/domain/entities/profile_preferences_entity.dart';
import 'package:hamsafar/features/profile/domain/params/edit_profile_params.dart';
import 'package:hamsafar/features/profile/domain/params/save_availability_params.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProfileDatasource {
  final SupabaseClient _supabaseClient;

  SupabaseProfileDatasource({required this._supabaseClient});

  User _requireUser() {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) throw Exception('User is not authenticated');
    return user;
  }

  Future<void> editProfile({required EditProfileParams params}) async {
    final user = _requireUser();

    final updatedProfiles = await _supabaseClient
        .from('profiles')
        .update({
          'username': params.userName,
          'first_name': params.firstName,
          'last_name': params.lastName,
          'bio': params.bio ?? '',
          'avatar_icon': params.avatarIcon,
          'rate': params.rate ?? 0.0,
          'trip_count': params.tripCount ?? 0,
          'onboarding_completed': params.onboardingCompleted,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', user.id)
        .select('id');

    if (updatedProfiles.isEmpty) {
      throw Exception('Profile update was not applied for the current user');
    }
  }


  Future<bool> getOnboardingCompleted() async {
    final user = _requireUser();
    final profile = await _supabaseClient
        .from('profiles')
        .select('onboarding_completed')
        .eq('id', user.id)
        .maybeSingle();

    return profile?['onboarding_completed'] == true;
  }

  Future<Map<String, dynamic>> getProfile() async {
    final user = _requireUser();

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

  Future<Map<String, dynamic>> getProfilePreferences() async {
    final user = _requireUser();

    final availability = await _supabaseClient
        .from('user_availability')
        .select('day_of_week, time_from, time_to')
        .eq('user_id', user.id);

    final tools = await _supabaseClient
        .from('user_tools')
        .select('id, tool_id, is_available, tools(id, name)')
        .eq('user_id', user.id)
        .order('id');

    return {'availability': availability, 'tools': tools};
  }

  Future<void> saveAvailability(SaveAvailabilityParams params) async {
    _requireUser();
    await _supabaseClient.rpc(
      'replace_user_availability',
      params: {
        'p_days': params.days,
        'p_time_from': params.timeFrom,
        'p_time_to': params.timeTo,
      },
    );
  }

  Future<void> saveTools(List<ProfileToolEntity> tools) async {
    _requireUser();
    await _supabaseClient.rpc(
      'save_user_tools',
      params: {
        'p_tools': tools
            .map(
              (tool) => {
                'name': tool.name.trim(),
                'is_available': tool.isAvailable,
              },
            )
            .toList(),
      },
    );
  }
}
