import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class FriendsProfileCard extends StatelessWidget {
  const FriendsProfileCard({super.key});

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
            backgroundColor: AppColors.avatars[1],
            child: txt(
              'ن',
              color: Colors.white,
              fontWeight: FontWeight.w900,
              size: 28.sp,
            ),
          ),

          SizedBox(height: 16.h),

          //* name
          txt('نگار احمدی', fontWeight: FontWeight.w900, size: 20.sp),

          SizedBox(height: 4.h),

          //* username and friend since
          txt(
            '@negar_a · دوست از ۱۴۰۲',
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
                  txt('۴.۹', fontWeight: FontWeight.w900, size: 18.sp),
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
                  txt('۸', fontWeight: FontWeight.w900, size: 18.sp),
                  SizedBox(height: 4.h),
                  txt(
                    'تعداد سفرها',
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

              //* mutual friends stat
              Column(
                children: [
                  txt('۳', fontWeight: FontWeight.w900, size: 18.sp),
                  SizedBox(height: 4.h),
                  txt(
                    'دوست مشترک',
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
