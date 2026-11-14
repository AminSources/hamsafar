import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';
import 'package:hamsafar/features/friends/domain/usecases/friend_request_usecases.dart';
import 'package:hamsafar/features/friends/domain/usecases/get_friend_profile_usecase.dart';

part 'friend_profile_event.dart';
part 'friend_profile_state.dart';

class FriendProfileBloc extends Bloc<FriendProfileEvent, FriendProfileState> {
  final GetFriendProfileUsecase getFriendProfileUsecase;
  final SendFriendRequestUsecase sendFriendRequestUsecase;
  final CancelFriendRequestUsecase cancelFriendRequestUsecase;
  final RespondToFriendRequestUsecase respondToFriendRequestUsecase;
  final RemoveFriendUsecase removeFriendUsecase;

  FriendProfileBloc({
    required this.getFriendProfileUsecase,
    required this.sendFriendRequestUsecase,
    required this.cancelFriendRequestUsecase,
    required this.respondToFriendRequestUsecase,
    required this.removeFriendUsecase,
  }) : super(const FriendProfileInitial()) {
    on<FriendProfileLoadRequested>(_onLoad);
    on<FriendProfileSendRequestRequested>(_onSendRequest);
    on<FriendProfileCancelRequestRequested>(_onCancelRequest);
    on<FriendProfileRequestResponseRequested>(_onRespondToRequest);
    on<FriendProfileRemoveFriendRequested>(_onRemoveFriend);
  }

  Future<void> _onLoad(
    FriendProfileLoadRequested event,
    Emitter<FriendProfileState> emit,
  ) async {
    emit(const FriendProfileLoading());
    final result = await getFriendProfileUsecase(event.userId);
    if (result is DataSuccess<FriendEntity> && result.data != null) {
      emit(FriendProfileSuccess(friend: result.data!));
    } else {
      emit(FriendProfileFailure(
        message: _friendlyError(
          result is DataFailed ? result.message ?? '' : '',
        ),
      ));
    }
  }

  Future<void> _onSendRequest(
    FriendProfileSendRequestRequested event,
    Emitter<FriendProfileState> emit,
  ) {
    return _performRelationshipAction(
      emit,
      action: (userId) => sendFriendRequestUsecase(userId),
      nextRelationStatus: 'outgoing_pending',
      successMessage: 'درخواست دوستی ارسال شد.',
    );
  }

  Future<void> _onCancelRequest(
    FriendProfileCancelRequestRequested event,
    Emitter<FriendProfileState> emit,
  ) {
    return _performRelationshipAction(
      emit,
      action: (userId) => cancelFriendRequestUsecase(userId),
      nextRelationStatus: 'none',
      successMessage: 'درخواست دوستی لغو شد.',
    );
  }

  Future<void> _onRespondToRequest(
    FriendProfileRequestResponseRequested event,
    Emitter<FriendProfileState> emit,
  ) {
    return _performRelationshipAction(
      emit,
      action: (userId) => respondToFriendRequestUsecase(
        RespondToFriendRequestParams(
          otherUserId: userId,
          accept: event.accept,
        ),
      ),
      nextRelationStatus: event.accept ? 'friends' : 'none',
      successMessage: event.accept
          ? 'درخواست دوستی پذیرفته شد.'
          : 'درخواست دوستی رد شد.',
    );
  }

  Future<void> _onRemoveFriend(
    FriendProfileRemoveFriendRequested event,
    Emitter<FriendProfileState> emit,
  ) {
    return _performRelationshipAction(
      emit,
      action: (userId) => removeFriendUsecase(userId),
      nextRelationStatus: 'none',
      successMessage: 'دوست از فهرست شما حذف شد.',
    );
  }

  Future<void> _performRelationshipAction(
    Emitter<FriendProfileState> emit, {
    required Future<DataState<bool>> Function(String userId) action,
    required String nextRelationStatus,
    required String successMessage,
  }) async {
    final current = state;
    if (current is! FriendProfileSuccess || current.isActionLoading) return;

    emit(current.copyWith(
      isActionLoading: true,
      clearActionMessage: true,
    ));

    try {
      final result = await action(current.friend.id);
      final latest = state;
      if (latest is! FriendProfileSuccess ||
          latest.friend.id != current.friend.id) {
        return;
      }

      if (result is DataSuccess<bool>) {
        emit(latest.copyWith(
          friend: latest.friend.copyWith(relationStatus: nextRelationStatus),
          isActionLoading: false,
          actionMessage: successMessage,
          actionError: false,
        ));
      } else {
        emit(latest.copyWith(
          isActionLoading: false,
          actionMessage: _friendlyError(
            result is DataFailed ? result.message ?? '' : '',
          ),
          actionError: true,
        ));
      }
    } catch (_) {
      final latest = state;
      if (latest is FriendProfileSuccess) {
        emit(latest.copyWith(
          isActionLoading: false,
          actionMessage: 'عملیات انجام نشد. دوباره تلاش کنید.',
          actionError: true,
        ));
      }
    }
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
    if (message.contains('friendship_not_found')) {
      return 'این کاربر دیگر در فهرست دوستان شما نیست.';
    }
    if (message.contains('profile_not_accessible')) {
      return 'دسترسی به اطلاعات این کاربر امکان‌پذیر نیست.';
    }
    return 'عملیات انجام نشد. لطفاً دوباره تلاش کنید.';
  }
}
