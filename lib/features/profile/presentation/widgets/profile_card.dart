import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/utils/avatar_color_util.dart';
import 'package:hamsafar/core/utils/avatar_converter.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/profile/domain/entities/profile_entity.dart';
import 'package:hamsafar/features/profile/presentation/widgets/profile_summary.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProfileCard extends StatelessWidget {
  final ProfileEntity profileInfo;

  const ProfileCard({super.key, required this.profileInfo});

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      padding: EdgeInsets.all(20.w),
      radius: 16.r,
      color: context.colorScheme.surface,
      child: Column(
        children: [
          //* avatar
          HsAvatar(
            size: 70.w,
            label: Icon(
              AvatarConverter.stringToIconData(
                avatarName: profileInfo.avatarIcon,
              ),
              size: 30.sp,
            ),
            color: getAvatarColor(profileInfo.firstName + profileInfo.lastName),
            type: HsAvatarType.profile,
          ),
          SizedBox(height: 16.h),

          //* name
          txt(
            '${profileInfo.firstName} ${profileInfo.lastName}',
            style: context.textTheme.headlineLarge,
          ),
          SizedBox(height: 4.h),

          //* username
          txt(
            '@${profileInfo.userName}',
            style: context.textTheme.bodyMedium,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 20.h),

          //* stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //* rating stat
              ProfileSummary(
                value: profileInfo.rate.toString(),
                title: "امتیاز من",
                icon: Icons.star_rounded,
                iconColor: context.colorScheme.secondary,
              ),
              SizedBox(width: 32.w),

              //* trips stat
              ProfileSummary(
                value: profileInfo.tripCount.toString(),
                title: 'تعداد سفرها',
                icon: LucideIcons.mapPinCheck,
              ),
              SizedBox(width: 32.w),

              //* friends stat
              ProfileSummary(
                value: profileInfo.friendCount.toString(),
                title: 'دوستان',
                icon: LucideIcons.usersRound,
              ),
            ],
          ),
          SizedBox(height: 20.h),

          //* edit profile button
          SizedBox(
            width: double.infinity,
            height: 46.h,
            child: OutlinedButton(
              onPressed: () {},
              child: txt('ویرایش پروفایل', style: context.textTheme.labelLarge),
            ),
          ),
        ],
      ),
    );
  }
}
