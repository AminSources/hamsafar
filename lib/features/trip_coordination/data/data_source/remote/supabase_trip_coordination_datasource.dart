import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseTripCoordinationDatasource {
  final SupabaseClient client;

  const SupabaseTripCoordinationDatasource({required this.client});

  Future<Map<String, dynamic>?> getMyTripBudget() async {
    final response = await client.rpc('get_my_trip_budget');
    final rows = response as List;
    if (rows.isEmpty) return null;
    return Map<String, dynamic>.from(rows.first as Map);
  }

  Future<void> submitTripPayment({
    required int tripId,
    required String method,
    String? reference,
  }) async {
    await client.rpc(
      'submit_trip_payment',
      params: {
        'p_trip_id': tripId,
        'p_method': method,
        'p_reference': reference,
      },
    );
  }

  Future<void> confirmTripPayment({
    required int tripId,
    required String userId,
  }) async {
    await client.rpc(
      'confirm_trip_payment',
      params: {'p_trip_id': tripId, 'p_user_id': userId},
    );
  }

  Future<Map<String, dynamic>> getTripTaskContext(int tripId) async {
    final response = await client.rpc(
      'get_trip_task_context',
      params: {'p_trip_id': tripId},
    );
    return Map<String, dynamic>.from(response as Map);
  }

  Future<void> saveTripTask({
    int? taskId,
    required int tripMemberId,
    required String title,
  }) async {
    final values = {'trip_member_id': tripMemberId, 'task': title};
    if (taskId == null) {
      await client.from('trip_member_tasks').insert(values);
      return;
    }

    await client.from('trip_member_tasks').update(values).eq('id', taskId);
  }

  Future<void> deleteTripTask(int taskId) async {
    await client.from('trip_member_tasks').delete().eq('id', taskId);
  }

  Future<void> completeTripTask(int taskId) async {
    await client
        .from('trip_member_tasks')
        .update({'is_done': true})
        .eq('id', taskId);
  }

  Future<List<Map<String, dynamic>>> getMyDeparturePolls() async {
    final response = await client.rpc('get_my_departure_polls');
    return (response as List)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList();
  }

  Future<void> castDepartureVote({
    required int tripId,
    required int optionId,
  }) async {
    await client.rpc(
      'cast_departure_vote',
      params: {'p_trip_id': tripId, 'p_option_id': optionId},
    );
  }
}
