import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_avatar_stack.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_chip.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_in_trip_info.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_preparing_info.dart';

class HomeTripCard extends StatelessWidget {
  final bool isInTrip;

  const HomeTripCard({super.key, required this.isInTrip});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/trip-detail'),
      child: HsContainer(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        color: context.colorScheme.surface,
        gradient: isInTrip ? context.verticalGradient : null,
        radius: 20.r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* status chips
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                HomeChip(
                  label: isInTrip ? '🚗 در حال سفر' : 'در حال آماده‌سازی',
                  bg: context.colorScheme.surfaceContainerHigh,
                  fg: context.colorScheme.onSurface,
                ),
                isInTrip
                    ? HomeChip(
                        label: 'موقعیت فعال',
                        bg: context.colorScheme.surfaceContainer,
                        fg: context.colorScheme.onSurface,
                        icon: Icons.my_location,
                      )
                    : HomeChip(
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
                    isInTrip
                        ? 'اقامتگاه بوم‌گردی، کلاردشت'
                        : 'جاده چالوس، آبشار شکرآب',
                    size: 12.sp,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            isInTrip ? HomeInTripInfo() : HomePreparingInfo(),
            SizedBox(height: 16.h),
            Divider(color: Colors.white24, height: 1),
            SizedBox(height: 14.h),
            HomeAvatarStack(),
          ],
        ),
      ),
    );
  }
}
