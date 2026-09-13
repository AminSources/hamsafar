import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_chip.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_preparing_info.dart';

class TdTripCard extends StatelessWidget {
  const TdTripCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: AppColors.tripLiveGradient,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.30),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              HomeChip(
                label: 'در حال آماده‌سازی',
                bg: Colors.white.withValues(alpha: 0.18),
                fg: Colors.white,
              ),

              HomeChip(
                label: '۳ روز مانده',
                bg: context.colorScheme.secondary,
                fg: context.colorScheme.onSecondary,
              ),
            ],
          ),
          SizedBox(height: 14.h),
          txt(
            'سفر جنگل‌گردی شمال 🌲',
            size: 18.sp,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 15.sp,
                color: Colors.white70,
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: txt(
                  'جاده چالوس، آبشار شکرآب',
                  size: 12.sp,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          HomePreparingInfo(),
        ],
      ),
    );
  }
}
