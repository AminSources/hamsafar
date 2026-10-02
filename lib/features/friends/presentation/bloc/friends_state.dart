part of 'friends_bloc.dart';

sealed class FriendsState extends Equatable {
  const FriendsState();

  @override
  List<Object> get props => [];
}

final class FriendsInitial extends FriendsState {}

final class FriendsLoading extends FriendsState {}

final class FriendsSuccess extends FriendsState {
  final List<FriendEntity> friends;

  const FriendsSuccess({required this.friends});

  @override
  List<Object> get props => [friends];
}

final class FriendsFailure extends FriendsState {
  final String errorMessage;

  const FriendsFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
