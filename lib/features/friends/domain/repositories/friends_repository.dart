import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';

abstract class FriendsRepository {
  Future<DataState<List<FriendEntity>>> getFriends(NoParams noParams);

  Future<DataState<List<FriendEntity>>> searchUsers(String query);

  /// [incoming] is true for requests addressed to the current user.
  Future<DataState<List<FriendEntity>>> getPendingFriendRequests({
    required bool incoming,
  });

  Future<DataState<bool>> sendFriendRequest(String receiverId);

  Future<DataState<bool>> respondToFriendRequest({
    required String otherUserId,
    required bool accept,
  });

  Future<DataState<bool>> cancelFriendRequest({
    required String otherUserId,
  });
}
