import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_day_chip.dart';

class FriendsAvailableDaysCard extends StatelessWidget {
  final List<String> freeDays;

  const FriendsAvailableDaysCard({super.key, required this.freeDays});

  @override
  Widget build(BuildContext context) {
    final weekdays = ["ش", "ی", "د", "س", "چ", "پ", "ج"];
    final isAvailable = weekdays.map((day) => freeDays.contains(day)).toList();

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
                Icons.calendar_today_outlined,
                size: 18.sp,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: 8.w),
              txt('روزهای آزاد هفته', fontWeight: FontWeight.w800, size: 14.sp),
            ],
          ),

          SizedBox(height: 16.h),

          //* days grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              7,
              (index) => FriendsDayChip(
                dayLetter: weekdays[index],
                isActive: isAvailable[index],
                onChange: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
