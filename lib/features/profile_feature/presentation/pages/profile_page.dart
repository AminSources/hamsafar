import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* appbar
              HsAppBar(title: 'پروفایل 👤'),
              SizedBox(height: 24.h),

              //* profile header card
              HsContainer(
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
                                txt(
                                  '۴.۹',
                                  style: context.textTheme.titleMedium,
                                ),
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
                        child: txt(
                          'ویرایش پروفایل',
                          style: context.textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              //* available days item
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 16.r,
                color: context.colorScheme.surface,
                onTap: () {
                  context.push('/available-days');
                },
                child: Row(
                  children: [
                    //* icon box
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.calendar_today_rounded,
                        color: context.colorScheme.primary,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),

                    //* text column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          txt(
                            'روزهای آزاد من',
                            style: context.textTheme.titleSmall,
                          ),
                          SizedBox(height: 4.h),
                          txt(
                            'چ، پ، ج',
                            style: context.textTheme.bodySmall,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),

                    //* chevron
                    Icon(
                      Icons.chevron_left_rounded,
                      color: context.colorScheme.onSurfaceVariant,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              //* my items item
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 16.r,
                color: context.colorScheme.surface,
                onTap: () {
                  context.push('/my-items');
                },
                child: Row(
                  children: [
                    //* icon box
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.backpack_rounded,
                        color: context.colorScheme.primary,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),

                    //* text column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          txt('وسایل من', style: context.textTheme.titleSmall),
                          SizedBox(height: 4.h),
                          txt(
                            '۵ مورد',
                            style: context.textTheme.bodySmall,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),

                    //* chevron
                    Icon(
                      Icons.chevron_left_rounded,
                      color: context.colorScheme.onSurfaceVariant,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              //* settings section title
              txt('تنظیمات', style: context.textTheme.titleMedium),
              SizedBox(height: 12.h),

              //* app settings item
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 16.r,
                color: context.colorScheme.surface,
                onTap: () {
                  context.push('/settings');
                },
                child: Row(
                  children: [
                    //* icon box
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.settings_rounded,
                        color: context.colorScheme.secondary,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),

                    //* text
                    Expanded(
                      child: txt(
                        'تنظیمات برنامه',
                        style: context.textTheme.titleSmall,
                      ),
                    ),

                    //* chevron
                    Icon(
                      Icons.chevron_left_rounded,
                      color: context.colorScheme.onSurfaceVariant,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              //* account settings item
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 16.r,
                color: context.colorScheme.surface,
                onTap: () {},
                child: Row(
                  children: [
                    //* icon box
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.privacy_tip_rounded,
                        color: context.colorScheme.secondary,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),

                    //* text
                    Expanded(
                      child: txt(
                        'تنظیمات حساب کاربری و حریم خصوصی',
                        style: context.textTheme.titleSmall,
                      ),
                    ),

                    //* chevron
                    Icon(
                      Icons.chevron_left_rounded,
                      color: context.colorScheme.onSurfaceVariant,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              //* logout button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: context.colorScheme.error),
                  ),
                  icon: Icon(
                    Icons.logout,
                    size: 18.sp,
                    color: context.colorScheme.error,
                  ),
                  label: txt(
                    'خروج از حساب کاربری',
                    color: context.colorScheme.error,
                    fontWeight: FontWeight.w800,
                    size: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
