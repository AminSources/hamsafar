import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_button_type.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/friends/presentation/bloc/friend_profile_bloc.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_available_days_card.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_profile_about_card.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_profile_card.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_tools_card.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_request_button.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_recevied_req_button.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FriendProfilePage extends StatelessWidget {
  final String userId;

  const FriendProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FriendProfileBloc, FriendProfileState>(
      listener: (context, state) {
        if (state is FriendProfileSuccess && state.actionMessage != null) {
          context.showHsSnackBar(
            text: state.actionMessage!,
            hsSnackBarType: state.actionError
                ? HsSnackBarType.error
                : HsSnackBarType.success,
          );
        }
      },
      builder: (context, state) {
        if (state is FriendProfileInitial || state is FriendProfileLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is FriendProfileFailure) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        LucideIcons.userRoundX,
                        size: 44.sp,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(height: 16.h),
                      txt(
                        state.message,
                        textAlign: TextAlign.center,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(height: 20.h),
                      HsButton(
                        onTap: () => context.read<FriendProfileBloc>().add(
                          FriendProfileLoadRequested(userId),
                        ),
                        child: const txt('تلاش مجدد', color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        if (state is! FriendProfileSuccess) {
          return const Scaffold(body: SizedBox.shrink());
        }

        final friend = state.friend;
        final displayName = '${friend.firstName} ${friend.lastName}'.trim();
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HsAppBar(title: 'پروفایل دوست', hasBack: true),
                  SizedBox(height: 24.h),
                  FriendsProfileCard(
                    name: displayName.isEmpty ? friend.userName : displayName,
                    userName: friend.userName,
                    avatar: friend.avatarIcon,
                    tripCount: friend.tripCount,
                    rate: friend.rate,
                  ),
                  if (friend.bio.trim().isNotEmpty) ...[
                    SizedBox(height: 20.h),
                    FriendsProfileAboutCard(bio: friend.bio),
                  ],
                  if (friend.freeDays.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    FriendsAvailableDaysCard(freeDays: friend.freeDays),
                  ],
                  if (friend.tools.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    FriendsToolsCard(tools: friend.tools),
                  ],
                  SizedBox(height: 24.h),
                  _RelationshipActions(
                    relationStatus: friend.relationStatus,
                    isLoading: state.isActionLoading,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RelationshipActions extends StatelessWidget {
  final String relationStatus;
  final bool isLoading;

  const _RelationshipActions({
    required this.relationStatus,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FriendProfileBloc>();

    switch (relationStatus) {
      case 'friends':
        return HsButton(
          hsButtonType: HsButtonType.outline,
          borderColor: context.colorScheme.error,
          onTap: isLoading
              ? null
              : () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const txt('حذف دوست'),
                      content: const txt(
                        'آیا مطمئن هستید که می‌خواهید این کاربر را از فهرست دوستان حذف کنید؟',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(dialogContext).pop(false),
                          child: const txt('انصراف'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(dialogContext).pop(true),
                          child: const txt('حذف'),
                        ),
                      ],
                    ),
                  );
                  if (confirmed == true && context.mounted) {
                    bloc.add(const FriendProfileRemoveFriendRequested());
                  }
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Icon(
                  LucideIcons.userRoundMinus,
                  size: 18.sp,
                  color: context.colorScheme.error,
                ),
              SizedBox(width: 8.w),
              txt(
                'حذف دوست',
                color: context.colorScheme.error,
                fontWeight: FontWeight.w800,
              ),
            ],
          ),
        );
      case 'none':
        return FriendsRequestButton(
          isSended: false,
          isLoading: isLoading,
          onSend: (_) => bloc.add(const FriendProfileSendRequestRequested()),
        );
      case 'outgoing_pending':
        return HsButton(
          hsButtonType: HsButtonType.outline,
          onTap: isLoading
              ? null
              : () => bloc.add(const FriendProfileCancelRequestRequested()),
          child: isLoading
              ? SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                )
              : const txt('لغو درخواست دوستی'),
        );
      case 'incoming_pending':
        return FriendsReceviedReqButton(
          isLoading: isLoading,
          onAccept: () => bloc.add(
            const FriendProfileRequestResponseRequested(accept: true),
          ),
          onReject: () => bloc.add(
            const FriendProfileRequestResponseRequested(accept: false),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
