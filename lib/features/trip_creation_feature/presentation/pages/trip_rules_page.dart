import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripRulesPage extends StatelessWidget {
  const TripRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 20.w),
      child: Column(
        children: [
          //* add rule input row
          Row(
            children: [
              //* rule text field
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'قانون جدید را بنویسید...',
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              //* add button
              SizedBox(
                width: 100.w,
                height: 50.h,
                child: FilledButton(
                  onPressed: () {},
                  child: txt(
                    'افزودن',
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    size: 13.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          //* rules list title
          txt(
            'قوانین تعیین‌شده (۳)',
            size: 13.sp,
            fontWeight: FontWeight.w800,
            color: context.colorScheme.onSurface,
          ),
          SizedBox(height: 12.h),

          //* rule 1
          HsContainer(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            color: context.colorScheme.surface,
            radius: 14.r,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.gavel,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: txt(
                    'حضور به‌موقع در محل تجمع (۱۵ دقیقه قبل از حرکت)',
                    size: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.close,
                  size: 18.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          //* rule 2
          HsContainer(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            color: context.colorScheme.surface,
            radius: 14.r,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.gavel,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: txt(
                    'لغو برنامه کمتر از ۴۸ ساعت قبل از سفر ممنوع است',
                    size: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.close,
                  size: 18.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          //* rule 3
          HsContainer(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            color: context.colorScheme.surface,
            radius: 14.r,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.gavel,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: txt(
                    'برگشت زودتر از موعد، فقط با هماهنگی لیدر مجاز است',
                    size: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.close,
                  size: 18.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

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
                    'قوانین برای جلوگیری از مشکلات حین سفر (برگشت زودهنگام، اختلاف مالی و...) تعیین می‌شوند و همه اعضا پس از عضویت آن‌ها را تأیید می‌کنند.',
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
