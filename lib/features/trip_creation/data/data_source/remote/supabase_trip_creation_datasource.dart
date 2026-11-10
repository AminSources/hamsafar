import 'package:hamsafar/features/trip_creation/domain/entities/trip_draft.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseTripCreationDatasource {
  final SupabaseClient client;

  const SupabaseTripCreationDatasource({required this.client});

  Future<int> saveTrip(TripDraft draft, {int? tripId}) async {
    final isVoting = draft.scheduleType == 'voting';
    final departure = isVoting && draft.departureOptions.isNotEmpty
        ? draft.departureOptions
            .map((option) => option.startsAt)
            .reduce((a, b) => a.isBefore(b) ? a : b)
        : draft.departureAt;
    final returning = isVoting && draft.departureOptions.isNotEmpty
        ? draft.departureOptions
            .map((option) => option.endsAt)
            .reduce((a, b) => a.isAfter(b) ? a : b)
        : draft.returnAt;

    final options = isVoting
        ? draft.departureOptions
            .map(
              (option) => {
                'starts_at': option.startsAt.toUtc().toIso8601String(),
                'ends_at': option.endsAt.toUtc().toIso8601String(),
              },
            )
            .toList()
        : <Map<String, String>>[];

    final response = await client.rpc(
      'save_trip_with_payment_details',
      params: {
        'p_trip_id': tripId,
        'p_name': draft.name.trim(),
        'p_location': draft.location.trim(),
        'p_description': draft.description.trim(),
        'p_meeting_point': draft.meetingPoint.trim(),
        'p_departure_at': departure.toUtc().toIso8601String(),
        'p_return_at': returning.toUtc().toIso8601String(),
        'p_budget': draft.budget,
        'p_schedule_type': draft.scheduleType,
        'p_cost_items': draft.costItems,
        'p_rules': draft.rules,
        'p_invited_user_ids': draft.invitedUserIds,
        'p_departure_options': options,
        'p_bank_card_number': draft.bankCardNumber,
        'p_bank_account_name': draft.bankAccountName,
      },
    );

    return (response as num).toInt();
  }
}
