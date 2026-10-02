import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';

abstract class FriendsRepository {
  Future<DataState<List<FriendEntity>>> getFriends(NoParams noParams);
}
