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
        for (final friend in response)
          FriendModel.fromJson(friend['profiles'] as Map<String, dynamic>),
      ];

      return DataSuccess(data);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
