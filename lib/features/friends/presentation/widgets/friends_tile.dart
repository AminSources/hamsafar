import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/utils/avatar_color_util.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/widgets/hs_tile.dart';
import 'package:hamsafar/features/friends/enums/friend_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_recevied_req_button.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_remove_button.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_request_button.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_tile_info.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FriendsTile extends StatelessWidget {
  final String name;
  final String userName;
  final String rate;
  final int tripCount;
  final FriendType friendType;
  final bool? isSended;
  final ValueChanged<bool>? onSend;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onCancelRequest;
  final bool isActionLoading;

  const FriendsTile({
    super.key,
    required this.name,
    required this.userName,
    required this.rate,
    required this.tripCount,
    required this.friendType,
    this.isSended,
    this.onSend,
    this.onAccept,
    this.onReject,
    this.onCancelRequest,
    this.isActionLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final safeName = name.isEmpty ? '?' : name;

    return HsTile(
      onTap: () {
        context.push('/friend-profile');
      },
      child: Column(
        children: [
          Row(
            children: [
              HsAvatar(
                size: 44.w,
                label: txt(safeName[0], size: 16.sp),
                color: getAvatarColor(safeName),
                type: HsAvatarType.profile,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    txt(safeName, fontWeight: FontWeight.w800, size: 14.sp),
                    if (friendType == FriendType.alreadyFriend ||
                        friendType == FriendType.sentRequest) ...[
                      txt(
                        userName,
                        color: context.colorScheme.onSurfaceVariant,
                        size: 11.sp,
                      ),
                      SizedBox(height: 4.h),
                      FriendsTileInfo(rate: rate, tripCount: tripCount),
                    ] else
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12.w,
                        runSpacing: 4.h,
                        children: [
                          txt(
                            userName,
                            color: context.colorScheme.onSurfaceVariant,
                            size: 11.sp,
                          ),
                          FriendsTileInfo(rate: rate, tripCount: tripCount),
                        ],
                      ),
                  ],
                ),
              ),
              if (friendType == FriendType.alreadyFriend)
                const FriendsRemoveButton(),
              if (friendType == FriendType.sentRequest) ...[
                HsBadge(
                  label: 'در انتظار',
                  icon: LucideIcons.clock,
                  backgroundColor: context.colorScheme.onSecondaryContainer,
                  foregroundColor: context.colorScheme.secondaryContainer,
                ),
                if (onCancelRequest != null)
                  IconButton(
                    tooltip: 'لغو درخواست',
                    onPressed: isActionLoading ? null : onCancelRequest,
                    icon: isActionLoading
                        ? SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            Icons.close,
                            size: 18.sp,
                            color: context.colorScheme.error,
                          ),
                  ),
              ],
            ],
          ),
          if (friendType == FriendType.receivedRequest) ...[
            SizedBox(height: 12.h),
            FriendsReceviedReqButton(
              onAccept: onAccept,
              onReject: onReject,
              isLoading: isActionLoading,
            ),
          ],
          if (friendType == FriendType.searched) ...[
            SizedBox(height: 12.h),
            FriendsRequestButton(
              isSended: isSended ?? false,
              isLoading: isActionLoading,
              onSend: onSend ?? (value) {},
            ),
          ],
        ],
      ),
    );
  }
}
