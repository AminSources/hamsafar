import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_info_item.dart';

class HomeInTripInfo extends StatelessWidget {
  const HomeInTripInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            HomeInfoItem(label: 'شروع', value: '۱۵ اردیبهشت'),
            HomeInfoItem(label: 'روز سفر', value: '۲ از ۴'),
            HomeInfoItem(label: 'پایان', value: '۱۷ اردیبهشت'),
          ],
        ),
        SizedBox(height: 12.h),
        HsContainer(
          width: double.infinity,
          height: 75.h,
          radius: 15.r,
          borderColor: AppColors.border,
          color: AppColors.background.withValues(alpha: 0.2),
          alignment: Alignment.center,
          child: Center(
            child: Row(
              mainAxisAlignment: .spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HomeInfoItem(label: 'تاریخ', value: '۱۵ تا ۱۷ اردیبهشت'),

                Container(
                  width: 1.w,
                  height: 20.h,
                  color: context.colorScheme.onSurfaceVariant,
                ),

                HomeInfoItem(label: 'زمان حرکت', value: '۰۷:۰۰'),

                Container(
                  width: 1.w,
                  height: 20.h,
                  color: context.colorScheme.onSurfaceVariant,
                ),

                HomeInfoItem(label: 'اعضا', value: '۶ نفر'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
