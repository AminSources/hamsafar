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

  const FriendsTile({
    super.key,
    required this.name,
    required this.userName,
    required this.rate,
    required this.tripCount,
    required this.friendType,
    this.isSended,
    this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return HsTile(
      onTap: () {
        //? push to friend profile page
        context.push("/friend-profile");
      },
      child: Column(
        children: [
          Row(
            children: [
              //* avatar
              HsAvatar(
                size: 44.w,
                label: txt(name[0], size: 16.sp),
                color: getAvatarColor(name),
                type: HsAvatarType.profile,
              ),

              SizedBox(width: 12.w),

              //* friend info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* name
                  txt(name, fontWeight: FontWeight.w800, size: 14.sp),

                  if (friendType == FriendType.alreadyFriend ||
                      friendType == FriendType.sentRequest) ...[
                    //* username
                    txt(
                      userName,
                      color: context.colorScheme.onSurfaceVariant,
                      size: 11.sp,
                    ),

                    SizedBox(height: 4.h),

                    //* rating and trip count
                    FriendsTileInfo(rate: rate, tripCount: tripCount),
                  ] else
                    Row(
                      children: [
                        //* username
                        txt(
                          userName,
                          color: context.colorScheme.onSurfaceVariant,
                          size: 11.sp,
                        ),

                        SizedBox(width: 12.h),

                        //* rating and trip count
                        FriendsTileInfo(rate: rate, tripCount: tripCount),
                      ],
                    ),
                ],
              ),

              const Spacer(),

              //* tile button
              if (friendType == FriendType.alreadyFriend)
                const FriendsRemoveButton(),
              if (friendType == FriendType.sentRequest)
                HsBadge(
                  label: "در انتظار",
                  icon: LucideIcons.clock,
                  backgroundColor: context.colorScheme.onSecondaryContainer,
                  foregroundColor: context.colorScheme.secondaryContainer,
                ),
            ],
          ),

          //* tile button
          if (friendType == FriendType.receivedRequest) ...[
            SizedBox(height: 12.h),
            const FriendsReceviedReqButton(),
          ],
          if (friendType == FriendType.searched) ...[
            SizedBox(height: 12.h),
            FriendsRequestButton(
              isSended: isSended ?? false,
              onSend: isSended ?? false ? (value) {} : onSend ?? (value) {},
            ),
          ],
        ],
      ),
    );
  }
}
