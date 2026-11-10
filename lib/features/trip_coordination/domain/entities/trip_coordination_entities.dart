class TripBudgetMemberEntity {
  final String userId;
  final String firstName;
  final String lastName;
  final String paymentStatus;
  final String memberType;
  final int share;
  final String? paymentMethod;
  final String? paymentReference;

  const TripBudgetMemberEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.paymentStatus,
    required this.memberType,
    required this.share,
    required this.paymentMethod,
    required this.paymentReference,
  });

  String get displayName {
    final name = '$firstName $lastName'.trim();
    return name.isEmpty ? 'عضو سفر' : name;
  }
}

class TripBudgetEntity {
  final int tripId;
  final bool isLeader;
  final List<TripBudgetMemberEntity> members;
  final String? myPaymentStatus;
  final String tripName;
  final int totalBudget;
  final int myShare;
  final String? bankCardNumber;
  final String? bankAccountName;

  const TripBudgetEntity({
    required this.tripId,
    required this.isLeader,
    required this.members,
    required this.myPaymentStatus,
    required this.tripName,
    required this.totalBudget,
    required this.myShare,
    required this.bankCardNumber,
    required this.bankAccountName,
  });
}

class TripTaskMemberEntity {
  final int tripMemberId;
  final String firstName;
  final String lastName;
  final String username;

  const TripTaskMemberEntity({
    required this.tripMemberId,
    required this.firstName,
    required this.lastName,
    required this.username,
  });

  String get displayName {
    final name = '$firstName $lastName'.trim();
    return name.isEmpty ? (username.isEmpty ? 'عضو سفر' : username) : name;
  }
}

class TripTaskEntity {
  final int id;
  final int tripMemberId;
  final String title;
  final bool isDone;
  final String userId;
  final String firstName;
  final String lastName;
  final String username;

  const TripTaskEntity({
    required this.id,
    required this.tripMemberId,
    required this.title,
    required this.isDone,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.username,
  });

  String get memberDisplayName {
    final name = '$firstName $lastName'.trim();
    return name.isEmpty ? (username.isEmpty ? 'عضو سفر' : username) : name;
  }
}

class TripTaskContextEntity {
  final bool isLeader;
  final bool membershipClosed;
  final List<TripTaskMemberEntity> members;
  final List<TripTaskEntity> tasks;

  const TripTaskContextEntity({
    required this.isLeader,
    required this.membershipClosed,
    required this.members,
    required this.tasks,
  });
}

class DeparturePollOptionEntity {
  final int id;
  final DateTime startsAt;
  final DateTime endsAt;
  final int voteCount;

  const DeparturePollOptionEntity({
    required this.id,
    required this.startsAt,
    required this.endsAt,
    required this.voteCount,
  });
}

class DeparturePollEntity {
  final int tripId;
  final int? myOptionId;
  final String tripName;
  final String? location;
  final List<DeparturePollOptionEntity> options;

  const DeparturePollEntity({
    required this.tripId,
    required this.myOptionId,
    required this.tripName,
    required this.location,
    required this.options,
  });
}
