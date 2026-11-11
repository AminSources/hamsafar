import 'package:hamsafar/features/profile/domain/entities/profile_preferences_entity.dart';
import 'package:hamsafar/features/profile/domain/params/edit_profile_params.dart';
import 'package:hamsafar/features/profile/domain/params/save_availability_params.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProfileDatasource {
  final SupabaseClient _supabaseClient;

  SupabaseProfileDatasource({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  User _requireUser() {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) throw StateError('User is not authenticated');
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
          // Rating and trip_count are server-owned; clients must not overwrite them.
          'onboarding_completed': params.onboardingCompleted,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', user.id)
        .select('id');

    if (updatedProfiles.isEmpty) {
      throw StateError('Profile update was not applied for the current user.');
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
    final results = await Future.wait<Object?>([
      _supabaseClient.from('profiles').select().eq('id', user.id).single(),
      _supabaseClient.from('friendships').select('id').eq('user_id', user.id),
      _supabaseClient
          .from('user_availability')
          .select('day_of_week')
          .eq('user_id', user.id),
      _supabaseClient.from('user_tools').select('id').eq('user_id', user.id),
    ]);

    final profile = Map<String, dynamic>.from(results[0] as Map);
    final friends = results[1] as List;
    final freeDays = results[2] as List;
    final userTools = results[3] as List;
    return {
      ...profile,
      'friend_count': friends.length,
      'tool_count': userTools.length,
      'free_days': freeDays.map((day) => (day as Map)['day_of_week']).toList(),
    };
  }

  Future<Map<String, dynamic>> getProfilePreferences() async {
    final user = _requireUser();
    final results = await Future.wait<Object?>([
      _supabaseClient
          .from('user_availability')
          .select('day_of_week, time_from, time_to')
          .eq('user_id', user.id),
      _supabaseClient
          .from('user_tools')
          .select('id, tool_id, is_available, tools(id, name)')
          .eq('user_id', user.id)
          .order('id'),
    ]);
    return {
      'availability': results[0] as List,
      'tools': results[1] as List,
    };
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
