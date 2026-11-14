import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/core/usecase/usecase.dart';
import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';
import 'package:hamsafar/features/friends/domain/repositories/friends_repository.dart';

class GetFriendProfileUsecase
    implements Usecase<DataState<FriendEntity>, String> {
  final FriendsRepository friendsRepository;

  GetFriendProfileUsecase({required this.friendsRepository});

  @override
  Future<DataState<FriendEntity>> call(String userId) {
    return friendsRepository.getFriendProfile(userId);
  }
}
