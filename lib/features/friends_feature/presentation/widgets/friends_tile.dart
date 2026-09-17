import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/features/friends_feature/enums/friend_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/friends_feature/presentation/widgets/friends_recevied_req_button.dart';
import 'package:hamsafar/features/friends_feature/presentation/widgets/friends_remove_button.dart';
import 'package:hamsafar/features/friends_feature/presentation/widgets/friends_request_button.dart';
import 'package:hamsafar/features/friends_feature/presentation/widgets/friends_tile_info.dart';

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
    return HsContainer(
      padding: EdgeInsets.all(16.w),
      radius: 16.r,
      color: context.colorScheme.surface,
      onTap: () {
        //? push to friend profile page
        context.push("/friend-profile");
      },
      child: Column(
        children: [
          Row(
            children: [
              //* avatar
              CircleAvatar(
                radius: 25.r,
                backgroundColor: AppColors.avatars[1],
                child: txt(
                  name[0],
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  size: 18.sp,
                ),
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
