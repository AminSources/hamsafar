import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/core/usecase/usecase.dart';
import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';
import 'package:hamsafar/features/friends/domain/repositories/friends_repository.dart';

class GetFriendsUsecase
    implements Usecase<DataState<List<FriendEntity>>, NoParams> {
  final FriendsRepository friendsRepository;

  GetFriendsUsecase({required this.friendsRepository});

  @override
  Future<DataState<List<FriendEntity>>> call(NoParams params) {
    return friendsRepository.getFriends(params);
  }
}
