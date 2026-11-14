import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/utils/avatar_color_util.dart';
import 'package:hamsafar/core/utils/avatar_converter.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class FriendsProfileCard extends StatelessWidget {
  final String name;
  final String userName;
  final String avatar;
  final int tripCount;
  final double rate;

  const FriendsProfileCard({
    super.key,
    required this.name,
    required this.userName,
    required this.avatar,
    required this.tripCount,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      padding: EdgeInsets.all(20.w),
      radius: 20.r,
      color: context.colorScheme.surface,
      child: Column(
        children: [
          //* avatar
          CircleAvatar(
            radius: 40.r,
            backgroundColor: getAvatarColor(name),
            child: Icon(AvatarConverter.stringToIconData(avatarName: avatar)),
          ),

          SizedBox(height: 16.h),

          //* name
          txt(name, fontWeight: FontWeight.w900, size: 20.sp),

          SizedBox(height: 4.h),

          //* username and friend since
          txt(
            '@$userName',
            color: context.colorScheme.onSurfaceVariant,
            size: 12.sp,
          ),

          SizedBox(height: 16.h),

          //* stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //* rating stat
              Column(
                children: [
                  txt(
                    rate.toString(),
                    fontWeight: FontWeight.w900,
                    size: 18.sp,
                  ),
                  SizedBox(height: 4.h),
                  txt(
                    'امتیاز',
                    color: context.colorScheme.onSurfaceVariant,
                    size: 11.sp,
                  ),
                ],
              ),

              //* divider
              Container(
                width: 1.w,
                height: 30.h,
                color: context.colorScheme.outline,
              ),

              //* trips stat
              Column(
                children: [
                  txt(
                    tripCount.toString(),
                    fontWeight: FontWeight.w900,
                    size: 18.sp,
                  ),
                  SizedBox(height: 4.h),
                  txt(
                    'تعداد سفرها',
                    color: context.colorScheme.onSurfaceVariant,
                    size: 11.sp,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
