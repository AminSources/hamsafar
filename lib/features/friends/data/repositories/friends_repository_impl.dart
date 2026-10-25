import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/friends/data/data_source/remote/supabase_friends_datasource.dart';
import 'package:hamsafar/features/friends/data/models/friend_model.dart';
import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';
import 'package:hamsafar/features/friends/domain/repositories/friends_repository.dart';

class FriendsRepositoryImpl extends FriendsRepository {
  final SupabaseFriendsDatasource supabaseFriendsDatasource;

  FriendsRepositoryImpl({required this.supabaseFriendsDatasource});

  @override
  Future<DataState<List<FriendEntity>>> getFriends(NoParams noParams) async {
    try {
      final response = await supabaseFriendsDatasource.getFriends();
      final data = [
        for (final row in response)
          FriendModel.fromJson({
            ...Map<String, dynamic>.from(row['profiles'] as Map),
            'relation_status': 'friends',
          }),
      ];
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<FriendEntity>>> searchUsers(String query) async {
    try {
      if (query.trim().length < 2) return const DataSuccess([]);
      final response = await supabaseFriendsDatasource.searchUsers(query.trim());
      return DataSuccess([
        for (final row in response) FriendModel.fromJson(row),
      ]);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<FriendEntity>>> getPendingFriendRequests({
    required bool incoming,
  }) async {
    try {
      final response = await supabaseFriendsDatasource.getPendingRequests(
        incoming: incoming,
      );
      return DataSuccess([
        for (final row in response)
          FriendModel.fromJson({
            ...row,
            'relation_status': incoming ? 'incoming_pending' : 'outgoing_pending',
          }),
      ]);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<bool>> sendFriendRequest(String receiverId) async {
    try {
      await supabaseFriendsDatasource.sendFriendRequest(receiverId);
      return const DataSuccess(true);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<bool>> respondToFriendRequest({
    required String otherUserId,
    required bool accept,
  }) async {
    try {
      await supabaseFriendsDatasource.respondToFriendRequest(
        otherUserId: otherUserId,
        accept: accept,
      );
      return const DataSuccess(true);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<bool>> cancelFriendRequest({
    required String otherUserId,
  }) async {
    try {
      await supabaseFriendsDatasource.cancelFriendRequest(
        otherUserId: otherUserId,
      );
      return const DataSuccess(true);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
