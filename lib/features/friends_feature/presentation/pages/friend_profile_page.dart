// lib/features/friends_feature/presentation/pages/friend_profile_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class FriendProfilePage extends StatelessWidget {
  const FriendProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* appbar section
              HsAppBar(title: 'پروفایل دوست', hasBack: true),

              SizedBox(height: 24.h),

              //* profile header section
              HsContainer(
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
                            txt(
                              '۴.۹',
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
              ),

              SizedBox(height: 20.h),

              //* about me section
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 16.r,
                color: context.colorScheme.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* section title
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          size: 18.sp,
                          color: context.colorScheme.primary,
                        ),
                        SizedBox(width: 8.w),
                        txt(
                          'درباره من',
                          fontWeight: FontWeight.w800,
                          size: 14.sp,
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    //* about text
                    txt(
                      'علاقه‌مند به طبیعت‌گردی و عکاسی. معمولاً آخر هفته‌ها آزادم و وسایل کمپینگ دارم. 📷',
                      color: context.colorScheme.onSurfaceVariant,
                      size: 12.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              //* available days section
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 16.r,
                color: context.colorScheme.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* section title
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 18.sp,
                          color: context.colorScheme.primary,
                        ),
                        SizedBox(width: 8.w),
                        txt(
                          'روزهای آزاد هفته',
                          fontWeight: FontWeight.w800,
                          size: 14.sp,
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    //* days grid
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //* شنبه
                        _buildDayChip('ش', false, context),
                        //* یکشنبه
                        _buildDayChip('ی', false, context),
                        //* دوشنبه
                        _buildDayChip('د', false, context),
                        //* سه‌شنبه
                        _buildDayChip('س', false, context),
                        //* چهارشنبه
                        _buildDayChip('چ', true, context),
                        //* پنج‌شنبه
                        _buildDayChip('پ', true, context),
                        //* جمعه
                        _buildDayChip('ج', true, context),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              //* my items section
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 16.r,
                color: context.colorScheme.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* section title
                    Row(
                      children: [
                        Icon(
                          Icons.backpack_outlined,
                          size: 18.sp,
                          color: context.colorScheme.primary,
                        ),
                        SizedBox(width: 8.w),
                        txt(
                          'وسایل من',
                          fontWeight: FontWeight.w800,
                          size: 14.sp,
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    //* items list
                    _buildItemRow('🏕', 'چادر ۲ نفره', context),
                    SizedBox(height: 8.h),
                    _buildItemRow('🔥', 'اجاق گاز', context),
                    SizedBox(height: 8.h),
                    _buildItemRow('📷', 'دوربین حرفه‌ای', context),
                    SizedBox(height: 8.h),
                    _buildItemRow('🧭', 'قطب‌نما', context),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              //* remove friend button
              HsButton(
                width: double.infinity,
                height: 50.h,
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_remove_outlined,
                      size: 20.sp,
                      color: context.colorScheme.error,
                    ),
                    SizedBox(width: 8.w),
                    txt(
                      'حذف دوست',
                      color: context.colorScheme.error,
                      fontWeight: FontWeight.w800,
                      size: 14.sp,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  //* helper method to build day chip
  Widget _buildDayChip(String day, bool isActive, BuildContext context) {
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: isActive
            ? context.colorScheme.primary
            : context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: txt(
          day,
          color: isActive
              ? context.colorScheme.onPrimary
              : context.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w700,
          size: 14.sp,
        ),
      ),
    );
  }

  //* helper method to build item row
  Widget _buildItemRow(String emoji, String itemName, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          //* emoji
          txt(emoji, size: 20.sp),

          SizedBox(width: 12.w),

          //* item name
          Expanded(
            child: txt(itemName, fontWeight: FontWeight.w700, size: 13.sp),
          ),

          //* status indicator
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
