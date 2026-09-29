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
        })
        .eq('id', user.id);
  }
}
