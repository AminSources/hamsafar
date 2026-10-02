import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';
import 'package:hamsafar/features/friends/domain/usecases/get_friends_usecase.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final GetFriendsUsecase getFriendsUsecase;

  FriendsBloc({required this.getFriendsUsecase}) : super(FriendsInitial()) {
    on<FriendsEvent>((event, emit) {});
    on<GetFriendsEvent>(getFriends);
  }

  void getFriends(GetFriendsEvent event, emit) async {
    emit(FriendsLoading());

    final result = await getFriendsUsecase(NoParams());
    if (result is DataSuccess) {
      emit(FriendsSuccess(friends: result.data!));
    } else if (result is DataFailed) {
      emit(FriendsFailure(errorMessage: result.message!));
    }
  }
}
