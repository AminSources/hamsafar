import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      padding: EdgeInsets.all(20.w),
      radius: 16.r,
      color: context.colorScheme.surface,
      child: Column(
        children: [
          //* avatar
          CircleAvatar(
            radius: 40.r,
            backgroundColor: AppColors.avatars[0],
            child: txt(
              'س',
              color: Colors.white,
              fontWeight: FontWeight.w800,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 16.h),

          //* name
          txt('سارا محمدی', style: context.textTheme.headlineLarge),
          SizedBox(height: 4.h),

          //* username
          txt(
            '@sara_travel',
            style: context.textTheme.bodyMedium,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 20.h),

          //* stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //* rating stat
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: context.colorScheme.secondary,
                        size: 18.sp,
                      ),
                      SizedBox(width: 4.w),
                      txt('۴.۹', style: context.textTheme.titleMedium),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  txt(
                    'امتیاز من',
                    style: context.textTheme.bodySmall,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              SizedBox(width: 32.w),

              //* trips stat
              Column(
                children: [
                  txt('۱۲', style: context.textTheme.titleMedium),
                  SizedBox(height: 4.h),
                  txt(
                    'تعداد سفرها',
                    style: context.textTheme.bodySmall,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              SizedBox(width: 32.w),

              //* friends stat
              Column(
                children: [
                  txt('۸', style: context.textTheme.titleMedium),
                  SizedBox(height: 4.h),
                  txt(
                    'دوستان',
                    style: context.textTheme.bodySmall,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
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
