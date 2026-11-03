import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_button_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';
import 'package:hamsafar/features/friends/presentation/bloc/friends_bloc.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_available_days_card.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_profile_about_card.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_profile_card.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_tools_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FriendProfilePage extends StatelessWidget {
  final FriendEntity friendEntity;

  const FriendProfilePage({super.key, required this.friendEntity});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FriendsBloc, FriendsState>(
      listener: (context, state) {
        final removedSuccessfully =
            (state is FriendsSuccess &&
                state.actionMessage != null &&
                !state.actionError) ||
            (state is FriendsSearchSuccess &&
                state.actionMessage != null &&
                !state.actionError);

        if (removedSuccessfully && context.canPop()) {
          context.pop();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HsAppBar(title: 'پروفایل دوست', hasBack: true),
                SizedBox(height: 24.h),
                FriendsProfileCard(
                  name: "${friendEntity.firstName} ${friendEntity.lastName}",
                  userName: friendEntity.userName,
                  avatar: friendEntity.avatarIcon,
                  tripCount: friendEntity.tripCount,
                  rate: friendEntity.rate,
                ),
                SizedBox(height: 20.h),
                FriendsProfileAboutCard(bio: friendEntity.bio),
                SizedBox(height: 16.h),
                FriendsAvailableDaysCard(freeDays: friendEntity.freeDays),
                SizedBox(height: 16.h),
                FriendsToolsCard(tools: friendEntity.tools),
                SizedBox(height: 24.h),
                if (friendEntity.relationStatus == 'friends') ...[
                  BlocBuilder<FriendsBloc, FriendsState>(
                    builder: (context, state) {
                      final isRemoving =
                          (state is FriendsSuccess &&
                              state.busyUserId == friendEntity.id) ||
                          (state is FriendsSearchSuccess &&
                              state.busyUserId == friendEntity.id);

                      return HsButton(
                        hsButtonType: HsButtonType.outline,
                        borderColor: context.colorScheme.error,
                        onTap: isRemoving
                            ? null
                            : () async {
                                final confirmed = await showDialog<bool>(
                                  context: context,
                                  builder: (dialogContext) => AlertDialog(
                                    title: const Text('حذف دوست'),
                                    content: const Text(
                                      'آیا مطمئن هستید که می‌خواهید این کاربر را از فهرست دوستان حذف کنید؟',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(
                                          dialogContext,
                                        ).pop(false),
                                        child: const Text('انصراف'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(
                                          dialogContext,
                                        ).pop(true),
                                        child: const Text('حذف'),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirmed == true && context.mounted) {
                                  context.read<FriendsBloc>().add(
                                    RemoveFriendEvent(
                                      friendId: friendEntity.id,
                                    ),
                                  );
                                }
                              },
                        child: Row(
                          spacing: 8.w,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isRemoving)
                              SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            else
                              Icon(
                                LucideIcons.userRoundMinus,
                                size: 20.sp,
                                color: context.colorScheme.error,
                              ),
                            txt(
                              'حذف دوست',
                              color: context.colorScheme.error,
                              fontWeight: FontWeight.w800,
                              size: 14.sp,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
