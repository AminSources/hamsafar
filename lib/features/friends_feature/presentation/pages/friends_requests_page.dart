import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class FriendsRequestsPage extends StatelessWidget {
  const FriendsRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* requests content section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* received requests section
            txt('دریافتی (۲)', fontWeight: FontWeight.w800, size: 14.sp),

            SizedBox(height: 12.h),

            //* received request 1
            HsContainer(
              padding: EdgeInsets.all(16.w),
              radius: 16.r,
              color: context.colorScheme.surface,
              child: Row(
                children: [
                  //* avatar
                  CircleAvatar(
                    radius: 25.r,
                    backgroundColor: AppColors.avatars[4],
                    child: txt(
                      'ر',
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      size: 18.sp,
                    ),
                  ),

                  SizedBox(width: 12.w),

                  //* request info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        txt(
                          'رضا قاسمی',
                          fontWeight: FontWeight.w800,
                          size: 14.sp,
                        ),
                        SizedBox(height: 4.h),
                        txt(
                          '@reza_q · ۲ ساعت پیش',
                          color: context.colorScheme.onSurfaceVariant,
                          size: 11.sp,
                        ),
                      ],
                    ),
                  ),

                  //* accept button
                  HsButton(
                    width: 80.w,
                    height: 36.h,
                    child: txt(
                      'پذیرفتن',
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                      size: 11.sp,
                    ),
                  ),

                  SizedBox(width: 8.w),

                  //* reject button
                  HsContainer(
                    width: 36.w,
                    height: 36.w,
                    radius: 10.r,
                    color: context.colorScheme.errorContainer,
                    onTap: () {},
                    child: Icon(
                      Icons.close_rounded,
                      size: 18.sp,
                      color: context.colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            //* received request 2
            HsContainer(
              padding: EdgeInsets.all(16.w),
              radius: 16.r,
              color: context.colorScheme.surface,
              child: Row(
                children: [
                  //* avatar
                  CircleAvatar(
                    radius: 25.r,
                    backgroundColor: AppColors.avatars[5],
                    child: txt(
                      'ا',
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      size: 18.sp,
                    ),
                  ),

                  SizedBox(width: 12.w),

                  //* request info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        txt(
                          'الناز شریفی',
                          fontWeight: FontWeight.w800,
                          size: 14.sp,
                        ),
                        SizedBox(height: 4.h),
                        txt(
                          '@elnaz_sh · ۱ روز پیش',
                          color: context.colorScheme.onSurfaceVariant,
                          size: 11.sp,
                        ),
                      ],
                    ),
                  ),

                  //* accept button
                  HsButton(
                    width: 80.w,
                    height: 36.h,
                    child: txt(
                      'پذیرفتن',
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                      size: 11.sp,
                    ),
                  ),

                  SizedBox(width: 8.w),

                  //* reject button
                  HsContainer(
                    width: 36.w,
                    height: 36.w,
                    radius: 10.r,
                    color: context.colorScheme.errorContainer,
                    onTap: () {},
                    child: Icon(
                      Icons.close_rounded,
                      size: 18.sp,
                      color: context.colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            //* sent requests section
            txt('درخواست‌های ارسالی', fontWeight: FontWeight.w800, size: 14.sp),

            SizedBox(height: 12.h),

            //* sent request 1
            HsContainer(
              padding: EdgeInsets.all(16.w),
              radius: 16.r,
              color: context.colorScheme.surface,
              child: Row(
                children: [
                  //* avatar
                  CircleAvatar(
                    radius: 25.r,
                    backgroundColor: AppColors.avatars[0],
                    child: txt(
                      'ح',
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      size: 18.sp,
                    ),
                  ),

                  SizedBox(width: 12.w),

                  //* request info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        txt(
                          'حامد توکلی',
                          fontWeight: FontWeight.w800,
                          size: 14.sp,
                        ),
                        SizedBox(height: 4.h),
                        txt(
                          '@hamed_t · ارسال ۳ روز پیش',
                          color: context.colorScheme.onSurfaceVariant,
                          size: 11.sp,
                        ),
                      ],
                    ),
                  ),

                  //* pending status
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: txt(
                      'در انتظار',
                      color: context.colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.w700,
                      size: 11.sp,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            //* sent request 2
            HsContainer(
              padding: EdgeInsets.all(16.w),
              radius: 16.r,
              color: context.colorScheme.surface,
              child: Row(
                children: [
                  //* avatar
                  CircleAvatar(
                    radius: 25.r,
                    backgroundColor: AppColors.avatars[1],
                    child: txt(
                      'م',
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      size: 18.sp,
                    ),
                  ),

                  SizedBox(width: 12.w),

                  //* request info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        txt(
                          'مریم صادقی',
                          fontWeight: FontWeight.w800,
                          size: 14.sp,
                        ),
                        SizedBox(height: 4.h),
                        txt(
                          '@maryam_s · ارسال ۱ هفته پیش',
                          color: context.colorScheme.onSurfaceVariant,
                          size: 11.sp,
                        ),
                      ],
                    ),
                  ),

                  //* viewed status
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: txt(
                      'مشاهده شد',
                      color: context.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w700,
                      size: 11.sp,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            //* info message
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer.withValues(
                  alpha: 0.3,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 18.sp,
                    color: context.colorScheme.primary,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: txt(
                      'پس از پذیرفته شدن درخواست، دوست به لیست «دوستان من» اضافه می‌شود',
                      color: context.colorScheme.onPrimaryContainer,
                      size: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ],
    );
  }
}
