import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProfileDatasource {
  final SupabaseClient _supabaseClient;

  SupabaseProfileDatasource({required this._supabaseClient});

  Future<User> editProfile({
    required String userName,
    required String displayName,
    String? bio,
  }) async {
    final response = await _supabaseClient.auth.updateUser(
      UserAttributes(
        data: {
          "userName": userName,
          "displayName": displayName,
          "bio": bio ?? "",
        },
      ),
    );
    return response.user!;
  }
}
