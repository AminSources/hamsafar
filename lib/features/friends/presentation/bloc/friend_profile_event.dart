part of 'friend_profile_bloc.dart';

sealed class FriendProfileEvent extends Equatable {
  const FriendProfileEvent();

  @override
  List<Object?> get props => [];
}

final class FriendProfileLoadRequested extends FriendProfileEvent {
  final String userId;

  const FriendProfileLoadRequested(this.userId);

  @override
  List<Object?> get props => [userId];
}

final class FriendProfileSendRequestRequested extends FriendProfileEvent {
  const FriendProfileSendRequestRequested();
}

final class FriendProfileCancelRequestRequested extends FriendProfileEvent {
  const FriendProfileCancelRequestRequested();
}

final class FriendProfileRequestResponseRequested extends FriendProfileEvent {
  final bool accept;

  const FriendProfileRequestResponseRequested({required this.accept});

  @override
  List<Object?> get props => [accept];
}

final class FriendProfileRemoveFriendRequested extends FriendProfileEvent {
  const FriendProfileRemoveFriendRequested();
}
