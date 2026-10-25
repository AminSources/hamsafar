import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/friends/enums/friend_type.dart';
import 'package:hamsafar/features/friends/presentation/bloc/friends_bloc.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_tile.dart';

class FriendsSearchPage extends StatefulWidget {
  const FriendsSearchPage({super.key});

  @override
  State<FriendsSearchPage> createState() => _FriendsSearchPageState();
}

class _FriendsSearchPageState extends State<FriendsSearchPage> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onQueryChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      context.read<FriendsBloc>().add(SearchFriendsEvent(query: value.trim()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FriendsBloc, FriendsState>(
      listener: (context, state) {
        if (state is FriendsSearchSuccess && state.actionMessage != null) {
          context.showHsSnackBar(
            text: state.actionMessage!,
            hsSnackBarType: state.actionError
                ? HsSnackBarType.error
                : HsSnackBarType.success,
          );
        } else if (state is FriendsSearchFailure) {
          context.showHsSnackBar(
            text: state.errorMessage,
            hsSnackBarType: HsSnackBarType.error,
          );
        }
      },
      child: Column(
        children: [
          TextField(
            controller: _controller,
            onChanged: _onQueryChanged,
            decoration: InputDecoration(
              hintText: 'جستجوی نام کاربری...',
              prefixIcon: Icon(
                Icons.search,
                size: 20.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          BlocBuilder<FriendsBloc, FriendsState>(
            builder: (context, state) {
              if (state is FriendsSearchLoading) {
                return const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is FriendsSearchFailure) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: txt(
                    state.errorMessage,
                    color: context.colorScheme.error,
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (state is! FriendsSearchSuccess) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: txt(
                    'برای جستجو، حداقل دو حرف از نام کاربری را وارد کنید.',
                    color: context.colorScheme.onSurfaceVariant,
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (state.query.length < 2) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: txt(
                    'برای جستجو، حداقل دو حرف از نام کاربری را وارد کنید.',
                    color: context.colorScheme.onSurfaceVariant,
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (state.users.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: txt(
                    'کاربری با این نام کاربری پیدا نشد.',
                    color: context.colorScheme.onSurfaceVariant,
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  final friendType = switch (user.relationStatus) {
                    'friends' => FriendType.alreadyFriend,
                    'incoming_pending' => FriendType.receivedRequest,
                    'outgoing_pending' => FriendType.sentRequest,
                    _ => FriendType.searched,
                  };
                  final busy = state.busyUserId == user.id;
                  final fullName = '\${user.firstName} \${user.lastName}'.trim();
                  final username = user.userName.startsWith('@')
                      ? user.userName
                      : '@\${user.userName}';

                  return Padding(
                    padding: EdgeInsets.only(top: index == 0 ? 0 : 8.h),
                    child: FriendsTile(
                      name: fullName.isEmpty ? user.userName : fullName,
                      userName: username,
                      rate: user.rate.toStringAsFixed(1),
                      tripCount: user.tripCount,
                      friendType: friendType,
                      isSended: user.relationStatus == 'outgoing_pending',
                      isActionLoading: busy,
                      onSend: friendType == FriendType.searched
                          ? (_) => context.read<FriendsBloc>().add(
                                SendFriendRequestEvent(receiverId: user.id),
                              )
                          : null,
                      onAccept: () => context.read<FriendsBloc>().add(
                        RespondToFriendRequestEvent(
                          otherUserId: user.id,
                          accept: true,
                        ),
                      ),
                      onReject: () => context.read<FriendsBloc>().add(
                        RespondToFriendRequestEvent(
                          otherUserId: user.id,
                          accept: false,
                        ),
                      ),
                      onCancelRequest: () => context.read<FriendsBloc>().add(
                        CancelFriendRequestEvent(otherUserId: user.id),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
