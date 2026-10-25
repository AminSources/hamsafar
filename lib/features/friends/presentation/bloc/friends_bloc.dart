import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';
import 'package:hamsafar/features/friends/domain/usecases/friend_request_usecases.dart';
import 'package:hamsafar/features/friends/domain/usecases/get_friends_usecase.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final GetFriendsUsecase getFriendsUsecase;
  final SearchFriendsUsecase searchFriendsUsecase;
  final GetPendingFriendRequestsUsecase getPendingFriendRequestsUsecase;
  final SendFriendRequestUsecase sendFriendRequestUsecase;
  final RespondToFriendRequestUsecase respondToFriendRequestUsecase;
  final CancelFriendRequestUsecase cancelFriendRequestUsecase;

  int _searchRequestVersion = 0;
  String _latestSearchQuery = '';

  FriendsBloc({
    required this.getFriendsUsecase,
    required this.searchFriendsUsecase,
    required this.getPendingFriendRequestsUsecase,
    required this.sendFriendRequestUsecase,
    required this.respondToFriendRequestUsecase,
    required this.cancelFriendRequestUsecase,
  }) : super(FriendsInitial()) {
    on<GetFriendsEvent>(_getFriends);
    on<SearchFriendsEvent>(_searchFriends);
    on<GetFriendRequestsEvent>(_getFriendRequests);
    on<SendFriendRequestEvent>(_sendFriendRequest);
    on<RespondToFriendRequestEvent>(_respondToFriendRequest);
    on<CancelFriendRequestEvent>(_cancelFriendRequest);
  }

  Future<void> _getFriends(
    GetFriendsEvent event,
    Emitter<FriendsState> emit,
  ) async {
    emit(FriendsLoading());
    final result = await getFriendsUsecase(NoParams());
    if (result is DataSuccess) {
      emit(FriendsSuccess(friends: result.data!));
    } else if (result is DataFailed) {
      emit(FriendsFailure(errorMessage: _friendlyError(result.message ?? '')));
    }
  }

  Future<void> _searchFriends(
    SearchFriendsEvent event,
    Emitter<FriendsState> emit,
  ) async {
    final query = event.query.trim();
    _latestSearchQuery = query;
    final version = ++_searchRequestVersion;

    if (query.length < 2) {
      emit(FriendsSearchSuccess(query: query, users: const []));
      return;
    }

    emit(FriendsSearchLoading());
    final result = await searchFriendsUsecase(query);
    if (version != _searchRequestVersion) return;

    if (result is DataSuccess) {
      emit(FriendsSearchSuccess(query: query, users: result.data!));
    } else if (result is DataFailed) {
      emit(FriendsSearchFailure(
        errorMessage: _friendlyError(result.message ?? ''),
      ));
    }
  }

  Future<void> _getFriendRequests(
    GetFriendRequestsEvent event,
    Emitter<FriendsState> emit,
  ) async {
    emit(FriendsRequestsLoading());
    await _refreshRequests(emit);
  }

  Future<void> _refreshRequests(
    Emitter<FriendsState> emit, {
    String? actionMessage,
  }) async {
    final incomingResult = await getPendingFriendRequestsUsecase(true);
    final outgoingResult = await getPendingFriendRequestsUsecase(false);

    if (incomingResult is DataSuccess && outgoingResult is DataSuccess) {
      emit(FriendsRequestsSuccess(
        incoming: incomingResult.data!,
        outgoing: outgoingResult.data!,
        actionMessage: actionMessage,
      ));
      return;
    }

    final errorMessage = incomingResult is DataFailed
        ? incomingResult.message
        : outgoingResult is DataFailed
            ? outgoingResult.message
            : null;
    emit(FriendsRequestsFailure(
      errorMessage: _friendlyError(errorMessage ?? ''),
    ));
  }

  Future<void> _sendFriendRequest(
    SendFriendRequestEvent event,
    Emitter<FriendsState> emit,
  ) async {
    final previous = state;
    if (previous is! FriendsSearchSuccess) return;

    emit(FriendsSearchSuccess(
      query: previous.query,
      users: previous.users,
      busyUserId: event.receiverId,
    ));

    final result = await sendFriendRequestUsecase(event.receiverId);
    final activeState = state;
    if (_latestSearchQuery != previous.query ||
        activeState is! FriendsSearchSuccess ||
        activeState.query != previous.query ||
        activeState.busyUserId != event.receiverId) {
      return;
    }

    if (result is DataSuccess) {
      final refreshed = await searchFriendsUsecase(previous.query);
      final refreshedState = state;
      if (_latestSearchQuery != previous.query ||
          refreshedState is! FriendsSearchSuccess ||
          refreshedState.query != previous.query ||
          refreshedState.busyUserId != event.receiverId) {
        return;
      }
      emit(FriendsSearchSuccess(
        query: previous.query,
        users: refreshed is DataSuccess ? refreshed.data! : previous.users,
        actionMessage: 'درخواست دوستی ارسال شد.',
      ));
    } else {
      emit(FriendsSearchSuccess(
        query: previous.query,
        users: previous.users,
        actionMessage: _friendlyError(
          result is DataFailed ? result.message ?? '' : '',
        ),
        actionError: true,
      ));
    }
  }

  Future<void> _respondToFriendRequest(
    RespondToFriendRequestEvent event,
    Emitter<FriendsState> emit,
  ) async {
    final previous = state;
    if (previous is FriendsSearchSuccess) {
      emit(FriendsSearchSuccess(
        query: previous.query,
        users: previous.users,
        busyUserId: event.otherUserId,
      ));
    } else if (previous is FriendsRequestsSuccess) {
      emit(FriendsRequestsSuccess(
        incoming: previous.incoming,
        outgoing: previous.outgoing,
        busyUserId: event.otherUserId,
      ));
    }

    final result = await respondToFriendRequestUsecase(
      RespondToFriendRequestParams(
        otherUserId: event.otherUserId,
        accept: event.accept,
      ),
    );

    if (previous is FriendsSearchSuccess) {
      final activeState = state;
      if (_latestSearchQuery != previous.query ||
          activeState is! FriendsSearchSuccess ||
          activeState.query != previous.query ||
          activeState.busyUserId != event.otherUserId) {
        return;
      }
      if (result is DataSuccess) {
        final refreshed = await searchFriendsUsecase(previous.query);
        final refreshedState = state;
        if (_latestSearchQuery != previous.query ||
            refreshedState is! FriendsSearchSuccess ||
            refreshedState.query != previous.query ||
            refreshedState.busyUserId != event.otherUserId) {
          return;
        }
        emit(FriendsSearchSuccess(
          query: previous.query,
          users: refreshed is DataSuccess ? refreshed.data! : previous.users,
          actionMessage: event.accept
              ? 'درخواست دوستی پذیرفته شد.'
              : 'درخواست دوستی رد شد.',
        ));
      } else {
        emit(FriendsSearchSuccess(
          query: previous.query,
          users: previous.users,
          actionMessage: _friendlyError(
            result is DataFailed ? result.message ?? '' : '',
          ),
          actionError: true,
        ));
      }
      return;
    }

    if (previous is FriendsRequestsSuccess) {
      final activeState = state;
      if (activeState is! FriendsRequestsSuccess ||
          activeState.busyUserId != event.otherUserId) {
        return;
      }
      if (result is DataSuccess) {
        await _refreshRequests(
          emit,
          actionMessage: event.accept
              ? 'درخواست دوستی پذیرفته شد.'
              : 'درخواست دوستی رد شد.',
        );
      } else {
        emit(FriendsRequestsSuccess(
          incoming: previous.incoming,
          outgoing: previous.outgoing,
          actionMessage: _friendlyError(
            result is DataFailed ? result.message ?? '' : '',
          ),
          actionError: true,
        ));
      }
      return;
    }

    if (result is DataSuccess) add(GetFriendRequestsEvent());
  }

  Future<void> _cancelFriendRequest(
    CancelFriendRequestEvent event,
    Emitter<FriendsState> emit,
  ) async {
    final previous = state;
    if (previous is FriendsSearchSuccess) {
      emit(FriendsSearchSuccess(
        query: previous.query,
        users: previous.users,
        busyUserId: event.otherUserId,
      ));
    } else if (previous is FriendsRequestsSuccess) {
      emit(FriendsRequestsSuccess(
        incoming: previous.incoming,
        outgoing: previous.outgoing,
        busyUserId: event.otherUserId,
      ));
    }

    final result = await cancelFriendRequestUsecase(event.otherUserId);

    if (previous is FriendsSearchSuccess) {
      final activeState = state;
      if (_latestSearchQuery != previous.query ||
          activeState is! FriendsSearchSuccess ||
          activeState.query != previous.query ||
          activeState.busyUserId != event.otherUserId) {
        return;
      }
      if (result is DataSuccess) {
        final refreshed = await searchFriendsUsecase(previous.query);
        final refreshedState = state;
        if (_latestSearchQuery != previous.query ||
            refreshedState is! FriendsSearchSuccess ||
            refreshedState.query != previous.query ||
            refreshedState.busyUserId != event.otherUserId) {
          return;
        }
        emit(FriendsSearchSuccess(
          query: previous.query,
          users: refreshed is DataSuccess ? refreshed.data! : previous.users,
          actionMessage: 'درخواست ارسالی لغو شد.',
        ));
      } else {
        emit(FriendsSearchSuccess(
          query: previous.query,
          users: previous.users,
          actionMessage: _friendlyError(
            result is DataFailed ? result.message ?? '' : '',
          ),
          actionError: true,
        ));
      }
      return;
    }

    if (previous is FriendsRequestsSuccess) {
      if (result is DataSuccess) {
        await _refreshRequests(
          emit,
          actionMessage: 'درخواست ارسالی لغو شد.',
        );
      } else {
        emit(FriendsRequestsSuccess(
          incoming: previous.incoming,
          outgoing: previous.outgoing,
          actionMessage: _friendlyError(
            result is DataFailed ? result.message ?? '' : '',
          ),
          actionError: true,
        ));
      }
      return;
    }

    if (result is DataSuccess) add(GetFriendRequestsEvent());
  }

  String _friendlyError(String raw) {
    final message = raw.toLowerCase();
    if (message.contains('not_authenticated') ||
        message.contains('not authenticated')) {
      return 'برای انجام این کار ابتدا وارد حساب خود شوید.';
    }
    if (message.contains('already_friends')) {
      return 'شما از قبل با این کاربر دوست هستید.';
    }
    if (message.contains('incoming_request_exists')) {
      return 'این کاربر قبلاً برای شما درخواست فرستاده است.';
    }
    if (message.contains('request_already_pending') ||
        message.contains('friend_requests_unique_pending_pair')) {
      return 'یک درخواست دوستی در انتظار پاسخ است.';
    }
    if (message.contains('pending_incoming_request_not_found') ||
        message.contains('pending_outgoing_request_not_found') ||
        message.contains('request_not_found')) {
      return 'این درخواست دیگر در انتظار پاسخ نیست.';
    }
    if (message.contains('receiver_not_found') ||
        message.contains('invalid_receiver')) {
      return 'کاربر انتخاب‌شده معتبر نیست.';
    }
    return 'عملیات انجام نشد. لطفاً دوباره تلاش کنید.';
  }
}
