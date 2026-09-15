import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_appbar.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
              HsAppbar(title: 'تنظیمات ⚙️', hasBack: true),
              SizedBox(height: 24.h),

              //* app settings section title
              txt('تنظیمات برنامه', style: context.textTheme.titleMedium),
              SizedBox(height: 12.h),

              //* language setting
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 16.r,
                color: context.colorScheme.surface,
                onTap: () {},
                child: Row(
                  children: [
                    //* icon
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.language_rounded,
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
                            'زبان برنامه',
                            style: context.textTheme.titleSmall,
                          ),
                          SizedBox(height: 4.h),
                          txt(
                            'فارسی',
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
              SizedBox(height: 10.h),

              //* theme mode setting
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 16.r,
                color: context.colorScheme.surface,
                onTap: () {},
                child: Row(
                  children: [
                    //* icon
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.brightness_6_rounded,
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
                          txt('نوع تم', style: context.textTheme.titleSmall),
                          SizedBox(height: 4.h),
                          txt(
                            'روشن',
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
              SizedBox(height: 10.h),

              //* theme color setting
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 16.r,
                color: context.colorScheme.surface,
                onTap: () {},
                child: Row(
                  children: [
                    //* icon
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.palette_rounded,
                        color: context.colorScheme.primary,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),

                    //* text
                    Expanded(
                      child: txt('رنگ تم', style: context.textTheme.titleSmall),
                    ),

                    //* color preview
                    Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),

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

              //* account and support section title
              txt('حساب و پشتیبانی', style: context.textTheme.titleMedium),
              SizedBox(height: 12.h),

              //* account settings item
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 16.r,
                color: context.colorScheme.surface,
                onTap: () {},
                child: Row(
                  children: [
                    //* icon
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
              SizedBox(height: 10.h),

              //* report bug item
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 16.r,
                color: context.colorScheme.surface,
                onTap: () {
                  context.push('/bug-report');
                },
                child: Row(
                  children: [
                    //* icon
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.bug_report_rounded,
                        color: context.colorScheme.secondary,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),

                    //* text
                    Expanded(
                      child: txt(
                        'گزارش باگ',
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
              SizedBox(height: 10.h),

              //* contact us item
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 16.r,
                color: context.colorScheme.surface,
                onTap: () {
                  context.push('/bug-report');
                },
                child: Row(
                  children: [
                    //* icon
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.contact_support_rounded,
                        color: context.colorScheme.secondary,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),

                    //* text
                    Expanded(
                      child: txt(
                        'تماس با ما',
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
              SizedBox(height: 32.h),

              //* app version info
              Center(
                child: Column(
                  children: [
                    txt(
                      'همسفر · نسخه ۱.۰.۰',
                      style: context.textTheme.bodySmall,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(height: 4.h),
                    txt(
                      'ساخته‌شده با 💚 برای سفرهای دوستانه',
                      style: context.textTheme.bodySmall,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ],
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
