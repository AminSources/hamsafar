import 'package:flutter_test/flutter_test.dart';
import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';
import 'package:hamsafar/features/friends/domain/repositories/friends_repository.dart';
import 'package:hamsafar/features/friends/domain/usecases/friend_request_usecases.dart';
import 'package:hamsafar/features/friends/domain/usecases/get_friend_profile_usecase.dart';
import 'package:hamsafar/features/friends/presentation/bloc/friend_profile_bloc.dart';

class _FakeFriendsRepository implements FriendsRepository {
  FriendEntity profile = const FriendEntity(
    id: 'friend-id',
    userName: 'traveler',
    firstName: 'Test',
    lastName: 'User',
    avatarIcon: 'tent',
    bio: 'Travel enthusiast',
    rate: 4.5,
    tripCount: 3,
    freeDays: ['sat', 'sun'],
    tools: [],
  );

  @override
  Future<DataState<FriendEntity>> getFriendProfile(String userId) async {
    if (userId != profile.id) return const DataFailed('profile_not_found');
    return DataSuccess(profile);
  }

  @override
  Future<DataState<bool>> sendFriendRequest(String receiverId) async =>
      const DataSuccess(true);

  @override
  Future<DataState<bool>> cancelFriendRequest({
    required String otherUserId,
  }) async => const DataSuccess(true);

  @override
  Future<DataState<bool>> respondToFriendRequest({
    required String otherUserId,
    required bool accept,
  }) async => const DataSuccess(true);

  @override
  Future<DataState<bool>> removeFriend(String friendId) async =>
      const DataSuccess(true);

  @override
  Future<DataState<List<FriendEntity>>> getFriends(NoParams noParams) async =>
      const DataSuccess<List<FriendEntity>>([]);

  @override
  Future<DataState<List<FriendEntity>>> searchUsers(String query) async =>
      const DataSuccess([]);

  @override
  Future<DataState<List<FriendEntity>>> getPendingFriendRequests({
    required bool incoming,
  }) async => const DataSuccess([]);
}

void main() {
  late _FakeFriendsRepository repository;
  late FriendProfileBloc bloc;

  setUp(() {
    repository = _FakeFriendsRepository();
    bloc = FriendProfileBloc(
      getFriendProfileUsecase: GetFriendProfileUsecase(
        friendsRepository: repository,
      ),
      sendFriendRequestUsecase: SendFriendRequestUsecase(
        friendsRepository: repository,
      ),
      cancelFriendRequestUsecase: CancelFriendRequestUsecase(
        friendsRepository: repository,
      ),
      respondToFriendRequestUsecase: RespondToFriendRequestUsecase(
        friendsRepository: repository,
      ),
      removeFriendUsecase: RemoveFriendUsecase(
        friendsRepository: repository,
      ),
    );
  });

  tearDown(() async {
    await bloc.close();
  });

  test('loads the full profile by user ID', () async {
    final resultFuture = bloc.stream.firstWhere(
      (state) => state is FriendProfileSuccess,
    );

    bloc.add(const FriendProfileLoadRequested('friend-id'));

    final result = (await resultFuture) as FriendProfileSuccess;
    expect(result.friend.userName, 'traveler');
    expect(result.friend.freeDays, ['sat', 'sun']);
    expect(result.friend.tools, isEmpty);
  });

  test('sends a friend request and updates relationship state', () async {
    final loadedFuture = bloc.stream.firstWhere(
      (state) => state is FriendProfileSuccess,
    );
    bloc.add(const FriendProfileLoadRequested('friend-id'));
    await loadedFuture;

    final updatedFuture = bloc.stream.firstWhere(
      (state) =>
          state is FriendProfileSuccess &&
          state.friend.relationStatus == 'outgoing_pending',
    );
    bloc.add(const FriendProfileSendRequestRequested());

    final updated = (await updatedFuture) as FriendProfileSuccess;
    expect(updated.isActionLoading, isFalse);
    expect(updated.actionError, isFalse);
    expect(updated.friend.relationStatus, 'outgoing_pending');
  });
}
