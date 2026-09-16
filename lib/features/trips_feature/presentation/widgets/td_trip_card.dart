import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/trip_info_table.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
              HsBadge(
                label: 'در حال آماده‌سازی',
                backgroundColor: Colors.white.withValues(alpha: 0.18),
                foregroundColor: Colors.white,
              ),

              HsBadge(
                label: '۳ روز مانده',
                backgroundColor: context.colorScheme.secondary,
                foregroundColor: context.colorScheme.onSecondary,
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
              Icon(LucideIcons.mapPin, size: 15.sp, color: Colors.white70),
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
          TripInfoTable(
            borderColor: Colors.white.withValues(alpha: 0.18),
            labels: ["تاریخ", "زمان حرکت", "اعضا"],
            values: ["۱۵ تا ۱۷ اردیبهشت", "۰۷:۰۰", '۶ نفر'],
            labelColor: Colors.white.withValues(alpha: 0.7),
            valueColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
