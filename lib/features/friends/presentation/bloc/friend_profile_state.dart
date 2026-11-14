part of 'friend_profile_bloc.dart';

sealed class FriendProfileState extends Equatable {
  const FriendProfileState();

  @override
  List<Object?> get props => [];
}

final class FriendProfileInitial extends FriendProfileState {
  const FriendProfileInitial();
}

final class FriendProfileLoading extends FriendProfileState {
  const FriendProfileLoading();
}

final class FriendProfileFailure extends FriendProfileState {
  final String message;

  const FriendProfileFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

final class FriendProfileSuccess extends FriendProfileState {
  final FriendEntity friend;
  final bool isActionLoading;
  final String? actionMessage;
  final bool actionError;

  const FriendProfileSuccess({
    required this.friend,
    this.isActionLoading = false,
    this.actionMessage,
    this.actionError = false,
  });

  FriendProfileSuccess copyWith({
    FriendEntity? friend,
    bool? isActionLoading,
    String? actionMessage,
    bool actionError = false,
    bool clearActionMessage = false,
  }) {
    return FriendProfileSuccess(
      friend: friend ?? this.friend,
      isActionLoading: isActionLoading ?? this.isActionLoading,
      actionMessage: clearActionMessage ? null : actionMessage ?? this.actionMessage,
      actionError: clearActionMessage ? false : actionError,
    );
  }

  @override
  List<Object?> get props => [
    friend,
    isActionLoading,
    actionMessage,
    actionError,
  ];
}
