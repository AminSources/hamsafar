part of 'friends_bloc.dart';

sealed class FriendsState extends Equatable {
  const FriendsState();

  @override
  List<Object?> get props => [];
}

final class FriendsInitial extends FriendsState {}

final class FriendsLoading extends FriendsState {}

final class FriendsSuccess extends FriendsState {
  final List<FriendEntity> friends;

  const FriendsSuccess({required this.friends});

  @override
  List<Object?> get props => [friends];
}

final class FriendsFailure extends FriendsState {
  final String errorMessage;

  const FriendsFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

final class FriendsSearchLoading extends FriendsState {}

final class FriendsSearchSuccess extends FriendsState {
  final String query;
  final List<FriendEntity> users;
  final String? busyUserId;
  final String? actionMessage;
  final bool actionError;

  const FriendsSearchSuccess({
    required this.query,
    required this.users,
    this.busyUserId,
    this.actionMessage,
    this.actionError = false,
  });

  @override
  List<Object?> get props => [
    query,
    users,
    busyUserId,
    actionMessage,
    actionError,
  ];
}

final class FriendsSearchFailure extends FriendsState {
  final String errorMessage;

  const FriendsSearchFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

final class FriendsRequestsLoading extends FriendsState {}

final class FriendsRequestsSuccess extends FriendsState {
  final List<FriendEntity> incoming;
  final List<FriendEntity> outgoing;
  final String? busyUserId;
  final String? actionMessage;
  final bool actionError;

  const FriendsRequestsSuccess({
    required this.incoming,
    required this.outgoing,
    this.busyUserId,
    this.actionMessage,
    this.actionError = false,
  });

  @override
  List<Object?> get props => [
    incoming,
    outgoing,
    busyUserId,
    actionMessage,
    actionError,
  ];
}

final class FriendsRequestsFailure extends FriendsState {
  final String errorMessage;

  const FriendsRequestsFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
