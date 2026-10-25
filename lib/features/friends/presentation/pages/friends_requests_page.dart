import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_note_type.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_error.dart';
import 'package:hamsafar/core/widgets/hs_header.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/friends/enums/friend_type.dart';
import 'package:hamsafar/features/friends/presentation/bloc/friends_bloc.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_tile.dart';

class FriendsRequestsPage extends StatefulWidget {
  const FriendsRequestsPage({super.key});

  @override
  State<FriendsRequestsPage> createState() => _FriendsRequestsPageState();
}

class _FriendsRequestsPageState extends State<FriendsRequestsPage> {
  @override
  void initState() {
    super.initState();
    context.read<FriendsBloc>().add(GetFriendRequestsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FriendsBloc, FriendsState>(
      listener: (context, state) {
        if (state is FriendsRequestsSuccess && state.actionMessage != null) {
          context.showHsSnackBar(
            text: state.actionMessage!,
            hsSnackBarType: state.actionError
                ? HsSnackBarType.error
                : HsSnackBarType.success,
          );
        } else if (state is FriendsRequestsFailure) {
          context.showHsSnackBar(
            text: state.errorMessage,
            hsSnackBarType: HsSnackBarType.error,
          );
        }
      },
      child: BlocBuilder<FriendsBloc, FriendsState>(
        builder: (context, state) {
          if (state is FriendsRequestsLoading) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is FriendsRequestsFailure) {
            return HsError(
              illustrationPath: 'lib/assets/images/error.svg',
              title: state.errorMessage,
              subtitle: 'برای بارگذاری دوباره، این بخش را مجدداً باز کنید.',
            );
          }

          if (state is! FriendsRequestsSuccess) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HsHeader(title: 'دریافتی (${state.incoming.length})'),
              SizedBox(height: 12.h),
              if (state.incoming.isEmpty)
                _emptyMessage(context, 'درخواست دریافتیِ در انتظاری ندارید.')
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.incoming.length,
                  itemBuilder: (context, index) {
                    final user = state.incoming[index];

                    return Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 0 : 8.h),
                      child: FriendsTile(
                        friendEntity: user,
                        friendType: FriendType.receivedRequest,
                        isActionLoading: state.busyUserId == user.id,
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
                      ),
                    );
                  },
                ),
              SizedBox(height: 24.h),
              HsHeader(title: 'درخواست‌های ارسالی'),
              SizedBox(height: 12.h),
              if (state.outgoing.isEmpty)
                _emptyMessage(context, 'درخواست ارسالیِ در انتظاری ندارید.')
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.outgoing.length,
                  itemBuilder: (context, index) {
                    final user = state.outgoing[index];

                    return Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 0 : 8.h),
                      child: FriendsTile(
                        friendEntity: user,
                        friendType: FriendType.sentRequest,
                        isActionLoading: state.busyUserId == user.id,
                        onCancelRequest: () => context.read<FriendsBloc>().add(
                          CancelFriendRequestEvent(otherUserId: user.id),
                        ),
                      ),
                    );
                  },
                ),
              SizedBox(height: 16.h),
              const HsNote(
                note:
                    'پس از پذیرفته شدن درخواست، دوست به لیست «دوستان من» اضافه می‌شود',
                noteMode: HsNoteType.success,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _emptyMessage(BuildContext context, String message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: SizedBox(
        width: double.infinity,
        child: txt(
          message,
          color: context.colorScheme.onSurfaceVariant,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
