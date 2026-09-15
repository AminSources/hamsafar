import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripInvitationPage extends StatelessWidget {
  const TripInvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 20.w),
      child: Column(
        children: [
          //* subtitle
          txt(
            'از لیست دوستان',
            size: 12.sp,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 12.h),

          //* search field
          TextField(
            decoration: InputDecoration(
              hintText: 'جستجو در دوستان...',
              prefixIcon: Icon(
                Icons.search,
                size: 20.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(height: 20.h),

          //* friends list
          //* friend 1 - selected
          HsContainer(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            color: context.colorScheme.primaryContainer,
            borderColor: context.colorScheme.primary,
            radius: 14.r,
            child: Row(
              children: [
                //* avatar (م)
                Container(
                  width: 42.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    color: Color(0xFF0EA5E9),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: txt(
                    'م',
                    size: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 12.w),
                //* info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      txt(
                        'مهدی رضایی',
                        size: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: context.colorScheme.onSurface,
                      ),
                      SizedBox(height: 4.h),
                      txt(
                        '۱۲ سفر مشترک · امتیاز ۴.۸',
                        size: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
                //* checkbox
                Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check,
                    size: 16.sp,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          //* friend 2 - selected
          HsContainer(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            color: context.colorScheme.primaryContainer,
            borderColor: context.colorScheme.primary,
            radius: 14.r,
            child: Row(
              children: [
                //* avatar (ن)
                Container(
                  width: 42.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    color: Color(0xFFF97316),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: txt(
                    'ن',
                    size: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 12.w),
                //* info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      txt(
                        'نگار احمدی',
                        size: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: context.colorScheme.onSurface,
                      ),
                      SizedBox(height: 4.h),
                      txt(
                        '۸ سفر مشترک · امتیاز ۴.۹',
                        size: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
                //* checkbox
                Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check,
                    size: 16.sp,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          //* friend 3 - selected
          HsContainer(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            color: context.colorScheme.primaryContainer,
            borderColor: context.colorScheme.primary,
            radius: 14.r,
            child: Row(
              children: [
                //* avatar (ع)
                Container(
                  width: 42.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    color: Color(0xFF8B5CF6),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: txt(
                    'ع',
                    size: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 12.w),
                //* info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      txt(
                        'علی کریمی',
                        size: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: context.colorScheme.onSurface,
                      ),
                      SizedBox(height: 4.h),
                      txt(
                        '۵ سفر مشترک · امتیاز ۴.۶',
                        size: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
                //* checkbox
                Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check,
                    size: 16.sp,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          //* friend 4 - not selected
          HsContainer(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            color: context.colorScheme.surface,
            radius: 14.r,
            child: Row(
              children: [
                //* avatar (ر)
                Container(
                  width: 42.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    color: Color(0xFFEC4899),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: txt(
                    'ر',
                    size: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 12.w),
                //* info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      txt(
                        'رضا قاسمی',
                        size: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: context.colorScheme.onSurface,
                      ),
                      SizedBox(height: 4.h),
                      txt(
                        '۳ سفر مشترک · امتیاز ۴.۷',
                        size: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
                //* empty checkbox
                Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.colorScheme.outline,
                      width: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          //* friend 5 - not selected
          HsContainer(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            color: context.colorScheme.surface,
            radius: 14.r,
            child: Row(
              children: [
                //* avatar (ا)
                Container(
                  width: 42.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    color: Color(0xFF22C55E),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: txt(
                    'ا',
                    size: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 12.w),
                //* info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      txt(
                        'الناز شریفی',
                        size: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: context.colorScheme.onSurface,
                      ),
                      SizedBox(height: 4.h),
                      txt(
                        '۲ سفر مشترک · امتیاز ۴.۵',
                        size: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
                //* empty checkbox
                Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.colorScheme.outline,
                      width: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          //* selected count badge
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: txt(
                  '۳ نفر انتخاب شده',
                  size: 11.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          //* info note
          HsContainer(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            color: context.colorScheme.secondaryContainer,
            borderColor: context.colorScheme.secondary,
            radius: 10.r,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 18.sp,
                  color: context.colorScheme.onSecondaryContainer,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: txt(
                    'دعوت‌شدگان می‌توانند عضویت را بپذیرند یا رد کنند',
                    size: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSecondaryContainer,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
