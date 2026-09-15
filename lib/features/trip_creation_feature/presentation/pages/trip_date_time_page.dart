import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trip_creation_feature/presentation/widgets/date_time_option.dart';
import 'package:hamsafar/features/trip_creation_feature/presentation/widgets/trip_input.dart';

class TripDateTimePage extends StatelessWidget {
  const TripDateTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            spacing: 10.w,
            children: [
              //* option 1 - fixed
              DateTimeOption(title: "تعیین قطعی", selected: true),

              //* option 2 - voting
              DateTimeOption(title: "رای گیری از اعضا", selected: false),
            ],
          ),
          SizedBox(height: 16.h),

          //* date inputs row
          Row(
            spacing: 10.w,
            children: [
              //* departure date
              TripInput(
                title: "تاریخ رفت",
                value: "۱۷ اردیبهشت",
                icon: Icons.calendar_today_outlined,
              ),

              //* return date
              TripInput(
                title: "تاریخ برگشت",
                value: "۱۷ اردیبهشت",
                icon: Icons.calendar_today_outlined,
              ),
            ],
          ),
          SizedBox(height: 16.h),

          //* time inputs row
          Row(
            spacing: 10.w,
            children: [
              //* departure time
              TripInput(
                title: "ساعت حرکت",
                value: "۰۷:۰۰",
                icon: Icons.access_time_outlined,
              ),

              //* return time
              TripInput(
                title: "ساعت برگشت",
                value: "۰۷:۰۰",
                icon: Icons.access_time_outlined,
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
                    'در حالت «رای‌گیری»، تنها یک مورد (مثلاً فقط زمان حرکت) برای تصمیم‌گیری اعضا گذاشته می‌شود و پس از بسته شدن عضوگیری آغاز خواهد شد.',
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
