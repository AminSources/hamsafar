import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripItem extends StatelessWidget {
  final String status;
  final String badge;
  final Color statusColor;
  final Color statusTextColor;
  final Color badgeColor;
  final Color badgeTextColor;
  final String title;
  final String date;
  final String members;

  const TripItem({
    super.key,
    required this.status,
    required this.badge,
    required this.statusColor,
    required this.statusTextColor,
    required this.badgeColor,
    required this.badgeTextColor,
    required this.title,
    required this.date,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      color: context.colorScheme.surface,
      radius: 16.r,
      onTap: () {
        //? push trip details page
        context.push("/trip-detail", extra: false);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: txt(
                  status,
                  size: 10.5.sp,
                  color: statusTextColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: txt(
                  badge,
                  size: 10.5.sp,
                  color: badgeTextColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          txt(
            title,
            size: 15.sp,
            fontWeight: FontWeight.w800,
            color: context.colorScheme.onSurface,
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 14.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: 4.w),
              txt(
                date,
                size: 12.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(
                Icons.people_outline,
                size: 14.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: 4.w),
              txt(
                members,
                size: 12.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
