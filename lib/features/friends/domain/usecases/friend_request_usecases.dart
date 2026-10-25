import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/core/usecase/usecase.dart';
import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';
import 'package:hamsafar/features/friends/domain/repositories/friends_repository.dart';

class SearchFriendsUsecase
    implements Usecase<DataState<List<FriendEntity>>, String> {
  final FriendsRepository friendsRepository;

  SearchFriendsUsecase({required this.friendsRepository});

  @override
  Future<DataState<List<FriendEntity>>> call(String query) {
    return friendsRepository.searchUsers(query);
  }
}

class GetPendingFriendRequestsUsecase
    implements Usecase<DataState<List<FriendEntity>>, bool> {
  final FriendsRepository friendsRepository;

  GetPendingFriendRequestsUsecase({required this.friendsRepository});

  @override
  Future<DataState<List<FriendEntity>>> call(bool incoming) {
    return friendsRepository.getPendingFriendRequests(incoming: incoming);
  }
}

class SendFriendRequestUsecase
    implements Usecase<DataState<bool>, String> {
  final FriendsRepository friendsRepository;

  SendFriendRequestUsecase({required this.friendsRepository});

  @override
  Future<DataState<bool>> call(String receiverId) {
    return friendsRepository.sendFriendRequest(receiverId);
  }
}

class RespondToFriendRequestParams {
  final String otherUserId;
  final bool accept;

  const RespondToFriendRequestParams({
    required this.otherUserId,
    required this.accept,
  });
}

class RespondToFriendRequestUsecase
    implements Usecase<DataState<bool>, RespondToFriendRequestParams> {
  final FriendsRepository friendsRepository;

  RespondToFriendRequestUsecase({required this.friendsRepository});

  @override
  Future<DataState<bool>> call(RespondToFriendRequestParams params) {
    return friendsRepository.respondToFriendRequest(
      otherUserId: params.otherUserId,
      accept: params.accept,
    );
  }
}

class CancelFriendRequestUsecase
    implements Usecase<DataState<bool>, String> {
  final FriendsRepository friendsRepository;

  CancelFriendRequestUsecase({required this.friendsRepository});

  @override
  Future<DataState<bool>> call(String otherUserId) {
    return friendsRepository.cancelFriendRequest(otherUserId: otherUserId);
  }
}
