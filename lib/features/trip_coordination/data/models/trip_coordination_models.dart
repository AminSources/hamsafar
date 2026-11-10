import 'package:hamsafar/features/trip_coordination/domain/entities/trip_coordination_entities.dart';

int _intValue(dynamic value, {int fallback = 0}) {
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? fallback;
}

String _stringValue(dynamic value) => value?.toString() ?? '';

List<Map<String, dynamic>> _rows(dynamic value) {
  if (value is! List) return const [];
  return value
      .whereType<Map>()
      .map((row) => Map<String, dynamic>.from(row))
      .toList();
}

class TripBudgetModel {
  static TripBudgetEntity fromJson(Map<String, dynamic> json) {
    final members = _rows(json['members'])
        .map(
          (member) => TripBudgetMemberEntity(
            userId: _stringValue(member['user_id']),
            firstName: _stringValue(member['first_name']),
            lastName: _stringValue(member['last_name']),
            paymentStatus: _stringValue(member['pay_status']),
            memberType: _stringValue(member['member_type']),
            share: _intValue(member['share']),
            paymentMethod: member['payment_method']?.toString(),
            paymentReference: member['payment_reference']?.toString(),
          ),
        )
        .toList();

    return TripBudgetEntity(
      tripId: _intValue(json['trip_id']),
      isLeader: json['is_leader'] == true,
      members: members,
      myPaymentStatus: json['my_pay_status']?.toString(),
      tripName: _stringValue(json['trip_name']),
      totalBudget: _intValue(json['total_budget']),
      myShare: _intValue(json['my_share']),
      bankCardNumber: json['bank_card_number']?.toString(),
      bankAccountName: json['bank_account_name']?.toString(),
    );
  }
}

class TripTaskContextModel {
  static TripTaskContextEntity fromJson(Map<String, dynamic> json) {
    final members = _rows(json['members'])
        .map(
          (member) => TripTaskMemberEntity(
            tripMemberId: _intValue(member['trip_member_id']),
            firstName: _stringValue(member['first_name']),
            lastName: _stringValue(member['last_name']),
            username: _stringValue(member['username']),
          ),
        )
        .toList();

    final tasks = _rows(json['tasks'])
        .map(
          (task) => TripTaskEntity(
            id: _intValue(task['id']),
            tripMemberId: _intValue(task['trip_member_id']),
            title: _stringValue(task['task']),
            isDone: task['is_done'] == true,
            userId: _stringValue(task['user_id']),
            firstName: _stringValue(task['first_name']),
            lastName: _stringValue(task['last_name']),
            username: _stringValue(task['username']),
          ),
        )
        .toList();

    return TripTaskContextEntity(
      isLeader: json['is_leader'] == true,
      membershipClosed: json['membership_closed'] == true,
      members: members,
      tasks: tasks,
    );
  }
}

class DeparturePollModel {
  static DeparturePollEntity fromJson(Map<String, dynamic> json) {
    final options = _rows(json['options'])
        .map(
          (option) => DeparturePollOptionEntity(
            id: _intValue(option['id']),
            startsAt: DateTime.parse(_stringValue(option['starts_at'])),
            endsAt: DateTime.parse(_stringValue(option['ends_at'])),
            voteCount: _intValue(option['vote_count']),
          ),
        )
        .toList();

    return DeparturePollEntity(
      tripId: _intValue(json['trip_id']),
      myOptionId: json['my_option_id'] == null
          ? null
          : _intValue(json['my_option_id']),
      tripName: _stringValue(json['trip_name']),
      location: json['location']?.toString(),
      options: options,
    );
  }
}
