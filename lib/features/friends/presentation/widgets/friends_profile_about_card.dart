import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class FriendsProfileAboutCard extends StatelessWidget {
  const FriendsProfileAboutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HsContainer(
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
              txt('درباره من', fontWeight: FontWeight.w800, size: 14.sp),
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
    );
  }
}
