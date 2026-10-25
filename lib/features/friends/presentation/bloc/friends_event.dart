part of 'friends_bloc.dart';

sealed class FriendsEvent extends Equatable {
  const FriendsEvent();

  @override
  List<Object> get props => [];
}

class GetFriendsEvent extends FriendsEvent {}

class SearchFriendsEvent extends FriendsEvent {
  final String query;

  const SearchFriendsEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class GetFriendRequestsEvent extends FriendsEvent {}

class SendFriendRequestEvent extends FriendsEvent {
  final String receiverId;

  const SendFriendRequestEvent({required this.receiverId});

  @override
  List<Object> get props => [receiverId];
}

class RespondToFriendRequestEvent extends FriendsEvent {
  final String otherUserId;
  final bool accept;

  const RespondToFriendRequestEvent({
    required this.otherUserId,
    required this.accept,
  });

  @override
  List<Object> get props => [otherUserId, accept];
}

class CancelFriendRequestEvent extends FriendsEvent {
  final String otherUserId;

  const CancelFriendRequestEvent({required this.otherUserId});

  @override
  List<Object> get props => [otherUserId];
}
